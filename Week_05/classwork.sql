-- Question 1

SELECT right(website,3), count(*)
FROM accounts
GROUP BY right(website,3);

-- Question 2

SELECT upper(left(name, 1)), count(*) as count_letters
FROM accounts
GROUP BY upper(left(name,1))
ORDER BY 1;

-- Question 3

SELECT count(*),
CASE WHEN UPPER(left(name,1)) IN ('A','E','I','O','U') THEN 'vowel'
	ELSE 'consonant'
	END letter_type
FROM accounts
GROUP BY letter_type;

-- Question 4

SELECT primary_poc, left(primary_poc, position(' ' in primary_poc)-1) as firstname, right(primary_poc, length(primary_poc)-position(' ' in primary_poc)) as lastname
FROM accounts;

-- Question 5

SELECT concat(lower(left(primary_poc, position(' ' in primary_poc)-1)),
			  '.',
			  lower(right(primary_poc, length(primary_poc)-position(' ' in primary_poc))),
			  '@',
			  right(website,length(website)-4)) as email_address			  
FROM accounts;

-- Question 6

SELECT concat(lower(left(primary_poc, position(' ' in primary_poc)-1)),
			  '.',
			  lower(right(primary_poc, length(primary_poc)-position(' ' in primary_poc))),
			  '@',
			  lower(replace(name, ' ', '')),
			 '.com') as email_address
FROM accounts;

-- Question 7

SELECT primary_poc, sales_rep_id,
		concat(lower(left(primary_poc, 1)),
			  substr(left(primary_poc, position(' ' in primary_poc)-1), position(' ' in primary_poc)-1, 1),
			  left(right(primary_poc, length(primary_poc)-position(' ' in primary_poc)),1),
			  upper(right(right(primary_poc, length(primary_poc)-position(' ' in primary_poc)),1)),
			  length(left(primary_poc, position(' ' in primary_poc)-1)),
			  length(right(primary_poc, length(primary_poc)-position(' ' in primary_poc))),
			  replace(name, ' ', ''),
			  substr(sales_rep_id::text,4,2)) as password
FROM accounts;

-- USING SUBQUERIES WILL BE EASIER AS YOU'LL HAVE FIRSTNAME AND LASTNAME DEFINED ALREADY FROM PREVIOUS QUESTIONS!

-- Question 8

SELECT *, sum(total_amt_usd) over() as overall_total
FROM orders;

-- Question 9

SELECT account_id, total_amt_usd,
	   sum(total_amt_usd) over(partition by account_id) as overall_total,
	   count(*) over(partition by account_id) as overall_count
FROM orders
ORDER BY account_id;

-- Question 10

SELECT occurred_at, standard_amt_usd,
	   sum(standard_amt_usd) over(order by occurred_at) as running_total
FROM orders;

-- Question 11

SELECT occurred_at, date_part('month', occurred_at), standard_amt_usd,
	   sum(standard_amt_usd) over(partition by date_part('month', occurred_at) order by occurred_at) as running_total
FROM orders;

-- Question 12

SELECT occurred_at, date_part('year', occurred_at), standard_qty,
	   sum(standard_qty) over(partition by date_part('year', occurred_at) order by occurred_at) as running_total
FROM orders;

-- Question 13

SELECT standard_qty,
	   row_number() over(order by standard_qty),
	   rank() over(order by standard_qty),
	   dense_rank() over(order by standard_qty)
FROM orders
WHERE account_id = 1001;

-- Question 14

SELECT account_id, standard_qty,
	   row_number() over(partition by account_id order by standard_qty),
	   rank() over(partition by account_id order by standard_qty),
	   dense_rank() over(partition by account_id order by standard_qty)
FROM orders;

-- Question 15

SELECT id, account_id, standard_qty,
	   dense_rank() over(partition by account_id order by standard_qty),
	   sum(standard_qty) over(partition by account_id order by standard_qty) as running_total,
	   avg(standard_qty) over(partition by account_id order by standard_qty) as average,
	   min(standard_qty) over(partition by account_id order by standard_qty) as minimum,
	   max(standard_qty) over(partition by account_id order by standard_qty) as maximum
FROM orders;

-- Question 16

SELECT id, account_id, standard_qty,
	   dense_rank() over(partition by account_id order by standard_qty),
	   sum(standard_qty) over(partition by account_id order by standard_qty) as running_total,
	   avg(standard_qty) over(partition by account_id order by standard_qty) as average,
	   min(standard_qty) over(partition by account_id order by standard_qty) as minimum,
	   max(standard_qty) over(partition by account_id order by standard_qty) as maximum
FROM orders
WINDOW account_window as (partition by account_id order by standard_qty);

-- Question 17

SELECT account_id, occurred_at, standard_qty,
	   ntile(4) over(partition by account_id order by standard_qty) as standard_qty_quartile
FROM orders;

-- Question 18

SELECT account_id, occurred_at, gloss_qty,
	   ntile(2) over(partition by account_id order by gloss_qty) as gloss_qty_half
FROM orders;

