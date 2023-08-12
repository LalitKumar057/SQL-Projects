drop table team ;
create table team 
(team1 varchar (50) ,team2 varchar (50) ,winner varchar (50) )
insert into team
values
('India','SL','India'),
('SL','Aus','Aus'),
('SA','Eng','Eng'),
('Eng','NZ','NZ'),
('Aus','India','India')

select * from team;


with cte as 
	(select team1 as team_name,
	case when  team1 = winner then 1 else 0 end as win_flag
	from team
	union all
	select team2 as team_name,
	case when team2 = winner then 1 else 0 end as win_flag
	from team)
	
	select team_name ,count(1) as no_of_match_played,
	sum(win_flag) as won_matches,count(1)-sum(win_flag) as no_of_losses
	from cte
	group by team_name
	order by won_matches desc
