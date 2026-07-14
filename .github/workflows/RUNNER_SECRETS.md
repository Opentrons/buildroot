# Ephemeral runner API secrets (buildroot)

Workflow: `build.yml` job `initialize-infra` runs `initialize_runner.py`, which picks static vs ephemeral runners from **variant** (`internal-release` vs `release`), fork status, and `force-ephemeral-infra`.

| Secret | Infra stack | S3 / CloudFront host (prod) |
|--------|-------------|-----------------------------|
| `EPHEMERAL_RUNNER_FORKED_INTERNAL_API_URL_PROD` | `ot2-internal-ci` | `ot2-development.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_FORKED_INTERNAL_API_URL_DEV` | `ot2-internal-ci` (dev workspace) | `ot2-development-dev.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_FORKED_RELEASE_API_URL_PROD` | `ot2-ci` | `ot2.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_FORKED_RELEASE_API_URL_DEV` | `ot2-ci` (dev workspace) | `ot2-dev.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_UNFORKED_API_URL_PROD` | `release-ci` / merged stack | `builds.opentrons.com` |
| `EPHEMERAL_RUNNER_UNFORKED_API_URL_DEV` | `release-ci` (dev) | `dev.builds.opentrons.com` |

## Buildroot S3 downloads / ccache cache

CI uses runner env `S3_CACHE_ARN` and `LOCAL_CACHE`. Helper: [`.github/scripts/s3-buildroot-cache.sh`](../scripts/s3-buildroot-cache.sh).

- Trees: `downloads` (`BR2_DL_DIR`), `ccache` (`BR2_CCACHE_DIR`) under `LOCAL_CACHE`.
- Objects under `s3://…/ot2-br/`: `<type>.tar.zst` + `<type>.manifest` (fingerprint skip on push).
- **Pull** is skipped if that prefix is already &gt; 50 GB. **Push** runs after artifact/release upload; **poisoned cache** wipe on job failure.
- Requires **zstd** on the ephemeral runner image. Legacy `ot2-br/*.zip` objects are ignored; first run after merge cold-misses until a successful push seeds the new format.
