select * from ms_user_dimension;
select * from ms_acc_dimension;
select * from ms_download_facts;

with cte as
(select dwnd.date ,msu.user_id,acc.acc_id ,acc.paying_customer ,dwnd.downloads from ms_user_dimension msu
join ms_acc_dimension acc
on msu.acc_id = acc.acc_id
join ms_download_facts dwnd
on msu.user_id = dwnd.user_id),
final_data as 
(select date,
sum(case when paying_customer ='no' then downloads else 0 end ) as non_paying_customers ,
sum(case when paying_customer ='yes' then downloads else 0 end ) as paying_customers
from cte
group by date)

select * from final_data
where non_paying_customers > Paying_customers
order by date

