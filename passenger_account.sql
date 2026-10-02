CREATE TABLE passenger_account (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    user_id BINARY(16) NOT NULL,
    rating DECIMAL(3, 2) NOT NULL DEFAULT 5.00,
    completed_rides_count INT UNSIGNED NOT NULL DEFAULT 0,
    cancelled_rides_count INT UNSIGNED NOT NULL DEFAULT 0,
    preferred_payment_method ENUM('cash', 'card') NOT NULL DEFAULT 'cash',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_passenger_account_user FOREIGN KEY (user_id)
        REFERENCES user (id) ON DELETE CASCADE,
    CONSTRAINT uq_passenger_account_user_id UNIQUE (user_id),
    CONSTRAINT chk_passenger_account_rating CHECK (rating BETWEEN 1.00 AND 5.00)
);
