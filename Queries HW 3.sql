
--1.	Get	the	cities	of	agents	booking	an	order	for	--customer	c002.	Use	a	
--subquery.	(Yes,	this	is	the	same	question	as	--on	homework	#2)


SELECT a.city
FROM agents a
WHERE aid IN  (SELECT aid
               FROM orders
               WHERE cid = 'c002' ) 
               
               
--2.     Get	the	cities	of	agents	booking	an	order	for	--customer	c002.	This	time	
--use	joins;	no	subqueries.


SELECT Distinct a.city
FROM customers c, agents a inner join orders o ON a.aid = o.aid
WHERE o.cid = 'c002'


--3.      Get	the	pids	of	products	ordered	through	any	agent	who	makes	at	least	
--one	order	for	a	customer	in	Kyoto.	Use	--subqueries.	(Yes,	this	is	also	the	
--same	question	as	on	homework	#2.)

SELECT DISTINCT o.pid
FROM orders o 
WHERE aid in (SELECT a.aid
              FROM agents a
              WHERE EXISTS (SELECT c.city
		           FROM customers c
		           WHERE city ='Kyoto') )

--4 Get	the	pids	of	products	ordered	through	any	agent	who	makes	at	least	
--one	order	for	a	customer	in	Kyoto.	Use	joins	thus	time;	no	subqueries.

SELECT o.pid
FROM 
orders o inner join agents a  on  a.aid = o.aid 
agents a inner join  customers c on a.city = c.city
WHERE c.city = 'Kyoto'

SELECT Distinct o.pid
FROM customers c, agents a inner join orders o ON a.aid = o.aid
WHERE o.cid = 'c002'

--5 Get	the	names	of	customers	who	have	never	placed	an	order.	Use	a	
--subquery

SELECT c.name
FROM customers c
WHERE cid NOT IN (SELECT cid
              From orders o )

       --6Get	the	names	of	customers	who	have	--never	placed	an	order.	Use	an	
--outer	join


SELECT Distinct c.name
FROM customers c
LEFT JOIN  orders o
ON c.cid=o.cid
WHERE o.cid is NULL

--7 Get	the	names	of	customers	who	placed	at	--least	one	order	through	an	
--agent	in	their	city,	along	with	those	agent(s names

SELECT Distinct c.name, a.name
FROM customers c inner join agents a on c.city = a.city inner join orders o on o.aid = a.aid
WHERE

--8.	Get	the	names	of	customers	and	agents	in	the	same	city,	along	with	the	
--name	of	the	city,	regardless	of	whether	or	not	the	customer	has	ever	
--placed	an	order	with	that	agent.

SELECT Distinct c.name, a.name, c.city
FROM customers c inner join agents a on c.city = a.city inner join orders o on o.aid = a.aid

--9.	Get	the	name	and	city	of	customers	who	live	in	the	city	where	the	least	
--number	of	products	are	made.

SELECT Distinct c.name, c.city
FROM customers c
WHERE cid in ( SELECT o.cid
               FROM orders o
               WHERE qty =
                      (SELECT MIN (o.qty)
                        FROM orders o
               ) )
              

--12 List	the	products	whose	priceUSD	is	above	the	average	priceUSD.

SELECT p.name
FROM products p
WHERE priceUSD >=  (SELECT AVG(priceUSD) 
                      FROM products )
                      
--13- Show	the	customer	name,	pid	ordered,	and	the	dollars	for	all	customer	
--orders,	sorted	by	dollars	from	high	to	low


SELECT c.name, o.pid, o.dollars
FROM customers c, orders o
ORDER By o.dollars desc

--14 Show	all	customer	names	(in	order)	and	their	total	ordered,	and	
--nothing	more.	Use	coalesce	to	avoid	showing	NULLs


--15.	Show	the	names	of	all	customers	who	bought	products	from	agents	
--based	in	New	York	along	with	the	names	of	the	products	they	ordered,	
--and	the	names	of	the	agents	who	sold	it	--to	them

SELECT Distinct c.name
FROM customers c, agents a
WHERE a.city ='New York'
