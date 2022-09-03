drop table customer_orders ;
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;
select * from customer_orders co ;
-- ============================================ --
with first_order as
(
select
	customer_id,
	min(order_date) as first_visit_date
from
	customer_orders co
group by
	customer_id ),
visit_flag as
(
select
	co.*,
	fv.first_visit_date,
	case 
		when co.order_date = fv.first_visit_date then 1
		else 0
	end as first_visit_flag,
	case 
		when co.order_date = fv.first_visit_date then co.order_amount 
		else 0
	end as first_visit_revenue_flag,
	case 
		when co.order_date != fv.first_visit_date then 1
		else 0
	end as repeat_visit_date,
	case 
		when co.order_date != fv.first_visit_date then co.order_amount 
		else 0
	end as repeat_visit_revenue_flag
from
	customer_orders co
inner join first_order fv on
	fv.customer_id = co.customer_id
order by
	order_id )
select
	vf.order_date,
	sum(vf.first_visit_flag) as no_of_new_customers,
	sum(vf.repeat_visit_date) as no_of_repeat_customers,
	sum(vf.first_visit_revenue_flag) as first_visit_revenue,
	sum(vf.repeat_visit_revenue_flag) as repeat_visit_revenue
from
	visit_flag vf
group by
	vf.order_date
order by
	vf.order_date;
	-- ======================================================== --

with first_order as
(
select
	customer_id,
	min(order_date) as first_visit_date
from
	customer_orders co
group by
	customer_id )
select
	co.order_date ,
	sum(case 
		when co.order_date = fv.first_visit_date then 1
		else 0
	end) as first_visit_flag,
	sum(case 
		when co.order_date != fv.first_visit_date then 1
		else 0
	end) as repeat_visit_date
from
	customer_orders co
inner join first_order fv on
	fv.customer_id = co.customer_id
group by 
order_date 
order by 
order_date ;