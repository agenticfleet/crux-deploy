# Configuration

Copy `.env.example` to `.env` and edit values in place.
Never commit `.env`.

| Variable | Default | Purpose |
|---|---|---|
| `CRUX_VERSION` | `main` | Image tag used for all Crux component images. |
| `AGENTGATEWAY_VERSION` | `latest` | agentgateway image tag. Pinned to the version validated by crux-server CI. |
| `AGENTGATEWAY_LOG_LEVEL` | `info` | agentgateway log verbosity. Use `debug` to trace MCP routing. |
| `AGENTGATEWAY_ADMIN_PORT` | `8080` | Host port for agentgateway admin API (crux-server pushes listener config here). |
| `AGENTGATEWAY_LISTENER_PORT` | `7702` | Host port for agentgateway MCP listener (managed-agent wedge target URL). |
| `CRUX_REQUIRE_SHIM` | `false` | Informational flag. Set to `true` when activating the shim profile. |
| `CRUX_MCP_INJECTION_SHIM_PORT` | `7702` | Host port for shim MCP listener (only relevant when `COMPOSE_PROFILES=shim`). |
| `POSTGRES_DB` | `crux` | Postgres database name. |
| `POSTGRES_USER` | `crux` | Postgres user. |
| `POSTGRES_PASSWORD` | `changeme` | Postgres password. Change before exposing to a network. |
| `CRUX_SERVER_PORT` | `7700` | Host port for crux-server REST API. |
| `CRUX_SERVER_LISTEN_ADDR` | `0.0.0.0` | Listen address for crux-server. |
| `CRUX_SERVER_API_KEY` | `change-me-please` | Bearer token for crux-server API auth. Change before exposing to a network. |
| `CRUX_WORKER_ID` | `selfhosted-worker-1` | Stable worker identity. |
| `CRUX_WORKER_CONCURRENCY` | `2` | Worker parallelism. Higher values consume more CPU and memory. |
| `CRUX_CONSOLE_PORT` | `7780` | Host port for crux-console operator UI. |
| `CRUX_CONSOLE_AUTH_MODE` | `none` | Console authentication mode. Reserved for OIDC in V0.2+. |
| `CRUX_GATEWAY_PORT` | `7701` | Host port for crux-gateway model gateway (V0.2+). |
| `OPENAI_API_KEY` | empty | Provider credential for crux-gateway (V0.2+). |
| `ANTHROPIC_API_KEY` | empty | Provider credential for crux-gateway (V0.2+). |
| `GOOGLE_API_KEY` | empty | Provider credential for crux-gateway (V0.2+). |

## Validate

```bash
make config
```
