create table mode 
(
id int
);

insert into mode values (1),(2),(2),(3),(3),(3),(3),(4),(5);
-- =======================================================  --

select * from mode;

--methoid 1 : cte

with frequency_cte as 
(select id, count(id) as frequency from mode group by id)
select * from frequency_cte where frequency = (select max(frequency) from frequency_cte);
insert into mode values (4);

-- method 2 : cte
with frequency_cte as 
(select id, count(id) as freq from mode group by id),
rnk_cte as 
(select *, rank() over(order by freq desc) as rnk from frequency_cte)
select * from rnk_cte where rnk=1;