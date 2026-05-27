# Ephemeral runner API variables (buildroot)

Workflow: `build.yml` job `initialize-infra` runs `initialize_runner.py`, which picks static vs ephemeral runners from **variant** (`internal-release` vs `release`), fork status, and `force-ephemeral-infra`.

Configure these under **Settings → Secrets and variables → Actions → Variables** (not secrets).

| Variable | Infra stack | S3 / CloudFront host (prod) |
|--------|-------------|-----------------------------|
| `EPHEMERAL_RUNNER_FORKED_INTERNAL_API_URL_PROD` | `ot2-internal-ci` | `ot2-development.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_FORKED_INTERNAL_API_URL_DEV` | `ot2-internal-ci` (dev workspace) | `ot2-development-dev.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_FORKED_RELEASE_API_URL_PROD` | `ot2-ci` | `ot2.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_FORKED_RELEASE_API_URL_DEV` | `ot2-ci` (dev workspace) | `ot2-dev.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_UNFORKED_API_URL_PROD` | `release-ci` / merged stack | `builds.opentrons.com` |
| `EPHEMERAL_RUNNER_UNFORKED_API_URL_DEV` | `release-ci` (dev) | `dev.builds.opentrons.com` |
