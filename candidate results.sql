create table candidates
(id integer primary key,
gender varchar,
age integer,
party varchar);
insert into candidates
values
(1,'M',55,'Democratic') ,
(2,'M',51,'Democratic') ,
(3,'F',62,'Democratic') ,
(4,'M',60,'Democratic') ,
(5,'F',61,'Democratic') ,
(6,'F',58,'Democratic');

create table results 
(constituency_id integer ,
candidate_id integer,
votes bigint);
insert into results
values
(1,1,847529),
(1,4,283409),
(2,2,293841),
(2,5,394385),
(3,3,429084),
(3,6,303890);


select * from candidates;
select * from results;

--Query
with cte as 
	(select c.id , c.party ,r.constituency_id,r.votes
	 from candidates c
	 join results r
	on c.id = r.candidate_id
	order by votes desc),
final_data as	
(select party, constituency_id ,votes,
row_number()over(partition by constituency_id order by votes desc) rnk
from cte)
select concat(party,' ',count(party)) as number_of_const_wins from final_data 
where rnk = 1
group by party







