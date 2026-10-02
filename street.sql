CREATE TABLE street (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    name VARCHAR(255) NOT NULL,
    district_id BINARY(16) NOT NULL,
    is_pedestrian BOOLEAN NOT NULL DEFAULT FALSE,
    is_mono_directional BOOLEAN NOT NULL DEFAULT FALSE,
    is_blocked BOOLEAN NOT NULL DEFAULT FALSE,
    type ENUM('street', 'avenue', 'boulevard', 'lane', 'square', 'descent', 'embankment', 'highway') NOT NULL DEFAULT 'street',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_district_id FOREIGN KEY (district_id) REFERENCES district (id) ON DELETE RESTRICT,
    CONSTRAINT uq_street_district_name UNIQUE (district_id, name),
    INDEX idx_street_name (name),
    INDEX idx_street_district_id (district_id)
);
