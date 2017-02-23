CREATE TABLE IF NOT EXISTS station (
  id SERIAL PRIMARY KEY,
  station_name VARCHAR(255) NOT NULL DEFAULT '',
  station_id INTEGER,
  city VARCHAR(255) NOT NULL DEFAULT '',
  coordinate POINT NOT NULL DEFAULT POINT(0, 0)
);

CREATE TABLE IF NOT EXISTS vehicle_type (
  id SERIAL PRIMARY KEY,
  vehicle_name VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS route (
  id SERIAL PRIMARY KEY,
  route_name VARCHAR(255) NOT NULL DEFAULT '',
  start_station_id INTEGER REFERENCES station(id),
  final_station_id INTEGER REFERENCES station(id),
  vehicle_type_id INTEGER REFERENCES vehicle_type(id)
);

CREATE TABLE IF NOT EXISTS neighb_stations (
  id BIGSERIAL PRIMARY KEY,
  from_station_id INTEGER REFERENCES station(id),
  to_station_id INTEGER REFERENCES station(id),
  route_id INTEGER REFERENCES route(id),
  departure_time TIME,
  arrival_time TIME,
  price REAL CONSTRAINT positive_price CHECK (price > 0),
  price_last_update_time TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tutu (
  id INTEGER,
  name VARCHAR(255),
  tutu_type VARCHAR(255)
);

CREATE TRIGGER distance_trigger BEFORE INSERT ON neighb_stations 
FOR EACH ROW EXECUTE PROCEDURE distance();

CREATE OR REPLACE FUNCTION distance() RETURNS trigger AS $$
DECLARE
    point_1 point;
    point_2 point;
BEGIN
  SELECT INTO point_1 FROM station AS s WHERE NEW.from_station_id = s.id;
  SELECT INTO point_2 FROM station AS s WHERE NEW.to_station_id = s.id;
  INSERT INTO neighb_stations(price) VALUES (point_1 <@> point_2);
END
$$ LANGUAGE plpgsql;
