-- train station --

with t1 as(
	select 
		a.station_name as from_station_name,
		b.station_name as to_station_name,
		(69.0410421 
			* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(a.latitude::DECIMAL))
			* COS(RADIANS(b.latitude::DECIMAL))
			* COS(RADIANS(a.longitude::DECIMAL - b.longitude::DECIMAL))
			+ SIN(RADIANS(a.latitude::DECIMAL))
			* SIN(RADIANS(b.latitude::DECIMAL))))))::DECIMAL(7,3) as distance
		FROM train_stations a
		JOIN train_stations b ON a.station_name != b.station_name
)

select 
	'total' as from_station_name,
	'' as to_station_name,
	avg(t1.distance)::decimal(4,3)
	from t1
	where t1.distance < (select 
						 	 (2* stddev(t1.distance)) 
						  	  + PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY t1.distance)
						 	  from t1)				  

UNION ALL

select 
	t1.*
	from t1
	where t1.distance < (select 
						 	 (2* stddev(t1.distance)) 
						  	  + PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY t1.distance)
						 	  from t1)	
							  
-- grocery store --
with b1 as(

with t1 as(
	select 
		a.store_name as from_store_name,
		b.store_name as to_store_name,
		(69.0410421 
			* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(a.latitude::DECIMAL))
			* COS(RADIANS(b.latitude::DECIMAL))
			* COS(RADIANS(a.longitude::DECIMAL - b.longitude::DECIMAL))
			+ SIN(RADIANS(a.latitude::DECIMAL))
			* SIN(RADIANS(b.latitude::DECIMAL))))))::DECIMAL(7,3) as distance
		FROM clean_grocery_stores a
		JOIN clean_grocery_stores b ON a.store_name != b.store_name
		where a.latitude::numeric > 41.88398406
		and b.latitude::numeric > 41.88398406
)

select 
	'total' as from_store_name,
	'' as to_store_name,
	avg(t1.distance)::decimal(4,3) as average_distance
	from t1
	where t1.distance < (select 
						 	 (2* stddev(t1.distance)) 
						  	  + PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY t1.distance)
						 	  from t1)	
	
)

select 
	'north' as "region",
	b1.average_distance
	from b1
	
union all 

with b1 as(

with t1 as(
	select 
		a.store_name as from_store_name,
		b.store_name as to_store_name,
		(69.0410421 
			* DEGREES(ACOS(LEAST(1.0, COS(RADIANS(a.latitude::DECIMAL))
			* COS(RADIANS(b.latitude::DECIMAL))
			* COS(RADIANS(a.longitude::DECIMAL - b.longitude::DECIMAL))
			+ SIN(RADIANS(a.latitude::DECIMAL))
			* SIN(RADIANS(b.latitude::DECIMAL))))))::DECIMAL(7,3) as distance
		FROM clean_grocery_stores a
		JOIN clean_grocery_stores b ON a.store_name != b.store_name
		where a.latitude::numeric < 41.88398406
		and b.latitude::numeric < 41.88398406
)

select 
	'total' as from_store_name,
	'' as to_store_name,
	avg(t1.distance)::decimal(4,3) as average_distance
	from t1
	where t1.distance < (select 
						 	 (2* stddev(t1.distance)) 
						  	  + PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY t1.distance)
						 	  from t1)	
	
)

select 
	'south' as "region",
	b1.average_distance
	from b1

	
	


