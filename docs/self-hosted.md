# Self-Hosted Deployment

This repository provides the Docker Compose deployment surface for Crux Control.

The compose file pulls images from GitHub Container Registry.
Some component images are still scaffolds while runtime implementation lands, but `crux-mcp-gateway` now starts a working MCP governance runtime.

## Requirements

- Docker Engine with the Compose plugin.
- Network egress to `ghcr.io`.
- A local `.env` created from `.env.example`.

## Start

```bash
cp .env.example .env
docker compose --env-file .env config
docker compose --env-file .env pull
docker compose --env-file .env up -d
docker compose --env-file .env ps
```

## Stop

```bash
docker compose --env-file .env down
```

## Data

Postgres data is stored in the `postgres-data` named volume.
MCP gateway audit events are stored in the `mcp-audit-data` named volume.
Do not remove these volumes unless you intentionally want to delete control-plane state or replayable audit history.

## Version Pinning

Preview:

```dotenv
CRUX_VERSION=main
```

Pinned release:

```dotenv
CRUX_VERSION=v0.1.0
```

All Crux service images use the same tag in this compose stack.
Mixed-version deployments are not supported yet.
