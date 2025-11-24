SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT * FROM stops_raw
LIMIT 100;


SELECT * FROM accidents_raw
LIMIT 100;