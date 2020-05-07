#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER obdeploy;
    CREATE DATABASE gateway;
    GRANT ALL PRIVILEGES ON DATABASE gateway TO obdeploy;
EOSQL
