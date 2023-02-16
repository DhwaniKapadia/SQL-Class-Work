
--Question 1

select distinct uniquecarrier
from flights;

--Question 2

select *
from flights
where uniquecarrier IN ('DL', 'UA');

--Question 3

select *
from flights
where origin = 'IAH' AND
	  distance >= 3000;
	  
--Question 4

select distinct dest, origin, distance --since top 5 destinations can't be repetitive
from flights
where origin = 'IAH'
order by distance desc
limit 5;

--Question 5

select tailnum, taxiin+taxiout as taxiing, airtime
from flights
where taxiin+taxiout > airtime;

--Question 6

select *
from flights
where dest = 'DFW' AND
	  deptime < 800 AND
	  airtime IS NOT NULL
ORDER BY airtime desc; 

--Question 7

select uniquecarrier, dayofweek, cancelled
from flights
where cancelled = '1'AND dayofweek IN ('1', '7'); -- 1 is Sunday and 7 is Saturday

--Question 8

select *
from flights
where uniquecarrier = 'AA' AND
	  arrdelay>0;

