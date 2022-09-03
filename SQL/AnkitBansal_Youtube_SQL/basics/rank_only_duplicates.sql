create table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');
-- =========================== --
select * from list;

with cte_dups as
(select id from list group by id having count(id)>1),
cte_rank as
(select *, rank() over(order by id) as rnk from cte_dups)
select l.*, 'DUP'||cr.rnk as output
from list l
left join cte_rank cr 
on l.id = cr.id; 