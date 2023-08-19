--Find the 3-month rolling average of total revenue from purchases given a table with users, 
--their purchase amount, and date purchased. Do not include returns which are represented by
--negative purchase values. Output the month  and 3-month rolling average of revenue,
--sorted from earliest month to latest month
--souce : strata_scratch table name : amazon_purchases
with cte as
	   (select  user_id ,extract( 'Month' from created_at) as month 
	   from amazon_purchase),
data as 
	  (select *,
	  case when ap.purchase_amt > 0 then 1 else 0 end as flag
	  from  amazon_purchase ap
	  join cte c
	  on c.user_id = ap.user_id),
data1 as 
      (select month,avg(purchase_amt) as average
	  from data
	  where flag =1
	  group by month),
final as
      (select *,
	   ntile(3)over( order by month asc) agg_month
	   from data1),
final_output as	   
		(select  agg_month ,round(avg(average),2) as agg_avg_of_three_months from final
		group by agg_month
		)
select * from final_output	




	   
	   
	   




