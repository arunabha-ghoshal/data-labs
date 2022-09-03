drop table employee;
create table employee
(
Id varchar(10),
Name varchar(200),
Salary int
);
select * from employee ;
truncate employee ;
insert into employee values(1,'A',200000);
insert into employee values(2,'B',300000);
insert into employee values(3,'C',500000);
insert into employee values(4,'D',400000);
insert into employee values(5,'E',600000);

select * from employee 
-- =========================================== --

select	*
from
	employee
order by
	salary desc;
	
select distinct salary from employee where salary>400000;
select * from employee emp1 where 3=(select count(distinct emp2.salary) from employee emp2 where emp2.salary>emp1.salary);
select * from employee where 1=1;
