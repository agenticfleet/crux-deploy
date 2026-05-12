# Configuration

Copy `.env.example` to `.env` and edit values in place.
Never commit `.env`.

| Variable | Default | Purpose |
|---|---|---|
| `CRUX_VERSION` | `main` | Image tag used for all Crux component images. |
| `CRUX_SERVER_PORT` | `7700` | Host port for `crux-server`. |
| `CRUX_GATEWAY_PORT` | `7701` | Host port for `crux-gateway`. |
| `CRUX_MCP_GATEWAY_PORT` | `7702` | Host port for `crux-mcp-gateway`. |
| `CRUX_CONSOLE_PORT` | `7780` | Host port for `crux-console`. |
| `POSTGRES_DB` | `crux` | Postgres database name. |
| `POSTGRES_USER` | `crux` | Postgres user. |
| `POSTGRES_PASSWORD` | `changeme` | Postgres password; change before real deployments. |
| `CRUX_WORKER_ID` | `selfhosted-worker-1` | Stable worker identity. |
| `CRUX_WORKER_CONCURRENCY` | `2` | Worker parallelism. Higher values consume more CPU and memory. |
| `OPENAI_API_KEY` | empty | Optional provider credential for custom agents once gateway implementation lands. |
| `ANTHROPIC_API_KEY` | empty | Optional provider credential for custom agents once gateway implementation lands. |
| `GOOGLE_API_KEY` | empty | Optional provider credential for custom agents once gateway implementation lands. |
| `CRUX_CONSOLE_AUTH_MODE` | `none` | Reserved for console authentication implementation. |

## Validate

```bash
docker compose --env-file .env config
```
