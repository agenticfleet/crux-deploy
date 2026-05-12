# Images and Tags

## Images

| Service | Image |
|---|---|
| CLI tools | `ghcr.io/agenticfleet/crux-cli` |
| Server | `ghcr.io/agenticfleet/crux-server` |
| Worker | `ghcr.io/agenticfleet/crux-worker` |
| Model/API gateway | `ghcr.io/agenticfleet/crux-gateway` |
| MCP gateway | `ghcr.io/agenticfleet/crux-mcp-gateway` |
| Console | `ghcr.io/agenticfleet/crux-console` |

## Tags

| Tag | Meaning |
|---|---|
| `main` | Latest image built from the repository `main` branch. |
| `<commit-sha>` | Exact commit image from a `main` push. |
| `vX.Y.Z` | Pinned semver release image. |
| `latest` | Alias for the latest semver release image. |

## Current State

The component repositories currently publish scaffold images.
They are useful for validating image distribution, compose wiring, and release automation.
Runtime behavior lands in the service repositories and will replace the scaffold image commands directly.
