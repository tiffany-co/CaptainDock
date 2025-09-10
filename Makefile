# Makefile - A developer's swiss army knife
# This version incorporates more advanced Docker and database commands.

# --- VARIABLES ---
DOCKER_COMPOSE_DEV = docker-compose -f docker-compose.dev.yml
DOCKER_COMPOSE_PROD = docker-compose -f docker-compose.prod.yml

# --- DEFAULT COMMAND ---
.PHONY: all help
all: help

# --- HELP ---
.PHONY: help
help:
	@echo "Usage: make [command]"
	@echo ""
	@echo "---------------- Development Environment ----------------"
	@echo "  up-dev              - Start development containers (Postgres, Redis)."
	@echo "  down-dev            - Stop development containers."
	@echo "  down-dev-volume     - Stop dev containers and remove the database volume."
	@echo ""
	@echo "---------------- Production Environment -----------------"
	@echo "  up-prod             - Start production containers using existing images."
	@echo "  up-prod-build       - Rebuild images and start production containers."
	@echo "  up-prod-build-debug - Rebuild and run in the foreground for debugging."
	@echo "  down-prod           - Stop production containers."
	@echo "  down-prod-volume    - Stop prod containers and remove all volumes."
	@echo ""
	@echo "---------------- Database Management ------------------"
	@echo "  db-migrate          - Generate a new Alembic migration script."
	@echo "  db-upgrade          - Apply database migrations to the dev DB."
	@echo "  db-downgrade        - Revert the last database migration on the dev DB."
	@echo ""
	@echo "---------------- Utilities ----------------------------"
	@echo "  create-admin        - Create an admin user for the dev DB."
	@echo "  truncate-db         - [DANGEROUS] Truncate the dev DB."
	@echo "  create-admin-prod   - Create an admin user in the running prod container."
	@echo "  truncate-db-prod    - [DANGEROUS] Truncate the prod DB via the container."


# --- DEVELOPMENT ENVIRONMENT COMMANDS ---
.PHONY: up-dev down-dev down-dev-volume
up-dev:
	@echo Starting development environment...
	$(DOCKER_COMPOSE_DEV) up -d

down-dev:
	@echo Stopping development environment...
	$(DOCKER_COMPOSE_DEV) down

down-dev-volume:
	@echo Stopping development environment and removing volumes...
	$(DOCKER_COMPOSE_DEV) down -v

# --- PRODUCTION ENVIRONMENT COMMANDS ---
.PHONY: up-prod up-prod-build up-prod-build-debug down-prod down-prod-volume
up-prod:
	@echo Starting production environment...
	$(DOCKER_COMPOSE_PROD) up -d

up-prod-build:
	@echo Rebuilding and starting production environment...
	$(DOCKER_COMPOSE_PROD) up -d --build

up-prod-build-debug:
	@echo Rebuilding and starting production environment in foreground...
	$(DOCKER_COMPOSE_PROD) up --build

down-prod:
	@echo Stopping production environment...
	$(DOCKER_COMPOSE_PROD) down

down-prod-volume:
	@echo Stopping production environment and removing volumes...
	$(DOCKER_COMPOSE_PROD) down -v

# --- DATABASE MANAGEMENT COMMANDS (LOCAL/DEV) ---
.PHONY: db-migrate db-upgrade db-downgrade truncate-db
db-migrate:
	cd backend && poetry run alembic revision --autogenerate -m "New migration"

db-upgrade:
	cd backend && poetry run alembic upgrade head

db-downgrade:
	cd backend && poetry run alembic downgrade -1

truncate-db:
	@echo Running database truncate script on dev DB...
	cd backend && poetry run python scripts/truncate_db.py

# --- UTILITIES (LOCAL/DEV) ---
.PHONY: create-admin
create-admin:
	@echo Creating admin user on dev DB...
	cd backend && poetry run python scripts/create_admin.py

# --- PRODUCTION MANAGEMENT COMMANDS (RUNNING ON CONTAINER) ---
.PHONY: create-admin-prod truncate-db-prod
create-admin-prod:
	@echo Creating admin user in the production container...
	$(DOCKER_COMPOSE_PROD) exec backend python scripts/create_admin.py

truncate-db-prod:
	@echo Running database truncate script in the production container...
	$(DOCKER_COMPOSE_PROD) exec backend python scripts/truncate_db.py

