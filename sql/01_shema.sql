-- Accident events 
CREATE TABLE accident_events (
    accident_id SERIAL PRIMARY KEY,
    source_id TEXT, -- i.e. original ID from data source 
    accident_datetime TIMESTAMP, 
    year INT, 
    month INT, 
    weekday INT, 
    hour INT, 
    severity TEXT, 
    accident_type   TEXT,
    event_description   TEXT,
    weather_condition   TEXT,
    N   DOUBLE PRECISION,
    E   DOUBLE PRECISION
    );