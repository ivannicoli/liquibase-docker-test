#!/bin/bash

# Wait a moment for PostgreSQL to be fully up and running
echo "Waiting for PostgreSQL to start..."
sleep 3

# Connect to PostgreSQL
echo "Connecting to PostgreSQL..."
PGPASSWORD=postgres psql -h localhost -p 5432 -U postgres -d postgres

# If you want to execute a specific SQL command, uncomment and modify the following line:
# PGPASSWORD=postgres psql -h localhost -p 5432 -U postgres -d postgres -c "SELECT version();"
