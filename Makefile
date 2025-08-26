# Makefile for simplifying common development tasks.
# This version is cleaned up and uses a more cross-platform friendly syntax.

# Define variables for docker-compose files to make commands cleaner.
DOCKER_COMPOSE_DEV = docker-compose -f docker-compose.dev.yml
DOCKER_COMPOSE_PROD = docker-compose -f docker-compose.prod.yml

# Using .PHONY to ensure these targets run as commands, not as file checks.
.PHONY: all help up-dev down-dev up-prod down-prod create-admin truncate-db seed-db

# The default command that runs when you just type "make".
all: help

# Help command to display available commands and their descriptions.
help:
	@echo Usage: make [command]
	@echo Commands:
	@echo   up-dev          - Start the development environment.
	@echo   down-dev        - Stop the development environment.
	@echo   up-prod         - Start the production environment.
	@echo   down-prod       - Stop the production environment.
	@echo   create-admin    - (Not Implemented) Create an admin user.
	@echo   truncate-db     - (Not Implemented) Truncate all database tables.
	@echo   seed-db         - (Not Implemented) Seed the database with initial data.

# --- Development Environment Commands ---
up-dev:
	@echo Starting development environment...
	$(DOCKER_COMPOSE_DEV) up -d

down-dev:
	@echo Stopping development environment...
	$(DOCKER_COMPOSE_DEV) down

# --- Production Environment Commands ---
up-prod:
	@echo Starting production environment...
	$(DOCKER_COMPOSE_PROD) up -d

down-prod:
	@echo Stopping production environment...
	$(DOCKER_COMPOSE_PROD) down

# --- Database Management Commands (Placeholders) ---
create-admin:
	@echo Creating admin user...
	@echo Admin user creation script needs to be implemented.

truncate-db:
	@echo Truncating database...
	@echo Database truncation script needs to be implemented.

seed-db:
	@echo Seeding database...
	@echo Database seeding script needs to be implemented.
