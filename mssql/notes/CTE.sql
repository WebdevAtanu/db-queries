-- CTE
-- Definition: A Common Table Expression (CTE) is a temporary result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement. It is defined using the WITH keyword and provides a way to organize complex queries, improve readability, and enable recursive queries.
WITH EmployeeCTE AS (
    SELECT Department, AVG(Salary) AS AverageSalary FROM Employees GROUP BY Department
)
select * from Employees e JOIN EmployeeCTE cte ON e.Department = cte.Department
WHERE e.salary > cte.AverageSalary -- use a Common Table Expression (CTE) to calculate average salary by department and filter employees with above-average salary

