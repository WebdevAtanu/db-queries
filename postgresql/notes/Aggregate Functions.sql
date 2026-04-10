-- aggregate functions
SELECT COUNT(*) FROM person; -- count the total number of records in the 'person' table
SELECT AVG(balance) FROM customer; -- calculate the average balance in the 'customer' table
SELECT MAX(balance) FROM customer; -- retrieve the maximum balance in the 'customer' table
SELECT MIN(balance) FROM customer; -- retrieve the minimum balance in the 'customer' table
SELECT SUM(balance) FROM customer; -- calculate the total balance in the 'customer' table
SELECT city, COUNT(*) FROM person GROUP BY city; -- count the number of people in each city