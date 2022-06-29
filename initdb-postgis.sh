#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# https://pgtune.leopard.in.ua/
# DB Version: 11
# OS Type: linux
# DB Type: web
# Total Memory (RAM): 4 GB
# CPUs num: 2
# Connections num: 150
# Data Storage: ssd
psql -c "ALTER SYSTEM SET max_connections = '150';"
psql -c "ALTER SYSTEM SET shared_buffers = '1GB';"
psql -c "ALTER SYSTEM SET effective_cache_size = '3GB';"
psql -c "ALTER SYSTEM SET maintenance_work_mem = '256MB';"
psql -c "ALTER SYSTEM SET checkpoint_completion_target = '0.7';"
psql -c "ALTER SYSTEM SET wal_buffers = '16MB';"
psql -c "ALTER SYSTEM SET default_statistics_target = '100';"
psql -c "ALTER SYSTEM SET random_page_cost = '1.1';"
psql -c "ALTER SYSTEM SET effective_io_concurrency = '200';"
psql -c "ALTER SYSTEM SET work_mem = '6990kB';"
psql -c "ALTER SYSTEM SET min_wal_size = '1GB';"
psql -c "ALTER SYSTEM SET max_wal_size = '2GB';"
psql -c "ALTER SYSTEM SET max_worker_processes = '2';"

# create databases
psql -c "CREATE DATABASE panama_imports;"

# restore database if dump file exists
if [ -f /opt/backups/panama-imports.sql ]; then
  echo "Restoring panama_imports..."
  #pg_restore -n postgres -d panama_imports -c --if-exists /opt/backups/panama-imports.sql
  psql panama < /opt/backups/panama-imports.sql
fi
