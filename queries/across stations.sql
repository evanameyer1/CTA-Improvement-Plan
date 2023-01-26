-- police stations -- 	

drop table police_stations
create table clean_police_stations as
select 
	district_name,
	address,
	zip,
	round(latitude::decimal, 8) as latitude,
	round(longitude::decimal, 8) as longitude
	from police_stations

drop table police_across_stations
create table police_across_stations as
with t1 as(
select *
	from clean_police_stations
),

t2 as(
select * 
	from clean_train_stations
)

select 
		t2.station_number,
		t2.station_name,
		count(distinct(case when(69.0410421 
				* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t2.latitude::DECIMAL))
				* COS(RADIANS(t1.latitude::DECIMAL))
				* COS(RADIANS(t2.longitude::DECIMAL - t1.longitude::DECIMAL))
				+ SIN(RADIANS(t2.latitude::DECIMAL))
				* SIN(RADIANS(t1.latitude::DECIMAL))))))::DECIMAL(7,3) < '1.75' then district_name end)) as police_totals
	FROM t1, t2
	group by 1, 2 
	ORDER BY 3 DESC
	
-- grocery stores -- 	

drop table grocery_across_stations
create table grocery_across_stations as
with t1 as(
select *
	from clean_grocery_stores
),

t2 as(
select * 
	from clean_train_stations
)

select 
		t2.station_number,
		t2.station_name,
		count(distinct(case when(69.0410421 
				* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t2.latitude::DECIMAL))
				* COS(RADIANS(t1.latitude::DECIMAL))
				* COS(RADIANS(t2.longitude::DECIMAL - t1.longitude::DECIMAL))
				+ SIN(RADIANS(t2.latitude::DECIMAL))
				* SIN(RADIANS(t1.latitude::DECIMAL))))))::DECIMAL(7,3) < '0.5' then store_name end)) as grocery_totals
	FROM t1, t2
	group by 1, 2 
	ORDER BY 3 ASC
	
-- bike stations --

drop table bikes_across_stations
create table bikes_across_stations as
with t1 as(
select *
	from clean_bike_stations
),

t2 as(
select * 
	from clean_train_stations
)

select 
		t2.station_number,
		t2.station_name,
		count(distinct(case when(69.0410421 
				* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t2.latitude::DECIMAL))
				* COS(RADIANS(t1.latitude::DECIMAL))
				* COS(RADIANS(t2.longitude::DECIMAL - t1.longitude::DECIMAL))
				+ SIN(RADIANS(t2.latitude::DECIMAL))
				* SIN(RADIANS(t1.latitude::DECIMAL))))))::DECIMAL(7,3) < '0.3' then t1.station_name end)) as bike_totals
	FROM t1, t2
	group by 1, 2 
	ORDER BY 3 ASC
	
-- bus stations --

drop table buses_across_stations
create table buses_across_stations as
with t1 as(
select *
	from clean_bus_stations
),

t2 as(
select * 
	from clean_train_stations
)

select 
		t2.station_number,
		t2.station_name,
		count(distinct(case when(69.0410421 
				* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t2.latitude::DECIMAL))
				* COS(RADIANS(t1.latitude::DECIMAL))
				* COS(RADIANS(t2.longitude::DECIMAL - t1.longitude::DECIMAL))
				+ SIN(RADIANS(t2.latitude::DECIMAL))
				* SIN(RADIANS(t1.latitude::DECIMAL))))))::DECIMAL(7,3) < '0.3' then t1.stop_id end)) as bus_totals
	FROM t1, t2
	group by 1, 2 
	ORDER BY 3 ASC

-- rentals --

drop table rentals_across_stations
create table rentals_across_stations as
with t1 as(
select *
	from clean_affordable_rentals
),

t2 as(
select * 
	from clean_train_stations
)

select 
		t2.station_number,
		t2.station_name,
		count(distinct(case when(69.0410421 
				* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t2.latitude::DECIMAL))
				* COS(RADIANS(t1.latitude::DECIMAL))
				* COS(RADIANS(t2.longitude::DECIMAL - t1.longitude::DECIMAL))
				+ SIN(RADIANS(t2.latitude::DECIMAL))
				* SIN(RADIANS(t1.latitude::DECIMAL))))))::DECIMAL(7,3) < '0.5' then t1.property_name end)) as rental_totals
	FROM t1, t2
	group by 1, 2 
	ORDER BY 3 ASC
	
-- crime_01 --

drop table crime_across_stations_01
create table crime_across_stations_01 as
with t1 as(
select *
	from clean_crime
),

t2 as(
select * 
	from clean_train_stations
)

select 
		t2.station_number,
		t2.station_name,
		count(distinct(case when(69.0410421 
				* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t2.latitude::DECIMAL))
				* COS(RADIANS(t1.latitude::DECIMAL))
				* COS(RADIANS(t2.longitude::DECIMAL - t1.longitude::DECIMAL))
				+ SIN(RADIANS(t2.latitude::DECIMAL))
				* SIN(RADIANS(t1.latitude::DECIMAL))))))::DECIMAL(7,3) < '0.1' then t1.id end)) / 7 as crime_totals
	FROM t1, t2
	group by 1, 2 
	ORDER BY 3 DESC
	
-- crime_02 --

drop table crime_across_stations_02
create table crime_across_stations_02 as
with t1 as(
select *
	from clean_crime
),

t2 as(
select * 
	from clean_train_stations
)

select 
		t2.station_number,
		t2.station_name,
		count(distinct(case when(69.0410421 
				* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t2.latitude::DECIMAL))
				* COS(RADIANS(t1.latitude::DECIMAL))
				* COS(RADIANS(t2.longitude::DECIMAL - t1.longitude::DECIMAL))
				+ SIN(RADIANS(t2.latitude::DECIMAL))
				* SIN(RADIANS(t1.latitude::DECIMAL))))))::DECIMAL(7,3) < '0.2' then t1.id end)) / 7 as crime_totals
	FROM t1, t2
	group by 1, 2 
	ORDER BY 3 DESC
	
-- crime_03 --

drop table crime_across_stations_03
create table crime_across_stations_03 as
with t1 as(
select *
	from clean_crime
),

t2 as(
select * 
	from clean_train_stations
)

select 
		t2.station_number,
		t2.station_name,
		count(distinct(case when(69.0410421 
				* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(t2.latitude::DECIMAL))
				* COS(RADIANS(t1.latitude::DECIMAL))
				* COS(RADIANS(t2.longitude::DECIMAL - t1.longitude::DECIMAL))
				+ SIN(RADIANS(t2.latitude::DECIMAL))
				* SIN(RADIANS(t1.latitude::DECIMAL))))))::DECIMAL(7,3) < '0.3' then t1.id end)) / 7 as crime_totals
	FROM t1, t2
	group by 1, 2 
	ORDER BY 3 DESC