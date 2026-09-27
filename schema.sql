-- ============================================================================
-- Complete Database Schema Definition
-- Sequentially structured to satisfy all foreign key dependency constraints.
-- ============================================================================

DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS district;
DROP TABLE IF EXISTS street;
DROP TABLE IF EXISTS building;
DROP TABLE IF EXISTS building_entrance;

-- ----------------------------------------------------------------------------
-- 1. COUNTRY
-- ----------------------------------------------------------------------------
CREATE TABLE country (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    name VARCHAR(255) NOT NULL,

    INDEX idx_country_name (name)
);

-- ----------------------------------------------------------------------------
-- 2. CITY
-- ----------------------------------------------------------------------------
CREATE TABLE city (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    name VARCHAR(255) NOT NULL,
    country_id BINARY(16) NOT NULL,

    CONSTRAINT fk_country_id FOREIGN KEY (country_id) REFERENCES country (id) ON DELETE RESTRICT,
    INDEX idx_city_name (name),
    INDEX idx_city_country_id (country_id)
);

-- ----------------------------------------------------------------------------
-- 3. DISTRICT
-- ----------------------------------------------------------------------------
CREATE TABLE district (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    name VARCHAR(255) NOT NULL,
    city_id BINARY(16) NOT NULL,
    surge_charge_coefficient DECIMAL(3, 2) NOT NULL DEFAULT 1.00,
    center_latitude DECIMAL(10, 8),
    center_longitude DECIMAL(11, 8),
    area MULTIPOLYGON NOT NULL SRID 4326,

    CONSTRAINT fk_city_id FOREIGN KEY (city_id) REFERENCES city (id) ON DELETE RESTRICT,
    INDEX idx_district_name (name),
    INDEX idx_district_city_id (city_id),
    SPATIAL INDEX idx_district_area (area)
);

-- ----------------------------------------------------------------------------
-- 4. STREET
-- ----------------------------------------------------------------------------
CREATE TABLE street (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    name VARCHAR(255) NOT NULL,
    district_id BINARY(16) NOT NULL,
    is_pedestrian BOOLEAN NOT NULL DEFAULT FALSE,
    is_mono_directional BOOLEAN NOT NULL DEFAULT FALSE,
    is_blocked BOOLEAN NOT NULL DEFAULT FALSE,
    type ENUM('street', 'avenue', 'boulevard', 'lane', 'square', 'descent', 'embankment', 'highway') NOT NULL DEFAULT 'street',

    CONSTRAINT fk_district_id FOREIGN KEY (district_id) REFERENCES district (id) ON DELETE RESTRICT,
    INDEX idx_street_name (name),
    INDEX idx_street_district_id (district_id),
    INDEX idx_street_district_name (district_id, name)
);

-- ----------------------------------------------------------------------------
-- 5. BUILDING
-- ----------------------------------------------------------------------------
CREATE TABLE building (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    street_id BINARY(16) NOT NULL,
    type ENUM('house', 'residential', 'industrial', 'urban', 'commercial') NOT NULL,
    number VARCHAR(50) NOT NULL,
    name VARCHAR(255),
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    location POINT NOT NULL SRID 4326,

    CONSTRAINT fk_building_street FOREIGN KEY (street_id) REFERENCES street (id) ON DELETE RESTRICT,
    INDEX idx_building_name (name),
    INDEX idx_building_number (number),
    INDEX idx_building_street_number (street_id, number),
    SPATIAL INDEX idx_building_location (location)
);

-- ----------------------------------------------------------------------------
-- 6. BUILDING ENTRANCE
-- ----------------------------------------------------------------------------
CREATE TABLE building_entrance (
    id BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID(), 1)),
    building_id BINARY(16) NOT NULL,
    label VARCHAR(100),
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    location POINT NOT NULL SRID 4326,

    CONSTRAINT fk_building_entrance_building FOREIGN KEY (building_id)
        REFERENCES building (id) ON DELETE CASCADE,
    INDEX idx_building_entrance_building_id (building_id),
    INDEX idx_building_entrance_label (label),
    SPATIAL INDEX idx_building_entrance_location (location)
);
