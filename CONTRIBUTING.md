# Contributing

Crux Deploy owns the Docker Compose self-hosted deployment surface.

## Expectations

- Validate compose changes with `docker compose --env-file .env.example config`.
- Keep `.env.example`, `docs/configuration.md`, and `docs/self-hosted.md` aligned.
- Never commit `.env`, secrets, certificates, or private deployment material.
- Document image tag and upgrade changes in `CHANGELOG.md` and `RELEASES.md`.
