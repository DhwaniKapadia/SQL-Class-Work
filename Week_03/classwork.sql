-- GROUP BY

-- Question 1

SELECT  a.name, sum(o.total_amt_usd) as total_sales
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_sales desc;

-- Question 2

SELECT  channel, count(*)
FROM web_events
GROUP BY channel;

-- Question 3

SELECT a.name, max(o.total_amt_usd) as max_amount
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY max_amount desc;

-- Question 4

SELECT r.name, count(s.name) as total_area
FROM region as r
JOIN sales_reps as s
ON s.region_id = r.id
GROUP BY r.name
ORDER BY total_area;

-- Question 5

SELECT a.name, 
	   cast(avg(o.standard_amt_usd) as decimal(10,2)) as standard,  -- can also use round(table name,2) & F8 to download o/p
	   cast(avg(o.gloss_amt_usd)as decimal(10,2)) as glossy, 
	   cast(avg(o.poster_amt_usd)as decimal(10,2)) as poster
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name;

-- Question 6

SELECT s.name, w.channel, count(*) as num_events
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events desc;

-- Question 7

SELECT s.name, count(*) as num_of_accounts
FROM accounts as a
JOIN sales_reps as s
ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING count(*) > 5 --can't use alias as the alias is given after the aggregation
ORDER BY 2; --2nd column

-- Question 8

SELECT account_id, count(*) total_order
FROM orders
GROUP BY account_id
HAVING count(*) > 20;

-- Question 9

SELECT a.name, count(*) total_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_orders desc
limit 1;

-- Question 10

SELECT a.name, sum(o.total_amt_usd) as total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING sum(o.total_amt_usd) > 30000
ORDER BY total_spent;

-- Question 11

SELECT a.name, sum(o.total_amt_usd) as total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent desc
limit 1;

-- Question 12

SELECT a.name, w.channel, count(*) as frequency
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE channel = 'facebook'
GROUP BY a.name, w.channel
ORDER BY 3 desc
limit 1;

-- Question 13

SELECT a.name, w.channel, count(*) as frequency
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE channel = 'facebook'
GROUP BY a.name, w.channel
HAVING count(*) > 6
ORDER BY 3;

-- Question 14



-- Question 15

SELECT date_part('year',occurred_at) order_year, sum(total_amt_usd) total_spent
FROM orders o
GROUP BY order_year
ORDER BY 2 desc;

-- Question 16

SELECT date_part('month',occurred_at) order_month, sum(total_amt_usd) total_spent
FROM orders o
GROUP BY order_month
ORDER BY 2 desc
LIMIT 1;

-- Question 17

SELECT date_trunc('month', o.occurred_at) order_date, sum(o.gloss_amt_usd) gloss_amt
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 desc
limit 1;

-- Question 18

SELECT a.name, sum(o.total_amt_usd) total_spent,
	CASE WHEN sum(o.total_amt_usd) > 200000 THEN 'Top'
		 WHEN sum(o.total_amt_usd) > 100000 THEN 'Medium'
		 ELSE 'Low'
	END account_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name;

-- Question 19

SELECT a.name, sum(o.total_amt_usd) total_spent,
	CASE WHEN sum(o.total_amt_usd) > 200000 THEN 'Top'
		 WHEN sum(o.total_amt_usd) > 100000 THEN 'Medium'
		 ELSE 'Low'
	END account_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE date_part('year',o.occurred_at) IN (2016,2017)
GROUP BY a.name;

-- Question 20

SELECT s.id, count(*) num_orders,
	CASE WHEN count(*) > 200 THEN 'Top'
		 ELSE 'Low'
	END performance_level
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.id
ORDER BY 2 desc;

-- Question 21

SELECT s.id, count(*) num_orders, sum(o.total_amt_usd) total_spent,
	CASE WHEN count(*) > 200 OR sum(o.total_amt_usd) > 750000 THEN 'Top'
		 WHEN count(*) > 150 OR sum(o.total_amt_usd) > 500000 THEN 'Middle'
		 ELSE 'Low'
	END performance_level
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.id
ORDER BY 3 desc;


-- HAVING

-- Question 1

SELECT  a.name, sum(o.total_amt_usd) as total_sales
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_sales desc;

-- Question 2

SELECT  channel, count(*)
FROM web_events
GROUP BY channel;

-- Question 3

SELECT a.name, max(o.total_amt_usd) as max_amount
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY max_amount desc;

-- Question 4

SELECT r.name, count(s.name) as total_area
FROM region as r
JOIN sales_reps as s
ON s.region_id = r.id
GROUP BY r.name
ORDER BY total_area;

-- Question 5

SELECT a.name, 
	   cast(avg(o.standard_amt_usd) as decimal(10,2)) as standard,  -- can also use rount(table name,2) & F8 to download o/p
	   cast(avg(o.gloss_amt_usd)as decimal(10,2)) as glossy, 
	   cast(avg(o.poster_amt_usd)as decimal(10,2)) as poster
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name;

-- Question 6

SELECT s.name, w.channel, count(*) as num_events
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events desc;

