SELECT CONCAT(first_name, " ", last_name) AS 'Full Name' FROM customer; -- concatenate first name and last name and store in Full Name column
SELECT CONCAT_WS("-", first_name, last_name, email) AS 'Full Name' FROM customer; -- concatenate first name, last name and email with - and store in Full Name column
SELECT SUBSTRING(first_name, 1, 3) AS 'First Name' FROM customer; -- get first 3 characters of first name
SELECT REPLACE(first_name, "a", "A") AS 'First Name' FROM customer; -- replace a with A
SELECT REVERSE(first_name) AS 'First Name' FROM customer; -- reverse first name
SELECT LOWER(first_name) AS 'First Name' FROM customer; -- convert first name to lowercase
SELECT UPPER(first_name) AS 'First Name' FROM customer; -- convert first name to uppercase'
SELECT CHAR_LENGTH(first_name) AS 'First Name' FROM customer; -- get length of first name
SELECT CHARACTER_LENGTH(first_name) AS 'First Name' FROM customer; -- get length of first name
SELECT LEFT(first_name, 3) AS 'First Name' FROM customer; -- get first 3 characters of first name
SELECT RIGHT(first_name, 3) AS 'First Name' FROM customer; -- get last 3 characters of first name
SELECT REPEAT(first_name, 3) AS 'First Name' FROM customer; -- repeat first name 3 times
SELECT TRIM(first_name) AS 'First Name' FROM customer; -- remove spaces from first name