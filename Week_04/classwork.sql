
-- Question 1

SELECT round(avg(sum_usd),2) as average
FROM (SELECT a.name, sum(o.total_amt_usd)  as sum_usd
	 FROM orders o
	 JOIN accounts a
	 ON o.account_id = a.id
	 GROUP BY a.name
	 ORDER BY sum(o.total_amt_usd) desc
	 LIMIT(10)
	 )table1;

--Question 1 using WITH

WITH table1 as(
	SELECT a.name, sum(o.total_amt_usd)  as sum_usd
	 FROM orders o
	 JOIN accounts a
	 ON o.account_id = a.id
	 GROUP BY a.name
	 ORDER BY sum(o.total_amt_usd) desc
	 LIMIT(10))
SELECT round(avg(sum_usd),2) as average
FROM table1;

--WAY 3, not recc

CREATE VIEW v1 as
	SELECT o.account_id, sum(o.total_amt_usd) as total_sum
	FROM orders o
	GROUP BY o.account_id
	ORDER BY total_sum desc
	LIMIT(1);
SELECT v1.account_id, w.channel, count(*)
FROM web_events w
JOIN v1
ON v1.account_id = w.account_id
GROUP BY w.channel, v1.account_id;

-- Question 2
SELECT table1.account_id, w.channel
FROM	(SELECT o.account_id, sum(o.total_amt_usd) as total_sum
		FROM orders o
		GROUP BY o.account_id
		ORDER BY total_sum desc
		LIMIT(1))table1 
JOIN web_events w
ON table1.account_id = w.account_id
GROUP BY w.channel, table1.account_id;

-- Question 3

WITH table1 as(
	SELECT a.name, w.channel, count(*) as count
	FROM accounts a
	JOIN web_events w
	ON a.id = w.account_id
	GROUP BY a.name, w.channel
	ORDER BY a.name, count desc
),

table2 as (
	SELECT table1.name, max(count) as max_count
	FROM table1
	GROUP BY table1.name
	ORDER BY table1.name
)

SELECT table2.name, table1.channel, table2.max_count
FROM table1
JOIN table2
ON table1.name = table2.name AND table1.count = table2.max_count
ORDER BY table2.name;

-- Question 4

WITH table1 as(
	SELECT s.name as sales_rep_name, r.name as region_name, sum(o.total_amt_usd) as total_sum
	FROM orders o
	JOIN accounts a
	ON a.id = o.account_id
	JOIN sales_reps s
	ON s.id = a.sales_rep_id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY r.name, s.name
),

table2 as (
	SELECT table1.region_name, max(total_sum) as max_sum
	FROM table1
	GROUP BY table1.region_name
	ORDER BY table1.region_name
)


SELECT table2.region_name, table1.sales_rep_name, table2.max_sum
FROM table1
JOIN table2 
ON table1.region_name = table2.region_name AND table1.total_sum = table2.max_sum
ORDER BY table1.sales_rep_name;




	

