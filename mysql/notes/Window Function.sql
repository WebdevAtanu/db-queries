-- This query will return all columns from the customer table along with a count of how many customers are in each country. The COUNT(*) function is used as a window function, and the PARTITION BY clause groups the results by the country column.
SELECT *, COUNT(*) OVER (PARTITION BY country) FROM customer 

-- This query will return the customer_id, first_name, full_name (concatenation of first_name and last_name), country, amount from the payment table, and a rank of each customer within their country based on the amount they paid. The RANK() function is used as a window function, and the PARTITION BY clause groups the results by the country column while ordering them by the amount in descending order.
SELECT c.customer_id,CONCAT(c.first_name,' ',c.last_name) AS full_name,c.country,p.amount, RANK() OVER (PARTITION BY country ORDER BY p.amount) AS cus_rank 
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
ORDER BY country, cus_rank DESC

-- DENSE_RANK() is similar to RANK(), but it does not skip ranks if there are ties. For example, if two customers have the same amount, they will both receive the same rank, and the next rank will be the next consecutive number.
SELECT c.customer_id,CONCAT(c.first_name,' ',c.last_name) AS full_name,c.country,p.amount, DENSE_RANK() OVER (PARTITION BY country ORDER BY p.amount) AS cus_rank 
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
ORDER BY country, cus_rank DESC