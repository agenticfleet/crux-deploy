.PHONY: up down restart config logs ps smoke nuke

COMPOSE = docker compose --env-file .env

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

restart: down up

config:
	$(COMPOSE) config > /dev/null && echo "compose config valid"

logs:
	$(COMPOSE) logs -f --tail=200

ps:
	$(COMPOSE) ps

smoke:
	./scripts/smoke.sh

# WARNING: destroys all volumes (postgres data, any persisted state).
nuke:
	$(COMPOSE) down -v
