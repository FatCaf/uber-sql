CREATE TABLE user (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255),
    is_phone_verified BOOLEAN NOT NULL DEFAULT FALSE,
    is_email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    date_of_birth DATE,
    avatar_url VARCHAR(2048),
    locale VARCHAR(10) NOT NULL DEFAULT 'uk',
    status ENUM('active', 'blocked') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,

    UNIQUE INDEX uq_user_phone_not_deleted ((IF(deleted_at IS NULL, phone, NULL))),
    UNIQUE INDEX uq_user_email_not_deleted ((IF(deleted_at IS NULL, email, NULL))),
    INDEX idx_user_phone (phone),
    INDEX idx_user_email (email),
    CONSTRAINT chk_user_phone_e164 CHECK (phone REGEXP '^[+][1-9][0-9]{7,14}$'),
    FULLTEXT INDEX ft_user_name (first_name, last_name),
    INDEX idx_user_status (status)
);
