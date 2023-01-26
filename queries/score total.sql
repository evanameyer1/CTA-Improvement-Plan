create table ffinal_result as
	select 
		station_number::integer,
		station,
		ridership_score,
		yearly_avg as daily_rides,
		crime_score,
		crime_totals,
		grocery_score,
		grocery_totals,
		police_score,
		police_totals,
		bikes_score,
		bike_totals,
		buses_score,
		bus_totals,
		rentals_score,
		rental_totals,
		score_total
	from final_result
	
drop table final_result as 	
with t1 as(
	select 
		sub.*,
		case when sub.rank < 20 then '4'
		when sub.rank < 40 then '3'
		when sub.rank < 60 then '2'
		when sub.rank < 80 then '1'
		else '0' end as ridership_score
		from(
			select 
			row_number () over (order by yearly_avg asc) as rank,
			station_number, 
			station_name, 
			yearly_avg			
			from ridership_across_stations
		) sub
),

t2 as (
	select 
		sub.*,
		case when sub.rank < 20 then '3'
		when sub.rank < 40 then '2'
		when sub.rank < 60 then '1'
		else '0' end as crime_score
		from(
			select 
			row_number () over (order by crime_totals desc) as rank,
			*
			from crime_across_stations_01
		) sub
),

t3 as (
	select 
		sub.*,
		case when sub.rank < 30 then '1'
		else '0' end as grocery_score
		from(
			select 
			row_number () over (order by grocery_totals asc) as rank,
			*
			from grocery_across_stations
		) sub
),

t4 as (
	select 
		sub.*,
		case when sub.rank < 30 then '1'
		else '0' end as police_score
		from(
			select 
			row_number () over (order by police_totals asc) as rank,
			*
			from police_across_stations
		) sub
),

t5 as (
	select 
		sub.*,
		case when sub.rank < 30 then '1'
		else '0' end as bikes_score
		from(
			select 
			row_number () over (order by bike_totals asc) as rank,
			*
			from bikes_across_stations
		) sub
),

t6 as (
	select 
		sub.*,
		case when sub.rank < 30 then '2'
		when sub.rank < 50 then '1'
		else '0' end as buses_score
		from(
			select 
			row_number () over (order by bus_totals asc) as rank,
			*
			from buses_across_stations
		) sub
),

t7 as (
	select 
		sub.*,
		case when sub.rank < 30 then '1'
		else '0' end as rentals_score
		from(
			select 
			row_number () over (order by rental_totals asc) as rank,
			*
			from rentals_across_stations
		) sub
)

select 
	t1.station_number::text as station_number,
	t1.station_name as station,
	t1.ridership_score::decimal(6,0),
	t1.yearly_avg::decimal(6,0),
	t2.crime_score::decimal(6,0),
	t2.crime_totals::decimal(6,0),
	t3.grocery_score::decimal(6,0),
	t3.grocery_totals::decimal(6,0),
	t4.police_score::decimal(6,0),
	t4.police_totals::decimal(6,0),
	t5.bikes_score::decimal(6,0),
	t5.bike_totals::decimal(6,0),
	t6.buses_score::decimal(6,0),
	t6.bus_totals::decimal(6,0),
	t7.rentals_score::decimal(6,0),
	t7.rental_totals::decimal(6,0),
	t1.ridership_score::integer + t2.crime_score::integer +
	t3.grocery_score::integer + t4.police_score::integer +
	t5.bikes_score::integer + t6.buses_score::integer +
	t7.rentals_score::integer as score_total
	from t1, t2, t3, t4, t5, t6, t7
	where t1.station_number = t2.station_number
	and t1.station_number = t3.station_number
	and t1.station_number = t4.station_number
	and t1.station_number = t5.station_number
	and t1.station_number = t6.station_number
	and t1.station_number = t7.station_number
	order by score_total DESC

create table comparing_stations as 
select 
	'Total Averages' as station_number,
	'' as station,
	avg(t8.ridership_score)::decimal(4,3) as ridership_score,
	avg(t1.yearly_avg)::decimal(9,3) as daily_rides,
	avg(t8.crime_score)::decimal(4,3) as crime_score,
	(avg(t2.crime_totals)/ 365)::decimal(4,3) as daily_crime,
	avg(t8.grocery_score)::decimal(4,3) as grocery_score,
	avg(t3.grocery_totals)::decimal(4,3) as nearby_grocery,
	avg(t8.police_score)::decimal(4,3) as police_score,
	avg(t4.police_totals)::decimal(4,3) as nearby_police,
	avg(t8.bikes_score)::decimal(4,3) as bike_score,
	avg(t5.bike_totals)::decimal(4,3) as nearby_bikesshare,
	avg(t8.buses_score)::decimal(4,3) as bus_score,
	avg(t6.bus_totals)::decimal(4,3) as nearby_bus_stops,
	avg(t8.rentals_score)::decimal(4,3) as rental_score,
	avg(t7.rental_totals)::decimal(4,3) as nearby_affordable_rentals,
	avg(t8.score_total)::decimal(4,3) as average_score
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
	join rentals_across_stations t7
	using(station_number)
	join ffinal_result t8
	using(station_number)

union all

select 
	station_number::text,
	station,
	ridership_score,
	daily_rides,
	crime_score,
	(crime_totals / 365)::decimal(4,3),
	grocery_score,
	grocery_totals,
	police_score,
	police_totals,
	bikes_score,
	bike_totals,
	buses_score,
	bus_totals,
	rentals_score,
	rental_totals,
	score_total
	from ffinal_result