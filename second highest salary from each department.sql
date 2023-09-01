--write a query to find the second highest salary from each department
with cte as
(select *
from dp_department d
join dp_employee e 
on e.department_id = d.id),
output as
(select department,max(salary) as max_salary from cte 
group by department),
final as
(select *,
row_number()over(order by max_salary desc) rn
from output)
select * from final 
where rn=2 