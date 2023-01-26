with t1 as(
 select 
	supersub.*
	from (
	select	
		sub.station as station,
		round(coalesce(avg(case when sub.date = 2016 then sub.rides end), '0')) as "2016", 
		round(coalesce(avg(case when sub.date = 2017 then sub.rides end), '0')) as "2017",
		round(coalesce(avg(case when sub.date = 2018 then sub.rides end), '0')) as "2018",
		round(coalesce(avg(case when sub.date = 2019 then sub.rides end), '0')) as "2019",
		round(coalesce(avg(case when sub.date = 2020 then sub.rides end), '0')) as "2020",
		round(coalesce(avg(case when sub.date = 2021 then sub.rides end), '0')) as "2021",
		round(coalesce(avg(case when sub.date = 2022 then sub.rides end), '0')) as "2022",
		round(avg(sub.rides)) as "total"
		from(
			select 
			ride.stationname as "station",
			date_part('year', ride.date) as date, 
			ride.rides
			from ridership ride
			) sub
		group by 1
		) supersub
	WHERE supersub.total > (select 
						avg(rides) - (2 * (stddev(rides)))
						from ridership)
		AND supersub.total > '100'
 	order by 9 ASC
 	limit 20
),

t2 as (
 SELECT 
	supersub.*
	FROM(
		SELECT 
			sub.station_name,
			coalesce(sum(case when sub.date = 2016 then crime_totals end), '0')::numeric as "2016", 
			coalesce(sum(case when sub.date = 2017 then crime_totals end), '0')::numeric as "2017",
			coalesce(sum(case when sub.date = 2018 then crime_totals end), '0')::numeric as "2018",
			coalesce(sum(case when sub.date = 2019 then crime_totals end), '0')::numeric as "2019",
			coalesce(sum(case when sub.date = 2020 then crime_totals end), '0')::numeric as "2020",
			coalesce(sum(case when sub.date = 2021 then crime_totals end), '0')::numeric as "2021",
			coalesce(sum(case when sub.date = 2022 then crime_totals end), '0')::numeric as "2022",
			coalesce(sum(crime_totals), '0')::numeric as "total"			
			FROM(
				SELECT 
					station_name,
					date_part('year', "date") as date,
					case when (69.0410421 
								* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(trains.latitude::DECIMAL))
								* COS(RADIANS(crime.latitude::DECIMAL))
								* COS(RADIANS(trains.longitude::DECIMAL - crime.longitude::DECIMAL))
								+ SIN(RADIANS(trains.latitude::DECIMAL))
								* SIN(RADIANS(crime.latitude::DECIMAL))))))::DECIMAL(7,3) < '0.3' then 1 end as crime_totals
					FROM train_stations as trains
					INNER JOIN crime
					ON levenshtein(crime.latitude, trains.latitude) <= 3
			) sub
			GROUP BY 1
		) supersub
	ORDER BY 9 DESC
	LIMIT 20
)

select t1.station, avg(t1.total)::integer as daily_rides, (avg(t2.total) / 365)::decimal(4,3) as daily_crime
from t1, t2
where t1.station = t2.station_name
group by 1