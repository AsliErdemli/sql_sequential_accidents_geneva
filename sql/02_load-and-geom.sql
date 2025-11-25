/*
Load raw data and create geometry columns
*/

-- Load raw data into accidents_raw table

TRUNCATE TABLE accidents_raw; -- empty the table before loading new data
COPY accidents_raw(
    OBJECTID,
    ID_ACCIDENT,-- i.e. permanent original ID from data source 
    DATE_,
    GROUPE_ACCIDENT,
    TYPE, 
    CAUSE,
    COMMUNE,
    CONDITIONS_LUMINEUSES,
    CONDITIONS_METEO,
    CONSEQUENCES,
    COOR_X,
    COOR_Y,
    ETAT_ROUTE,
    GENRE_ROUTE,
    HEURE,
    JOUR,
    NB_ENFANTS_IMPLIQUES,
    NB_ENFANTS_ECOLE ,
    NB_BLESSES_LEGERS ,
    NB_BLESSES_GRAVES , 
    NB_TUES ,
    NB_PIETONS ,
    NB_BICYCLETTES ,
    NB_VAE_25 ,
    NB_VAE_45 ,
    NB_CYCLOMOTEURS ,
    NB_MOTOS_50 , 
    NB_MOTOS ,
    NB_VOITURES_TOURISME ,
    NB_VOITURES_LIVRAISON , 
    NB_CAMIONS ,
    NB_BUS , 
    NB_TRAM , 
    NB_TRAINS ,
    NB_SENIORS ,
    NB_TC ,
    REF_GROUPE_CAUSE ,
    TOTAL_PERSONNES ,
    ANNEE ,
    E  ,
    N 
)
FROM '/Users/asli/repositories/sql_sequential_accidents_geneva/data/OTC_ACCIDENTS-CSV/OTC_ACCIDENTS.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ';',
    ENCODING 'UTF8'
);

--Load raw data into stops_raw table
TRUNCATE TABLE stops_raw; -- empty the table before loading new data
COPY stops_raw(
    Ortschaftsname,
    PLZ,
    Zusatzziffer,
    Gemeindename,
    "BFS-Nr",
    "Kantonskürzel",
    E,
    N,
    Sprache,
    Validity
)
FROM '/Users/asli/repositories/sql_sequential_accidents_geneva/data/AMTOVZ_CSV_LV95.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ';',
    ENCODING 'UTF8'
);

-- Add geometry columns and populate them
ALTER TABLE accidents_raw
ADD COLUMN geom geometry(Point, 2056); -- accidents raw uses CH1903+ / LV95 coordinate system. 2056 is the EPSG code (SRID) for that.

UPDATE accidents_raw
SET geom = ST_SetSRID(
    ST_MakePoint(E, N),
     2056
);

ALTER TABLE stops_raw
ADD COLUMN geom geometry(Point, 2056);

UPDATE stops_raw
SET geom = ST_SetSRID(
    ST_MakePoint(E, N),
     2056
);
