
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
