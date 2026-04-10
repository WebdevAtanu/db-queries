-- Subqueries
SELECT * FROM Employees WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE HireDate > '2020-01-01') -- use subquery to filter records
SELECT FirstName, LastName FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees) -- use subquery to compare Salary with average Salary
SELECT EmployeeID, FirstName, LastName FROM Employees WHERE HireDate = (SELECT MIN(HireDate) FROM Employees) -- use subquery to find employees with earliest HireDate
SELECT EmployeeID, FirstName, LastName FROM Employees WHERE Salary = (SELECT MAX(Salary) FROM Employees WHERE HireDate < '2021-01-01') -- use subquery with condition
SELECT EmployeeID, FirstName, LastName FROM Employees WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE Salary > 60000) -- use subquery to filter by Salary
SELECT FirstName, LastName FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees WHERE HireDate > '2019-01-01') -- use subquery with condition
SELECT EmployeeID, FirstName, LastName FROM Employees WHERE HireDate = (SELECT MIN(HireDate) FROM Employees WHERE Salary > 50000) -- use subquery with condition
SELECT EmployeeID, FirstName, LastName FROM Employees WHERE Salary = (SELECT MAX(Salary) FROM Employees WHERE HireDate BETWEEN '2019-01-01' AND '2020-12-31') -- use subquery with range condition
SELECT EmployeeID, FirstName, LastName FROM Employees WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE HireDate < '2020-01-01' AND Salary > 70000) -- use subquery with multiple conditions
SELECT FirstName, LastName FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees WHERE HireDate BETWEEN '2019-01-01' AND '2021-12-31') -- use subquery with range condition

SELECT * from Employees e1
WHERE Salary > (SELECT AVG(Salary) FROM Employees e2 WHERE e1.HireDate = e2.HireDate) -- use correlated subquery to compare Salary within same HireDate group

SELECT FirstName, avg from(
    select HireDate, FirstName, AVG(Salary) as avg from Employees GROUP BY HireDate, FirstName
) as AvgSalaries
WHERE avg>20000