#!/usr/bin/env python3
"""Build Slack payload for build alerts."""

import json
import os
import sys


def build_payload():
    """Build Slack payload from environment variables."""
    # Get inputs
    status = os.environ.get('INPUT_STATUS', '')
    workflow_name = os.environ.get('INPUT_WORKFLOW_NAME', '')
    tag_name = os.environ.get('TAG_NAME', '')
    failed_jobs = os.environ.get('INPUT_FAILED_JOBS', '')
    buildroot_ref = os.environ.get('INPUT_BUILDROOT_REF', '')
    monorepo_ref = os.environ.get('INPUT_MONOREPO_REF', '')
    console_url = os.environ.get('INPUT_CONSOLE_URL', '')
    system_url = os.environ.get('INPUT_SYSTEM_URL', '')
    fullimage_url = os.environ.get('INPUT_FULLIMAGE_URL', '')
    version_file_url = os.environ.get('INPUT_VERSION_FILE_URL', '')
    release_notes_file_url = os.environ.get('INPUT_RELEASE_NOTES_FILE_URL', '')
    github_server_url = os.environ.get('GITHUB_SERVER_URL', '')
    github_repository = os.environ.get('GITHUB_REPOSITORY', '')
    github_run_id = os.environ.get('GITHUB_RUN_ID', '')

    # Build status text and color
    if status == 'success':
        status_text = '✅ Build Success'
        color = 'good'
    elif status == 'failure':
        status_text = '❌ Build Failed'
        color = 'danger'
    else:
        status_text = '⚠️ Build Cancelled'
        color = 'warning'

    # Build fields array
    fields = [
        {"type": "mrkdwn", "text": f"*Tag:* `{tag_name}`"},
        {"type": "mrkdwn", "text": f"*Workflow:* `{workflow_name}`"},
        {"type": "mrkdwn", "text": f"*Status:* `{status}`"},
        {"type": "mrkdwn", "text": f"*View Details:* <{github_server_url}/{github_repository}/actions/runs/{github_run_id}|Open Workflow>"}
    ]

    if failed_jobs:
        fields.append({"type": "mrkdwn", "text": f"*Failed Jobs:* `{failed_jobs}`"})

    if buildroot_ref:
        fields.append({"type": "mrkdwn", "text": f"*Buildroot:* `{buildroot_ref}`"})

    if monorepo_ref:
        fields.append({"type": "mrkdwn", "text": f"*Monorepo:* `{monorepo_ref}`"})

    # Build blocks array
    blocks = [
        {
            "type": "header",
            "text": {
                "type": "plain_text",
                "text": status_text
            }
        },
        {
            "type": "section",
            "fields": fields
        }
    ]

    # Add artifacts section if URLs are provided
    if console_url or system_url or fullimage_url or version_file_url or release_notes_file_url:
        # Build artifact text with links using Slack's link format: <url|text>
        artifact_lines = ["*Artifacts:*"]

        if console_url:
            artifact_lines.append(f"*Download at:* <{console_url}|S3 Console>")

        if system_url:
            artifact_lines.append(f"*System Image (For Updates):* <{system_url}|Download>")

        if fullimage_url:
            artifact_lines.append(f"*Full Image (For Flashing):* <{fullimage_url}|Download>")

        if version_file_url:
            artifact_lines.append(f"*Version file:* <{version_file_url}|Download>")

        if release_notes_file_url:
            artifact_lines.append(f"*Release notes:* <{release_notes_file_url}|Download>")

        # Use a single text block with properly formatted links
        # Note: Slack requires URLs in link format to be properly escaped if they contain special chars
        artifact_text = "\n".join(artifact_lines)
        blocks.append({
            "type": "section",
            "text": {
                "type": "mrkdwn",
                "text": artifact_text
            }
        })

    # Build full payload
    # Note: Channel is determined by the webhook URL, not set in payload
    payload = {
        "username": "GitHub Actions",
        "icon_emoji": ":robot_face:",
        "attachments": [
            {
                "color": color,
                "blocks": blocks
            }
        ]
    }

    # Output JSON
    print(json.dumps(payload))


if __name__ == '__main__':
    build_payload()

