insert into example_1  values (1, 'Mainak',900,1250,2),(2,'Kunal',800,2000,2),(3,'Rishi',700,9500,2),(7,'Ron',200,1450,4),(8,'Anirban',300,8000,5);
select * from example_1 ;
-- Q1. How to find duplicates in a  given table
select emp_id, count(emp_id) from example_1 group by emp_id having count(emp_id)>1 order by 1 asc;

-- Q2. How to delete duplicates

with cte as (select *, row_number() over(partition by emp_id order by emp_id) as rn from example_1) select * from cte;
delete from cte where rn>1;

-- Q3. difference between union and union all


-- Q4. difference between rank, row_number and dense_rank 
-- check sql file dedicated to this

-- Q5. 

-- Q6. second highest salary in each department
select * from emp1 e ;
select * from (select emp1.*, dense_rank() over(partition by department_id order by salary desc) as rnk from emp1) a where a.rnk=2;

-- Q7. Find all transactions done by Shilpa (name is in any case)
create table transaction_table
(
customer_name varchar(200),
order_date date,
order_amount int,
customer_gender varchar(50)
);
drop table transaction_table;
select * from transaction_table;
insert into transaction_table  values ('Shilpa',to_date('2022-06-22','YYYY-MM-DD'),1000,'Male'),('SHILPA',to_date('2022-06-21','YYYY-MM-DD'),500,'Male'),('shilpa',to_date('2022-06-20','YYYY-MM-DD'),2000,'Male');
insert into transaction_table  values ('Raj',to_date('2022-06-22','YYYY-MM-DD'),1000,'Female'),('Aryan',to_date('2022-06-21','YYYY-MM-DD'),500,'Female'),('raJ',to_date('2022-06-20','YYYY-MM-DD'),2000,'Female');
select * from transaction_table where upper(customer_name)='SHILPA'; 

-- Q8. 

-- Q9.

-- Q10. Update query to swap gender
select * from transaction_table ;
update transaction_table  set customer_gender = case when customer_gender='Male' then 'Female'
													when customer_gender='Female' then 'Male' end;