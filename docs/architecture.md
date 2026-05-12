# Deployment Architecture

```text
operator
  |
  v
crux-console ───────┐
crux-cli     ───────┼──> crux-server ───> postgres
crux-worker  ───────┤
crux-gateway ───────┤
crux-mcp-gateway ───┘
```

`crux-server` is the stateful control plane.
`crux-worker` executes jobs.
`crux-gateway` routes custom-agent model/API calls.
`crux-mcp-gateway` governs MCP/tool traffic.
`crux-console` is the operator UI.
`crux-cli` is available as an optional tools profile.
