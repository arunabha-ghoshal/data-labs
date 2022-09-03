create table strings (name varchar(50));
delete from strings;
insert into strings values ('Ankit Bansal'),('Ram Kumar Verma'),('Akshay Kumar Ak k'),('Rahul');
-- ================================ --
select * from strings;

select name, 
replace(name,'Ak','') as rep_name,
(length(name)-length(replace(name,'Ak','')))/length('Ak') as cnt
from strings;