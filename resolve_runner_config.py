#!/usr/bin/env python3
"""Resolve runner labels and group from initialize-infra step outputs."""

import json
import os
import sys


def write_output(name: str, value: str) -> None:
    with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as fh:
        fh.write(f"{name}={value}\n")


def env_bool(name: str) -> bool:
    return os.environ[name].strip().lower() == "true"


def main() -> None:
    force_ephemeral = env_bool("FORCE_EPHEMERAL")
    is_fork = env_bool("MONOREPO_IS_FORK")
    variant = os.environ["VARIANT"]
    infra_stage = os.environ["INFRA_STAGE"]
    monorepo_repo = os.environ["MONOREPO_REPO"]

    static_labels = os.environ.get("STATIC_LABELS", "").strip()
    internal_labels = os.environ.get("INTERNAL_LABELS", "").strip()
    external_labels = os.environ.get("EXTERNAL_LABELS", "").strip()
    unforked_labels = os.environ.get("UNFORKED_LABELS", "").strip()

    # Order matches the former job-output case() expression.
    if not force_ephemeral and not is_fork:
        resolution = "static"
        runner_labels = static_labels or json.dumps(
            ["self-hosted", infra_stage, variant]
        )
    elif variant == "internal-release":
        resolution = "ephemeral-internal"
        runner_labels = internal_labels
    elif is_fork:
        resolution = "ephemeral-ot2-external"
        runner_labels = external_labels
    elif force_ephemeral:
        resolution = "ephemeral-unforked"
        runner_labels = unforked_labels
    else:
        resolution = "unknown"
        runner_labels = json.dumps(["unknown infra stage"])

    if not runner_labels:
        print(
            f"No runner_labels resolved (resolution={resolution}); "
            "check initialize-infra step if: conditions",
            file=sys.stderr,
        )
        raise SystemExit(1)

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
