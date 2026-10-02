# Database Schema Documentation

Brief overview of the spatial and address schema designed for taxi/dispatch systems, including entity descriptions and an Entity-Relationship (ER) diagram.

---

### Entity Descriptions

- **`country`**: Top-level geographical entity representing sovereign countries.
- **`city`**: Cities located within a specific country (`country_id`).
- **`district`**: Administrative and operational city districts containing spatial boundaries (`area` polygon/multipolygon), center coordinates, and dynamic surge pricing multipliers (`surge_charge_coefficient`).
- **`street`**: Roadways and thoroughfares inside districts with traffic attributes (`is_pedestrian`, `is_mono_directional`, `is_blocked`, `type`).
- **`building`**: Specific buildings located on streets with building classification (`type`), postal number, name, and spatial GIS point (`location`).
- **`building_entrance`**: Specific pickup/dropoff entrances and gates for a building with precise coordinates (`location`) and descriptive labels.
- **`user`**: Generic identity shared by every app role: name, phone (E.164) and email unique among non-deleted users (functional unique indexes on `IF(deleted_at IS NULL, ...)`, so a deleted user's contacts can be reused), verification flags, locale, account `status` (`active`/`blocked`), and soft delete via `deleted_at`.
- **`passenger_account`**: Passenger-app profile, strictly one-to-one with `user` (`user_id` is `UNIQUE`, cascades on user delete). Holds rating, ride counters, and preferred payment method.
- **`passenger_saved_place`**: Named pickup/dropoff shortcuts of a passenger ("Home", "Work", "Gym"), one-to-many from `passenger_account`, each pinned to a `building` and optionally to an exact `building_entrance` (not every building has one; entrance delete falls back to the building). Label is unique per passenger.

---

### Entity-Relationship Diagram

```mermaid
erDiagram
    country ||--o{ city : "contains"
    city ||--o{ district : "contains"
    district ||--o{ street : "contains"
    street ||--o{ building : "contains"
    building ||--o{ building_entrance : "has"
    user ||--o| passenger_account : "is"
    passenger_account ||--o{ passenger_saved_place : "saves"
    building ||--o{ passenger_saved_place : "referenced by"
    building_entrance |o--o{ passenger_saved_place : "referenced by"

    country {
        binary id PK
        varchar name
        timestamp created_at
        timestamp updated_at
    }

    city {
        binary id PK
        varchar name
        binary country_id FK
        timestamp created_at
        timestamp updated_at
    }

    district {
        binary id PK
        varchar name
        binary city_id FK
        decimal surge_charge_coefficient
        decimal center_latitude
        decimal center_longitude
        multipolygon area
        timestamp created_at
        timestamp updated_at
    }

    street {
        binary id PK
        varchar name
        binary district_id FK
        boolean is_pedestrian
        boolean is_mono_directional
        boolean is_blocked
        enum type
        timestamp created_at
        timestamp updated_at
    }

    building {
        binary id PK
        binary street_id FK
        enum type
        varchar number
        varchar name
        point location
        timestamp created_at
        timestamp updated_at
    }

    building_entrance {
        binary id PK
        binary building_id FK
        varchar label
        point location
        timestamp created_at
        timestamp updated_at
    }

    user {
        binary id PK
        varchar first_name
        varchar last_name
        varchar phone
        varchar email
        boolean is_phone_verified
        boolean is_email_verified
        date date_of_birth
        varchar avatar_url
        varchar locale
        enum status
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at
    }

    passenger_account {
        binary id PK
        binary user_id FK, UK
        decimal rating
        int completed_rides_count
        int cancelled_rides_count
        enum preferred_payment_method
        timestamp created_at
        timestamp updated_at
    }

    passenger_saved_place {
        binary id PK
        binary passenger_account_id FK
        binary building_id FK
        binary building_entrance_id FK
        varchar label
        timestamp created_at
        timestamp updated_at
    }
```
