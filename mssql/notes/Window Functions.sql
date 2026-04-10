-- Window functions
-- Definition: Window functions perform calculations across a set of table rows that are related to the current row. They allow you to compute values such as running totals, ranks, and moving averages without collapsing the result set like aggregate functions do. Window functions use the OVER() clause to define the window of rows for the calculation.
SELECT EmployeeID, FirstName, LastName,
    ROW_NUMBER() OVER (ORDER BY HireDate) AS RowNum
FROM Employees -- assign a unique row number to each employee ordered by HireDate

SELECT FirstName, Salary, SUM(Salary) OVER() AS TotalSalary,
    CAST( Salary * 100 / SUM(Salary) OVER() AS DECIMAL(10,2)) AS SalaryPercentage
FROM Employees -- calculate total salary and each employee's salary percentage of the total

SELECT FirstName, Salary, SUM(Salary) OVER(PARTITION BY Department) AS TotalSalary
from Employees -- calculate total salary partitioned by Department

SELECT EmployeeID, FirstName, LastName,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees -- rank employees based on Salary in descending order

SELECT EmployeeID, FirstName, LastName,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank
FROM Employees -- assign dense rank to employees based on Salary in descending order