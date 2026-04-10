-- grouping and filtering
SELECT city, COUNT(*) FROM person GROUP BY city HAVING COUNT(*) > 1; -- count the number of people in each city and filter to show only cities with more than 1 person
SELECT acc_type, AVG(balance) FROM customer GROUP BY acc_type; -- calculate the average balance for each account type in the 'customer' table
SELECT acc_type, SUM(balance) AS total_balance FROM customer GROUP BY acc_type; -- calculate the total balance for each account type in the 'customer' table
SELECT acc_type, COUNT(*) FROM customer GROUP BY acc_type HAVING COUNT(*) >= 5; -- count the number of customers for each account type and filter to show only account types with more than 5 customers  
