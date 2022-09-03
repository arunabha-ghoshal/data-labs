-- Write a query to provide the date for nth occurence of Sunday in future from the given date
-- pg_catalog.date_part(text, timetz)

with first_tue as (
	select case when 2 - date_part('isodow', date '2022-06-15') > 0
		then 2 - date_part('isodow', date '2022-06-15')
		else 9 - date_part('isodow', date '2022-06-15') end as distance_from_tue
)
select cast(date '2022-06-15' + cast(distance_from_tue as int) + interval '2 week' as date) as nth_tue
from first_tue;

