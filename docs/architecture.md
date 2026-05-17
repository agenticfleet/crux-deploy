# Deployment Architecture

```text
operator
  |
  v
crux-console ───────┐
crux-cli     ───────┼──> crux-server ───> postgres
crux-worker  ───────┤         |
crux-gateway ───────┘         v
                         agentgateway
                         (MCP listener + admin API)
```

`crux-server` is the stateful control plane. It pushes listener/route/backend
configuration to `agentgateway` via the admin API at startup and when resources
change.

`crux-worker` executes jobs dispatched by crux-server.

`crux-gateway` routes custom-agent model/API calls (V0.2+; running but no-op in V0.1).

`agentgateway` is the data plane. Managed agents connect to its MCP listener
on port 7702. crux-server programs it at runtime.

`crux-console` is the read-only operator UI.

`crux-cli` is available as an optional `tools` profile.

`crux-mcp-injection-shim` is an optional `shim` profile service, activated only
if the pinned `agentgateway` release fails the wedge demo smoke test.
