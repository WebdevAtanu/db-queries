SELECT datname FROM pg_database -- show all databases
CREATE DATABASE my_new_database; -- create a new database named 'my_new_database'
DROP DATABASE my_old_database; -- delete the database named 'my_old_database'

CREATE TABLE person(
    id INT,
    name VARCHAR(100),
    city VARCHAR(100)
) -- create a new table named 'person' with three columns: id, name, and city

CREATE TABLE customer(
    acc_no SERIAL PRIMARY KEY, -- the acc_no column is an auto-incrementing primary key
    name VARCHAR(100) NOT NULL, -- the name column cannot be null
    email VARCHAR(100) UNIQUE NOT NULL, -- the email column must be unique and cannot be null
    acc_type VARCHAR(50) NOT NULL DEFAULT 'savings', -- the acc_type column cannot be null and has a default value of 'savings'
    balance DECIMAL(10, 2) NOT NULL CHECK (balance >= 0) -- the balance column cannot be null and must be a non-negative decimal number with up to 10 digits and 2 decimal places
) 

INSERT INTO person (id, name, city) VALUES (1, 'Alice', 'New York'); -- insert a new record into the 'person' table
INSERT INTO person (id, name, city) VALUES (2, 'Bob', 'Los Angeles'); -- insert another record into the 'person' table

SELECT * FROM person; -- retrieve all records from the 'person' table
SELECT name FROM person WHERE city = 'New York'; -- retrieve the names of people who live in New York
UPDATE person SET city = 'San Francisco' WHERE name = 'Alice'; -- update the city for the person named 'Alice' to 'San Francisco'
DELETE FROM person WHERE id = 2; -- delete the record of the person with id 2 from the 'person' table

ALTER TABLE person ADD COLUMN age INT; -- add a new column named 'age' of type integer to the 'person' table
ALTER TABLE person DROP COLUMN age; -- remove the 'age' column from the 'person' table
ALTER TABLE person RENAME TO individual; -- rename the 'person' table to 'individual'
ALTER TABLE person RENAME COLUMN name TO full_name; -- rename the 'name' column to 'full_name' in the 'person' table