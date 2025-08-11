# PostgreSQL with Liquibase Setup

This repository contains a Docker setup for PostgreSQL and Liquibase for database migrations.

## Prerequisites

- Docker and Docker Compose installed
- Liquibase CLI installed (for direct commands)

## Getting Started

### 1. Start the PostgreSQL Container

```bash
docker-compose up -d
```

This will start a PostgreSQL container with the following credentials:
- **Username**: postgres
- **Password**: postgres
- **Database**: postgres
- **Port**: 5432

### 2. Connect to PostgreSQL

You can connect to the PostgreSQL database using the provided script:

```bash
./run.sh
```

## Using Liquibase

Liquibase is a database schema change management tool that allows you to track, version, and deploy database changes.

### Liquibase Structure

- `liquibase/changelog.xml`: Master changelog file that includes all SQL scripts
- `liquibase/liquibase.properties`: Configuration file with database connection details
- `liquibase/sql/`: Directory containing SQL migration scripts

### Liquibase Commands

Here are some common Liquibase commands you can use:

#### Update Database

Apply all pending changesets to the database:

```bash
liquibase update
```

#### Generate Update SQL

Generate SQL for pending changesets without applying them:

```bash
liquibase update-sql
```

#### Rollback

Rollback the most recent changeset:

```bash
liquibase rollback-count 1
```

Rollback to a specific tag:

```bash
liquibase rollback TAG_NAME
```

#### Status

Check the status of changesets:

```bash
liquibase status
```

#### Validate

Validate the changelog for errors:

```bash
liquibase validate
```

#### History

View the history of applied changesets:

```bash
liquibase history
```

### Running Liquibase Commands

To run Liquibase commands, navigate to the liquibase directory and run:

```bash
cd liquibase
liquibase --defaultsFile=liquibase.properties <command>
```

For example:

```bash
cd liquibase
liquibase --defaultsFile=liquibase.properties update
```

## Sample Database Schema

The Liquibase changesets will create the following tables:

1. `users`: User information
2. `products`: Product catalog
3. `orders`: Customer orders
4. `order_items`: Items within orders

Each script includes rollback instructions for easy reversal of changes if needed.

## Troubleshooting

### Duplicate Changeset Identifiers

If you encounter an error like:
```
Validation Failed: 5 changesets had duplicate identifiers
```

This means that your changeset IDs are not unique across files. In our setup, each changeset has a unique identifier in the format `author:id`, for example:

```
--changeset testuser:01-create-users-table
```

Make sure each changeset has a unique ID across all your SQL files.
