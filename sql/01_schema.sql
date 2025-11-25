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
    OBJECTID INT  PRIMARY KEY,
    ID_ACCIDENT DOUBLE PRECISION,-- i.e. permanent original ID from source but not primary because of duplicates 
    DATE_ DATE,
    GROUPE_ACCIDENT TEXT,
    TYPE TEXT, 
    CAUSE TEXT,
    COMMUNE TEXT,
    CONDITIONS_LUMINEUSES TEXT,
    CONDITIONS_METEO TEXT,
    CONSEQUENCES TEXT,
    COOR_X DOUBLE PRECISION,
    COOR_Y DOUBLE PRECISION,
    ETAT_ROUTE TEXT,
    GENRE_ROUTE TEXT,
    HEURE TEXT, -- wrong format but, I don't know what format is correct yet
    JOUR TEXT,
    NB_ENFANTS_IMPLIQUES INT,
    NB_ENFANTS_ECOLE INT,
    NB_BLESSES_LEGERS INT,
    NB_BLESSES_GRAVES INT, 
    NB_TUES INT,
    NB_PIETONS INT,
    NB_BICYCLETTES INT,
    NB_VAE_25 INT,
    NB_VAE_45 INT,
    NB_CYCLOMOTEURS INT,
    NB_MOTOS_50 INT, 
    NB_MOTOS INT,
    NB_VOITURES_TOURISME INT,
    NB_VOITURES_LIVRAISON INT, 
    NB_CAMIONS INT,
    NB_BUS INT, 
    NB_TRAM TEXT, -- exceptional, values are BOOLEAN
    NB_TRAINS INT,
    NB_SENIORS INT,
    NB_TC INT,
    REF_GROUPE_CAUSE TEXT,
    TOTAL_PERSONNES INT,
    ANNEE INT,
    E   DOUBLE PRECISION,
    N   DOUBLE PRECISION
);

-- Create Public trasport stops (raw)
DROP TABLE IF EXISTS stops_raw;
CREATE TABLE stops_raw (
    stop_id SERIAL PRIMARY KEY,
    Ortschaftsname TEXT,
    PLZ INT,
    Zusatzziffer INT,
    Gemeindename TEXT,
    "BFS-Nr" INT,
    "Kantonskürzel" TEXT,
    E DOUBLE PRECISION,
    N DOUBLE PRECISION,
    Sprache TEXT,
    Validity DATE
);


-- Enable PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;
