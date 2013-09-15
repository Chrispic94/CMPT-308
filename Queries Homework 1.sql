--List all data	for all customers
SELECT *
FROM customers

--List the name	and city of agents named Smith

SELECT name, city 
FROM agents 
WHERE name = 'Smith'

--Listpid,name,and quantity of products costing	more than US$1.25.

SELECT pid,name, quantity
FROM products
WHERE priceusd > 1.25
--List the ordno and aid of all orders

SELECT ordno, aid
FROM orders 

--List the names and cities of customers not in Dallas.

SELECT name, city
FROM customers 
WHERE city !='Dallas'

--List the names of agents in New York or Newark.

SELECT name
FROM agents
WHERE city ='New York'OR city = 'Newark'

--List all data	for products not in New York or Newark that cost US$1 or less.

SELECT *
FROM products
WHERE city !='New York' AND city !='Newark' AND priceusd <=1

--List all data for orders in January or March.

SELECT *
FROM orders
WHERE mon = 'jan' OR mon = 'mar'

--List all data	for orders in February less than US$100.

SELECT *
FROM orders
WHERE mon = 'feb' AND dollars < 100

--List all orders from	the customer whose cid is C005.

SELECT ordno
FROM orders
WHERE cid = 'c005'