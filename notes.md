Row count of collisions_raw : 513801

SELECT
    collision_index,
    COUNT(*) AS occurrence_count
FROM collisions_raw
GROUP BY collision_index
HAVING COUNT(*) > 1;

This validates that in the raw data, collision_index is a primary identifier as it is unique, and does not appear more than once.

04/10/2026 - Summary
So far I have created the project outline with the necessary folders, set up on PostGreSQL, and imported the raw data from gov.uk regarding UK collisions, casualties and the vehicles.