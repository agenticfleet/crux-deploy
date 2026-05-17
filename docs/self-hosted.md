# Self-Hosted Deployment

This repository provides the Docker Compose deployment surface for Crux Control.

The compose file pulls images from GitHub Container Registry. V0.1 uses
`agentgateway` as the data plane for the managed-agent wedge demo. See
[docs/deployment-guide.md](deployment-guide.md) for the full install and
operations guide.

## Requirements

- Docker Engine with the Compose plugin.
- Network egress to `ghcr.io` and `ghcr.io/agentgateway`.
- A local `.env` created from `.env.example`.

## Start

```bash
cp .env.example .env
# Edit .env: set CRUX_SERVER_API_KEY at minimum.
make up
make smoke
```

## Stop

```bash
make down
```

## Data

Postgres data is stored in the `postgres-data` named volume.
Do not remove this volume unless you intentionally want to delete
control-plane state.

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
