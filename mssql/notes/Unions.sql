-- Unions
-- Definition: UNION is used to combine the result sets of two or more SELECT statements into a single result set. It removes duplicate rows from the combined result. UNION ALL is similar but does not remove duplicates.
SELECT FirstName, LastName, 'Employee' AS Role FROM Employees
UNION
SELECT Name AS FirstName, '' AS LastName, 'Customer' AS Role FROM Customers -- combine Employees and Customers into a single result set with UNION

-- Union all
-- Definition: UNION ALL combines the result sets of two or more SELECT statements into a single result set without removing duplicates. It is faster than UNION because it does not perform the duplicate elimination step.
SELECT FirstName, LastName, 'Employee' AS Role FROM Employees
UNION ALL
SELECT Name AS FirstName, '' AS LastName, 'Customer' AS Role FROM Customers -- combine Employees and Customers into a single result set with UNION ALL

-- Intersect
-- Definition: INTERSECT returns the rows that are present in both SELECT statements. It removes duplicates and only returns distinct rows that are present in both queries.
SELECT FirstName, LastName FROM Employees
INTERSECT
SELECT Name AS FirstName, '' AS LastName FROM Customers -- get employees who are also customers using INTERSECT

-- Except
-- Definition: EXCEPT returns the rows from the first SELECT statement that are not present in the second SELECT statement. It removes duplicates and only returns distinct rows from the first query that do not have a match in the second query.
SELECT FirstName, LastName FROM Employees
EXCEPT
SELECT Name AS FirstName, '' AS LastName FROM Customers -- get employees who are not customers using EXCEPT