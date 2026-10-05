-- ============================================
-- Collision Severity Analysis
-- ============================================

SELECT
    collision_severity,
    COUNT(*) AS collision_count
FROM collisions
GROUP BY collision_severity;


SELECT MIN(collision_date) AS earliest_collision, MAX(collision_date) AS latest_collision
FROM collisions;

-- Collisions per year
SELECT
    EXTRACT(YEAR FROM collision_date) AS collision_year,
    COUNT(*) AS collision_count
FROM collisions
GROUP BY EXTRACT(YEAR FROM collision_date)
ORDER BY collision_year; -- extract the year of each collision, count them so we get the total per year.

-- Collision severity conversion using CASE statements.
SELECT collision_severity,
CASE 
WHEN collision_severity = 1 THEN 'Fatal'
WHEN collision_severity = 2 THEN 'Serious'
WHEN collision_severity = 3 THEN 'Slight'
ELSE 'Unknown'
END AS severity_description,
COUNT(*) AS collision_count
FROM collisions
GROUP BY collision_severity -- CASE converts the numeric code into readable label, group by collision severity, of 1, 2 and 3. counting collisions which fit into each group.

-- Collision severity conversion using CASE statements & calculating percentages of respective collision_severities.
SELECT
    collision_severity,
    CASE
        WHEN collision_severity = 1 THEN 'Fatal'
        WHEN collision_severity = 2 THEN 'Serious'
        WHEN collision_severity = 3 THEN 'Slight'
        ELSE 'Unknown'
    END AS severity_description,
    COUNT(*) AS collision_count,
    ROUND(
        (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ())::numeric, -- casts the end product into a numeric data type, which fits for ROUNDING
        2
    ) AS percentage_of_collisions -- SUM(COUNT(*)) OVER ()) - window function which allows you to calculate sum of the count over a window of rows, doesn't collate them into one row.
FROM collisions
GROUP BY collision_severity
ORDER BY collision_severity; -- 1.47% Fatal, 22.74% Serious, 75.79% is Slight.


-- How have collision volumes changed over the five-year period?
SELECT 
    collision_year, 
    COUNT(*) AS total_collisions,

    LAG(COUNT(*)) OVER (ORDER BY collision_year) AS previous_year_collisions,

    ROUND(
        (COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY collision_year))
        * 100.0 -- integer division
        / LAG(COUNT(*)) OVER (ORDER BY collision_year),
        2
    ) AS percentage_collision_difference_per_year

FROM collisions
GROUP BY collision_year
ORDER BY collision_year; -- From 2021 to 2022, 4.86% increase of collision incidents, 2022 to 2023, a drop of 1.65% of incidents, 2023 to 2024, decrease of 3.19%. 2024 to 2025, increase of 0.59%

-- Collisions by day
SELECT
    day_of_week,
    COUNT(*) AS collision_count
FROM collisions
GROUP BY day_of_week
ORDER BY day_of_week DESC;

-- Collisions by hour
SELECT EXTRACT(HOUR FROM collision_time) AS collision_hour, 
COUNT(*) AS collision_count
FROM collisions
WHERE collision_time IS NOT NULL
GROUP BY collision_hour
ORDER BY collision_hour;

-- Highest collision count and the hour
SELECT
    EXTRACT(HOUR FROM collision_time) AS collision_hour,
    COUNT(*) AS collision_count
FROM collisions
WHERE collision_time IS NOT NULL
GROUP BY collision_hour
ORDER BY collision_count DESC
LIMIT 1;

-- Casualties per collision
SELECT
    MIN(number_of_casualties) AS min_casualties,
    MAX(number_of_casualties) AS max_casualties,
    AVG(number_of_casualties) AS avg_casualties
FROM collisions;

--Checking for variance on casualties per collision.
SELECT
    collision_index,
    collision_date,
    number_of_vehicles,
    number_of_casualties
FROM collisions
ORDER BY number_of_casualties DESC
LIMIT 20; -- 142 casualties identified as an extreme outlier. Value retained pending validation against the casualties dataset