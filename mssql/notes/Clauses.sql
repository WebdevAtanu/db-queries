-- Clauses
SELECT DISTINCT LastName FROM Employees -- get distinct LastNames from Employees table
SELECT * FROM Employees WHERE HireDate > '2019-12-31' -- filter records with WHERE clause
SELECT FirstName, LastName FROM Employees ORDER BY LastName ASC -- sort records with ORDER BY clause
SELECT TOP 1 * FROM Employees -- limit results to top 1 record
SELECT FirstName, LastName FROM Employees GROUP BY LastName -- group records by LastName