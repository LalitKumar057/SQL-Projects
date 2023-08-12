---write a query to find the brands where price is increased year by year (2018-2020)
create table brand
(year varchar(50) , Brands varchar(50),Amount integer)

insert into brand
values
(2018,'Apple',45000),
(2019,'Apple',35000),
(2020,'Apple',75000),
(2018,'Samsung',15000),
(2019,'Samsung',20000),
(2020,'Samsung',25000),
(2018,'Nokia',21000),
(2019,'Nokia',17000),
(2020,'Nokia',14000);

select * from brand


with cte as 
		(
		select *,
		case  when amount < lead(amount,1,amount+1)over(partition by brands order by brand) 
			then 1 else 0 end as flag
		from brand),
	output as 	
	(select * ,
	sum(flag)over(partition by brands order by brands) 
	from cte 
	)
	
	select year,brands,amount 
	from output 
	where sum >= 3
	
	-----------------------OR----------------------------------------------------------
	
	with cte as 
		(
		select *,
		case  when amount < lead(amount,1,amount+1)over(partition by brands order by brand) 
			then 1 else 0 end as flag
		from brand)
	
	select *
	from brand
	where brands not in (select brands from cte where flag =0)
	
	









