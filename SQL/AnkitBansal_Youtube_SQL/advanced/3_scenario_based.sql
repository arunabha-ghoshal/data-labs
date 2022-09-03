create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');
select * from entries ent;

-- =============================================================================================================================== --
with total_visits as (
select
	e.name,
	count("name") as total_visits,
	string_agg(distinct e.resources, ',') as resources_used
from
	entries e
group by
	e.name),
floor_visit as
(
select
	e.name,
	e.floor,
	count('name') as no_of_floor_visits,
	rank() over(partition by name
order by
	count('name') desc) as rank_col
from
	entries e
group by
	e.name,
	e.floor)
select
	fv.name,
	fv.floor as most_visited_floor,
	tv.total_visits,
	tv.resources_used
from
	floor_visit fv
inner join total_visits tv on
	fv .name = tv.name
where
	rank_col = 1;



