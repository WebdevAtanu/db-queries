EXEC sp_databases -- show all databases on the server
SELECT name FROM sys.databases -- show all databases names on the server

-- Create, use, drop database
CREATE DATABASE test_db -- create a new database named test_db
USE test_db -- switch to the test_db database
SELECT DB_NAME() AS CurrentDatabase -- show the current database name
DROP DATABASE test_db -- delete the test_db database


-- Create, alter, drop table
CREATE TABLE Employer ( -- create a new table named Employer
    EmployeeID INT PRIMARY KEY, -- define EmployeeID as the primary key
    FirstName NVARCHAR(50), -- define FirstName column
    LastName NVARCHAR(50), -- define LastName column
    HireDate DATE -- define HireDate column
);
ALTER TABLE Employer ADD Salary DECIMAL(10, 2) -- add a new column Salary to Employer table
ALTER TABLE Employer DROP COLUMN Salary -- remove the Salary column from Employer table
DROP TABLE Employer -- delete the Employer table
EXEC sp_help 'Employees' -- show the structure of the Employees table


-- Insert, select, update, delete, truncate
INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate) VALUES -- insert sample data into Employees table
(1, 'John', 'Doe', '2020-01-15'),
(2, 'Jane', 'Smith', '2019-03-22'),
(3, 'Emily', 'Johnson', '2021-07-30');
SELECT * FROM Employees -- retrieve all records from Employees table
UPDATE Employees SET LastName = 'Doe-Smith' WHERE EmployeeID = 2 -- update LastName for EmployeeID 2
DELETE FROM Employees WHERE EmployeeID = 3 -- delete record for EmployeeID 3
TRUNCATE TABLE Employees -- remove all records from Employees table