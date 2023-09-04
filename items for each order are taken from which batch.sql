--write a query to determine items fo each order are taken from which batch
--assuming that items are sequentilly taken from each batch starting from first batch

---CREATING TABLE BATCH
create table batch 
(batch_id varchar(10),quantity integer)
insert into batch
values
('B1',5),
('B2',12),
('B3',8)

select * from batch;

--CREATING TABLE ORDERS
create table orders 
(order_number varchar (10) ,quantity integer)

insert into orders
values
('O1',2),
('O2',8),
('O3',2),
('O4',5),
('O5',9),
('O6',5)

select * from orders


with batch_cte as
(select * , row_number()over(order by batch_id) as rn
from 
(with recursive my_cte as
(select batch_id , 1 as quantity
from batch 
union all
select  b.batch_id , (cte.quantity+1) quantity
 from my_cte cte 
 join batch b
 on cte.batch_id = b.batch_id and cte.quantity < b.quantity

)
select batch_id , 1 as quantity from my_cte
) as x),

order_cte as
(
select * , row_number()over(order by order_number) as rn
from
(with recursive cte as
(select order_number , 1 as quantity
from orders 
union all
select  o.order_number , (cte.quantity+1) quantity
 from cte 
 join orders o
 on cte.order_number = o.order_number and cte.quantity < o.quantity

)
select order_number , 1 as quantity from cte

) y
)
select od.order_number ,ba.batch_id , sum(od.quantity) as quantity
from order_cte od
left join batch_cte ba
on od.rn = ba.rn
group by  od.order_number ,ba.batch_id 
order by od.order_number,ba.batch_id

