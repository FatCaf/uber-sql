CREATE TABLE passenger_saved_place (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    passenger_account_id BINARY(16) NOT NULL,
    building_id BINARY(16) NOT NULL,
    building_entrance_id BINARY(16),
    label VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_passenger_saved_place_passenger FOREIGN KEY (passenger_account_id)
        REFERENCES passenger_account (id) ON DELETE CASCADE,
    CONSTRAINT fk_passenger_saved_place_building FOREIGN KEY (building_id)
        REFERENCES building (id) ON DELETE CASCADE,
    CONSTRAINT fk_passenger_saved_place_entrance FOREIGN KEY (building_entrance_id)
        REFERENCES building_entrance (id) ON DELETE SET NULL,
    CONSTRAINT uq_passenger_saved_place_passenger_label UNIQUE (passenger_account_id, label),
    INDEX idx_passenger_saved_place_building_id (building_id),
    INDEX idx_passenger_saved_place_entrance_id (building_entrance_id)
);
