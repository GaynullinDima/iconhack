CREATE TABLE IF NOT EXISTS station (
  id  PRIMARY KEY AUTO_INCREMENT,
  station_name VARCHAR(255) NOT NULL DEFAULT '',
  city VARCHAR(255) NOT NULL DEFAULT '',
  coordinate POINT NOT NULL DEFAULT (0, 0)
);

CREATE TABLE IF NOT EXISTS vehicle_type (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  vehicle_name VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS route (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  route_name VARCHAR(255) NOT NULL DEFAULT '',
  start_station_id INTEGER REFERENCES station(id),
  final_station_id INTEGER REFERENCES station(id),
  vehicle_type_id INTEGER REFERENCES vehicle_type(id)
);

CREATE TABLE IF NOT EXISTS neighb_stations (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  from_station_id INTEGER REFERENCES station(id),
  to_station_id INTEGER REFERENCES station(id),
  route_id INTEGER REFERENCES route(id),
  departure_time TIME,
  arrival_time TIME,
  price REAL,
  price_last_update_time TIMESTAMP
);
