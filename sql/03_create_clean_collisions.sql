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