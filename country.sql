CREATE TABLE country (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    name VARCHAR(255) NOT NULL,

    INDEX idx_country_name (name)
);
