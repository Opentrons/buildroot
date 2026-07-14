#!/usr/bin/env bash
# Buildroot S3 cache for CI (downloads + ccache).
#
# Local trees (under <cachedir>/):
#   downloads/   BR2_DL_DIR bind mount
#   ccache/      BR2_CCACHE_DIR bind mount
#
# S3 objects (under <s3_prefix>/, typically .../ot2-br/):
#   <type>.tar.zst     archive of that tree (tar + zstd; preserves empty dirs)
#   <type>.manifest    sha256 of sorted "path + size" (+ empty dirs)
#
# Commands:
#   pull  Download each .tar.zst that exists and extract into <cachedir>/<type>.
#         Missing objects are skipped (cold / partial cache is fine).
#   push  Fingerprint each local tree. If it matches the remote .manifest, skip.
#         Otherwise archive to .tar.zst, upload it, and write .manifest.
#
# Busting: change tree contents so the fingerprint no longer matches .manifest,
# or delete the S3 objects. First merge of this format expects a cache miss
# (legacy .zip objects under the same prefix are ignored); the next successful
# push publishes .tar.zst + .manifest.
#
# Requires zstd on PATH. Provision it on the ephemeral runner image — this
# script does not install packages.
set -euo pipefail

CACHE_TYPES=(downloads ccache)

log() {
  echo "$@"
}

require_zstd() {
  if ! command -v zstd >/dev/null 2>&1; then
    log "ERROR: zstd is required but not on PATH. Install it on the ephemeral runner image." >&2
    return 1
  fi
  zstd --version
}

# Fingerprint used to decide whether push can skip archive+upload.
fingerprint_dir() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    echo "missing"
    return 0
  fi
  (
    cd "$dir"
    find . -type f -printf 'f %P %s\n' 2>/dev/null
    find . -type d -empty -printf 'd %P\n' 2>/dev/null
  ) | LC_ALL=C sort | sha256sum | awk '{print $1}'
}

s3_exists() {
  local uri="$1"
  aws s3api head-object \
    --bucket "$(echo "$uri" | sed -E 's|^s3://([^/]+)/.*|\1|')" \
    --key "$(echo "$uri" | sed -E 's|^s3://[^/]+/||')" \
    >/dev/null 2>&1
}

s3_cp() {
  aws s3 cp --no-progress "$@"
}

download_with_retries() {
  local src="$1"
  local dest="$2"
  local max_attempts=3
  local attempt=1
  local rc=0
  while true; do
    log "Downloading ${src} (attempt ${attempt}/${max_attempts})"
    if s3_cp "$src" "$dest"; then
      return 0
    fi
    rc=$?
    log "Download failed (exit ${rc})"
    if [[ $attempt -ge $max_attempts ]]; then
      return "$rc"
    fi
    sleep $((attempt * 15))
    attempt=$((attempt + 1))
  done
}

pull_all() {
  local s3_prefix="$1"
  local cachedir="$2"
  require_zstd
  mkdir -p "$cachedir"

  local workdir
  workdir="$(mktemp -d -t s3-cache-pull-XXXXXX)"
  local -a pids=()
  local -a types=()
  local cachetype
  local i=0

  # Download in parallel; extract sequentially after joins.
  for cachetype in "${CACHE_TYPES[@]}"; do
    (
      if s3_exists "${s3_prefix}/${cachetype}.tar.zst"; then
        download_with_retries "${s3_prefix}/${cachetype}.tar.zst" "${workdir}/${cachetype}.tar.zst"
        log "Fetched ${cachetype}.tar.zst ($(du -h "${workdir}/${cachetype}.tar.zst" | cut -f1)B)"
        exit 0
      fi
      log "No ${cachetype}.tar.zst in S3; skipping"
      exit 1
    ) &
    pids+=($!)
    types+=("$cachetype")
  done

  local -a fetched=()
  for i in "${!pids[@]}"; do
    if wait "${pids[$i]}"; then
      fetched+=("${types[$i]}")
    fi
  done

  if [[ ${#fetched[@]} -eq 0 ]]; then
    log "WARNING: no cache archives downloaded; Buildroot will be a cold build for downloads/ccache"
    rm -rf "$workdir"
    return 0
  fi

  for cachetype in "${fetched[@]}"; do
    local dest="${cachedir}/${cachetype}"
    local archive="${workdir}/${cachetype}.tar.zst"
    mkdir -p "$dest"
    log "Extracting ${cachetype} -> ${dest}"
    zstd -d -T0 -c "$archive" | tar -C "$dest" -xf -
    rm -f "$archive"
    log "Extracted ${cachetype}: $(du -sh "$dest" | cut -f1)"
  done

  rm -rf "$workdir"
}

push_one() {
  local s3_prefix="$1"
  local cachedir="$2"
  local cachetype="$3"
  local thiscache="${cachedir}/${cachetype}"
  local archive="${cachedir}/../${cachetype}.tar.zst"
  local manifest_remote="${s3_prefix}/${cachetype}.manifest"
  local local_fp remote_fp

  if [[ ! -d "$thiscache" ]]; then
    log "No local directory for ${cachetype}; skipping"
    return 0
  fi

  local file_count
  file_count=$(find "$thiscache" -type f 2>/dev/null | wc -l | tr -d ' ')
  log "Cache ${cachetype}: ${file_count} files, $(du -sh "$thiscache" | cut -f1)"
  if [[ "$file_count" -eq 0 ]]; then
    log "Cache ${cachetype} empty; skipping"
    return 0
  fi

  log "Fingerprinting ${cachetype}"
  local_fp="$(fingerprint_dir "$thiscache")"
  log "Local fingerprint: ${local_fp}"

  remote_fp=""
  if remote_fp="$(aws s3 cp --no-progress "$manifest_remote" - 2>/dev/null)"; then
    remote_fp="$(echo -n "$remote_fp" | tr -d '[:space:]')"
    log "Remote fingerprint: ${remote_fp}"
  else
    log "No remote manifest for ${cachetype}"
  fi

  if [[ -n "$remote_fp" && "$local_fp" == "$remote_fp" ]]; then
    log "Skipping ${cachetype}: fingerprint unchanged"
    return 0
  fi

  log "Archiving ${cachetype} -> ${archive}"
  rm -f "$archive"
  tar -C "$thiscache" -cf - . | zstd -T0 -3 -q -o "$archive"
  log "Archived ${cachetype}: $(du -h "$archive" | cut -f1)B"

  log "Uploading ${cachetype}.tar.zst"
  s3_cp "$archive" "${s3_prefix}/${cachetype}.tar.zst"
  echo -n "$local_fp" | s3_cp - "$manifest_remote"
  log "Wrote ${cachetype}.manifest"

  rm -f "$archive"
}

push_all() {
  local s3_prefix="$1"
  local cachedir="$2"
  require_zstd

  if [[ -d "$cachedir" ]]; then
    sudo chown -R "$(id -u):$(id -g)" "$cachedir" || true
  fi

  local cachetype
  for cachetype in "${CACHE_TYPES[@]}"; do
    push_one "$s3_prefix" "$cachedir" "$cachetype"
  done
}

usage() {
  cat <<EOF
Usage:
  $0 require-zstd
  $0 pull <s3_prefix> <cachedir>
  $0 push <s3_prefix> <cachedir>
EOF
}

main() {
  local cmd="${1:-}"
  case "$cmd" in
    require-zstd)
      require_zstd
      ;;
    pull)
      if [[ $# -ne 3 ]]; then usage; exit 1; fi
      pull_all "$2" "$3"
      ;;
    push)
      if [[ $# -ne 3 ]]; then usage; exit 1; fi
      push_all "$2" "$3"
      ;;
    *)
      usage
      exit 1
      ;;
  esac
}

main "$@"
