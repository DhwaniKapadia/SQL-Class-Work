-- Question 6

SELECT e.first_name as employee, m.first_name as manager -- select is run last so we can use m before defining it
FROM employee as m
JOIN employee as e
ON m.employee_id = e.manager_id;

-- Update the previous query to show null when he/she manages no one

SELECT e.first_name as employee, m.first_name as manager -- select is run last so we can use m before defining it
FROM employee as m
FULL JOIN employee as e
ON m.employee_id = e.manager_id;

-- Who the boss!!

SELECT * 
FROM employee 
where manager_id is NULL;

-- Question 7

SELECT o.id as ORDER_ID, a.name as ACCOUNT_NAME, o.total as TOTAL_ORDERS 
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
WHERE a.name = 'Walmart';

-- Question 8

SELECT a.name as account_name, w.channel
FROM accounts as a
JOIN web_events as w
ON a.id = w.account_id
WHERE a.id = 1001;

-- Question 9

SELECT o.occurred_at, a.name as ACCOUNT_NAME, o.total, o.total_amt_usd
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
WHERE occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY occurred_at; 

-- Question 10

SELECT r.name as region_name, s.name as sales_rep_name, a.name as account_name
FROM accounts as a
JOIN sales_reps as s
ON a.sales_rep_id = s.id
JOIN region as r
ON r.id = s.region_id;

-- Question 11

SELECT r.name as region_name, s.name as sales_rep_name, a.name as account_name
FROM accounts as a
JOIN sales_reps as s
ON a.sales_rep_id = s.id
JOIN region as r
ON r.id = s.region_id
WHERE r.name = 'Midwest';

-- Question 12

SELECT w.occurred_at, a.primary_poc
FROM accounts as a
JOIN web_events as w
ON w.account_id = a.id
ORDER BY w.occurred_at
limit(1);

-- Question 13

SELECT r.name as regionname, a.name as accountname, round(o.total_amt_usd/(o.total+0.00001),2) as unitprice 
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
JOIN sales_reps as s
ON a.sales_rep_id = s.id
JOIN region as r
ON r.id = s.region_id;

-- Question 14

SELECT count(*)
FROM accounts;

-- Question 15

SELECT sum(poster_qty)
FROM orders;

-- Question 16

SELECT min(poster_qty), max(poster_qty)
FROM orders;

-- Question 17

SELECT min(occurred_at)
FROM orders;

-- Question 18

SELECT avg(standard_amt_usd) standardaverage, 
	   avg(gloss_amt_usd) glossaverage, 
	   avg(poster_amt_usd) posteraverage
FROM orders;

-- QUESTION 19

select percentile_cont(0.5) within group(order by total_amt_usd)
from orders;
