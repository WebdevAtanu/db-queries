SELECT COUNT(*) FROM customer; -- count the number of rows
SELECT COUNT(DISTINCT country) FROM customer; -- count the number of unique values
SELECT COUNT(*) as customers, country FROM customer GROUP BY country; -- count the number of unique values in each group by country
SELECT MIN(amount) FROM payment; -- find the minimum amount
SELECT MAX(amount) FROM payment; -- find the maximum amount

SELECT * FROM customer WHERE customer_id = (SELECT customer_id from payment WHERE amount = (SELECT MIN(amount) FROM payment)); -- find the customer who made the smallest payment

SELECT SUM(amount) FROM payment; -- sum all the amounts
SELECT AVG(amount) FROM payment; -- average all the amounts