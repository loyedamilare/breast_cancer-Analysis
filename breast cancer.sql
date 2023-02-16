select * 
from breast_cancer

-- exploring the data
select distinct race
from breast_cancer


-- amount of candidate per race

select race, count(*) as num_per_race
from breast_cancer 
group by race

-- this shows that the data was gotten in a white dominated environment

-- data exploraration based on race

select 
	race, avg(age) avg_age, min(age) min_age, max(age) max_age	
from 
	breast_cancer
Group by race


with t1 as  (select age, 
			 		case when age between 30 and 50 then 'young < 50' else 'old > 50' end as age_count
			 from breast_cancer)
			 
select age_count, count(age_count)
from t1 
group by 1


select sixthstage, sum(alive) alive, sum(dead) dead 
from (select sixthstage, case when status = 'Alive' then 1 else 0 end as alive,
			 case when status = 'Alive' then 0 else 1 end as dead
	   from breast_cancer ) status
group by 1
order by 2,3


with s1 as (select race, case when status = 'Alive' then 1 else 0 end as alive,
							case when status = 'Alive' then 0 else 1 end as dead
	  		from breast_cancer
			order by 2,3),
		
	s2 as (select race, sum(alive) alive, sum(dead) dead  
 	   	   from s1
      	   group by 1),
  
	s3 as (select race, alive, dead, alive + dead as total
  		   from s2)
  
select race, 
	   cast (alive as real)/ cast (total as real) *100 as percent_alive,
  	   cast (dead as real)/ cast (total as real) *100 as percent_dead
  from s3
  

-- some exploratory analysis

select count(*), sixthstage
from breast_cancer
group by sixthstage

-- comparing the average tumor size for each of the cancer stages
-- Does the size of the tumor determine survival or the extent of metastais
select 
	avg (survivalmonths) as avgsurvivalmonths,
	avg(cast(tumorsize as int))as avgtumorsize,
	nstage,
	tstage
from 
	breast_cancer
GROUP by nstage, tstage
order by 3,4

select astage, avg(survival months)
from breast_cancer
group by 1


-- checking for the amount of cancer cells that have negative progesterone status

select 
	count(progesteronestatus) Negative_progesteronestatus
from breast_cancer
where progesteronestatus = 'Negative' 


-- checking for the amount of cancer cells that have Positive progesterone status

select count(progesteronestatus) Positive_pogesteronestatus
from breast_cancer
where progesteronestatus = 'Positive'
  
 DROP TABLE projesterone_status;

 CREATE TABLE projesterone_status 
 (negative_progesteronestatus INT, positive_progesteronestatus INT, total_progesteronestatus int);

 INSERT INTO 
	projesterone_status
	(negative_progesteronestatus, positive_progesteronestatus,
	 total_progesteronestatus)
VALUES ( 698, 3325, 4023)

SELECT negative_progesteronestatus, 
	positive_progesteronestatus, 
	total_progesteronestatus,
	cast (negative_progesteronestatus as float)/ cast(total_progesteronestatus as float)*100 
	as negative_progesterone_percent
FROM samDB..projesterone_status

SELECT negative_progesteronestatus, 
	positive_progesteronestatus, 
	total_progesteronestatus,
	cast (positive_progesteronestatus as float)/ cast(total_progesteronestatus as float)*100 
	as positive_progesterone_percent
FROM samDB..projesterone_status

SELECT distinct age age, avg (survivalmonths) as survivalmonths,
 avg(tumorsize) tumorsize 
 from breast_cancer
 where astage= 'Regional'
 group by survivalmonths, age
 order by 1 desc
 
 -- cancer metastasis where the status of the individual is dead.
 select 
	count(astage) cancermetastasis_dead,
	astage
 from breast_cancer
 where status = 'Dead'
 group by astage

  -- cancer metastasis where the status of the individual is Alive.
select 
	count(astage) cancermetastasis_alive,
	astage
 from breast_cancer
 where status = 'Alive'
 group by astage

 --using CTE
 with metastasis (cancermetastasis_alive, astage) 
 as ( 
 select 
	count(astage) cancermetastasis_alive,
	astage
 from breast_cancer
 where status = 'Alive'
 group by astage

 select count(estrogenstatus) as est_count, estrogenstatus
 from breast_cancer
 group by estrogenstatus
 
 Create Table estrogen_percentage (est_count int, estrogenstatus nvarchar (255))


Insert into estrogen_percentage (est_count, estrogenstatus)
values (269, 'negative'),
		(3754,'positive')

Drop table estrogen_percentage
select *
from samDB..estrogen_percentage
 
 select (cast(est_count as float)/4023)*100 as percentestrogenstatus, estrogenstatus
 from samDB..estrogen_percentage


