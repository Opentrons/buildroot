#!/usr/bin/env python3
"""Request an ephemeral GitHub Actions runner from the robot-stack API."""

import json
import os
import sys
import time
import urllib.error
import urllib.request


def main() -> None:
    api_url = os.environ.get("API_URL", "").strip()
    if not api_url:
        print(
            os.environ.get(
                "MISSING_SECRET_MESSAGE",
                "Missing API_URL (ephemeral runner request endpoint)",
            ),
            file=sys.stderr,
        )
        raise SystemExit(1)

    infra_stage = os.environ["INFRA_STAGE"]
    variant = os.environ["VARIANT"]
    runner_label = os.environ["RUNNER_LABEL"]
    max_attempts = int(os.environ.get("MAX_ATTEMPTS", "120"))
    retry_seconds = int(os.environ.get("RETRY_SECONDS", "60"))
    request_kind = os.environ.get("REQUEST_KIND", "unknown")

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

    with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as fh:
        fh.write(f'runner_labels=["{runner_label}"]\n')

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
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a", encoding="utf-8") as fh:
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
                f"Runner capacity full (429), waiting {retry_seconds}s before retry ({attempt}/{max_attempts})..."
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


if __name__ == "__main__":
    main()
