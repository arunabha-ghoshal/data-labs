drop table icc_world_cup;

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');
insert into icc_world_cup  values('India','Aus','Draw');
insert into icc_world_cup  values('SA','Aus','Draw');

select * from icc_world_cup;
-- ========================================================== --
select
	A.team_name,
	count(team_name) as number_of_matches_played,
	sum(win_flag) as number_of_matches_won,
	count(team_name)-sum(win_flag) as number_of_matches_lost
from
	(
	select
		team_1 as team_name,
		case
			when team_1 = winner then 1
			else 0
		end as win_flag
		
	from
		icc_world_cup iwc
union all
	select
		team_2 as team_name,
		case
			when team_2 = winner then 1
			else 0
		end as win_flag
	from
		icc_world_cup iwc ) A
group by
	team_name
order by
	number_of_matches_won desc;
-- ==================================== --
select
	A.team_name,
	count(team_name) as number_of_matches_played,
	sum(win_flag) as number_of_matches_won,
	count(team_name)-sum(draw_flag)-sum(win_flag) as number_of_matches_lost,
	sum(draw_flag) as draw_matches 
from
	(
	select
		team_1 as team_name,
		case
			when team_1 = winner then 1
			else 0
		end as win_flag,
		case 
			when winner = 'Draw' then 1
			else 0
		end as draw_flag
	from
		icc_world_cup iwc
union all
	select
		team_2 as team_name,
		case
			when team_2 = winner then 1
			else 0
		end as win_flag,
		case
			when winner = 'Draw' then 1
			else 0
		end as draw_flag
	from
		icc_world_cup iwc) A
group by
	A.team_name
order by 
number_of_matches_won desc;
