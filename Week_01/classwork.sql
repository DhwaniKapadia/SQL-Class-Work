select *
from accounts;

select * 
from orders;

--Question 2

select id, name
from sales_reps

--Question 3

select id, account_id,occurred_at
from orders;

--Question 4

select *
from orders
limit 10;

--Question 5

select *
from orders
order by occurred_at desc 
limit 10;

--Question 6

select id, occurred_at, total_amt_usd
from orders
order by occurred_at
limit 10;

--Question 7

select id, total_amt_usd
from orders
order by total_amt_usd desc
limit 5;

--Question 8

select *
from orders
order by account_id, total_amt_usd desc;

--Question 9

select id, total, total_amt_usd
from orders
order by total desc, total_amt_usd desc
limit 5;

--Question 10

select *
from orders
where account_id=4251;

--Question 11

select *
from orders
where total_amt_usd<=500
limit 5;

--Question 12

select name, website, primary_poc
from accounts
where name='Exxon Mobil'

--Question 13

select account_id, occurred_at, gloss_qty+poster_qty as non_standard_quantity
from orders;

--Question 14

select id, account_id, standard_qty*100/total::float as percentage_standard
from orders
where total>0; 

--Question 15

select *
from accounts
where name like '%whole%';

--Question 16

select *
from accounts
where name like '%one%';

--Question 17

select *
from accounts
where name like 'C%';

--Question 18

select *
from accounts
where name like '%s';

--Question 19

select account_id, name
where name='name'
