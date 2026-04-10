-- Group by
SELECT HireDate, COUNT(*) AS EmployeeCount FROM Employees GROUP BY HireDate -- count number of employees grouped by HireDate
SELECT HireDate, COUNT(*) AS EmployeeCount FROM Employees GROUP BY HireDate HAVING COUNT(*) > 1 -- filter groups with HAVING clause
SELECT HireDate, FirstName, COUNT(*) AS EmployeeCount FROM Employees GROUP BY HireDate, FirstName -- group by multiple columns
SELECT FirstName, HireDate, Salary FROM Employees GROUP BY HireDate, FirstName, Salary HAVING Salary > 50000 -- filter grouped records with HAVING clause on multiple columns
SELECT HireDate, AVG(Salary) AS AverageSalary FROM Employees GROUP BY HireDate ORDER BY AverageSalary DESC -- order grouped records by average salary in descending order
SELECT HireDate, SUM(Salary) AS TotalSalary FROM Employees GROUP BY ROLLUP (HireDate) -- use ROLLUP to get grand total for Salary
SELECT COALESCE(FirstName, 'Total'), Salary FROM Employees GROUP BY FirstName, ROLLUP(Salary) -- use ROLLUP on multiple columns
SELECT COALESCE(FirstName, 'Total'), Salary FROM Employees GROUP BY ROLLUP(Salary, FirstName) -- use ROLLUP on multiple columns
