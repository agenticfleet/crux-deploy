# crux-deploy

Docker Compose deployment for **Crux Control V0.1** — the vendor-neutral
AI agent control plane.

This stack pulls images from GHCR and brings up the full V0.1 surface:
Postgres, `crux-server` (control plane), `crux-worker` (execution engine),
`agentgateway` (data plane — MCP listener + admin API), `crux-console`
(read-only operator UI). `crux-mcp-injection-shim` ships as an optional
profile-activated service, used only if the pinned `agentgateway` release
cannot host the wedge demo end-to-end.

## Quick start

```bash
git clone https://github.com/agenticfleet/crux-deploy.git
cd crux-deploy
cp .env.example .env
# Edit .env: set CRUX_SERVER_API_KEY at minimum.
make up
make smoke
```

## Images

| Service | Image |
|---|---|
| agentgateway | `ghcr.io/agentgateway/agentgateway` |
| crux-server | `ghcr.io/agenticfleet/crux-server` |
| crux-worker | `ghcr.io/agenticfleet/crux-worker` |
| crux-gateway | `ghcr.io/agenticfleet/crux-gateway` |
| crux-console | `ghcr.io/agenticfleet/crux-console` |
| crux-cli (profile: tools) | `ghcr.io/agenticfleet/crux-cli` |
| crux-mcp-injection-shim (profile: shim) | `ghcr.io/agenticfleet/crux-mcp-injection-shim` |

## Networking

| Service | Host port | Purpose |
|---|---|---|
| crux-server | 7700 | REST API |
| agentgateway | 7702 | MCP listener (managed-agent wedge target) |
| agentgateway | 8080 | Admin API (crux-server pushes config here) |
| crux-gateway | 7701 | Model gateway (V0.2+) |
| crux-console | 7780 | Operator UI |

## Versions

- `CRUX_VERSION` — pulls `ghcr.io/agenticfleet/<service>:${CRUX_VERSION}`.
  Use `main` for snapshot or `vX.Y.Z` for a pinned release.
- `AGENTGATEWAY_VERSION` — pinned to the version validated by crux-server CI.
  The default in `.env.example` matches `crux-server/internal/agentgateway/version.go`.

## Activating the shim

The `crux-mcp-injection-shim` is off by default. Activate only if the pinned
`agentgateway` version fails the wedge demo smoke test:

```bash
COMPOSE_PROFILES=shim docker compose --env-file .env up -d
```

See `docs/deployment-guide.md` for override instructions.

## Docs

- [Deployment guide](docs/deployment-guide.md)
- [Architecture](docs/architecture.md)
- [Images and tags](docs/images.md)
- [Configuration](docs/configuration.md)
- [Release strategy](docs/releases.md)
- [Troubleshooting](docs/troubleshooting.md)

## License

Apache-2.0.
