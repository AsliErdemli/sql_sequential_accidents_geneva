-- Schema for accident and public transport stops databases: building raw tables


ROLLBACK; -- aborts all previous commands in case of error

DROP SCHEMA public CASCADE;-- clean up all existing tables

--Recreate public schema, since I just destroyed it
CREATE SCHEMA public
  AUTHORIZATION postgres;

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
COMMENT ON SCHEMA public
  IS 'standard public schema';

-- Create Accident table (raw) 
DROP TABLE IF EXISTS accidents_raw;
CREATE TABLE accidents_raw (
    accident_id SERIAL PRIMARY KEY,
    source_id TEXT, -- i.e. original ID from data source 
    accident_datetime TIMESTAMP, 
    year INT, 
    month INT, 
    weekday INT, 
    accident_type  TEXT,
    event_description  TEXT,
    weather_condition  TEXT,
    N   DOUBLE PRECISION,
    E   DOUBLE PRECISION
);

-- Create Public trasport stops (raw)
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
