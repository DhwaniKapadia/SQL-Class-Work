-- Question 1

SELECT vendname
FROM vendors
WHERE vendcity IN ('Bellevue', 'Ballard', 'Redmond');

-- Question 2

SELECT p.productname, pv.wholesaleprice, v.vendname 
FROM vendors v
JOIN product_vendors pv
ON pv.vendorid = v.vendorid
JOIN products p
ON p.productnumber = pv.productnumber
WHERE wholesaleprice < 100;

-- Question 3

SELECT DISTINCT c.custfirstname, c.custlastname, p.productname 
FROM products p
JOIN order_details od
ON p.productnumber = od.productnumber
JOIN orders o
ON o.ordernumber = od.ordernumber
JOIN customers c
ON o.customerid = c.customerid
WHERE p.productname LIKE '%Helmet%';

-- Question 4

SELECT v.vendname, v.vendstate, v.vendphonenumber 
FROM vendors v
JOIN product_vendors pv
ON pv.vendorid = v.vendorid
JOIN products p
ON p.productnumber = pv.productnumber
WHERE p.productname = 'Shinoman 105 SC Brakes' 
ORDER BY pv.daystodeliver
LIMIT 1;

-- Question 5

SELECT p.productname
FROM products p
LEFT JOIN order_details od
ON p.productnumber = od.productnumber
WHERE od.productnumber IS NULL; 			--The product has not been ordered so it is does not have an associated entry in the order_details column

-- Question 6

SELECT o.ordernumber, o.shipdate, sum(od.quotedprice * od.quantityordered) revenue 
FROM order_details od
JOIN orders o
ON o.ordernumber = od.ordernumber
WHERE o.shipdate BETWEEN '2018-01-01' AND '2018-01-31';

-- Question 7

SELECT DISTINCT c.custfirstname, c.custlastname, c.custphonenumber 
FROM products p
JOIN order_details od
ON p.productnumber = od.productnumber
JOIN orders o
ON o.ordernumber = od.ordernumber
JOIN customers c
ON o.customerid = c.customerid
WHERE p.productname = 'Shinoman Deluxe TX-30 Pedal';


