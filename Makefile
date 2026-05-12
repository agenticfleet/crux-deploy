.PHONY: config pull up down logs ps

COMPOSE = docker compose --env-file .env

config:
	$(COMPOSE) config

pull:
	$(COMPOSE) pull

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps
