create table example_1
(
emp_id int,
emn_name varchar(200),
department_id int,
salary int,
manager_id int
);
truncate example_1 ;
insert into example_1 values(1,'Ankit',100, 10000,4);
insert into example_1 values(2,'Raj',100, 15000,5);
insert into example_1 values(3,'Arun',100, 10000,4);
insert into example_1 values(4,'Debo',100, 10000,2);
insert into example_1 values(5,'Bro',200, 5000,6);
insert into example_1 values(6,'Sayan',200, 12000,2);
insert into example_1 values(7,'Bhasu',200, 12000,2);
insert into example_1 values(8,'Aryan',200, 9000,2);

alter table example_1 rename emn_name to emp_name;
update example_1  set department_id=100, salary=10000, manager_id=4 where emp_id=1;
select * from example_1 ;
-- ====================================================================== --

select * from example_1 where salary>10000;

select department_id, avg(salary) from example_1 group by department_id having avg(salary)>9000;

select
	department_id,
	avg(salary)
from
	example_1
where
	salary>10000
group by
	department_id
having
	avg(salary)>9000;