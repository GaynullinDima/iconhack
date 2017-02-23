import psycopg2
import sys
import pprint

class DB_connector:
    conn_string = "host='iconhack.bars66.com' dbname='postgres' user='postgres' password='10'"

    def __init__(self):
        self.conn = psycopg2.connect(self.conn_string)

    def connect(self, string):
        cursor = self.conn.cursor()
        cursor.execute(string)
        result = cursor.fetchall()
        return result

    def get_stations(self):
        stations = self.connect("SELECT id FROM station")
        return stations

    def get_connections(self):
        edges = self.connect("SELECT from_station_id, to_station_id, price FROM neighb_stations")
        return edges


def main():
    conn = DB_connector()
    stations = conn.get_stations()
    print(stations)
    edges = conn.get_connections()
    print(edges)


if __name__ == "__main__":
    main()
