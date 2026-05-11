SELECT DISTINCT country FROM customer; -- unique values only
SELECT * FROM customer ORDER BY country DESC; -- order by desc 
SELECT * FROM customer ORDER BY country ASC, first_name DESC; -- order by asc and desc
SELECT * FROM customer WHERE first_name LIKE "j%" OR first_name LIKE "J%"; -- case-insensitive like operator
SELECT * FROM customer LIMIT 5; -- limit the number of rows 
SELECT * FROM customer LIMIT 5 OFFSET 5; -- offset the number of rows
SELECT * FROM customer LIMIT 5, 5; -- offset the number of rows

-- having clause
-- description- The HAVING clause is used to filter the results of a query that uses the GROUP BY clause.
SELECT customer_id, SUM(amount) AS total_amount
FROM payment
GROUP BY customer_id
HAVING total_amount > 1000;

-- rollup
-- description- The ROLLUP clause is used to roll up the results of a query that uses the GROUP BY clause.
SELECT IFNULL(customer_id, 'Total'), SUM(amount) AS total_amount
FROM payment
GROUP BY customer_id WITH ROLLUP;