create table emp1
(
emp_id int,
emp_name varchar(200),
department_id int,
salary int,
manager_id int
);
truncate emp1 ;
insert into emp1 values(1,'Ankit',100, 10000,4);
insert into emp1 values(2,'Raj',100, 15000,5);
insert into emp1 values(3,'Arun',100, 10000,4);
insert into emp1 values(4,'Debo',100, 10000,2);
insert into emp1 values(5,'Bro',200, 5000,6);
insert into emp1 values(6,'Sayan',200, 12000,2);
insert into emp1 values(7,'Bhasu',200, 12000,2);
insert into emp1 values(8,'Aryan',200, 9000,2);
select * from emp1;
-- =========================================== --
-- #window is created by partition by column
select * from 
(select
	emp_id,
	emp_name,
	department_id,
	salary,
	manager_id,
	rank() over(partition by department_id
order by
	salary desc) as rnk,
	dense_rank() over(partition by department_id
order by
	salary desc) as dense_rnk,
	row_number() over(partition by department_id
order by
	salary desc) row_num
from
	emp1) ab
where ab.rnk=1;