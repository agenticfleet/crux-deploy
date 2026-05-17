#!/usr/bin/env bash
# scripts/wait-for.sh -- block until a URL returns 2xx or timeout expires
# Usage: ./scripts/wait-for.sh <url> [timeout_seconds]
set -euo pipefail

url="$1"
timeout="${2:-60}"
deadline=$(( $(date +%s) + timeout ))

while [ "$(date +%s)" -lt "$deadline" ]; do
  if curl -fsS -o /dev/null "$url" 2>/dev/null; then
    exit 0
  fi
  sleep 1
done
echo "timeout waiting for $url" >&2
exit 1
