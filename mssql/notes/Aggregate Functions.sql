-- Aggregate functions
SELECT AVG(DATEDIFF(year, HireDate, GETDATE())) AS AverageYearsEmployed FROM Employees -- calculate average years employed
SELECT SUM(EmployeeID) AS SumOfEmployeeIDs FROM Employees -- calculate sum of EmployeeIDs
SELECT MIN(HireDate) AS EarliestHireDate FROM Employees -- find the earliest HireDate
SELECT MAX(HireDate) AS LatestHireDate FROM Employees -- find the latest HireDate
SELECT COUNT(*) AS EmployeeCount FROM Employees -- count total number of employees
SELECT COUNT(DISTINCT Department) AS UniqueDepartments FROM Employees -- count unique departments
