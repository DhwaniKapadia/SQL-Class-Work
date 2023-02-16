-- Question 1

SELECT country, count(*) as number_of_customers	
FROM customers
GROUP BY country
ORDER BY number_of_customers desc
limit(5);

-- Question 2

SELECT c.categoryname, count(*) as total_products
FROM products p
JOIN categories c
ON c.categoryid = p.categoryid
GROUP BY p.categoryid, c.categoryname;

-- Question 3

SELECT productid, productname
FROM products
WHERE unitsinstock + unitsonorder <= reorderlevel AND 
	  discontinued = 0;
	  
-- Question 4

SELECT date_part('year',o.shippeddate) as ship_year, count(*) as total
FROM orders o
JOIN shippers s
ON o.shipvia = s.shipperid
WHERE s.companyname = 'United Package' AND
	  date_part('year',o.shippeddate) = 1997
GROUP BY date_part('year',o.shippeddate);

-- Question 5

SELECT shipcountry, avg(freight)
FROM orders
WHERE date_part('year',orderdate) = 1996
GROUP BY shipcountry
ORDER BY avg(freight) desc
LIMIT(3);
	  
-- Question 6

SELECT e.lastname, e.firstname, count(*) as totalorders
FROM orders o
JOIN employees e
ON o.employeeid = e.employeeid
JOIN orderdetails od
ON o.orderid = od.orderid
WHERE o.requireddate <= o.shippeddate 
GROUP BY e.lastname, e.firstname
HAVING count(*) >= 5
ORDER BY totalorders desc;

-- Question 7

SELECT DISTINCT c.companyname, o.orderid, sum(od.quantity*od.unitprice) as total_order_amount
FROM customers c
JOIN orders o
ON o.customerid = c.customerid
JOIN orderdetails od
ON o.orderid = od.orderid
GROUP BY o.orderid, c.companyname
HAVING date_part('year',orderdate) = 1996 AND 
	  sum(od.quantity*od.unitprice) >= 10000;
	  
