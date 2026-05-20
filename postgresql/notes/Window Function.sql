-- over clause
SELECT name, balance, SUM(balance) OVER(ORDER BY balance) AS running_total FROM customer; -- calculates the running total of the balance for each customer by ordering the data based on the balance

-- partition by clause
SELECT name, acc_type, balance, SUM(balance) OVER(PARTITION BY acc_type) AS total_balance FROM customer; -- calculates the total balance for each account type by partitioning the data based on the account type

-- rank function
SELECT name, balance, RANK() OVER(ORDER BY balance DESC) AS rank FROM customer -- assigns a rank to each customer based on their balance in descending order

SELECT name, balance, acc_type, rank from (SELECT name, balance, acc_type, RANK() OVER(PARTITION BY acc_type ORDER BY balance DESC) AS rank FROM customer) as result WHERE rank=2 -- retrieves the name, balance, account type, and rank of customers who are ranked second in their respective account types based on their balance in descending order

-- dense_rank function
SELECT name, balance, DENSE_RANK() OVER(ORDER BY balance DESC) AS DENSE_RANK FROM customer -- assigns a dense rank to each customer based on their balance in descending order, without skipping ranks for ties

-- row_number function
SELECT name, balance, ROW_NUMBER() OVER(ORDER BY balance DESC) AS ROW_NUMBER FROM customer -- assigns a row number to each customer based on their balance in descending order, without skipping numbers for ties

-- lead and lag functions
SELECT name, balance, LEAD(balance) OVER(ORDER BY balance DESC) AS next_balance, LAG(balance) OVER(ORDER BY balance DESC) AS previous_balance FROM customer -- retrieves the next and previous balance of each customer based on their balance in descending order

