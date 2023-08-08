--creating_table

create table files
(
id              int primary key,
date_modified   date,
file_name       varchar(50)
)

---inserting_values

insert into files values (1	,   to_date('2021-06-03','yyyy-mm-dd'), 'thresholds.svg');
insert into files values (2	,   to_date('2021-06-01','yyyy-mm-dd'), 'redrag.py');
insert into files values (3	,   to_date('2021-06-03','yyyy-mm-dd'), 'counter.pdf');
insert into files values (4	,   to_date('2021-06-06','yyyy-mm-dd'), 'reinfusion.py');
insert into files values (5	,   to_date('2021-06-06','yyyy-mm-dd'), 'tonoplast.docx');
insert into files values (6	,   to_date('2021-06-01','yyyy-mm-dd'), 'uranian.pptx');
insert into files values (7	,   to_date('2021-06-03','yyyy-mm-dd'), 'discuss.pdf');
insert into files values (8	,   to_date('2021-06-06','yyyy-mm-dd'), 'nontheologically.pdf');
insert into files values (9	,   to_date('2021-06-01','yyyy-mm-dd'), 'skiagrams.py');
insert into files values (10,   to_date('2021-06-04','yyyy-mm-dd'), 'flavors.py');
insert into files values (11,   to_date('2021-06-05','yyyy-mm-dd'), 'nonv.pptx');
insert into files values (12,   to_date('2021-06-01','yyyy-mm-dd'), 'under.pptx');
insert into files values (13,   to_date('2021-06-02','yyyy-mm-dd'), 'demit.csv');
insert into files values (14,   to_date('2021-06-02','yyyy-mm-dd'), 'trailings.pptx');
insert into files values (15,   to_date('2021-06-04','yyyy-mm-dd'), 'asst.py');
insert into files values (16,   to_date('2021-06-03','yyyy-mm-dd'), 'pseudo.pdf');
insert into files values (17,   to_date('2021-06-03','yyyy-mm-dd'), 'unguarded.jpeg');
insert into files values (18,   to_date('2021-06-06','yyyy-mm-dd'), 'suzy.docx');
insert into files values (19,   to_date('2021-06-06','yyyy-mm-dd'), 'anitsplentic.py');
insert into files values (20,   to_date('2021-06-03','yyyy-mm-dd'), 'tallies.py');

---Write a query to find the most modified files on each day

with cte as
		(select date_modified,
		   substring(file_name ,(position ('.' in file_name)+1)) as ext, count(1) as cnt
		   from files
		   group by 1,ext
		 order by 1
		)
 
		 select date_modified ,string_agg(ext , ',' order by ext desc) as extension ,max(cnt) as count
		 from cte c1
		 where cnt = (select max(cnt) from cte c2
					 where c2.date_modified = c1.date_modified)
					 
		 group by date_modified