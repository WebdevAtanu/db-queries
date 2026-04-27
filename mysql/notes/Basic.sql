CREATE DATABASE test_db; -- create new database
SHOW DATABASES; -- show all databases
DROP DATABASE test_db; -- delete database
USE test_db; -- select database

-- create table
CREATE TABLE user(userId INT AUTO_INCREMENT PRIMARY KEY, 
userName VARCHAR(255), 
Email VARCHAR(255), 
userPassword VARCHAR(255));
DROP TABLE user; -- delete table
SHOW TABLES; -- show all tables
DESC user; -- describe table
INSERT INTO user(userName, Email, userPassword) 
VALUES("John", "l4V2r@example.com", "123456"); -- insert data into table
SELECT * FROM `user`; -- select all data from table
UPDATE `user` SET `Email` = "john@example.com" WHERE `userId` = 1; -- update data in table
DELETE FROM `user` WHERE `userId` = 1; -- delete data from table

CREATE Table customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE, -- email must be unique
    phone VARCHAR(20),
    country VARCHAR(255) DEFAULT "India" -- default value is India
);
INSERT INTO customer (first_name, last_name, email, phone)
VALUES ("John", "Doe", "l4V2r@example.com", "1234567890");
SELECT * FROM customer;
ALTER Table customer 
ADD COLUMN address VARCHAR(255); -- add column to table
ALTER Table customer 
DROP COLUMN address; -- drop column from table
