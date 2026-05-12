# Release Strategy

`crux-deploy` uses semver tags (`vX.Y.Z`) for compose bundle releases.

## Changelog

- `CHANGELOG.md` is the human-curated release history.
- Keep new work under `Unreleased`.
- Before tagging, move relevant entries from `Unreleased` into a dated `vX.Y.Z` section.

## GitHub Releases

- Tags matching `v*.*.*` run `.github/workflows/release.yml`.
- GitHub Release notes are generated from merged changes using `.github/release.yml`.
- Release notes must call out image tag defaults, required environment changes, port changes, data-volume changes, and upgrade steps.

## Image Pinning

- `CRUX_VERSION=main` tracks moving preview images.
- `CRUX_VERSION=vX.Y.Z` pins all Crux component images to the same release tag.
- Mixed-version deployments must be documented explicitly before they are supported.
