# SQL_Class_Work
Code from my PostgreSQL class at USC :)

Pgadmin 

F5 to run in pgadmin

Right click on databases > create > database > give name (database) > save
When you initiate it, it won’t have columns (obviously) – run code 
Right click on db created > query tools > type code to create database (create into and stuff)
Example:

BEGIN TRANSACTION;
CREATE TABLE web_events (
	id integer,
	account_id integer,
	occurred_at timestamp,
	channel bpchar
);
INSERT INTO web_events VALUES (1,1001,'2015-10-06 17:13:58','direct');
……
COMMIT;

Highlight the needed code and then run it > close (towards right) > now check schemas, it will have the columns we created!

Open query tool again and start writing queries

Queries in postgresql:

1.	Use limit function if you want only a certain number of outputs from the top or bottom
2.	Order by column_name desc/asc 		– if needed to sort by column name
3.	Use as while introducing a new column in select (SELECT col1+col2 as col – create a new column col)
4.	Can use in if there are multiple things to look for (question 20 from lecture 1)
Example: Where channel in (‘twitter’, ‘adwords’) – faster than col = ‘twitter’ and col = ‘adwords’
5.	Where name like ‘c%’ – returns everything starting from c (like is used for pattern matching) – if  you are trying to find the website for Whole Foods, and you don’t remember their exact name which is (Whole Foods Market. In this case, we can identify all accounts that has the word food in their url to find the exact URL for Whole Foods. 
6.	Using BETWEEN is tricky for dates! While BETWEEN is generally inclusive of endpoints, it assumes the time is at 00:00:00 (i.e. midnight) for dates. This is the reason why we set the right-side endpoint of the period at ‘01-01-2017’. 
Using occurred_at <= '2016-12-31' assumes that you are checking till 31st Dec 00:00 (or 30th dec night, the time turns 12am), so use < '2017-01-01' to include all orders of 2017
7.	Use parenthesis correctly while using AND/ OR/ etc. operators. 

