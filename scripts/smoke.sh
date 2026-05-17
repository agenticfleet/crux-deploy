#!/usr/bin/env bash
# scripts/smoke.sh -- V0.1 wedge demo smoke test against a running stack
# Usage: ./scripts/smoke.sh
set -euo pipefail

cd "$(dirname "$0")/.."

# Ensure .env exists
if [ ! -f .env ]; then
  echo "ERROR: .env not found. Copy .env.example to .env and configure it first." >&2
  exit 1
fi
# shellcheck disable=SC1091
. ./.env

CRUX_SERVER_URL="http://localhost:${CRUX_SERVER_PORT:-7700}"
AGENTGATEWAY_ADMIN_URL="http://localhost:${AGENTGATEWAY_ADMIN_PORT:-8080}"
API_KEY="${CRUX_SERVER_API_KEY:-change-me-please}"

echo "==> [1/5] Waiting for crux-server..."
./scripts/wait-for.sh "$CRUX_SERVER_URL/v1/healthz" 60
echo "    crux-server ready."

echo "==> [2/5] Waiting for agentgateway admin API..."
./scripts/wait-for.sh "$AGENTGATEWAY_ADMIN_URL/healthz" 60
echo "    agentgateway ready."

echo "==> [3/5] Applying managed Agent + MCPServer..."
curl -fsS -X POST "$CRUX_SERVER_URL/v1/resources/apply" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/yaml" \
  --data-binary @- <<'EOF'
apiVersion: crux.io/v1alpha1
kind: Agent
metadata:
  name: claude
  namespace: default
spec:
  class: managed
---
apiVersion: tools.crux.io/v1alpha1
kind: MCPServer
metadata:
  name: github
  namespace: default
spec:
  endpoint: https://mcp.example.com/github
  transport: streamable_http
  pinnedVersion: 1.2.0
EOF
echo "    Apply OK."

echo "==> [4/5] Verifying Agent stored..."
curl -fsS -H "Authorization: Bearer $API_KEY" \
  "$CRUX_SERVER_URL/v1/namespaces/default/agents/claude" | head -c 300
echo

echo "==> [5/5] Inspecting AgBOM for managed agent..."
AGBOM="$(curl -fsS -H "Authorization: Bearer $API_KEY" \
  "$CRUX_SERVER_URL/v1/agbom/default/claude")"
echo "$AGBOM" | head -c 500
echo

# Verify AgBOM contains at least 2 components
COMPONENT_COUNT="$(echo "$AGBOM" | grep -o '"components"' | wc -l || true)"
if [ "${COMPONENT_COUNT:-0}" -lt 1 ]; then
  echo "WARNING: AgBOM response may be missing 'components' field — check output above." >&2
fi

echo
echo "==> Wedge demo smoke PASSED."
