-- This query calculates the average payment amount for each customer using a Common Table Expression (CTE).
WITH cus_avg_payment AS(
    SELECT customer_id, AVG(amount) AS avg_payment
    FROM payment
    GROUP BY customer_id
)
SELECT * FROM cus_avg_payment

-- This query calculates the average payment amount for each customer in each country using a Common Table Expression (CTE).
GO
WITH avg_paid_country AS (
    SELECT c.country, AVG(p.amount) AS avg_payment
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.country
)
SELECT * FROM avg_paid_country