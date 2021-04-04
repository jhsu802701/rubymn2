# Docker Database Setup

This document explains how the database is set up in this app.  This is a handy reference for Dockerizing other Ruby on Rails apps.

# The docker/build User Inputs
* After you "git clone" this repository, you set up this app by running the docker/build script.
* This script asks you to enter the root name of your database (POSTGRES_DB), the database username (POSTGRES_USER), and the database password (POSTGRES_PASSWORD).
* This script then uses those inputs to fill in parameters in the ".env-docker/development/database".  These files and the ".env-docker/development/web" file are used by the docker-compose.yml file for the Docker setup.

# The config/database.yml File
* This file specifies the host name, username, password, and database names for the database of this Ruby on Rails app.
* Note that it relies on the environment variables POSTGRES_HOST, POSTGRES_USER, POSTGRES_PASSWORD, and POSTGRES_DB for these parameters.

# The ".env-docker/development/web" File
This file specifies the value of the environment variable POSTGRES_HOST.

# The ".env-docker/development/database" File
* This file specifies the value of the environment variables POSTGRES_USER, POSTGRES_PASSWORD, and POSTGRES_DB.
* Note that this file is EXCLUDED from the repository.  Instead, the docker/build script copies the ".env-docker/development/database-template" file and fills in the username, password, and database root name that you entered.

# Dockerfile
* This file specifies the process of building the "web" Docker container, the container that contains the Ruby on Rails app.
* Note that this file is EXCLUDED from the repository.  Instead, the docker/build script copies the "Dockerfile-template" file and fills in the Ruby version of this app as specified in the .ruby-version file.

# The docker-compose.yml File
### The "web" Docker Container (Ruby on Rails)
* This is based on the Dockerfile.
* This depends on the "database" Docker container (PostgreSQL).
* This relies on the ".env-docker/development/database" and ".env-docker/development/web" files for setting the environment variables.
### The "database" Docker Container (PostgreSQL)
* This is based on a PostgreSQL Docker image.
* This uses the ".env-docker/development/database" file to specify the values of environment variables.

# PostgreSQL Database Container Startup Actions
* The "database" Docker container has a built-in docker-entrypoint.sh script that automatically runs upon startup.
* The docker-entrypoint.sh script uses the environment variables POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB, and POSTGRES_HOST_AUTH_METHOD are used for creating a user and database.  Note that 3 of these 4 environment variables are specified in the ".env-docker/development/database" file.
* If a value for POSTGRES_PASSWORD is provided, there is no need to provide a value for POSTGRES_HOST_AUTH_METHOD.
* If the value of POSTGRES_HOST_AUTH_METHOD is set to "trust", there is no need to provide a value for POSTGRES_PASSWORD.  Thus, POSTGRES_HOST_AUTH_METHOD needs to be set to "trust" if the config/database.yml file of a Rails app does not specify a password for the development or test environments.
