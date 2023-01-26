create database divvy_bikes;

-- train locations --

create table train_locations(
	stop_id INTEGER PRIMARY KEY,
	direction_id TEXT NOT NULL, 
	stop_name TEXT NOT NULL,
	station_name TEXT NOT NULL, 
	station_descriptive_NAME TEXT NOT NULL,
	map_id INTEGER NOT NULL,
	"ADA" TEXT NOT NULL,
	RED TEXT NOT NULL,
	BLUE TEXT NOT NULL,
	"G" TEXT NOT NULL,
	BRN TEXT NOT NULL,
	"P" TEXT NOT NULL,
	Pexp TEXT NOT NULL,
	Y TEXT NOT NULL,
	Pnk TEXT NOT NULL,
	O TEXT NOT NULL,
	"location" TEXT NOT NULL
);

COPY train_locations(stop_id, direction_id, stop_name, station_name, station_descriptive_NAME,
		map_id, "ADA", RED, BLUE, "G", BRN, "P", Pexp, Y, Pnk, O, "location")
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\CTA_-_System_Information_-_List_of__L__Stops.csv' DELIMITER ',' CSV HEADER;
	
-- divvy trips --

drop table divvy_trips

create table divvy_trips(
	trip_id INTEGER PRIMARY KEY,
	start_time TIMESTAMP NOT NULL, 
	stop_time TIMESTAMP NOT NULL,
	bike_id TEXT NOT NULL, 
	trip_duration INTEGER NOT NULL,
	from_station_id TEXT NOT NULL,
	from_station_name TEXT NOT NULL,
	to_station_id TEXT NOT NULL,
	to_station_name TEXT NOT NULL,
	user_type TEXT NOT NULL,
	gender TEXT,
	birth_date INTEGER,
	from_longitude TEXT,
	from_latitude TEXT,
	from_location TEXT, 
	to_longitude TEXT,
	to_latitude TEXT,
	to_location TEXT
);

COPY divvy_trips(trip_id, start_time, stop_time,bike_id, trip_duration, from_station_id, from_station_name,
		 to_station_id, to_station_name, user_type,gender, birth_date, from_longitude, from_latitude, from_location, 
		 to_longitude, to_latitude, to_location)
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\Divvy_Trips.csv' DELIMITER ',' CSV HEADER;
	
-- bicycle stations --

drop table bus_stations

create table bus_stations(
	stop_id INTEGER PRIMARY KEY,
	cta_stop_name TEXT NOT NULL,
	direction TEXT NOT NULL, 
	routes TEXT NOT NULL,
	ward TEXT NOT NULL, 
	longitude TEXT NOT NULL, 
	latitude TEXT NOT NULL, 
	"location" TEXT NOT NULL,
	phase TEXT NOT NULL
);

COPY bus_stations(stop_id, cta_stop_name, direction, routes, ward, longitude, latitude, "location", phase)
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\CTA_-_System_Information_-_Bus_Stop_Locations_in_Digital_Sign_Project.csv'
	DELIMITER ',' CSV HEADER;

-- cta_ridership --

drop table cta_ridership

create table cta_ridership(
	station_id INTEGER NOT NULL,
	stationname TEXT NOT NULL,
	"date" TIMESTAMP NOT NULL,
	daytype TEXT NOT NULL,
	rides INTEGER NOT NULL
);

COPY cta_ridership(station_id, stationname, "date", daytype, rides)
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\CTA_-_Ridership_-__L__Station_Entries_-_Daily_Totals.csv' 
	DELIMITER ',' CSV HEADER;
	
-- bicycle stations --

drop table bicycle_stations

create table bicycle_stations(
	"id" BIGINT NOT NULL,
	station_name TEXT NOT NULL,
	total_docks INTEGER NOT NULL,
	docks_in_service INTEGER NOT NULL,
	status TEXT NOT NULL, 
	latitude TEXT NOT NULL,
	longitude TEXT NOT NULL,
	"location" TEXT NOT NULL
);

COPY bicycle_stations("id", station_name, total_docks, docks_in_service, status, latitude, longitude, "location")
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\Divvy_Bicycle_Stations.csv' DELIMITER ',' CSV HEADER;
	
-- crime --

drop table crime

create table crime (
	"id" BIGINT NOT NULL PRIMARY KEY,
	case_number TEXT,
	"date" TIMESTAMP, 
	block TEXT, 
	iucr TEXT,
	primary_type TEXT,
	description TEXT,
	location_description TEXT,
	arrest TEXT,
	domestic TEXT,
	beat TEXT,
	district TEXT,
	ward INTEGER,
	community_area TEXT,
	fbi_code TEXT,
	x_coordinate INTEGER,
	y_coordinate INTEGER,
	"year" INTEGER,
	updated_on TEXT,
	latitude TEXT,
	longitude TEXT,
	"location" TEXT
);

COPY crime("id",	case_number,	"date", 	block, 	iucr,	primary_type,	description,	location_description,	
		   arrest,	domestic,	beat,	district,	ward,	community_area,	fbi_code,	x_coordinate,	y_coordinate,	
		   "year",	updated_on,	latitude,	longitude,	"location")
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\Crimes_-_2001_to_Present.csv' DELIMITER ',' CSV HEADER;
	
-- affordable rental housing --

drop table affordable_rental_housing

create table affordable_rental_housing(
	community_area_name TEXT,
	community_area_number INTEGER,
	property_type TEXT,
	property_name TEXT,
	address TEXT,
	zip_code TEXT,
	phone_number TEXT,
	management_company TEXT,
	units INTEGER,
	x_coordinate DECIMAL,
	y_coordinate DECIMAL,
	latitude TEXT,
	longitude TEXT,
	"location" TEXT
);

COPY affordable_rental_housing(community_area_name,	community_area_number,	property_type,	property_name,	address,	zip_code,
	phone_number,	management_company,	units,	x_coordinate,	y_coordinate,	latitude,	longitude,	"location" )
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\Affordable_Rental_Housing_Developments.csv' DELIMITER ',' CSV HEADER;

-- grocery stores --

drop table grocery_stores

create table grocery_stores(
	store_name TEXT,
	address TEXT,
	zip TEXT,
	new_status TEXT,
	last_updated TIMESTAMP,
	"location" TEXT
);

COPY grocery_stores(store_name,	address,	zip,	new_status,	last_updated,	"location")
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\Grocery_Store_Status.csv' DELIMITER ',' CSV HEADER;

-- socioeconomically disadvantaged areas --	

drop table socioeconomically_disadvantaged_areas

create table socioeconomically_disadvantaged_areas(
	the_geom TEXT
);

COPY socioeconomically_disadvantaged_areas(the_geom) 
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\Socioeconomically_Disadvantaged_Areas.csv'  DELIMITER ',' CSV HEADER;

-- police stations --

drop table police_stations

create table police_stations(
	district TEXT,
	district_name TEXT,
	address TEXT,
	city TEXT,
	"state" TEXT,
	zip TEXT,
	website TEXT,
	phone TEXT,
	fax TEXT,
	tty TEXT,
	x_coordinate DECIMAL,
	y_coordinate DECIMAL,
	latitude TEXT,
	longitude TEXT,
	"location" TEXT
);

COPY police_stations(district,	district_name,	address,	city,	"state",	zip,	website,	phone,	fax,	tty,	x_coordinate ,
	y_coordinate,	latitude,	longitude,	"location" )
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\Police_Stations.csv' DELIMITER ',' CSV HEADER;
	
-- bus ridership --

drop table bus_ridership

create table bus_ridership (
	route TEXT,
	routename TEXT,
	month_beginning TIMESTAMP,
	avg_weekday_rides DECIMAL,
	avg_saturday_rides DECIMAL,
	"avg_sunday-holiday_rides" DECIMAL,
	monthtotal INTEGER
);

COPY bus_ridership (route,	routename,	month_beginning,	avg_weekday_rides,	avg_saturday_rides,	"avg_sunday-holiday_rides",	monthtotal)
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\CTA_-_Ridership_-_Bus_Routes_-_Monthly_Day-Type_Averages___Totals.csv'
	DELIMITER ',' CSV HEADER;
	
-- ward boundaries -- 

drop table ward_boundaries

create table ward_boundaries(
	ward INTEGER NOT NULL PRIMARY KEY,
	the_geom TEXT,
	objectid INTEGER,
	edit_date TIMESTAMP,
	ward_id INTEGER,
	globalid TEXT,
	st_area_sh DECIMAL,
	st_length_ DECIMAL
);

COPY ward_boundaries(ward,	the_geom ,	objectid,	edit_date,	ward_id,	globalid,	st_area_sh,	st_length_)
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\Boundaries_-_Wards__2023-_.csv' 
		DELIMITER ',' CSV HEADER;
		
create table ridership_totals as
	select *
	from daily_ridership_totals
	where date_part('year', "service_date") >= 2016
	
-- post pandemic --

drop table post_pandemic_divvy
	
create table post_pandemic_divvy(
	ride_id text,
    rideable_type text,
    started_at timestamp, 
    ended_at timestamp,
	start_station_name text,
	start_station_id int,
	end_station_name text,
	end_station_id int,
	start_lat numeric,
	start_lng numeric,
	end_lat numeric,
	end_lng numeric,
	member_casual text
);

COPY post_pandemic_divvy(ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual)
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\new\divvy_rides.csv' DELIMITER ',' CSV HEADER;
	
	
create table cleaned_divvy as
SELECT 
	bikes_data.trip_id, 
	bikes_data.bike_id, 
	bikes_data.start_date,
	bikes_data.start_time,
	bikes_data.end_date,
	bikes_data.end_time,
	bikes_data."time_elapsed(min)", 
	bikes_data.start_station,
	bikes_data.end_station,
	bikes_data."distance(mi)",
	case when bikes_data."time_elapsed(min)" = '0' then '0' else
	(bikes_data."distance(mi)" / bikes_data."time_elapsed(min)")::decimal(7,3) end as "speed(mi/min)",
	bikes_data.user_type,
	bikes_data.gender,
	bikes_data.birth_date
	FROM(
		SELECT 
			bikes.trip_id, 
			bikes.bike_id, 
			bikes.start_date,
			bikes.start_time,
			bikes.end_date,
			bikes.end_time,
			(60 * extract(hour from bikes."time_elapsed(min)")
				+ extract(minute from bikes."time_elapsed(min)"))::numeric as "time_elapsed(min)", 
			bikes.start_station as start_station,
			bikes.end_station as end_station,
			(69.0410421 *
			DEGREES(ACOS(LEAST(1.0, COS(RADIANS(bikes.start_lat::DECIMAL))
				* COS(RADIANS(bikes.end_lat::DECIMAL))
				* COS(RADIANS(bikes.start_long::DECIMAL - bikes.end_long::DECIMAL))
				+ SIN(RADIANS(bikes.start_lat::DECIMAL))
				* SIN(RADIANS(bikes.end_lat::DECIMAL))))))::DECIMAL(7,3) AS "distance(mi)",
			bikes.user_type,
			bikes.gender,
			bikes.birth_date
			FROM(
				 SELECT 
					bikes.trip_id, 
					bikes.bike_id, 
					bikes.start_time::date as start_date,
					bikes.start_time::time as start_time,
					bikes.stop_time::date as end_date,
					bikes.stop_time::time as end_time,
					bikes.stop_time - bikes.start_time as "time_elapsed(min)",
					start_stations.station_name as start_station,
					start_stations.latitude as start_lat,
					start_stations.longitude as start_long,
					end_stations.station_name as end_station,
					end_stations.latitude as end_lat,
					end_stations.longitude as end_long,
					bikes.user_type,
					bikes.gender,
					bikes.birth_date
					FROM divvy AS bikes
					INNER JOIN bicycle_stations AS start_stations 
						ON start_stations.station_name = bikes.from_station_name
					INNER JOIN bicycle_stations AS end_stations
						ON end_stations.station_name = bikes.to_station_name
					WHERE bikes.birth_date > '1930'
					ORDER BY bikes.start_time
				) bikes
		) bikes_data


create table cleaned_divvy_pp as
SELECT 
	bikes_data.trip_id, 
	bikes_data.start_date,
	bikes_data.start_time,
	bikes_data.end_date,
	bikes_data.end_time,
	bikes_data."time_elapsed(min)", 
	bikes_data.start_station,
	bikes_data.end_station,
	bikes_data."distance(mi)",
	case when bikes_data."time_elapsed(min)" = '0' then '0' else
	(bikes_data."distance(mi)" / bikes_data."time_elapsed(min)")::decimal(7,3) end as "speed(mi/min)",
	bikes_data.rideable_type,
	bikes_data.member_casual
	FROM(
		SELECT 
			bikes.trip_id, 
			bikes.start_date,
			bikes.start_time,
			bikes.end_date,
			bikes.end_time,
			(60 * extract(hour from bikes."time_elapsed(min)")
				+ extract(minute from bikes."time_elapsed(min)"))::numeric as "time_elapsed(min)", 
			bikes.start_station as start_station,
			bikes.end_station as end_station,
			(69.0410421 *
			DEGREES(ACOS(LEAST(1.0, COS(RADIANS(bikes.start_lat::DECIMAL))
				* COS(RADIANS(bikes.end_lat::DECIMAL))
				* COS(RADIANS(bikes.start_long::DECIMAL - bikes.end_long::DECIMAL))
				+ SIN(RADIANS(bikes.start_lat::DECIMAL))
				* SIN(RADIANS(bikes.end_lat::DECIMAL))))))::DECIMAL(7,3) AS "distance(mi)",
			bikes.rideable_type,
			bikes.member_casual
			FROM(
				 SELECT 
					bikes.ride_id as trip_id, 
					bikes.started_at::date as start_date,
					bikes.started_at::time as start_time,
					bikes.ended_at::date as end_date,
					bikes.ended_at::time as end_time,
					bikes.ended_at - bikes.started_at as "time_elapsed(min)",
					start_stations.station_name as start_station,
					start_stations.latitude as start_lat,
					start_stations.longitude as start_long,
					end_stations.station_name as end_station,
					end_stations.latitude as end_lat,
					end_stations.longitude as end_long,
					bikes.rideable_type,
					bikes.member_casual
					FROM post_pandemic_divvy AS bikes
					INNER JOIN bicycle_stations AS start_stations 
						ON start_stations.station_name = bikes.start_station_name
					INNER JOIN bicycle_stations AS end_stations
						ON end_stations.station_name = bikes.end_station_name
				) bikes
		) bikes_data
ORDER BY 2, 3

-- daily ridership totals --

drop table daily_ridership_totals

create table daily_ridership_totals(
	service_date TIMESTAMP,
	day_type TEXT,
	bus INTEGER,
	rail_boardings INTEGER,
	total_rides INTEGER
);

copy daily_ridership_totals(service_date, day_type, bus, rail_boardings, total_rides)
 FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\new\CTA_-_Ridership_-_Daily_Boarding_Totals.csv' 
 DELIMITER ',' CSV HEADER;
 
-- clean train stations --

drop table clean_train_stations

create table clean_train_stations(
	station_number INTEGER PRIMARY KEY,
	station_name TEXT,
	latitude NUMERIC,
	longitude NUMERIC
);

COPY clean_train_stations(station_number,station_name,latitude,longitude)
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\new\clean_train_stations.csv' DELIMITER ',' CSV HEADER;
	
-- ridership stations --

drop table ridership_stations 

create table ridership_stations (
	station_number INTEGER PRIMARY KEY,
	station_name TEXT
);

COPY ridership_stations (station_number,station_name)
	FROM 'C:\Users\evana\OneDrive\Desktop\GA Data Analytics Course\divvy\csv files\new\ridership_stations.csv' DELIMITER ',' CSV HEADER;