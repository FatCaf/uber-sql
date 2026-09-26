CREATE TABLE city (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    name VARCHAR(255) NOT NULL,
    country_id BINARY(16) NOT NULL,

    CONSTRAINT fk_country_id FOREIGN KEY (country_id) REFERENCES country (id) ON DELETE RESTRICT,
    INDEX idx_city_name (name),
    INDEX idx_city_country_id (country_id)
);
