/*

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
*/