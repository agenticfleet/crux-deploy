# Crux Control Self-Hosted Deployment Guide (V0.1)

## Prerequisites

- Docker Engine 24+ and Docker Compose v2.
- 2 GiB RAM minimum (Postgres + 4 Go services).
- Linux x86_64 / arm64 or macOS Docker Desktop.
- `curl` and `wget` for smoke tests and agentgateway healthchecks.

## Quick start

1. Clone this repo:
   ```bash
   git clone https://github.com/agenticfleet/crux-deploy.git
   cd crux-deploy
   ```

2. Copy the environment template:
   ```bash
   cp .env.example .env
   ```

3. Edit `.env`. At minimum set `CRUX_SERVER_API_KEY` to a strong random value.

4. Start the stack:
   ```bash
   make up
   ```

5. Run the wedge demo smoke test:
   ```bash
   make smoke
   ```

## Service overview

| Service | Image | Purpose |
|---|---|---|
| postgres | postgres:17-alpine | Shared store for crux-server |
| agentgateway | ghcr.io/agentgateway/agentgateway | Data plane — MCP listener + admin API |
| crux-server | ghcr.io/agenticfleet/crux-server | Control plane |
| crux-worker | ghcr.io/agenticfleet/crux-worker | Execution engine |
| crux-gateway | ghcr.io/agenticfleet/crux-gateway | Model gateway (V0.2+; running but no-op in V0.1) |
| crux-console | ghcr.io/agenticfleet/crux-console | Operator UI (read-only in V0.1) |
| crux-mcp-injection-shim (optional) | ghcr.io/agenticfleet/crux-mcp-injection-shim | Pre-fronts agentgateway if RFC validation requires it |

## Networking (published host ports)

| Service | Host port | Purpose |
|---|---|---|
| crux-server | 7700 | REST API (CLI, Console, Worker) |
| agentgateway | 7702 | MCP listener (managed-agent wedge target URL) |
| agentgateway | 8080 | Admin API (crux-server pushes listener config here) |
| crux-gateway | 7701 | Model gateway (V0.2+) |
| crux-console | 7780 | Operator UI |

Postgres is not published to the host.

## Make targets

| Target | Description |
|---|---|
| `make up` | Start all services detached |
| `make down` | Stop and remove containers |
| `make restart` | `down` then `up` |
| `make config` | Validate `compose.yaml` against `.env` |
| `make logs` | Follow logs for all services |
| `make ps` | Show container status |
| `make smoke` | Run the V0.1 wedge demo smoke test |
| `make nuke` | Stop and remove containers **and volumes** |

## Activating the crux-mcp-injection-shim

The shim is shipped behind the `shim` profile and is off by default. It is
only needed if the pinned `agentgateway` version cannot host the wedge demo
end-to-end (CI validates the pin on every push, so this should be rare).

To activate:

1. Add a `compose.override.yaml` to remove the `7702:7702` port mapping from
   `agentgateway` so the shim can claim that port:
   ```yaml
   services:
     agentgateway:
       ports:
         - "${AGENTGATEWAY_ADMIN_PORT:-8080}:8080"
   ```

2. Start with the shim profile:
   ```bash
   COMPOSE_PROFILES=shim docker compose --env-file .env up -d
   ```

## Upgrading

### Bumping CRUX_VERSION

1. Edit `.env`, set `CRUX_VERSION=vX.Y.Z`.
2. `make down && make up`.
3. `make smoke` to verify.

### Bumping AGENTGATEWAY_VERSION

The `AGENTGATEWAY_VERSION` in `.env.example` is pinned to the version validated
in CI (`crux-server/internal/agentgateway/version.go`). Do not change this
independently of a crux-server release that updates `PinnedVersion`.

To apply a new pin:
1. Check the release notes for the new `crux-server` version.
2. Edit `.env`, set `AGENTGATEWAY_VERSION=<new-tag>`.
3. `make down && make up`.
4. `make smoke`. If smoke fails, revert and file an issue.

## Troubleshooting

- **crux-server exits immediately with "store init"**: Postgres is not healthy
  yet. Check: `docker compose --env-file .env logs postgres`.

- **agentgateway healthcheck fails**: Check agentgateway logs:
  `docker compose --env-file .env logs agentgateway`.
  Verify `agentgateway/config.yaml` exists and is valid YAML.

- **smoke.sh: `curl` returns non-2xx on `/v1/agbom/default/claude`**: The
  `POST /v1/resources/apply` may have returned an error. Re-run with
  `bash -x ./scripts/smoke.sh` to see the full curl output.

- **Port conflict on 8080**: Another service on your host is already using
  8080. Change `AGENTGATEWAY_ADMIN_PORT` in `.env` and update
  `CRUX_AGENTGATEWAY_ADMIN_URL` in `compose.yaml` accordingly (or use an
  override file).

## Production hardening

V0.1 ships as a developer and small-team self-hosted stack. Before exposing
to a network:

- Change every default credential in `.env`:
  `POSTGRES_PASSWORD`, `CRUX_SERVER_API_KEY`.
- Place a TLS-terminating reverse proxy (nginx, Caddy, Traefik) in front of
  `crux-server` (7700) and `crux-console` (7780).
- Run Postgres on managed infrastructure or with verified backups.
- Enable OIDC authentication: `CRUX_CONSOLE_AUTH_MODE=oidc` (V0.2+).
- Set egress allow-lists on `agentgateway` before registering external MCPServers.
- Do not publish `agentgateway`'s admin port (8080) externally — crux-server
  uses it internally over the `crux` bridge network.

For Kubernetes deployment, wait for V0.3 + the Helm chart.

## Uninstall

```bash
make nuke
```

This stops all containers and removes all Docker volumes (Postgres data). The
`.env` file is not deleted.
