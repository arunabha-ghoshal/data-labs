create table emp(
emp_id int,
emp_name varchar(20),
dep_id int,
salary int,
manager_id int,
emp_age int);
create table dept(
dept_id int,
dep_name varchar(20)
);
delete from emp;
insert into emp
values
(1, 'Ankit', 100,10000, 4, 39);
insert into emp
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp
values (3, 'Vikas', 100, 10000,4,37);
insert into emp
values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp
values (5, 'Mudit', 200, 12000, 6,55);
insert into emp
values (6, 'Agam', 200, 12000,2, 14);
insert into emp
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp
values (8, 'Ashish', 200,5000,2,12);
insert into emp
values (9, 'Mukesh',300,6000,6,51);
insert into emp
values (10, 'Rakesh',500,7000,6,50);
insert into dept 
values (100, 'Analytics'),(200,'IT'),(300,'HR'),(400,'Text Analytics');
-- =========================================== --

select * from emp e ;
select * from dept ;

select * from emp e 
left join dept d
on e.dep_id = d.dept_id and d.dep_name = 'Analytics';

select * from emp e
left join (select * from dept where dep_name = 'Analytics') d on e.dep_id = d.dept_id;

select * from emp e 
left join dept d
on e.dep_id = d.dept_id
where d.dep_name = 'Analytics';

select * from emp e 
inner join dept d
on e.dep_id = d.dept_id
where d.dep_name = 'Analytics';

select * from emp e
left join dept d 
on e.dep_id = d.dept_id
where d.dept_id is null;

select * from emp e
left join dept d 
on e.dep_id = d.dept_id and e.salary =10000;

select * from emp e
left join dept d 
on e.dep_id = d.dept_id
where e.salary =10000;
