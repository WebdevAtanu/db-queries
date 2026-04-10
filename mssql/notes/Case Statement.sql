-- Case statements
SELECT FirstName, LastName,
    CASE 
        WHEN HireDate < '2020-01-01' THEN 'Veteran'
        WHEN HireDate BETWEEN '2020-01-01' AND '2021-12-31' THEN 'Experienced'
        ELSE 'Newcomer'
    END AS EmployeeType
FROM Employees -- categorize employees based on HireDate using CASE statement