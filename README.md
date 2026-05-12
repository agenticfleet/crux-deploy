# Crux Deploy

Self-hosted Docker Compose deployment files for Crux Control.

This repository pulls Crux component images from GitHub Container Registry:

```text
ghcr.io/agenticfleet/crux-server
ghcr.io/agenticfleet/crux-worker
ghcr.io/agenticfleet/crux-gateway
ghcr.io/agenticfleet/crux-mcp-gateway
ghcr.io/agenticfleet/crux-console
ghcr.io/agenticfleet/crux-cli
```

Most component images are scaffold images until their runtime implementations land.
`crux-mcp-gateway` now runs the Go MCP governance runtime with API-key auth, policy enforcement, audit persistence, and metrics on port `7702`.

## Quick start

```bash
cp .env.example .env
docker compose --env-file .env config
docker compose --env-file .env pull
docker compose --env-file .env up -d
```

Default image tag:

```bash
CRUX_VERSION=main
```

For a pinned release, set `CRUX_VERSION=vX.Y.Z`.

## Docs

- [Self-hosted deployment](docs/self-hosted.md)
- [Images and tags](docs/images.md)
- [Configuration](docs/configuration.md)
- [Release strategy](docs/releases.md)
- [Troubleshooting](docs/troubleshooting.md)

## License

Apache-2.0.
