create index station_names on clean_train_stations(station_number ASC, station_name, latitude, longitude);

create index ridership_index on ridership_across_stations(station_number, station_name, yearly_avg asc);

create index police_index on police_across_stations(station_number, station_name, police_totals asc);

create index grocery_index on grocery_across_stations(station_number, station_name, grocery_totals asc);

create index bikes_index on bikes_across_stations(station_number, station_name, bike_totals asc);

create index buses_index on buses_across_stations(station_number, station_name, bus_totals asc);

create index rental_index on rentals_across_stations(station_number, station_name, rental_totals asc);

create index crime_dates on clean_crime(date ASC, latitude, longitude);

create index crime_index_01 on crime_across_stations_01(station_number, station_name, crime_totals desc);

create index crime_index_02 on crime_across_stations_02(station_number, station_name, crime_totals desc);

create index crime_index_03 on crime_across_stations_03(station_number, station_name, crime_totals desc);