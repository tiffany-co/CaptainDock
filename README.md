
# Gold Shop Management - CaptainDock

This repository is the central orchestration layer for the Gold Shop Management application. It uses Docker Compose and Git submodules to manage the `backend` and `frontend` services, ensuring a consistent development and production environment.

## 🚀 Getting Started

Follow these steps to set up the project on a new machine.

### 1. Clone the Repository

This project uses Git submodules. You must use the `--recurse-submodules` flag to clone the repository and automatically initialize and clone the `backend` and `frontend` repositories.

```bash
git clone --recurse-submodules https://github.com/tiffany-co/CaptainDock
cd captaindock

```

### 2. Configure Your Environment

The project requires an `.env` file in the root directory to store sensitive information and environment-specific settings.

-   Copy the example file: `cp .env.example .env`
    
-   Open the new `.env` file and customize the variables if necessary (e.g., change the default passwords or ports).
    

### 3. Branching Strategy

This project follows a standard Git flow:

-   **`develop` branch:** All ongoing development and new features are merged into this branch. This is the primary branch for day-to-day work.
    
-   **`main` branch:** This branch is protected and contains only stable, tagged release versions. Code is merged from `develop` into `main` only when a new release is ready.
    

## 🛠️ Development Workflow

The development environment is designed to be flexible, running the backend code locally for easy debugging while using Docker for stateful services like the database.

For detailed instructions on setting up and running the backend locally, please refer to the [**Backend README**](https://github.com/tiffany-co/backend)

## 🚢 Production Workflow

The production environment is fully containerized for consistency and reliability.

### Running in Production

To build the images and start all services, run:

```
make up-prod-build

```

This will build the Docker images for the `backend` and `frontend`, start the containers, and automatically run database migrations.

To stop the production services, run:

```
make down-prod

```

### Managing the Production Environment

The `Makefile` provides safe and convenient commands to manage your running production application.

-   **Create an Admin User:**
    
    ```
    make create-admin-prod
    
    ```
    
-   **Truncate the Database (DANGEROUS):** This will delete all data and reset the database to a clean state.
    
    ```
    make truncate-db-prod
    
    ```
    

## 🧰 Tools and Troubleshooting

### Make

This project relies on `make` to simplify complex commands.

-   **Installation (Linux):** Usually pre-installed. If not, use your package manager (e.g., `sudo apt-get install build-essential`).
    
-   **Installation (Windows):** The easiest way is to install it via [Chocolatey](https://chocolatey.org/): `choco install make`.
    
-   **Usage:** To see all available commands, simply run `make` from the root directory.
    

### Windows Port Conflicts

Occasionally on Windows, the ports used by Docker may be reserved by the system. If you encounter errors related to a port being unavailable, you can try resetting the Windows NAT driver. Run these commands in an **Administrator PowerShell or Command Prompt**:

```
net stop winnat
net start winnat

```

### Database Monitoring with DBeaver

For a powerful and user-friendly GUI to view and manage your database, we recommend **DBeaver**.

-   **Download:**  [DBeaver Community Edition](https://dbeaver.io/download/) [unlimit version - soft98](https://soft98.ir/software/programming/2962-dbeaver.html)
    
-   **Connection Settings (for both Dev and Prod):**
    
    -   **Host:**  `localhost`
        
    -   **Port:** The `DB_PORT` you set in your `.env` file (default is `5432`).
        
    -   **Database:** The `POSTGRES_DB` from your `.env` file.
        
    -   **Username/Password:** The credentials from your `.env` file.