SELECT *
FROM collisions_raw
LIMIT 10; -- checking if the import of the raw data has been imported successfully.

SELECT COUNT(*) AS total_rows
FROM collisions_raw; -- checking total count of rows of the raw data : 513801

SELECT DISTINCT collision_year
FROM collisions_raw
ORDER BY collision_year; -- checking for 5 years of data from raw dataset : 2021, 2022, 2023, 2024, 2025

SELECT
    collision_index,
    COUNT(*) AS occurrence_count
FROM collisions_raw
GROUP BY collision_index
HAVING COUNT(*) > 1; -- checks for validation if each row in occurrence is unique and has any duplicates : No

SELECT COUNT(*) AS missing_collision_ids
FROM collisions_raw
WHERE collision_index IS NULL
OR TRIM(collision_index) = ''; -- checks if after trimming collision_index there is empty or whitespace.

SELECT
    collision_severity,
    COUNT(*) AS collisions
FROM collisions_raw
GROUP BY collision_severity
ORDER BY collision_severity; -- The outputs are numbers, which represent text corresponding to fatal, serious, slight. : 1, 2, 3

SELECT date
FROM collisions_raw
LIMIT 20; -- checking format of date : 04/10/2025

SELECT DISTINCT speed_limit
FROM collisions_raw
ORDER BY speed_limit; -- checking if the data is safe to convert to an Integer.

SELECT DISTINCT number_of_vehicles
FROM collisions_raw
ORDER BY number_of_vehicles; -- checking if the data is safe to convert to an Integer.

SELECT DISTINCT number_of_casualties
FROM collisions_raw
ORDER BY number_of_casualties; -- checking if the data is safe to convert to an Integer.