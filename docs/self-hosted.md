# Self-Hosted Deployment

This repository provides the Docker Compose deployment surface for Crux Control.

The compose file pulls images from GitHub Container Registry.
The first images are scaffolds while the runtime implementation lands, but the deployment contract is fixed around the service names, image names, ports, and environment variables below.

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
Do not remove this volume unless you intentionally want to delete control-plane state.

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
