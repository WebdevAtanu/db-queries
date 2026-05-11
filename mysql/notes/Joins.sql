-- inner join
-- inner join is the default join type if no join type is specified
SELECT *
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id;

-- left join
-- left join returns all rows from the left table and only the matching rows from the right table
SELECT *
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id;

-- right join
-- right join returns all rows from the right table and only the matching rows from the left table
SELECT *
FROM customer
RIGHT JOIN payment
ON customer.customer_id = payment.customer_id;

-- full join
-- full join returns all rows from both tables
SELECT *
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id;

-- cross join
-- cross join returns all possible combinations of rows from both tables
SELECT *
FROM customer
CROSS JOIN payment;

-- self join
-- self join is when a table is joined with itself
SELECT *
FROM customer c1
JOIN customer c2
ON c1.customer_id = c2.customer_id;


