SELECT *
FROM collisions
LIMIT 10; -- checking if transformation from collisions_raw worked on displaying the data types, e.g year

SELECT COUNT(*)
FROM collisions; -- Checking row count after transformation : 513801

SELECT
    (SELECT COUNT(*) FROM collisions_raw) AS raw_rows,
    (SELECT COUNT(*) FROM collisions) AS clean_rows;

--Reconciling row count after transformation 513801 : 513801