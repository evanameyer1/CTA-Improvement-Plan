drop table clean_grocery_stores1

create table clean_grocery_stores as
select 
	store_name,
	address,
	zip,
	new_status,
	last_updated,
	round(latitude::decimal, 8) as latitude,
	round(longitude::decimal, 8) as longitude
	from grocery_stores
	where new_status = 'OPEN'

create table clean_crime as
select 
	id,
	case_number,
	date,
	block,
	primary_type,
	description,
	location_description,
	round(latitude::decimal, 8) as latitude,
	round(longitude::decimal, 8) as longitude
	from crime
	where latitude IS NOT NULL
	AND longitude IS NOT NULL
	AND date_part('year', "date") >= 2016
	AND LOWER(primary_type) IN('assault','battery','crim sexual assault','criminal sexual assault','homicide','human trafficking','intimidation','kidnapping','obscenity','offense involving children','public indecency','public peace violation','robbery','sex offense','stalking')
	AND lower(location_description) in('street', 'sidewalk', 'other', 'parking lot/garage(non.resid.)', 'alley', 'grocery food store', 'gas station', 'parking lot / garage (non residential)', 'cta train', 'convenience store',
										'other (specifiy)', 'cta bus', 'cta platform', 'cta station', 'cta bus stop', 'government building/property', 'medical/dental office', 'other commercial transportation', 'police facility / vehicle parking lot',
										'cta garage / other property', 'government building / property', 'vehicle - other ride share service (e.g., uber, lyft)', 'vehicle - commercial', 'other railroad prop / tain depot',
										'cta parking lot / garage / other property', 'federal building', 'parking lot', 'cta "l" train', 'cta property', 'cta "l" platform', 'cta subway station', 'police facility')

	
create table clean_bike_stations as 
select 
	station_name,
	total_docks,
	docks_in_service,
	round(latitude::decimal, 8) as latitude,
	round(longitude::decimal, 8) as longitude
	from bicycle_stations
	where status = 'In Service'	

create table clean_bus_stations as
select
	stop_id,
	cta_stop_name,
	round(latitude::decimal, 8) as latitude,
	round(longitude::decimal, 8) as longitude
	from bus_stations
	
create table clean_affordable_rentals as
select
	property_name,
	property_type,
	zip_code,
	units,
	round(latitude::decimal, 8) as latitude,
	round(longitude::decimal, 8) as longitude
	from affordable_rental_housing
	
create table station_requirements as

with t3 as (
	select
	station_name,
	grocery_totals
	from grocery_across_stations
	order by 2 asc
),

t2 as (
	select
	*
	from crime_across_stations
	order by 2 desc
)

select 
	t2.station_name,
	trains.station_descriptive_name,
	t1.total::integer as daily_rides,
	(t2.yearly_avg / 365)::decimal(5,4) as daily_crime,
	t3.grocery_totals::integer as nearby_grocery,
	t4.police_totals::integer as nearby_police,
	t5.bike_totals::integer as nearby_bike_stations,
	t6.bus_totals::integer as nearby_bus_stations,
	t7.rental_totals::integer as nearby_affordable_rentals
	from crime_across_stations_01 t2
	join clean_train_stations trains
	on trains.station_name = t2.station_name
	left join grocery_across_stations t3
	on trains.station_name = t3.station_name
	left join police_across_stations t4
	on t3.station_name = t4.station_name
	left join bikes_across_stations t5
	on t4.station_name = t5.station_name
	left join buses_across_stations t6
	on t5.station_name = t6.station_name
	left join rentals_across_stations t7
	on t6.station_name = t7.station_name
	left join ridership_across_stations t1
	on t7.station_name = t1.station
	order by 3 asc
	
t1 as(
	select 
	*
	from ridership_across_stations
	order by 2 asc
),

t4 as (
	select
	station_name,
	police_totals
	from police_across_stations
	order by 2 asc
),

t5 as (
	select
	station_name,
	bike_totals
	from bikes_across_stations
	order by 2 asc
),

t6 as (
	select
	station_name,
	bus_totals
	from buses_across_stations
	order by 2 asc
)

drop table clean_train_stations

create table clean_train_stations as
select
	row_number() OVER (ORDER BY station_name) as station_number,
	sub.*
	from(
	select distinct 
	station_descriptive_name as station_name,
	round(translate(left("location", strpos("location", ',')- 1), '()', '')::decimal, 8) as latitude,
	round(translate(right("location", length("location") - strpos("location", ' ')), ',()', '')::decimal, 8) as longitude
	from train_locations
	order by 1 asc
	)sub ;

drop table ridership_stations
create table ridership_stations as
select distinct
	row_number() OVER (ORDER BY stationname) as station_number,
	stationname
	from ridership
	group by 2
	order by 1 asc;

select 
	a.station_number,
	a.station_name,
	b.stationname
	from clean_train_stations a
	join ridership_stations b
	using(station_number)
	order by 1 asc;
	
select * 
from clean_train_stations

drop table ridership
create table clean_ridership as
	select 
		b.station_number,
		stationname, 
		date, 
		daytype, 
		rides
	from ridership a
	join ridership_stations b
	on a.stationname = b.station_name
	where stationname NOT ilike 'madison/wabash'
	OR stationname NOT ilike 'randolph/wabash'
	order by 3 asc

create table clean_ridership_totals as 
	select
	service_date::date as date,
	bus as bus_totals,
	rail_boardings as train_totals,
	total_rides
	from ridership_totals
	order by 1