PHONY :=
PROJECT_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
DUMP := directus.sql

# Include project env vars (if exists)
-include .env

PHONY += backup
backup: ## Backup database
	docker exec -t $(COMPOSE_PROJECT_NAME)-database pg_dumpall -c -U $(POSTGRES_USER) > $(DUMP)

PHONY += restore
restore: ## Restore database
	cat $(DUMP) | docker exec -i $(COMPOSE_PROJECT_NAME)-database psql -U $(POSTGRES_USER)

PHONY += up
up: ## Start containers
	docker-compose up -d

.PHONY: $(PHONY)
