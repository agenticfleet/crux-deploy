# Troubleshooting

## Validate Compose

```bash
docker compose --env-file .env config
```

## Pull Images

```bash
docker compose --env-file .env pull
```

If image pulls fail, check:

- network access to `ghcr.io`,
- image tag in `CRUX_VERSION`,
- whether the component repository has published that tag.

## Logs

```bash
docker compose --env-file .env logs -f
```

Current scaffold images print a message and then stay alive for long-running services.
Once runtime implementation lands, service logs will include real startup diagnostics.

## Reset Local State

This deletes Postgres state:

```bash
docker compose --env-file .env down -v
```

Only use it when intentionally resetting a self-hosted environment.
