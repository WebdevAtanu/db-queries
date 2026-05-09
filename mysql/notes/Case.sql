-- Active: 1777266959161@@127.0.0.1@3306@test_db
SELECT customer_id, amount,
    CASE WHEN amount > 1000 THEN 'high' 
    WHEN amount BETWEEN 500 AND 1000 THEN 'medium'
ELSE 'low' 
END AS amount_type
FROM payment