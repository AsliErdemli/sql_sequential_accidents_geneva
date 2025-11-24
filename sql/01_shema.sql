-- Schema for accident events database
-- Accident events 
DROP TABLE IF EXISTS accidents_raw;
CREATE TABLE accidents_raw (
    accident_id SERIAL PRIMARY KEY,
    source_id TEXT, -- i.e. original ID from data source 
    accident_datetime TIMESTAMP, 
    year INT, 
    month INT, 
    weekday INT, 
    accident_type   TEXT,
    event_description   TEXT,
    weather_condition   TEXT,
    N   DOUBLE PRECISION,
    E   DOUBLE PRECISION
    );

-- Public trasport stops 
DROP TABLE IF EXISTS stops_raw;
CREATE TABLE stops_raw (
    stop_id SERIAL PRIMARY KEY,
    source_id TEXT, -- i.e. original ID from data source
    stop_name TEXT, 
    municipality TEXT, 
    stop_type TEXT, 
    N DOUBLE PRECISION,
    E DOUBLE PRECISION 
);


-- Enable PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

ALTER TABLE accidents_raw
ADD COLUMN geom geometry(Point, 2056); -- accidents raw uses CH1903+ / LV95 coordinate system. 2056 is the EPSG code (SRID) for that.

UPDATE accidents_raw
SET geom = ST_SetSRID(ST_MakePoint(E, N, 2056);

ALTER TABLE stops_raw
ADD COLUMN geom geometry(Point, 2056);

UPDATE stops_raw
SET geom = ST_SetSRID(ST_MakePoint(E, N), 2056);

-- Spatial indexes
CREATE INDEX idx_accidents_geom ON accidents_raw USING GIST (geom);
CREATE INDEX idx_stops_geom     ON stops_raw     USING GIST (geom);
