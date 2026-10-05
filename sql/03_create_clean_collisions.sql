CREATE TABLE collisions (
    collision_index TEXT PRIMARY KEY,
    collision_year SMALLINT,
    collision_ref_no TEXT,

    location_easting_osgr INTEGER,
    location_northing_osgr INTEGER,
    longitude NUMERIC(9,6),
    latitude NUMERIC(9,6),

    police_force SMALLINT,
    collision_severity SMALLINT,

    number_of_vehicles SMALLINT,
    number_of_casualties SMALLINT,

    collision_date DATE,
    day_of_week SMALLINT,
    collision_time TIME,

    local_authority_district TEXT,
    local_authority_ons_district TEXT,
    local_authority_highway TEXT,
    local_authority_highway_current TEXT,

    first_road_class SMALLINT,
    first_road_number INTEGER,
    road_type SMALLINT,
    speed_limit SMALLINT,

    junction_detail_historic SMALLINT,
    junction_detail SMALLINT,
    junction_control SMALLINT,

    second_road_class SMALLINT,
    second_road_number INTEGER,

    pedestrian_crossing_human_control_historic SMALLINT,
    pedestrian_crossing_physical_facilities_historic SMALLINT,
    pedestrian_crossing SMALLINT,

    light_conditions SMALLINT,
    weather_conditions SMALLINT,
    road_surface_conditions SMALLINT,
    special_conditions_at_site SMALLINT,

    carriageway_hazards_historic SMALLINT,
    carriageway_hazards SMALLINT,

    urban_or_rural_area SMALLINT,
    did_police_officer_attend_scene_of_accident SMALLINT,
    trunk_road_flag SMALLINT,

    lsoa_of_accident_location TEXT,

    enhanced_severity_collision SMALLINT,
    collision_injury_based TEXT,

    collision_adjusted_severity_serious NUMERIC,
    collision_adjusted_severity_slight NUMERIC
);

 -- Inserting raw data into collisions with properly typed data.
INSERT INTO collisions (
    collision_index,
    collision_year,
    collision_ref_no,
    location_easting_osgr,
    location_northing_osgr,
    longitude,
    latitude,
    police_force,
    collision_severity,
    number_of_vehicles,
    number_of_casualties,
    collision_date,
    day_of_week,
    collision_time
)
SELECT
    collision_index,
    collision_year::SMALLINT, -- same syntax as Casting collision_year as smallint. smallint used to reference years as Integer stores larger values.
    collision_ref_no,

    NULLIF(TRIM(location_easting_osgr), '')::INTEGER, -- TRIM cuts down any white spaces in data. NULLIF - If this value is an empty string, convert it to NULL, otherwise keep it. Converts to integer.
    NULLIF(TRIM(location_northing_osgr), '')::INTEGER,

    NULLIF(TRIM(longitude), '')::NUMERIC,
    NULLIF(TRIM(latitude), '')::NUMERIC,

    police_force::SMALLINT,
    collision_severity::SMALLINT,

    number_of_vehicles::SMALLINT,
    number_of_casualties::SMALLINT,

    TO_DATE(date, 'DD/MM/YYYY'), -- converted proper year format.

    day_of_week::SMALLINT,

    NULLIF(TRIM(time), '')::TIME

FROM collisions_raw;

TRUNCATE TABLE collisions; -- Removing all the data within collisions as is incomplete. only imported 14 columns & type

-- Importing all the data from collisions_raw to collisions with correct data types.
INSERT INTO collisions (
    collision_index,
    collision_year,
    collision_ref_no,
    location_easting_osgr,
    location_northing_osgr,
    longitude,
    latitude,
    police_force,
    collision_severity,
    number_of_vehicles,
    number_of_casualties,
    collision_date,
    day_of_week,
    collision_time,
    local_authority_district,
    local_authority_ons_district,
    local_authority_highway,
    local_authority_highway_current,
    first_road_class,
    first_road_number,
    road_type,
    speed_limit,
    junction_detail_historic,
    junction_detail,
    junction_control,
    second_road_class,
    second_road_number,
    pedestrian_crossing_human_control_historic,
    pedestrian_crossing_physical_facilities_historic,
    pedestrian_crossing,
    light_conditions,
    weather_conditions,
    road_surface_conditions,
    special_conditions_at_site,
    carriageway_hazards_historic,
    carriageway_hazards,
    urban_or_rural_area,
    did_police_officer_attend_scene_of_accident,
    trunk_road_flag,
    lsoa_of_accident_location,
    enhanced_severity_collision,
    collision_injury_based,
    collision_adjusted_severity_serious,
    collision_adjusted_severity_slight
)

SELECT
    collision_index,
    NULLIF(TRIM(collision_year), '')::SMALLINT,
    NULLIF(TRIM(collision_ref_no), ''),

    NULLIF(TRIM(location_easting_osgr), '')::INTEGER,
    NULLIF(TRIM(location_northing_osgr), '')::INTEGER,

    NULLIF(TRIM(longitude), '')::NUMERIC,
    NULLIF(TRIM(latitude), '')::NUMERIC,

    NULLIF(TRIM(police_force), '')::SMALLINT,
    NULLIF(TRIM(collision_severity), '')::SMALLINT,

    NULLIF(TRIM(number_of_vehicles), '')::SMALLINT,
    NULLIF(TRIM(number_of_casualties), '')::SMALLINT,

    TO_DATE(date, 'DD/MM/YYYY'),

    NULLIF(TRIM(day_of_week), '')::SMALLINT,
    NULLIF(TRIM(time), '')::TIME,

    NULLIF(TRIM(local_authority_district), ''),
    NULLIF(TRIM(local_authority_ons_district), ''),
    NULLIF(TRIM(local_authority_highway), ''),
    NULLIF(TRIM(local_authority_highway_current), ''),

    NULLIF(TRIM(first_road_class), '')::SMALLINT,
    NULLIF(TRIM(first_road_number), '')::INTEGER,

    NULLIF(TRIM(road_type), '')::SMALLINT,
    NULLIF(TRIM(speed_limit), '')::SMALLINT,

    NULLIF(TRIM(junction_detail_historic), '')::SMALLINT,
    NULLIF(TRIM(junction_detail), '')::SMALLINT,
    NULLIF(TRIM(junction_control), '')::SMALLINT,

    NULLIF(TRIM(second_road_class), '')::SMALLINT,
    NULLIF(TRIM(second_road_number), '')::INTEGER,

    NULLIF(TRIM(pedestrian_crossing_human_control_historic), '')::SMALLINT,
    NULLIF(TRIM(pedestrian_crossing_physical_facilities_historic), '')::SMALLINT,
    NULLIF(TRIM(pedestrian_crossing), '')::SMALLINT,

    NULLIF(TRIM(light_conditions), '')::SMALLINT,
    NULLIF(TRIM(weather_conditions), '')::SMALLINT,
    NULLIF(TRIM(road_surface_conditions), '')::SMALLINT,
    NULLIF(TRIM(special_conditions_at_site), '')::SMALLINT,

    NULLIF(TRIM(carriageway_hazards_historic), '')::SMALLINT,
    NULLIF(TRIM(carriageway_hazards), '')::SMALLINT,

    NULLIF(TRIM(urban_or_rural_area), '')::SMALLINT,

    NULLIF(
        TRIM(did_police_officer_attend_scene_of_accident),
        ''
    )::SMALLINT,

    NULLIF(TRIM(trunk_road_flag), '')::SMALLINT,

    NULLIF(TRIM(lsoa_of_accident_location), ''),

    NULLIF(TRIM(enhanced_severity_collision), '')::SMALLINT,

    NULLIF(TRIM(collision_injury_based), ''),

    NULLIF(
        TRIM(collision_adjusted_severity_serious),
        ''
    )::NUMERIC,

    NULLIF(
        TRIM(collision_adjusted_severity_slight),
        ''
    )::NUMERIC

FROM collisions_raw;
