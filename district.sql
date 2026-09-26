CREATE TABLE district (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    name VARCHAR(255) NOT NULL,
    city_id BINARY(16) NOT NULL,
    surge_charge_coefficient DECIMAL(3, 2) NOT NULL DEFAULT 1.00,
    center_latitude DECIMAL(10, 8),
    center_longitude DECIMAL(11, 8),
    area MULTIPOLYGON NULL SRID 4326,

    CONSTRAINT fk_city_id FOREIGN KEY (city_id) REFERENCES city (id) ON DELETE RESTRICT,
    INDEX idx_district_name (name),
    INDEX idx_district_city_id (city_id),
    SPATIAL INDEX idx_district_area (area)
);
