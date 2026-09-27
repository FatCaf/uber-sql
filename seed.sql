-- ============================================================================
-- Seed Script: Ukraine / Kropyvnytskyi (Кропивницький)
-- Re-runnable: cleans previous tables and populates realistic spatial & taxi data.
-- ============================================================================

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE building_entrance;
TRUNCATE TABLE building;
TRUNCATE TABLE street;
TRUNCATE TABLE district;
TRUNCATE TABLE city;
TRUNCATE TABLE country;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------------
-- 1. COUNTRY: Ukraine
-- ----------------------------------------------------------------------------
SET @country_ua_id = UUID_TO_BIN(UUID(), 1);

INSERT INTO country (id, name)
VALUES (@country_ua_id, 'Ukraine');

-- ----------------------------------------------------------------------------
-- 2. CITY: Kropyvnytskyi (Кропивницький)
-- ----------------------------------------------------------------------------
SET @city_krop_id = UUID_TO_BIN(UUID(), 1);

INSERT INTO city (id, name, country_id)
VALUES (@city_krop_id, 'Kropyvnytskyi', @country_ua_id);

-- ----------------------------------------------------------------------------
-- 3. DISTRICTS in Kropyvnytskyi
-- ----------------------------------------------------------------------------
SET @dist_tsentr_id       = UUID_TO_BIN(UUID(), 1);
SET @dist_kovalivka_id    = UUID_TO_BIN(UUID(), 1);
SET @dist_fortetsnyi_id   = UUID_TO_BIN(UUID(), 1);
SET @dist_podilskyi_id    = UUID_TO_BIN(UUID(), 1);
SET @dist_popova_id       = UUID_TO_BIN(UUID(), 1);
SET @dist_novomykol_id    = UUID_TO_BIN(UUID(), 1);

INSERT INTO district (id, name, city_id, surge_charge_coefficient, center_latitude, center_longitude, area)
VALUES
    (
        @dist_tsentr_id,
        'Центральний (Центр)',
        @city_krop_id,
        1.30,
        48.51150000,
        32.26420000,
        ST_GeomFromText('MULTIPOLYGON(((48.5050 32.2550, 48.5180 32.2550, 48.5180 32.2750, 48.5050 32.2750, 48.5050 32.2550)))', 4326)
    ),
    (
        @dist_kovalivka_id,
        'Ковалівка',
        @city_krop_id,
        1.15,
        48.52380000,
        32.26950000,
        ST_GeomFromText('MULTIPOLYGON(((48.5180 32.2600, 48.5300 32.2600, 48.5300 32.2800, 48.5180 32.2800, 48.5180 32.2600)))', 4326)
    ),
    (
        @dist_fortetsnyi_id,
        'Фортечний район',
        @city_krop_id,
        1.10,
        48.51850000,
        32.24200000,
        ST_GeomFromText('MULTIPOLYGON(((48.5000 32.2100, 48.5400 32.2100, 48.5400 32.2550, 48.5000 32.2550, 48.5000 32.2100)))', 4326)
    ),
    (
        @dist_podilskyi_id,
        'Подільський район',
        @city_krop_id,
        1.05,
        48.49800000,
        32.27500000,
        ST_GeomFromText('MULTIPOLYGON(((48.4800 32.2500, 48.5100 32.2500, 48.5100 32.3100, 48.4800 32.3100, 48.4800 32.2500)))', 4326)
    ),
    (
        @dist_popova_id,
        'Мікрорайон Попова - Жадова',
        @city_krop_id,
        1.25,
        48.49250000,
        32.22400000,
        ST_GeomFromText('MULTIPOLYGON(((48.4850 32.2150, 48.5020 32.2150, 48.5020 32.2350, 48.4850 32.2350, 48.4850 32.2150)))', 4326)
    ),
    (
        @dist_novomykol_id,
        'Новомиколаївка',
        @city_krop_id,
        1.00,
        48.53650000,
        32.25200000,
        ST_GeomFromText('MULTIPOLYGON(((48.5280 32.2400, 48.5500 32.2400, 48.5500 32.2650, 48.5280 32.2650, 48.5280 32.2400)))', 4326)
    );

-- ----------------------------------------------------------------------------
-- 4. STREETS in Kropyvnytskyi
-- ----------------------------------------------------------------------------
-- Central District Streets
SET @str_perspektyvna_id = UUID_TO_BIN(UUID(), 1);
SET @str_teatralna_id    = UUID_TO_BIN(UUID(), 1);
SET @str_soborna_id      = UUID_TO_BIN(UUID(), 1);
SET @str_shevchenka_id   = UUID_TO_BIN(UUID(), 1);
SET @str_pashutinska_id  = UUID_TO_BIN(UUID(), 1);
SET @str_chornovola_id   = UUID_TO_BIN(UUID(), 1);
SET @str_maidan_id       = UUID_TO_BIN(UUID(), 1);

-- Kovalivka Streets
SET @str_vokzalna_id     = UUID_TO_BIN(UUID(), 1);
SET @str_peremohy_id     = UUID_TO_BIN(UUID(), 1);
SET @str_chykalenka_id   = UUID_TO_BIN(UUID(), 1);

-- Fortetsnyi / Western Arteries
SET @str_telnova_id      = UUID_TO_BIN(UUID(), 1);
SET @str_heroiv_ukr_id   = UUID_TO_BIN(UUID(), 1);
SET @str_univ_ave_id     = UUID_TO_BIN(UUID(), 1);
SET @str_poltavska_id    = UUID_TO_BIN(UUID(), 1);

-- Popova - Zhadova Streets
SET @str_popova_id       = UUID_TO_BIN(UUID(), 1);
SET @str_zhadova_id      = UUID_TO_BIN(UUID(), 1);
SET @str_patona_id       = UUID_TO_BIN(UUID(), 1);

-- Podilskyi District Streets
SET @str_preobrazh_id    = UUID_TO_BIN(UUID(), 1);
SET @str_korolenka_id    = UUID_TO_BIN(UUID(), 1);
SET @str_oleksandr_id    = UUID_TO_BIN(UUID(), 1);

INSERT INTO street (id, name, district_id, is_pedestrian, is_mono_directional, is_blocked, type)
VALUES
    -- Center
    (@str_perspektyvna_id, 'вулиця Велика Перспективна', @dist_tsentr_id, FALSE, FALSE, FALSE, 'street'),
    (@str_teatralna_id,    'вулиця Театральна',           @dist_tsentr_id, TRUE,  FALSE, FALSE, 'street'),
    (@str_soborna_id,      'вулиця Соборна',              @dist_tsentr_id, FALSE, FALSE, FALSE, 'street'),
    (@str_shevchenka_id,   'вулиця Шевченка',             @dist_tsentr_id, FALSE, FALSE, FALSE, 'street'),
    (@str_pashutinska_id,  'вулиця Пашутінська',          @dist_tsentr_id, FALSE, TRUE,  FALSE, 'street'),
    (@str_chornovola_id,   'вулиця В''ячеслава Чорновола',@dist_tsentr_id, FALSE, FALSE, FALSE, 'street'),
    (@str_maidan_id,       'площа Героїв Майдану',        @dist_tsentr_id, TRUE,  FALSE, FALSE, 'square'),

    -- Kovalivka
    (@str_vokzalna_id,     'вулиця Вокзальна',            @dist_kovalivka_id, FALSE, FALSE, FALSE, 'street'),
    (@str_peremohy_id,     'проспект Перемоги',           @dist_kovalivka_id, FALSE, FALSE, FALSE, 'avenue'),
    (@str_chykalenka_id,   'вулиця Євгена Чикаленка',     @dist_kovalivka_id, FALSE, FALSE, FALSE, 'street'),

    -- Fortetsnyi
    (@str_telnova_id,      'вулиця Євгена Тельнова',      @dist_fortetsnyi_id, FALSE, FALSE, FALSE, 'street'),
    (@str_heroiv_ukr_id,   'вулиця Героїв України',       @dist_fortetsnyi_id, FALSE, FALSE, FALSE, 'street'),
    (@str_univ_ave_id,     'проспект Університетський',   @dist_fortetsnyi_id, FALSE, FALSE, FALSE, 'avenue'),
    (@str_poltavska_id,    'вулиця Полтавська',           @dist_fortetsnyi_id, FALSE, FALSE, FALSE, 'street'),

    -- Popova - Zhadova
    (@str_popova_id,       'вулиця Космонавта Попова',    @dist_popova_id, FALSE, FALSE, FALSE, 'street'),
    (@str_zhadova_id,      'вулиця Генерала Жадова',      @dist_popova_id, FALSE, FALSE, FALSE, 'street'),
    (@str_patona_id,       'вулиця Академіка Патона',     @dist_popova_id, FALSE, FALSE, FALSE, 'street'),

    -- Podilskyi
    (@str_preobrazh_id,    'вулиця Преображенська',       @dist_podilskyi_id, FALSE, FALSE, FALSE, 'street'),
    (@str_korolenka_id,    'вулиця Короленка',            @dist_podilskyi_id, FALSE, FALSE, FALSE, 'street'),
    (@str_oleksandr_id,    'Олександрійське шосе',        @dist_podilskyi_id, FALSE, FALSE, FALSE, 'highway');

-- ----------------------------------------------------------------------------
-- 5. BUILDINGS in Kropyvnytskyi
-- ----------------------------------------------------------------------------
-- Velyka Perspektyvna
SET @bld_miskrada_id     = UUID_TO_BIN(UUID(), 1);
SET @bld_depot_id        = UUID_TO_BIN(UUID(), 1);
SET @bld_hotel_kyiv_id   = UUID_TO_BIN(UUID(), 1);

-- Teatralna
SET @bld_teatr_id        = UUID_TO_BIN(UUID(), 1);
SET @bld_kava_teatr_id   = UUID_TO_BIN(UUID(), 1);

-- Soborna & Shevchenka
SET @bld_sobor_id        = UUID_TO_BIN(UUID(), 1);
SET @bld_cdu_univ_id     = UUID_TO_BIN(UUID(), 1);

-- Vokzalna & Kovalivka
SET @bld_railway_st_id   = UUID_TO_BIN(UUID(), 1);
SET @bld_kovalivka_res_id= UUID_TO_BIN(UUID(), 1);
SET @bld_elvorti_fact_id = UUID_TO_BIN(UUID(), 1);

-- Telnova & Heroiv Ukrainy & Universytetskyi
SET @bld_dendropark_id   = UUID_TO_BIN(UUID(), 1);
SET @bld_plazma_mall_id  = UUID_TO_BIN(UUID(), 1);
SET @bld_cntu_univ_id    = UUID_TO_BIN(UUID(), 1);
SET @bld_velmart_id      = UUID_TO_BIN(UUID(), 1);

-- Popova & Zhadova High-rises
SET @bld_popova_15_id    = UUID_TO_BIN(UUID(), 1);
SET @bld_popova_26_id    = UUID_TO_BIN(UUID(), 1);
SET @bld_zhadova_20_id   = UUID_TO_BIN(UUID(), 1);
SET @bld_zhadova_atb_id  = UUID_TO_BIN(UUID(), 1);

-- Podilskyi & Korolenka
SET @bld_preobrazh_12_id = UUID_TO_BIN(UUID(), 1);
SET @bld_hospital_id     = UUID_TO_BIN(UUID(), 1);
SET @bld_private_house_id= UUID_TO_BIN(UUID(), 1);
SET @bld_hydrosila_id    = UUID_TO_BIN(UUID(), 1);

INSERT INTO building (id, street_id, type, number, name, latitude, longitude, location)
VALUES
    -- Velyka Perspektyvna
    (
        @bld_miskrada_id,
        @str_perspektyvna_id,
        'urban',
        '41',
        'Кропивницька міська рада',
        48.51085000,
        32.26590000,
        ST_SRID(POINT(48.51085000, 32.26590000), 4326)
    ),
    (
        @bld_depot_id,
        @str_perspektyvna_id,
        'commercial',
        '48',
        'ТРЦ "Depot Center"',
        48.50942000,
        32.26418000,
        ST_SRID(POINT(48.50942000, 32.26418000), 4326)
    ),
    (
        @bld_hotel_kyiv_id,
        @str_perspektyvna_id,
        'commercial',
        '50',
        'Готель "Київ"',
        48.50889000,
        32.26350000,
        ST_SRID(POINT(48.50889000, 32.26350000), 4326)
    ),

    -- Teatralna
    (
        @bld_teatr_id,
        @str_teatralna_id,
        'urban',
        '4',
        'Театр Корифеїв ім. М. Кропивницького',
        48.51325000,
        32.26870000,
        ST_SRID(POINT(48.51325000, 32.26870000), 4326)
    ),
    (
        @bld_kava_teatr_id,
        @str_teatralna_id,
        'commercial',
        '24',
        'Кав''ярня "Дворцова" & Ресторація',
        48.51240000,
        32.26620000,
        ST_SRID(POINT(48.51240000, 32.26620000), 4326)
    ),

    -- Soborna & Shevchenka
    (
        @bld_sobor_id,
        @str_soborna_id,
        'urban',
        '1А',
        'Кафедральний собор Різдва Богородиці',
        48.51200000,
        32.26050000,
        ST_SRID(POINT(48.51200000, 32.26050000), 4326)
    ),
    (
        @bld_cdu_univ_id,
        @str_shevchenka_id,
        'urban',
        '1',
        'Центральноукраїнський державний університет ім. В. Винниченка',
        48.51460000,
        32.26280000,
        ST_SRID(POINT(48.51460000, 32.26280000), 4326)
    ),

    -- Kovalivka & Railway
    (
        @bld_railway_st_id,
        @str_vokzalna_id,
        'urban',
        '1',
        'Залізничний вокзал "Кропивницький"',
        48.52840000,
        32.27410000,
        ST_SRID(POINT(48.52840000, 32.27410000), 4326)
    ),
    (
        @bld_kovalivka_res_id,
        @str_vokzalna_id,
        'residential',
        '26',
        'ЖК "Ковалівський"',
        48.52510000,
        32.27180000,
        ST_SRID(POINT(48.52510000, 32.27180000), 4326)
    ),
    (
        @bld_elvorti_fact_id,
        @str_chykalenka_id,
        'industrial',
        '1',
        'Завод "Ельворті" / ПАТ "Ельворті"',
        48.52180000,
        32.26200000,
        ST_SRID(POINT(48.52180000, 32.26200000), 4326)
    ),

    -- Telnova, Heroiv Ukrainy, Universytetskyi
    (
        @bld_dendropark_id,
        @str_telnova_id,
        'urban',
        '1',
        'Дендропарк "Кропивницький"',
        48.51260000,
        32.23350000,
        ST_SRID(POINT(48.51260000, 32.23350000), 4326)
    ),
    (
        @bld_plazma_mall_id,
        @str_heroiv_ukr_id,
        'commercial',
        '22Б',
        'ТЦ "Плазма"',
        48.50850000,
        32.22810000,
        ST_SRID(POINT(48.50850000, 32.22810000), 4326)
    ),
    (
        @bld_cntu_univ_id,
        @str_univ_ave_id,
        'urban',
        '8',
        'Центральноукраїнський національний технічний університет (ЦНТУ)',
        48.50420000,
        32.22150000,
        ST_SRID(POINT(48.50420000, 32.22150000), 4326)
    ),
    (
        @bld_velmart_id,
        @str_univ_ave_id,
        'commercial',
        '29',
        'Гіпермаркет "Велмарт"',
        48.50150000,
        32.21720000,
        ST_SRID(POINT(48.50150000, 32.21720000), 4326)
    ),

    -- Popova - Zhadova High-rise Apartments
    (
        @bld_popova_15_id,
        @str_popova_id,
        'residential',
        '15к1',
        'Житловий 9-поверховий будинок',
        48.49420000,
        32.22680000,
        ST_SRID(POINT(48.49420000, 32.22680000), 4326)
    ),
    (
        @bld_popova_26_id,
        @str_popova_id,
        'residential',
        '26',
        'Житловий комплекс "Попова"',
        48.49120000,
        32.22310000,
        ST_SRID(POINT(48.49120000, 32.22310000), 4326)
    ),
    (
        @bld_zhadova_20_id,
        @str_zhadova_id,
        'residential',
        '20',
        'Багатоквартирний житловий будинок',
        48.49050000,
        32.21980000,
        ST_SRID(POINT(48.49050000, 32.21980000), 4326)
    ),
    (
        @bld_zhadova_atb_id,
        @str_zhadova_id,
        'commercial',
        '23',
        'Супермаркет "АТБ-Маркет"',
        48.48970000,
        32.22120000,
        ST_SRID(POINT(48.48970000, 32.22120000), 4326)
    ),

    -- Podilskyi, Korolenka, Poltavska
    (
        @bld_preobrazh_12_id,
        @str_preobrazh_id,
        'commercial',
        '12',
        'Торговий центр "Ятрань"',
        48.50410000,
        32.27100000,
        ST_SRID(POINT(48.50410000, 32.27100000), 4326)
    ),
    (
        @bld_hospital_id,
        @str_korolenka_id,
        'urban',
        '56',
        'Кіровоградська обласна лікарня',
        48.52040000,
        32.29150000,
        ST_SRID(POINT(48.52040000, 32.29150000), 4326)
    ),
    (
        @bld_private_house_id,
        @str_korolenka_id,
        'house',
        '78',
        'Приватний житловий будинок',
        48.52210000,
        32.29600000,
        ST_SRID(POINT(48.52210000, 32.29600000), 4326)
    ),
    (
        @bld_hydrosila_id,
        @str_poltavska_id,
        'industrial',
        '10',
        'Завод гідроарматури "Гідросила"',
        48.52980000,
        32.24750000,
        ST_SRID(POINT(48.52980000, 32.24750000), 4326)
    );

-- ----------------------------------------------------------------------------
-- 6. BUILDING ENTRANCES (Pick-up / Drop-off points)
-- ----------------------------------------------------------------------------
INSERT INTO building_entrance (id, building_id, label, latitude, longitude, location)
VALUES
    -- City Hall
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_miskrada_id,
        'Головний вхід (фасад)',
        48.51087000,
        32.26593000,
        ST_SRID(POINT(48.51087000, 32.26593000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_miskrada_id,
        'Вхід з двору / Парковка',
        48.51070000,
        32.26560000,
        ST_SRID(POINT(48.51070000, 32.26560000), 4326)
    ),

    -- Depot Center Mall
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_depot_id,
        'Центральний вхід №1 (з Перспективної)',
        48.50945000,
        32.26420000,
        ST_SRID(POINT(48.50945000, 32.26420000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_depot_id,
        'Вхід №2 (біля підземного паркінгу)',
        48.50930000,
        32.26400000,
        ST_SRID(POINT(48.50930000, 32.26400000), 4326)
    ),

    -- Theater
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_teatr_id,
        'Парадний вхід для глядачів',
        48.51327000,
        32.26873000,
        ST_SRID(POINT(48.51327000, 32.26873000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_teatr_id,
        'Службовий вхід (Акторський)',
        48.51310000,
        32.26840000,
        ST_SRID(POINT(48.51310000, 32.26840000), 4326)
    ),

    -- Railway Station
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_railway_st_id,
        'Центральний вестибюль / Каси',
        48.52843000,
        32.27415000,
        ST_SRID(POINT(48.52843000, 32.27415000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_railway_st_id,
        'Вихід до перону №1 (Зупинка таксі)',
        48.52860000,
        32.27440000,
        ST_SRID(POINT(48.52860000, 32.27440000), 4326)
    ),

    -- Dendropark
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_dendropark_id,
        'Головна арка (Вхід з вул. Тельнова)',
        48.51265000,
        32.23355000,
        ST_SRID(POINT(48.51265000, 32.23355000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_dendropark_id,
        'Західний вхід (Парковка атракціонів)',
        48.51220000,
        32.23150000,
        ST_SRID(POINT(48.51220000, 32.23150000), 4326)
    ),

    -- CNTU University
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_cntu_univ_id,
        'Головний корпус (Ректорат)',
        48.50425000,
        32.22155000,
        ST_SRID(POINT(48.50425000, 32.22155000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_cntu_univ_id,
        'Спорткомплекс / Гуртожитки',
        48.50380000,
        32.22080000,
        ST_SRID(POINT(48.50380000, 32.22080000), 4326)
    ),

    -- Residential Apartments: Popova 15k1 (4 Entrances)
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_popova_15_id,
        'Під''їзд 1 (кв. 1-36)',
        48.49421000,
        32.22670000,
        ST_SRID(POINT(48.49421000, 32.22670000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_popova_15_id,
        'Під''їзд 2 (кв. 37-72)',
        48.49423000,
        32.22680000,
        ST_SRID(POINT(48.49423000, 32.22680000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_popova_15_id,
        'Під''їзд 3 (кв. 73-108)',
        48.49425000,
        32.22690000,
        ST_SRID(POINT(48.49425000, 32.22690000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_popova_15_id,
        'Під''їзд 4 (кв. 109-144)',
        48.49427000,
        32.22700000,
        ST_SRID(POINT(48.49427000, 32.22700000), 4326)
    ),

    -- Residential Apartments: Zhadova 20 (3 Entrances)
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_zhadova_20_id,
        'Під''їзд 1',
        48.49052000,
        32.21975000,
        ST_SRID(POINT(48.49052000, 32.21975000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_zhadova_20_id,
        'Під''їзд 2',
        48.49054000,
        32.21985000,
        ST_SRID(POINT(48.49054000, 32.21985000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_zhadova_20_id,
        'Під''їзд 3',
        48.49056000,
        32.21995000,
        ST_SRID(POINT(48.49056000, 32.21995000), 4326)
    ),

    -- Regional Hospital
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_hospital_id,
        'Приймальне відділення (Невідкладна допомога / Швидка)',
        48.52045000,
        32.29155000,
        ST_SRID(POINT(48.52045000, 32.29155000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_hospital_id,
        'Центральний вхід / Поліклініка',
        48.52035000,
        32.29120000,
        ST_SRID(POINT(48.52035000, 32.29120000), 4326)
    ),

    -- Supermarket ATB
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_zhadova_atb_id,
        'Головний вхід для покупців',
        48.48972000,
        32.22123000,
        ST_SRID(POINT(48.48972000, 32.22123000), 4326)
    ),
    (
        UUID_TO_BIN(UUID(), 1),
        @bld_zhadova_atb_id,
        'Рампа розвантаження товару',
        48.48960000,
        32.22100000,
        ST_SRID(POINT(48.48960000, 32.22100000), 4326)
    );
