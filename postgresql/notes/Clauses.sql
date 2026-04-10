-- clauses:
SELECT name, city FROM person WHERE id = 1; -- retrieve the name and city of the person with id 1
SELECT name FROM person WHERE city = 'San Francisco'; -- retrieve the names of people who live in San Francisco
SELECT * FROM person ORDER BY name ASC; -- retrieve all records from the 'person' table and sort them by name in ascending order
SELECT * FROM person ORDER BY name DESC; -- retrieve all records from the 'person' table and sort them by name in descending order
SELECT * FROM person WHERE name LIKE 'A%'; -- retrieve records of people whose names start with 'A'
SELECT * FROM person WHERE name="Alice" or name="Bob"; -- retrieve records of people whose names are either 'Alice' or 'Bob'
SELECT * FROM person WHERE name IN ('Alice', 'Bob'); -- retrieve records of people whose names are in the list ('Alice', 'Bob')
SELECT * FROM person WHERE name IS NULL; -- retrieve records of people whose names are null
SELECT * FROM person WHERE name IS NOT NULL; -- retrieve records of people whose names are not null
SELECT * FROM person WHERE id > 1; -- retrieve records of people whose id is greater than 1
SELECT * FROM person WHERE id >= 1 AND id <= 10; -- retrieve records of people whose id is between 1 and 10 (inclusive)
SELECT * FROM person WHERE id < 5 OR city = 'New York'; -- retrieve records of people whose id is less than 5 or who live in New York
SELECT * FROM person WHERE name LIKE '%o%'; -- retrieve records of people whose names contain the letter 'o'
SELECT DISTINCT city FROM person; -- retrieve unique cities from the 'person' table
SELECT name FROM customer WHERE acc_type = 'savings' AND balance > 1000; -- retrieve the names of customers with a savings account and a balance greater than 1000
SELECT name FROM customer WHERE balance BETWEEN 500 AND 2000; -- retrieve the names of customers whose balance is between 500 and 2000
SELECT LIMIT 5 * FROM person; -- retrieve the first 5 records from the 'person' table
SELECT OFFSET 10 * FROM person; -- skip the first 10 records and retrieve the rest from the 'person' table
SELECT name FROM person ORDER BY name ASC LIMIT 3; -- retrieve the first 3 names from the 'person' table sorted by name in ascending order
SELECT name FROM person ORDER BY name DESC LIMIT 3; -- retrieve the first 3 names from the 'person' table sorted by name in descending order
