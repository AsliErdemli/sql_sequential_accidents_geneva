--  How do accidents distribute over time?

-- Accidents per year + severity 
DROP MATERIALIZED VIEW IF EXISTS my_accidents_by_year;
CREATE MATERIALIZED VIEW my_accidents_by_year AS
SELECT
    ANNEE as year,
    CONSEQUENCES as severity,
    COUNT(*) AS accident_count
FROM accidents_raw
GROUP BY ANNEE, CONSEQUENCES
ORDER BY ANNEE, CONSEQUENCES;



-- Accidents by hour of day
-- First, we need to extract the hour from HEURE text field
-- Format appears to be: 18991230HHMMSS (last 6 digits are HHMMSS)
DROP MATERIALIZED VIEW IF EXISTS my_accidents_by_hour_of_day;
CREATE MATERIALIZED VIEW my_accidents_by_hour_of_day AS
SELECT
    SUBSTRING(HEURE, 9, 2)::INT AS hour_of_day,
    COUNT(*) AS accident_count
FROM accidents_raw
WHERE HEURE IS NOT NULL AND LENGTH(HEURE) >= 10
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- Accidents by day of week
DROP MATERIALIZED VIEW IF EXISTS my_accidents_by_day_of_week;
CREATE MATERIALIZED VIEW my_accidents_by_day_of_week AS
SELECT
    JOUR AS day_of_week,
    COUNT(*) AS accident_count
FROM accidents_raw
GROUP BY JOUR
ORDER BY 
    CASE JOUR
        WHEN 'Lundi' THEN 1
        WHEN 'Mardi' THEN 2
        WHEN 'Mercredi' THEN 3
        WHEN 'Jeudi' THEN 4
        WHEN 'Vendredi' THEN 5
        WHEN 'Samedi' THEN 6
        WHEN 'Dimanche' THEN 7
    END;

-- Accidents by month
DROP MATERIALIZED VIEW IF EXISTS my_accidents_by_month;
CREATE MATERIALIZED VIEW my_accidents_by_month AS
SELECT
    EXTRACT(MONTH FROM DATE_) AS month,
    TO_CHAR(DATE_, 'Month') AS month_name,
    COUNT(*) AS accident_count
FROM accidents_raw
GROUP BY month, month_name
ORDER BY month;

-- Accidents by lighting conditions
DROP MATERIALIZED VIEW IF EXISTS my_accidents_by_light;
CREATE MATERIALIZED VIEW my_accidents_by_light AS
SELECT
    CONDITIONS_LUMINEUSES AS lighting_condition,
    COUNT(*) AS accident_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM accidents_raw
GROUP BY CONDITIONS_LUMINEUSES
ORDER BY accident_count DESC;

-- Accidents by weather conditions
DROP MATERIALIZED VIEW IF EXISTS my_accidents_by_wheather;
CREATE MATERIALIZED VIEW my_accidents_by_wheather AS
SELECT
    CONDITIONS_METEO AS weather_condition,
    COUNT(*) AS accident_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM accidents_raw
GROUP BY CONDITIONS_METEO
ORDER BY accident_count DESC;

-- Temporal trend: accidents per year with totals
DROP MATERIALIZED VIEW IF EXISTS my_accidents_temporal_trend;
CREATE MATERIALIZED VIEW my_accidents_temporal_trend AS
SELECT
    ANNEE AS year,
    COUNT(*) AS total_accidents,
    SUM(NB_TUES) AS total_deaths,
    SUM(NB_BLESSES_GRAVES) AS total_serious_injuries,
    SUM(NB_BLESSES_LEGERS) AS total_minor_injuries
FROM accidents_raw
GROUP BY ANNEE
ORDER BY ANNEE;

-- Peak accident times (day of week + hour)
DROP MATERIALIZED VIEW IF EXISTS my_accidents_peak_times;
CREATE MATERIALIZED VIEW my_accidents_peak_times AS
SELECT
    JOUR AS day_of_week,
    SUBSTRING(HEURE, 9, 2)::INT AS hour_of_day,
    COUNT(*) AS accident_count
FROM accidents_raw
WHERE HEURE IS NOT NULL AND LENGTH(HEURE) >= 10
GROUP BY JOUR, hour_of_day
ORDER BY accident_count DESC
LIMIT 20;