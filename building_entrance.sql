CREATE TABLE building_entrance (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    building_id BINARY(16) NOT NULL,
    label VARCHAR(100),
    location POINT NOT NULL SRID 4326,

    CONSTRAINT fk_building_entrance_building FOREIGN KEY (building_id)
        REFERENCES building (id) ON DELETE CASCADE,
    CONSTRAINT uq_building_entrance_building_label UNIQUE (building_id, label),
    INDEX idx_building_entrance_building_id (building_id),
    INDEX idx_building_entrance_label (label),
    SPATIAL INDEX idx_building_entrance_location (location)
);
