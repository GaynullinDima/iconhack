CREATE TABLE IF NOT EXISTS station (
  id SERIAL PRIMARY KEY, station_name VARCHAR(255) NOT NULL DEFAULT '',
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
  price REAL,
  price_last_update_time TIMESTAMP
);	
