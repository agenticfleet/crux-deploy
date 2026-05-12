# Release Strategy

`crux-deploy` releases are compose bundles.
The bundle pins deployment files, documentation, and expected image tag semantics.

## Release Process

1. Update `CHANGELOG.md`.
2. Validate `docker compose --env-file .env.example config`.
3. Tag `vX.Y.Z`.
4. Let `.github/workflows/release.yml` create the GitHub Release.

## Notes

Release notes must include:

- default `CRUX_VERSION`,
- image tags expected to exist,
- required `.env` changes,
- port changes,
- volume or data migration notes,
- known limitations.
