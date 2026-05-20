--CTE
-- This query calculates the average balance for each account type and then retrieves the customers whose balance is above the average for their respective account type.
WITH acc_type_average AS (
    SELECT acc_type, AVG(balance) AS average_balance
    FROM customer
    GROUP BY acc_type
) -- CTE to calculate average balance for each account type

SELECT c.name, c.balance, c.acc_type, ct.average_balance
FROM customer c
JOIN acc_type_average ct ON c.acc_type = ct.acc_type
WHERE c.balance > ct.average_balance
ORDER BY c.acc_type;