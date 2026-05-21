# Ephemeral runner API secrets (buildroot)

Workflow: `build.yml` routes OT2 builds to the correct artifact host by **variant** (`internal-release` vs `release`).

| Secret | Infra stack | S3 / CloudFront host (prod) |
|--------|-------------|-----------------------------|
| `EPHEMERAL_RUNNER_FORKED_INTERNAL_API_URL_PROD` | `ot2-internal-ci` | `ot2-development.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_FORKED_INTERNAL_API_URL_DEV` | `ot2-internal-ci` (dev workspace) | `ot2-development-dev.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_FORKED_RELEASE_API_URL_PROD` | `ot2-ci` | `ot2.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_FORKED_RELEASE_API_URL_DEV` | `ot2-ci` (dev workspace) | `ot2-dev.builds.opentrons.com` |
| `EPHEMERAL_RUNNER_UNFORKED_API_URL_PROD` | `release-ci` / merged stack | `builds.opentrons.com` |
| `EPHEMERAL_RUNNER_UNFORKED_API_URL_DEV` | `release-ci` (dev) | `dev.builds.opentrons.com` |

Terraform output to set each secret (prod example):

```bash
# ot2-internal-ci
terraform -chdir=inf/ot2-internal-ci output -raw runner_api_request_runner_url

# ot2-ci
terraform -chdir=inf/ot2-ci output -raw runner_api_request_runner_url
```

Do **not** point internal builds at `EPHEMERAL_RUNNER_FORKED_API_URL_*` unless it matches the internal stack URL above. Prefer the split `FORKED_INTERNAL_*` / `FORKED_RELEASE_*` secrets.

Optional repo **variables** for explicit S3 uploads (override runner `S3_ARTIFACT_ARN`):

- `OT2_ARTIFACT_HOST_INTERNAL_PROD` / `_DEV`
- `OT2_ARTIFACT_HOST_RELEASE_PROD` / `_DEV`

If unset, `build.yml` uses the hostnames in the table.
