drop table grocery_stores

create table grocery as
select 
	store_name,
	address,
	zip,
	new_status,
	last_updated::date,
	left(translate(right("location", strpos("location", ')') - 7), ')', ''), 
		 strpos(translate(right("location", strpos("location", ')') - 7), ')', ''), ' ') - 1) as latitude,
	right(translate(right("location", strpos("location", ')') - 7), ')', ''), 
		  length(translate(right("location", strpos("location", ')') - 7), ')', '')) 
		  - strpos(translate(right("location", strpos("location", ')') - 7), ')', ''), ' ')) as longitude
	from grocery_stores; 	
	