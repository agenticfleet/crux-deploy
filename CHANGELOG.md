# Changelog

All notable changes to `crux-deploy` will be documented here.

## Unreleased

- Replaced `crux-mcp-gateway` with `agentgateway` as the V0.1 data plane.
- Added `agentgateway` service with bootstrap config, healthcheck, and admin API port.
- Added `crux-mcp-injection-shim` as a profile-activated fallback service (`COMPOSE_PROFILES=shim`).
- Wired `crux-server` to `agentgateway` via `CRUX_AGENTGATEWAY_ADMIN_URL`.
- Added `scripts/smoke.sh` and `scripts/wait-for.sh` for V0.1 wedge demo verification.
- Added `Makefile` with `up`, `down`, `restart`, `config`, `logs`, `ps`, `smoke`, `nuke` targets.
- Added `docs/deployment-guide.md` with full install, ops, and production hardening guide.
- Refreshed `.env.example` with V0.1 variable surface.
- Updated README, architecture, images, configuration, and self-hosted docs.
- Added initial self-hosted Docker Compose deployment scaffold.
