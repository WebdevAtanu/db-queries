-- Having Clause is used to filter the data based on the aggregate function. It is used in conjunction with the GROUP BY clause.
SELECT name, acc_type, balance 
FROM customer
GROUP BY name, acc_type, balance HAVING balance > 1000; -- to filter the data based on the balance which is greater than 1000

-- Rollup is used to aggregate the data based on the grouping columns. It is used in conjunction with the GROUP BY clause.
SELECT COALESCE(name, 'Total') AS name, -- to replace null values with 'Total' for the grand total row
SUM(balance) AS Amount
FROM customer
GROUP BY ROLLUP(name)
ORDER BY Amount; -- to aggregate the data based on the name and calculate the total balance for each name, and also calculate the grand total balance for all names