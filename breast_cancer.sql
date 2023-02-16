select * 
from breast_cancer

-- exploring the data

select 
	distinct race
from 
	breast_cancer


-- amount of candidate per race

select
	race, count(*) as num_per_race
from 
	breast_cancer 
group by 
	race

-- this shows that the data was gotten in a white dominated environment

-- data exploraration based on race

select 
	race, avg(age) avg_age, min(age) min_age, max(age) max_age	
from 
	breast_cancer
Group by race


with 
	t1 as  (select 
				age, 
			 	case when age between 30 and 50 then 'below 50' else ' 50 plus' end as age_group
			 from breast_cancer)
			 
select age_group, count(*)
from t1 
group by 1;

with a1 as (select age, 
		   			case when age between 30 and 35 then '30-35'
		   				 when age between 36 and 40 then '36-40'
		   				 when age between 41 and 45 then '41-45'
		   				 when age between 46 and 50 then '46-50'
						 when age between 51 and 55 then '51-55'
						 when age between 56 and 60 then '56-60'
						 when age between 61 and 65 then '61-65'
						 when age > 65 then '> 65' end as agegroup
			from breast_cancer)
select agegroup, count(*)
from a1 
group by 1
order by 2



select 
	sixthstage,
	sum(alive) alive, 
	sum(dead) dead 
from 
	(select 
	 	sixthstage, 
	    case when status = 'Alive' then 1 else 0 end as alive,
		case when status = 'Alive' then 0 else 1 end as dead
	  from breast_cancer ) status
group by 1
order by 2,3


with 
	s1 as (select 
		   		race, 
		   		case when status = 'Alive' then 1 else 0 end as alive,
				case when status = 'Alive' then 0 else 1 end as dead
	  		from breast_cancer
			order by 2,3),
		
	s2 as (select 
		   		race, 
		   		sum(alive) alive, 
		  	 	sum(dead) dead  
 	   	   from s1
      	   group by 1),
  
	s3 as (select 
		   		race, 
		   		alive, 
		   		dead, 
		   		alive + dead as total
  		   from s2)
  
select race, 
	   cast (alive as real)/ cast (total as real) *100 as percent_alive,
  	   cast (dead as real)/ cast (total as real) *100 as percent_dead
  from s3


-- some exploratory analysis

select
	count(*),
	sixthstage
from 
	breast_cancer
group by
	sixthstage

-- comparing the average tumor size for each of the cancer stages
-- Does the size of the tumor determine survival or the extent of metastais
select 
	avg (survivalmonths) as avgsurvivalmonths,
	avg(cast(tumorsize as int))as avgtumorsize,
	nstage,
	tstage
from 
	breast_cancer
GROUP by 
	nstage, tstage
order by 3,4

select 
	astage, 
	avg(survivalmonths)
from 
	breast_cancer
group by 1

select 
	tstage, 
	avg(survivalmonths) avg_survival_months, 
	avg(tumorsize) avg_tumor_size
from
	breast_cancer
group by 1

select nstage, avg(survivalmonths) ang_survival_months, avg(tumorsize) avgtumorsize
from breast_cancer
group by 1

-- is there a relation between progesterone status and survival

select 
	count(*), progesteronestatus, avg(survivalmonth)
from breast_cancer
group by 2 


 -- cancer metastasis where the status of the individual is dead.
 select 
	count(astage) metastasis, 
	avg(survivalmonths),
	astage
 from 
 	breast_cancer
 where 
 	status = 'Dead'
 group by astage

  -- cancer metastasis where the status of the individual is Alive.
select 
	count(astage) metastasis, avg(survivalmonths),
	astage
 from breast_cancer
 where status = 'Alive'
 group by astage


