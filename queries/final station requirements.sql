with t1 as(
	select *
	from ridership_across_stations
	order by 3 asc
	limit 80
),

t2 as (
	select *
	from crime_across_stations_03
	order by 3 desc
	limit 80
),

t3 as (
	select *
	from grocery_across_stations
	order by 3 asc
	limit 80
),

t4 as (
	select *
	from police_across_stations
	order by 3 asc
	limit 80
),

t5 as (
	select *
	from bikes_across_stations
	order by 3 asc
	limit 80
),

t6 as (
	select *
	from buses_across_stations
	order by 3 asc
	limit 80
)

select 
	t1.station_number::text as station_number,
	t1.station_name as station,
	t1.yearly_avg as daily_rides,
	(t2.crime_totals::decimal / 365)::decimal(4,3) as daily_crime,
	t3.grocery_totals::integer as nearby_grocery,
	t4.police_totals::integer as nearby_police,
	t5.bike_totals::integer as nearby_bike_stations,
	t6.bus_totals::integer as nearby_bus_stations
	from t1, t2, t3, t4, t5, t6
	where t1.station_number = t2.station_number
	and t1.station_number = t3.station_number
	and t1.station_number = t4.station_number
	and t1.station_number = t5.station_number
	and t1.station_number = t6.station_number

union all

select 
	'Total Averages' as station_number,
	'' as station,
	avg(t1.yearly_avg)::decimal(9,3) as daily_rides,
	(avg(t2.crime_totals) / 365)::decimal(4,3) as daily_crime,
	avg(t3.grocery_totals)::decimal(4,3) as nearby_grocery,
	avg(t4.police_totals)::decimal(4,3) as nearby_police,
	avg(t5.bike_totals)::decimal(4,3) as nearby_bike_stations,
	avg(t6.bus_totals)::decimal(4,3) as nearby_bus_stations
	from ridership_across_stations t1 
	join crime_across_stations_01 t2
	using(station_number)
	join grocery_across_stations t3
	using(station_number)
	join police_across_stations t4
	using(station_number)
	join bikes_across_stations t5
	using(station_number)
	join buses_across_stations t6
	using(station_number)