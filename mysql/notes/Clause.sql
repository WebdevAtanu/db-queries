-- Active: 1777266959161@@127.0.0.1@3306@test_db
SELECT DISTINCT country FROM customer; -- unique values only
SELECT * FROM customer ORDER BY country DESC; -- order by desc 
SELECT * FROM customer ORDER BY country ASC, first_name DESC; -- order by asc and desc
SELECT * FROM customer WHERE first_name LIKE "j%" OR first_name LIKE "J%"; -- case-insensitive like operator
SELECT * FROM customer LIMIT 5; -- limit the number of rows 
SELECT * FROM customer LIMIT 5 OFFSET 5; -- offset the number of rows
SELECT * FROM customer LIMIT 5, 5; -- offset the number of rows
