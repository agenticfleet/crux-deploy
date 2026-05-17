# Images and Tags

## Images

| Service | Image |
|---|---|
| agentgateway (data plane) | `ghcr.io/agentgateway/agentgateway` |
| crux-server (control plane) | `ghcr.io/agenticfleet/crux-server` |
| crux-worker (execution engine) | `ghcr.io/agenticfleet/crux-worker` |
| crux-gateway (model gateway, V0.2+) | `ghcr.io/agenticfleet/crux-gateway` |
| crux-console (operator UI) | `ghcr.io/agenticfleet/crux-console` |
| crux-cli (profile: tools) | `ghcr.io/agenticfleet/crux-cli` |
| crux-mcp-injection-shim (profile: shim) | `ghcr.io/agenticfleet/crux-mcp-injection-shim` |

## Tags

| Tag | Meaning |
|---|---|
| `main` | Latest image built from the repository `main` branch. |
| `<commit-sha>` | Exact commit image from a `main` push. |
| `vX.Y.Z` | Pinned semver release image. |
| `latest` | Alias for the latest semver release image. |

## Current State

V0.1 ships `agentgateway` as the data plane. `crux-mcp-injection-shim` is an
optional fallback, activated only if the pinned `agentgateway` release cannot
host the V0.1 wedge demo. Other component images are scaffold images until
their runtime implementations land.
