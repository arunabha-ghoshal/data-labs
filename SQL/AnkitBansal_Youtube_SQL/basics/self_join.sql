-- Q: Find emplyees whose salaray is more than their managers' salary

select * from emp1 e ;

select
	e.emp_name as employee,
	e.salary as employee_salary,
	m.emp_name as manager,
	m.salary as manager_salary
from
	emp1 e
inner join emp1 m on
	e.manager_id = m.emp_id		-- note the joining condition
where
	e.salary > m.salary ;