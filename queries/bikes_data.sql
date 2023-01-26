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
					ORDER BY bikes.start_time
				) bikes
		) bikes_data
LIMIT 100;

--post pandemic--

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
LIMIT 100;

drop table crime_per_station

create table crime_across_stations_02 as

with trains as (
	select station_name,
	latitude,
	longitude
	from clean_train_stations
),

crime as (
	select 
	case_number,
	date,
	latitude,
	longitude
	from clean_crime
)

SELECT 
	sub.station_name,
	coalesce(sum(case when sub.date_year = 2016 then crime_totals end), '0')::numeric as "2016", 
	coalesce(sum(case when sub.date_year = 2017 then crime_totals end), '0')::numeric as "2017",
	coalesce(sum(case when sub.date_year = 2018 then crime_totals end), '0')::numeric as "2018",
	coalesce(sum(case when sub.date_year = 2019 then crime_totals end), '0')::numeric as "2019",
	coalesce(sum(case when sub.date_year = 2020 then crime_totals end), '0')::numeric as "2020",
	coalesce(sum(case when sub.date_year = 2021 then crime_totals end), '0')::numeric as "2021",
	coalesce(sum(case when sub.date_year = 2022 then crime_totals end), '0')::numeric as "2022",
	coalesce(avg(crime_totals), '0')::numeric as "yearly_avg"			
	FROM(
		SELECT 
			station_name,
			date_part('year', "date") as date_year,
			count(distinct(case when (69.0410421 
						* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(trains.latitude::DECIMAL))
						* COS(RADIANS(crime.latitude::DECIMAL))
						* COS(RADIANS(trains.longitude::DECIMAL - crime.longitude::DECIMAL))
						+ SIN(RADIANS(trains.latitude::DECIMAL))
						* SIN(RADIANS(crime.latitude::DECIMAL))))))::DECIMAL(7,3) < '0.2' then crime.case_number end)) as crime_totals
			FROM crime, trains
			GROUP BY 1, 2
	) sub
	GROUP BY 1
	ORDER BY 9 DESC
	
	create index crime_by_stations on crime_at_stations("station_name", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "total")

select count(id) from crime
	-- 1,723,649 --
	-- 141,395 -- (3)
	-- 6,600 -- (2)
	
CREATE EXTENSION fuzzystrmatch;

create table ridership_across_stations as

select 
	supersub.*
	from (
	select	
		sub.station_number,
		sub.station_name,
		round(coalesce(avg(case when sub.date = 2016 then sub.rides end), '0')) as "2016", 
		round(coalesce(avg(case when sub.date = 2017 then sub.rides end), '0')) as "2017",
		round(coalesce(avg(case when sub.date = 2018 then sub.rides end), '0')) as "2018",
		round(coalesce(avg(case when sub.date = 2019 then sub.rides end), '0')) as "2019",
		round(coalesce(avg(case when sub.date = 2020 then sub.rides end), '0')) as "2020",
		round(coalesce(avg(case when sub.date = 2021 then sub.rides end), '0')) as "2021",
		round(coalesce(avg(case when sub.date = 2022 then sub.rides end), '0')) as "2022",
		round(avg(sub.rides)::decimal(10,3)) as "yearly_avg"
		from(
			select 
			station_number as station_number,
			stationname as station_name,
			date_part('year', date) as date, 
			rides 
			from clean_ridership 
			order by 3 DESC
			) sub
		group by 1, 2
		) supersub
	ORDER BY 10 ASC;

-- average daily rides across stations --

select	
	sub.station,
	round(avg(case when sub.daytype = 'W' then sub.rides end)) as "daily_avg_rides(weekday)",
	round(avg(case when sub.daytype = 'A' then sub.rides end)) as "daily_avg_rides(sat)",
	round(avg(case when sub.daytype = 'U' then sub.rides end)) as "daily_avg_rides(sun/hol)"
	from(
		select 
		ride.stationname as "station",
		ride.daytype, 
		ride.rides,
		(((ride.rides)::decimal / (daily.rail_boardings)::decimal) * '100')::decimal(4,3) as "% of total"
		from ridership ride
		join ridership_totals daily
			on ride.daytype = daily.day_type
		order by 2
		) sub
	group by 1;