-- Chris Piccirillo
-- Database Management 
-- Queries HW 3 (FINAL COMMIT)
-- October 7, 2013






-1) 


SELECT a.city  
FROM agents a
WHERE aid IN  (SELECT aid 
               FROM orders  -- Used a subquery to find the exact spot in the orders table where the cid = 'c002'.  Connected the tables by the foreign key aid.   
               WHERE cid = 'c002' )  
  
 

-2)

SELECT Distinct a.city   	
FROM customers c, agents a inner join orders o ON a.aid = o.aid  -- Joined the orders table to agents table using the foreign key aid. 
WHERE o.cid = 'c002'

-3)  

SELECT DISTINCT pid
FROM orders  --Started from orders table
WHERE aid in (SELECT Distinct aid  --Finding the agent aid to speicify the agent who made one order to Kyoto.	
              FROM orders 
              WHERE cid = (SELECT cid  --Used a subquery inside of another to pinpoint the city Kyoto in the customers table.  
		           FROM customers 
		           WHERE city ='Kyoto') )




-4) 

SELECT Distinct o2.pid
FROM orders o1, orders o2, agents a, products p, customers c  
WHERE c.cid = o1.cid and --joinging orders table to customers table
      c.city = 'Kyoto' and -- Making sure the city name is Kyoto in the customer table.
      o1.aid = o2.aid   --Joins the orders table to orders, as o1, o2
      order by o2.pid
      


-5)  

SELECT c.name
FROM customers c  
WHERE cid NOT IN (SELECT cid  --finds where the cid from customers is not in orders
              From orders o )

-6) 

SELECT Distinct c.name
FROM customers c
FULL OUTER JOIN  orders o  --joining customers to orders and checking where the cid is non existant in orders, null
ON c.cid=o.cid
WHERE o.cid is NULL

-7) 

SELECT Distinct customers.name, agents.name   
FROM customers, agents, orders
WHERE customers.cid = orders.cid and --joining customers to orders by cid
      customers.city = agents.city and --joining customers to agentss by city
      agents.aid = orders.aid  --joining agents to orders by aid

8) 

SELECT Distinct c.name, a.name, c.city
FROM customers c inner join agents a on c.city = a.city inner join orders o on o.aid = a.aid  --using an inner join to just get the info that is the same in both tables


9)



DROP VIEW IF EXISTS citycount;
CREATE VIEW citycount as ( 
SELECT products.city,COUNT(city) Number --Creating a view, citycount to create a table with the number of cities in products.city
From products 
Group by products.city );


 SELECT customers.city , customers.name  --Query to find city 
from customers  
where city IN ( 
	SELECT products.city --subquery to find the city in products
	from products 
	group by products.city --
	having count(city) In 
		(SELECT MIN(number) from citycount) ) --querying the virtual table just created for the lowest number




10) 



DROP VIEW IF EXISTS citycount;  -- Creating the virutal table citycount 
CREATE VIEW citycount as ( 
SELECT products.city,COUNT(city) Number  --Getting the # of cities 
From products 
Group by products.city
order by number desc  --ordering numbers in descending order
limit 1 );  --limiting the possible results to 1 for "the city"




SELECT customers.name, customers.city  
FROM customers
WHERE city in (
		SELECT city --query to find the city in the virtual table
		FROM citycount
		
)                limit 1


11)  

DROP VIEW IF EXISTS citycount;  -- Creating the virtual table Citycount
CREATE VIEW citycount as ( 
SELECT products.city,COUNT(city) Number 
From products 
Group by products.city );


 SELECT customers.city , customers.name  
from customers 
where city IN (
	SELECT products.city               --subquery 
from products 
group by products.city                     --required for execution
having count(city) In                     --Queries the virtual table 
(SELECT MAX(number) from citycount) )  --Selects the highest number from virtual table 

12) 


SELECT p.name, p.priceUSD
FROM products p
WHERE priceUSD >=  (SELECT AVG(priceUSD) --Finds where the price is greater than the average price in the procucts table.
                      FROM products )

13) 


SELECT c.name, o.pid, o.dollars
FROM orders o 
JOIN
customers c ON c.cid = o.cid --joining orders to customers by cid
ORDER By dollars desc  --ordering by dollars in descending order


14) 


SELECT x.name, COALESCE ( Sum(x.dollars) , 0 ) as Total  --Finds all values that are null and puts 0 in their place
From 
(Select c.name, c.cid, o.dollars
From customers c   
full outer join  --full outer join to connect the necessary information from orders and customers 
orders o ON
c.cid = o.cid
) as x 

Group by x.name, x.cid

Order by x.name


15)

SELECT DISTINCT c.name,a.name,p.name
FROM customers c, agents a, orders o, products p
WHERE c.cid = o.cid and 
o.aid = a.aid and --connecting the orders and agents table
o.pid = p.pid and  --connecting the orders and products table 
a.city = 'New York'  -- Making sure agents.city is equal to New York

16)

DROP VIEW IF EXISTS recalcd; 
CREATE VIEW recalcd AS   --creating the virtual table recalcd. This table has the recalculated value of price in it. 
(
SELECT orders.ordno, (products.priceUSD * orders.qty ) - ((products.priceUSD * orders.qty )* (customers.discount / 100)) as Correct  -- Calculation of the correct price
FROM Orders, Products, Customers, Agents
WHERE 
products.pid = orders.pid  and -- joinging products to orders
customers.cid = orders.cid  --joining customers to orders
Group by orders.ordno,correct  
ORDER BY orders.ordno asc

);

Select orders.ordno, orders.dollars, recalcd.correct  --Selecting the info from the virtual table. 
From recalcd, orders
WHERE orders.ordno = recalcd.ordno;


17)
 

UPDATE orders
SET dollars = '100'
WHERE ordno = '1011'
;
DROP VIEW IF EXISTS accu;--re drops the table created with a view if it is already created
CREATE VIEW accu AS
  (
  SELECT o.ordno, (p.priceUSD * o.qty ) - ((p.priceUSD * o.qty )* (c.discount / 100)) as ACT --returns the actual value of the orders
  FROM orders o, products p, customers c
  WHERE o.cid = c.cid --joins orders to customers by cid
  AND 
  o.pid = p.pid--joins orders and products
  group by o.ordno, ACT --requried to execute query
  ORDER BY o.ordno asc -- changing the ordering to ascending
  )
;
SELECT o.ordno, o.dollars, a.ACT
FROM accu a, orders o --calls the table created above, accuracy as a
WHERE o.ordno = a.ordno --makes sure that the order numbers of both values match
AND
a.ACT != o.dollars --compares the actual price with one listed
;








