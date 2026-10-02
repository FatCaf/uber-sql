CREATE TABLE building (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    street_id BINARY(16) NOT NULL,
    type ENUM('house', 'residential', 'industrial', 'urban', 'commercial') NOT NULL,
    number VARCHAR(50) NOT NULL,
    name VARCHAR(255),
    location POINT NOT NULL SRID 4326,

    CONSTRAINT fk_building_street FOREIGN KEY (street_id) REFERENCES street (id) ON DELETE RESTRICT,
    CONSTRAINT uq_building_street_number UNIQUE (street_id, number),
    INDEX idx_building_name (name),
    INDEX idx_building_number (number),
    SPATIAL INDEX idx_building_location (location)
);
