-- Get the cites of agents booking an or order for customer c002

SELECT city
FROM agents 
WHERE aid IN  (SELECT aid
               FROM orders
               WHERE cid = 'c002'
)

-- Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto.  (This is not the same as asking for pids for products ordered by a customer in Kyoto.)

SELECT DISTINCT pid
FROM orders 
WHERE aid IN (SELECT aid
		      FROM agents
		      WHERE EXISTS (SELECT aid 
			  FROM customers
		      WHERE city = 'Kyoto'
				))



--Find	the	cids	and	names	of	customers	who	never	placed	an	order	through	agent a03.

SELECT cid, name
FROM customers
WHERE cid NOT IN( SELECT cid
                  FROM orders
                  WHERE aid = 'a03'
)



--Get	the	cids	and	names	of	customers	who	--ordered	both	product	p01	and	p07.

SELECT cid, name
FROM customers
WHERE cid IN (SELECT cid
              FROM orders
              WHERE pid = 'p01' 
INTERSECT
 SELECT cid
 FROM orders
 WHERE pid = 'p07' )



--Get	the	pids	of	products	ordered	by	any	customers	who	ever	placed	an	order	through	agent	a03.

SELECT DISTINCT pid
FROM orders
WHERE cid IN( SELECT cid
		           FROM orders
                   WHERE aid = 'a03' 
)

--Get	the	names	and	discounts	of	all	customers	who	place	orders	through	agents	in	Dallas	or	Duluth.

SELECT name, discount
FROM customers
WHERE cid IN ( SELECT cid 
               FROM orders 
               WHERE aid IN ( SELECT aid 
                              FROM agents
                              WHERE city = 'Dallas' OR city  = 'Duluth'

)) 


--Find	all	customers	who	have	the	same	discount	as	that	of	any	customers	in	Dallas	or	Kyoto.

SELECT * 
FROM customers
Where discount IN (SELECT discount
                   FROM customers
                   WHERE city = 'Dallas' OR city = 'Kyoto' )
	






