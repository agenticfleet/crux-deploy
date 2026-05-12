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
| `CRUX_MCP_GATEWAY_API_KEYS` | `change-me,selfhosted-admin,selfhosted,admin,codex` | API keys in `token,principal,workspace,role,agent_family[,user]` records. Replace before exposing the gateway. |
| `CRUX_MCP_GATEWAY_DEFAULT_POLICY_EFFECT` | `deny` | MCP gateway fail-closed default policy posture. |
| `CRUX_MCP_GATEWAY_BOOTSTRAP_ALLOW_TOOLS` | empty | Optional comma-separated tool allowlist for smoke tests. |
| `CRUX_MCP_GATEWAY_DEFAULT_ADAPTER_ID` | `echo` | Default adapter for tool calls that omit an adapter. |
| `CRUX_MCP_GATEWAY_ALLOW_SHELL_ADAPTER` | `false` | Enables shell subprocess adapters. |
| `CRUX_MCP_GATEWAY_AUDIT_SIGNING_KEY` | empty | HMAC key for tamper-evident audit signatures. |
| `CRUX_MCP_GATEWAY_REQUIRE_AUDIT_SIGNATURE` | `false` | Requires the signing key before startup. |
| `CRUX_MCP_GATEWAY_DEFAULT_WORKSPACE_BUDGET_USD` | `100` | Default workspace tool-call budget. |
| `CRUX_MCP_GATEWAY_COST_PER_1K_TOKENS_USD` | `0.001` | Cost estimate multiplier. |
| `CRUX_MCP_GATEWAY_CONTEXT_BUDGET_BYTES` | `65536` | Context packing budget. |
| `CRUX_MCP_GATEWAY_PROMPT_INJECTION_PHRASES` | built-in phrases | Comma-separated scanner phrases. |
| `CRUX_MCP_GATEWAY_REPLAY_DRY_RUN_ONLY` | `true` | Keeps replay from performing outbound side effects. |
| `CRUX_CONSOLE_AUTH_MODE` | `none` | Reserved for console authentication implementation. |

## Validate

```bash
docker compose --env-file .env config
```
