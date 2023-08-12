--write a query to find the repeated customers
create table new_orders
(order_id integer , customer_id integer ,order_date date)
insert into new_orders 
values

(1,100,'2023-01-01'),
(2,200,'2023-01-01'),
(3,300,'2023-01-01'),
(4,100,'2023-01-02'),
(5,400,'2023-01-02'),
(6,500,'2023-01-02'),
(7,100,'2023-01-03'),
(8,400,'2023-01-03'),
(9,500,'2023-01-03')

select * from new_orders;

with cte as
		(select customer_id ,min(order_date) first_visit_date
		from new_orders
		group by customer_id
		order by customer_id),
		
output as 
	(select nw.order_id,nw.customer_id ,cte.first_visit_date,nw.order_date,
	case when cte.first_visit_date = nw.order_date  then 1 else 0 end as new_user_flag,
	case  when cte.first_visit_date <> nw.order_date then 1 else 0 end as repeated_customers_flag
	from cte 
	join new_orders nw
	on nw.customer_id = cte.customer_id)
	
	
		select customer_id as repeated_customer ,first_visit_date
		from output
		where repeated_customers_flag =1 
		group by customer_id ,first_visit_date
	
		
		
		