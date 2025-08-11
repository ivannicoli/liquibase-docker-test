--liquibase formatted sql

--changeset testuser:01-create-users-table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
--rollback DROP TABLE users;

--changeset testuser:01-create-users-index
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
--rollback DROP INDEX idx_users_email; DROP INDEX idx_users_username;
