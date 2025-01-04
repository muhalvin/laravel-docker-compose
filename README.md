
# Laravel Dockerized App

This project demonstrates how to set up a Laravel application with Docker, providing a streamlined development environment using Docker Compose.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Environment Variables](#environment-variables)
- [Commands](#commands)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before getting started, make sure you have the following installed:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Installation

### 1. Clone the repository

Start by cloning the repository to your local machine.

```bash
git clone https://github.com/muhalvin/laravel-docker-compose.git
cd laravel-docker-compose
```

### 2. Build and start the containers

Run the following command to build and start the Docker containers for your application:

```bash
docker-compose up --build -d
```

This will build the Docker images and start the services defined in the `docker-compose.yml` file (Laravel app, MySQL database, etc.).

### 3. Install dependencies inside the container

Once the containers are running, you'll need to install Laravel's dependencies using Composer. Run:

```bash
docker-compose exec app composer install
```

### 4. Set up environment variables

Copy the example `.env` file to create your own `.env` file.

```bash
cp .env.example .env
```

Adjust the `.env` file settings to match your environment, especially for database connection settings.

### 5. Run migrations

Run the Laravel database migrations to set up your database:

```bash
docker-compose exec app php artisan migrate
```

## Usage

Once the containers are up and running, your Laravel app should be accessible at:

```bash
http://127.0.0.1:8000
```

You can use this URL to access the Laravel application in your browser.

## Environment Variables

You can customize various settings for your Laravel app using the `.env` file. Below are some key environment variables:

- `APP_NAME`: The name of your application.
- `APP_ENV`: The environment the app is running in (local, production, etc.).
- `APP_KEY`: The application encryption key (can be generated with `php artisan key:generate`).
- `DB_CONNECTION`: The database connection (default is `mysql`).
- `DB_HOST`: The database host (default is `db`, which matches the service name in Docker Compose).
- `DB_PORT`: The database port (default is `3306`).

Example `.env` configuration:

```env
APP_NAME=LaravelDockerApp
APP_ENV=local
APP_KEY=base64:yourappkeyhere
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=password
```

## Commands

Here are some useful commands you can run inside the Docker container:

- **Clear config cache**:

  ```bash
  docker-compose exec app php artisan config:clear
  ```

- **Run tests**:

  ```bash
  docker-compose exec app php artisan test
  ```

- **Access the app container**:

  ```bash
  docker-compose exec -it app bash
  ```

- **Stop and remove containers**:

  To stop the containers, run:

  ```bash
  docker-compose down
  ```

  To remove containers, volumes, and networks:

  ```bash
  docker-compose down --volumes --remove-orphans
  ```

  Check resource used by docker:

  ```bash
  docker stats
  ```

## Troubleshooting

- **Cannot connect to MySQL**: If you have issues connecting to the MySQL database, ensure the `DB_HOST` is set to `db` (the service name defined in `docker-compose.yml`).

- **Container not running**: If the container isn't running, check logs with:

  ```bash
  docker-compose logs app
  ```

- **Permission issues with `.env`**: Make sure the `.env` file has correct file permissions. If you encounter issues, run:

  ```bash
  chmod 644 .env
  ```

## Additional Information

For more details, check out this article: [Setting Up Laravel 11 with Docker](https://towardsdev.com/setting-up-a-laravel-11-with-docker-522eebbef82d)
