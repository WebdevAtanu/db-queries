-- In, not In, Between operators
SELECT * FROM Employees WHERE EmployeeID IN (1, 2) -- filter records with IN operator
SELECT * FROM Employees WHERE HireDate BETWEEN '2019-01-01' AND '2020-12-31' -- filter records with BETWEEN operator
SELECT * FROM Employees WHERE EmployeeID NOT IN (3, 4) -- filter records with NOT IN operator


--Like operator and wildcards
SELECT * FROM Employees WHERE FirstName LIKE 'D%' -- filter records with LIKE operator
SELECT * FROM Employees WHERE FirstName LIKE '[AC]%' -- filter records with pattern matching using brackets
SELECT * FROM Employees WHERE FirstName LIKE '[^J]%' -- filter records excluding those starting with 'J' using NOT operator in brackets
SELECT * FROM Employees WHERE FirstName LIKE '_____' -- filter records with exactly 5 characters in FirstName using underscore wildcard


-- Logical operators
SELECT * FROM Employees WHERE HireDate > '2019-01-01' AND LastName = 'Doe' -- filter records with AND operator
SELECT * FROM Employees WHERE LastName = 'Smith' OR LastName = 'Johnson' -- filter records with OR operator
SELECT * FROM Employees WHERE NOT LastName = 'Doe' -- filter records with NOT operator