with t1 as(
	select
		supersub.year,
		((supersub.bus_rides * 630000000) / supersub.bus_totals)::money as bus_price_per_ride,
		((supersub.train_rides * 630000000) / supersub.train_totals)::money as train_price_per_ride
		from (
			select 
				sub.year,
				(sub.bus_totals::decimal / sub.total::decimal)::decimal(4,3) as bus_rides,
				(sub.train_totals::decimal / sub.total::decimal)::decimal(4,3)  as train_rides,
				sub.bus_totals,
				sub.train_totals
				from (
				select 
						date_part('year', service_date) as year,
						sum(bus) as bus_totals,
						sum(rail_boardings) as train_totals,
						sum(total_rides) as total
						from ridership_totals
						where date_part('year', service_date) != 2020
						and date_part('year', service_date) != 2021
						and date_part('year', service_date) != 2022
						group by 1
						order by 1
				) sub
			) supersub
), 

t2 as(
select 
	sub.year,
	avg(sub.yearly_rides)::decimal(15,3) as yearly_rides
	from(
	select
		date_part('year', date) as year,
		stationname,
		sum(rides) as yearly_rides
		from clean_ridership
		where date_part('year', date) != 2020
		and date_part('year', date) != 2021
		and date_part('year', date) != 2022
		group by 1, 2
	) sub
	group by 1
)

select 
	t1.year,
	avg(t1.bus_price_per_ride::decimal * 10768)::money as yearly_bus_station_revenue,
	avg(t1.train_price_per_ride::decimal * t2.yearly_rides)::money as yearly_train_station_revenue
	from t1, t2
	group by 1