CREATE TABLE students(
 studentid int,
 studentname varchar(200),
 subject varchar(200),
 marks int,
 testid int,
 testdate date
);
--data:
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');
-- ========================================================================= --
select * from students order by 1;


-- Q1. Find the list of students who scored above the average marks in each subject
with avg_cte as
(select subject, avg(marks) as avg_marks
from students 
group by subject)
select * from students s
left join avg_cte
on s.subject=avg_cte.subject
where s.marks>avg_cte.avg_marks
order by 1;

-- Q2. Write a sql query to find out students who scored more than 90 in any subject among the students
select (count(distinct case when marks>90 then studentid else null end)*1.0/ count(distinct studentid))*100 as result_percentage
from students;

--Q3. Write a sql query to get the second highest and second lowest marks for each subject
with cte as (
select subject,
marks, 
rank() over(partition by subject order by marks asc) as rank_asc,
rank() over(partition by subject order by marks desc) as rank_desc
from students)
select subject, 
sum(case when rank_desc=2 then marks else null end) as second_highest,
sum(case when rank_asc=2 then marks else null end) as second_lowest
from cte
group by subject;

-- Q4. For each student and test, identify if their marks increased or decreased from previous test
select * from students
order by studentid,testdate,subject;

with stud_cte as (
select *,
lag(marks,1) over(partition by studentid order by testdate, subject) as prev_marks
from students)
select *,
case when marks>prev_marks then 'increased'
when marks<prev_marks then 'increased'
else 'NA' end as status
from stud_cte;

