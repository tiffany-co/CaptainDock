
# Gold Shop Management System

## Overview

This repository, `CaptainDock`, is the central hub for the Gold Shop Management System. It orchestrates the entire full-stack application, which includes a FastAPI backend, a frontend user interface, and the necessary database and caching services, all managed with Docker.

This document provides instructions for setting up, running, and managing the entire project.

## Prerequisites

Before you begin, ensure you have the following tools installed on your system:

-   **Git:** For version control. [Installation Guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
    
-   **Docker & Docker Compose:** For running the application in containers. [Install Docker Desktop](https://www.docker.com/products/docker-desktop/)
    
-   **Make:** A command-line utility to simplify complex commands.
    
    -   **macOS/Linux:** Usually pre-installed. You can check with `make -v`.
        
    -   **Windows:** Can be installed via [Chocolatey](https://community.chocolatey.org/packages/make) (`choco install make`) or by using a terminal like Git Bash or WSL which include it.
        

## Getting Started

1.  **Clone the Repository:** Clone this repository along with its submodules (`backend`, `frontend`) using the `--recurse-submodules` flag. This is crucial.
    
    ```
    git clone --recurse-submodules <your-repository-url>
    cd CaptainDock
    
    ```
    
2.  **Configure Environment:** The project uses a `.env` file for configuration. Create one by copying the example file:
    
    ```
    cp .env.example .env
    
    ```
    
    The default values in this file are suitable for local development. You do not need to change them to get started.
    

## Git Workflow

This project follows a standard Git flow model:

-   `develop`: This is the primary branch for all ongoing development. All new feature branches should be based on `develop` and merged back into it.
    
-   `main`: This branch contains only stable, tagged releases. It should **never** be committed to directly. Releases are made by merging `develop` into `main`.
    

**Updating the Project:** To pull the latest changes for this repository and all its submodules, run:

```
git pull --recurse-submodules

```

## Development Workflow (Local)

In development mode, the databases run inside Docker containers, but the backend and frontend code run directly on your local machine for easier debugging and hot-reloading.

### 1. Running the Backend

The backend is a FastAPI application. For detailed instructions on its setup, project structure, and database migrations, please refer to its dedicated documentation:

> [**backend/README.md**](https://github.com/tiffany-co/backend)

### 2. Running the Frontend

The frontend is a simple application. For instructions on its setup and development workflow, please refer to its dedicated documentation:

> [**frontend/README.md**](https://github.com/tiffany-co/frontend)

### 3. Starting Services

From the `CaptainDock` root directory, start the required database and Redis containers:

```
make up-dev

```

## Production Workflow (Docker)

In production mode, the entire application stack (backend, database, Redis) runs inside Docker containers, managed by `docker-compose.prod.yml`.

-   **Build and Start:** To build the Docker images and start the services in the background:
    
    ```
    make up-prod-build
    
    ```
    
-   **Stop:** To stop the production services:
    
    ```
    make down-prod
    
    ```
    

### Managing the Production Database

You can run administrative tasks on the production database via the running `backend` container.

-   **Create an Admin User:**
    
    ```
    make create-admin-prod
    
    ```
    
-   **Seed Demo Data:**
    
    ```
    make seed-db-prod
    
    ```
    
-   **Truncate the Database (DANGEROUS):**
    
    ```
    make truncate-db-prod
    
    ```
    

## Tools

### Using Make

This project uses a `Makefile` to provide simple, memorable commands for common operations. To see a full list of available commands and their descriptions, run:

```
make help

```

### Database Monitoring with DBeaver

A graphical tool like [DBeaver](https://dbeaver.io/) is highly recommended for viewing and managing the database.

**Connection Settings:**

-   **Host:**  `localhost`
    
-   **Database:**  `app` (or the value of `POSTGRES_DB` in your `.env` file)
    
-   **Port:**  `5433` (or the value of `DB_PORT` in your `.env` file)
    
-   **Username:**  `user` (or the value of `POSTGRES_USER`)
    
-   **Password:**  `password` (or the value of `POSTGRES_PASSWORD`)
    

## Troubleshooting

### Port Conflicts on Windows

Sometimes, Windows services may reserve the ports used by Docker. If you encounter errors related to a port being "already in use," you can often resolve it by running the following commands in an **Administrator PowerShell or Command Prompt**:

```
net stop winnat
net start winnat

```

Then, try running your `make` command again.