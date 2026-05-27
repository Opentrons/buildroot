#!/usr/bin/env python3
"""Resolve and initialize the GitHub Actions runner for buildroot builds."""

import json
import os
import sys
import time
import urllib.error
import urllib.request


def write_output(name: str, value: str) -> None:
    with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as fh:
        fh.write(f"{name}={value}\n")


def env_bool(name: str) -> bool:
    return os.environ[name].strip().lower() == "true"


def api_url_for(resolution: str, infra_stage: str) -> tuple[str, str]:
    """Return (api_url, missing_variable_message) for the given resolution."""
    is_dev = infra_stage == "stage-dev"
    if resolution == "ephemeral-internal":
        url = os.environ.get(
            "EPHEMERAL_RUNNER_FORKED_INTERNAL_API_URL_DEV" if is_dev
            else "EPHEMERAL_RUNNER_FORKED_INTERNAL_API_URL_PROD",
            "",
        ).strip()
        missing = (
            "Missing EPHEMERAL_RUNNER_FORKED_INTERNAL_API_URL_* repository variable "
            f"for infra-stage={infra_stage}"
        )
    elif resolution == "ephemeral-ot2-external":
        url = os.environ.get(
            "EPHEMERAL_RUNNER_FORKED_RELEASE_API_URL_DEV" if is_dev
            else "EPHEMERAL_RUNNER_FORKED_RELEASE_API_URL_PROD",
            "",
        ).strip()
        missing = (
            "Missing EPHEMERAL_RUNNER_FORKED_RELEASE_API_URL_* repository variable "
            f"for infra-stage={infra_stage}"
        )
    elif resolution == "ephemeral-unforked":
        url = os.environ.get(
            "EPHEMERAL_RUNNER_UNFORKED_API_URL_DEV" if is_dev
            else "EPHEMERAL_RUNNER_UNFORKED_API_URL_PROD",
            "",
        ).strip()
        missing = (
            "Missing EPHEMERAL_RUNNER_UNFORKED_API_URL_* repository variable "
            f"for infra-stage={infra_stage}"
        )
    else:
        raise ValueError(f"no API URL for resolution={resolution}")

    return url, missing


def resolve_kind(
    force_ephemeral: bool, is_fork: bool, variant: str
) -> tuple[str, str | None]:
    """Return (resolution, request_kind) where request_kind labels the API call."""
    if not force_ephemeral and not is_fork:
        return "static", None
    if variant == "internal-release":
        return "ephemeral-internal", "ot2-internal"
    if is_fork:
        return "ephemeral-ot2-external", "ot2-external"
    if force_ephemeral:
        return "ephemeral-unforked", "unforked"
    return "unknown", None


def request_ephemeral_runner(
    *,
    api_url: str,
    request_kind: str,
    infra_stage: str,
    variant: str,
    runner_label: str,
    max_attempts: int,
    retry_seconds: int,
) -> str:
    repository = os.environ.get("GITHUB_REPOSITORY", "")
    repo_label = repository.split("/")[-1] if repository else ""
    labels = [
        "x64",
        "linux-x64",
        "sb-x64",
        infra_stage,
        variant,
        runner_label,
        repo_label,
    ]
    labels_json = json.dumps(labels)

    print(f"Requesting runner with unique label: [{runner_label}]")
    print(f"Requested labels: {labels_json}")
    print(f"API URL host: {api_url.split('/')[2] if '://' in api_url else api_url}")

    start = time.monotonic()
    retries_on_429 = 0
    final_attempt = 0
    http_code = "n/a"

    payload = json.dumps(
        {
            "labels": labels,
            "workflow_run_id": os.environ.get("GITHUB_RUN_ID", ""),
            "repository": repository,
        }
    ).encode("utf-8")
    request_url = f"{api_url.rstrip('/')}/request-runner"

    def emit_request_summary(status: str) -> None:
        elapsed_seconds = int(time.monotonic() - start)
        waited_seconds = retries_on_429 * retry_seconds
        summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
        if not summary_path:
            return
        with open(summary_path, "a", encoding="utf-8") as fh:
            fh.write(f"### Runner Request Metrics ({request_kind})\n\n")
            fh.write("| Field | Value |\n")
            fh.write("|---|---|\n")
            fh.write(f"| Status | {status} |\n")
            fh.write(f"| Final HTTP status | {http_code} |\n")
            fh.write(f"| Attempts used | {final_attempt}/{max_attempts} |\n")
            fh.write(f"| 429 retries | {retries_on_429} |\n")
            fh.write(f"| Retry wait seconds | {waited_seconds} |\n")
            fh.write(f"| Total elapsed seconds | {elapsed_seconds} |\n")
            fh.write(f"| Runner label | {runner_label} |\n")
            fh.write(f"| Infra stage | {infra_stage} |\n")
            fh.write(f"| Variant | {variant} |\n")
            fh.write(f"| API URL | {api_url} |\n\n")

    requested = False
    for attempt in range(1, max_attempts + 1):
        final_attempt = attempt
        response_body = ""
        req = urllib.request.Request(
            request_url,
            data=payload,
            method="POST",
            headers={"Content-Type": "application/json"},
        )
        try:
            with urllib.request.urlopen(req) as resp:
                http_code = str(resp.getcode())
                response_body = resp.read().decode("utf-8", errors="replace")
        except urllib.error.HTTPError as exc:
            http_code = str(exc.code)
            response_body = exc.read().decode("utf-8", errors="replace")
        except Exception as exc:
            http_code = "request_error"
            response_body = str(exc)

        if http_code == "200":
            requested = True
            break
        if http_code == "429":
            retries_on_429 += 1
            print(
                f"Runner capacity full (429), waiting {retry_seconds}s before retry "
                f"({attempt}/{max_attempts})..."
            )
            time.sleep(retry_seconds)
            continue

        emit_request_summary("failed")
        print(f"Runner request failed with HTTP {http_code}", file=sys.stderr)
        if response_body:
            print(response_body, file=sys.stderr)
        raise SystemExit(1)

    if not requested:
        emit_request_summary("timed_out")
        print(
            f"Timed out waiting for ephemeral runner capacity after {max_attempts} attempts.",
            file=sys.stderr,
        )
        raise SystemExit(1)

    emit_request_summary("success")
    return json.dumps([runner_label])


def main() -> None:
    force_ephemeral = env_bool("FORCE_EPHEMERAL")
    is_fork = env_bool("MONOREPO_IS_FORK")
    variant = os.environ["VARIANT"]
    infra_stage = os.environ["INFRA_STAGE"]
    monorepo_repo = os.environ["MONOREPO_REPO"]
    runner_label = os.environ["RUNNER_LABEL"]
    max_attempts = int(os.environ.get("MAX_ATTEMPTS", "120"))
    retry_seconds = int(os.environ.get("RETRY_SECONDS", "60"))

    resolution, request_kind = resolve_kind(force_ephemeral, is_fork, variant)

    if resolution == "unknown":
        print("Could not resolve runner configuration from inputs", file=sys.stderr)
        raise SystemExit(1)

    if resolution == "static":
        runner_labels = json.dumps(["self-hosted", infra_stage, variant])
    else:
        api_url, missing_message = api_url_for(resolution, infra_stage)
        if not api_url:
            print(missing_message, file=sys.stderr)
            raise SystemExit(1)
        runner_labels = request_ephemeral_runner(
            api_url=api_url,
            request_kind=request_kind or resolution,
            infra_stage=infra_stage,
            variant=variant,
            runner_label=runner_label,
            max_attempts=max_attempts,
            retry_seconds=retry_seconds,
        )

    use_ephemeral_group = force_ephemeral or monorepo_repo == "opentrons-ot2"
    runner_group = (
        "ephemeral-system-builders" if use_ephemeral_group else "Custom Runners"
    )

    write_output("runner_labels", runner_labels)
    write_output("runner_group", runner_group)
    write_output("resolution", resolution)

    print(f"Resolved resolution={resolution}")
    print(f"Resolved runner_group={runner_group}")
    print(f"Resolved runner_labels={runner_labels}")

    summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary_path:
        with open(summary_path, "a", encoding="utf-8") as fh:
            fh.write("### Runner configuration\n\n")
            fh.write("| Field | Value |\n")
            fh.write("|---|---|\n")
            fh.write(f"| Resolution | {resolution} |\n")
            fh.write(f"| Runner group | {runner_group} |\n")
            fh.write(f"| Runner labels | `{runner_labels}` |\n\n")


if __name__ == "__main__":
    main()
