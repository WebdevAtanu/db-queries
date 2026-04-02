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


-- test_db tables
SELECT * FROM Customers
SELECT * FROM Employees
SELECT * FROM Menus
SELECT * FROM Orders
SELECT * FROM OrderItems
SELECT * FROM restaurants
SELECT * FROM payments
SELECT * FROM AuditLogs


-- Clauses
SELECT DISTINCT LastName FROM Employees -- get distinct LastNames from Employees table
SELECT * FROM Employees WHERE HireDate > '2019-12-31' -- filter records with WHERE clause
SELECT FirstName, LastName FROM Employees ORDER BY LastName ASC -- sort records with ORDER BY clause
SELECT TOP 1 * FROM Employees -- limit results to top 1 record
SELECT FirstName, LastName FROM Employees GROUP BY LastName -- group records by LastName


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


-- Case statements
SELECT FirstName, LastName,
    CASE 
        WHEN HireDate < '2020-01-01' THEN 'Veteran'
        WHEN HireDate BETWEEN '2020-01-01' AND '2021-12-31' THEN 'Experienced'
        ELSE 'Newcomer'
    END AS EmployeeType
FROM Employees -- categorize employees based on HireDate using CASE statement


-- Aggregate functions
SELECT AVG(DATEDIFF(year, HireDate, GETDATE())) AS AverageYearsEmployed FROM Employees -- calculate average years employed
SELECT SUM(EmployeeID) AS SumOfEmployeeIDs FROM Employees -- calculate sum of EmployeeIDs
SELECT MIN(HireDate) AS EarliestHireDate FROM Employees -- find the earliest HireDate
SELECT MAX(HireDate) AS LatestHireDate FROM Employees -- find the latest HireDate
SELECT COUNT(*) AS EmployeeCount FROM Employees -- count total number of employees


-- Group by
SELECT HireDate, COUNT(*) AS EmployeeCount FROM Employees GROUP BY HireDate -- count number of employees grouped by HireDate
SELECT HireDate, COUNT(*) AS EmployeeCount FROM Employees GROUP BY HireDate HAVING COUNT(*) > 1 -- filter groups with HAVING clause
SELECT HireDate, FirstName, COUNT(*) AS EmployeeCount FROM Employees GROUP BY HireDate, FirstName -- group by multiple columns
SELECT FirstName, HireDate, Salary FROM Employees GROUP BY HireDate, FirstName, Salary HAVING Salary > 50000 -- filter grouped records with HAVING clause on multiple columns
SELECT HireDate, AVG(Salary) AS AverageSalary FROM Employees GROUP BY HireDate ORDER BY AverageSalary DESC -- order grouped records by average salary in descending order
SELECT HireDate, SUM(Salary) AS TotalSalary FROM Employees GROUP BY ROLLUP (HireDate) -- use ROLLUP to get grand total for Salary
SELECT COALESCE(FirstName, 'Total'), Salary FROM Employees GROUP BY FirstName, ROLLUP(Salary) -- use ROLLUP on multiple columns
SELECT COALESCE(FirstName, 'Total'), Salary FROM Employees GROUP BY ROLLUP(Salary, FirstName) -- use ROLLUP on multiple columns


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


-- String functions
SELECT UPPER(FirstName) AS UpperFirstName FROM Employees -- convert FirstName to uppercase
SELECT LOWER(LastName) AS LowerLastName FROM Employees -- convert LastName to lowercase
SELECT FirstName, LEN(FirstName) AS FirstNameLength FROM Employees -- get length of FirstName
SELECT SUBSTRING(LastName, 1, 3) AS LastNameSubstring FROM Employees -- get substring of LastName
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees -- concatenate FirstName and LastName
SELECT REPLACE(LastName, 'Smith', 'Johnson') AS UpdatedLastName FROM Employees -- replace 'Smith' with 'Johnson' in LastName
SELECT LTRIM(RTRIM(FirstName)) AS TrimmedFirstName FROM Employees -- trim leading and trailing spaces from FirstName
SELECT CHARINDEX('o', LastName) AS PositionOfO FROM Employees -- find position of 'o' in LastName
SELECT CAST(Salary AS NVARCHAR(20)) AS SalaryAsString FROM Employees -- convert Salary to string
SELECT FORMAT(HireDate, 'yyyy-MM-dd') AS FormattedHireDate FROM Employees -- format HireDate to 'yyyy-MM-dd'
SELECT LEFT(FirstName, 2) AS FirstTwoChars FROM Employees -- get the first two characters of FirstName
SELECT RIGHT(LastName, 3) AS LastThreeChars FROM Employees -- get the last three characters of LastName
SELECT REVERSE(FirstName) AS ReversedFirstName FROM Employees -- reverse the characters in FirstName
SELECT STUFF(LastName, 2, 3, 'XXX') AS ModifiedLastName FROM Employees -- replace characters in LastName using STUFF function
SELECT DIFFERENCE(FirstName, 'John') AS SoundexDifference FROM Employees -- compare soundex values of FirstName with 'John'
SELECT SOUNDEX(LastName) AS LastNameSoundex FROM Employees -- get soundex value of LastName
SELECT REPLICATE(FirstName, 2) AS RepeatedFirstName FROM Employees -- repeat FirstName twice
SELECT PARSENAME('www.example.com', 1) AS TopLevelDomain -- get the top-level domain from a URL
SELECT STRING_AGG(LastName, ', ') AS AllLastNames FROM Employees -- aggregate LastNames into a single string
SELECT TRANSLATE(FirstName, 'aeiou', '12345') AS TranslatedFirstName FROM Employees -- translate vowels in FirstName to numbers
SELECT TRIM(FirstName) AS TrimmedFirstName FROM Employees -- trim spaces from both ends of FirstName
SELECT FORMATMESSAGE('Employee: %s %s', FirstName, LastName) AS FormattedMessage FROM Employees -- format a message with FirstName and LastName
SELECT CONCAT_WS('-', FirstName, LastName) AS FullNameWithSeparator FROM Employees -- concatenate FirstName and LastName with a separator
SELECT CONCAT_WS(' - ', FirstName, LastName, CAST(Salary AS NVARCHAR(20))) AS EmployeeInfo FROM Employees -- concatenate multiple fields with a separator


-- Date functions
SELECT GETDATE() AS CurrentDateTime -- get the current date and time
SELECT DATEADD(YEAR,2,GETDATE()) AS DateAfterTwoYears -- add 2 years to the current date
SELECT DATEDIFF(DAY,'2026-01-01',GETDATE()) AS NoOfDays -- calculate the difference in days from 2026-01-01 to today
SELECT DATEPART(MONTH,GETDATE()) AS CurrentMonth -- get the current month
SELECT DATENAME(WEEKDAY,GETDATE()) AS CurrentWeekdayName -- get the name of the current weekday
SELECT EOMONTH(GETDATE()) AS EndOfCurrentMonth -- get the end date of the current month
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+05:00') AS DateTimeInDifferentTimeZone -- switch the current date and time to a different time zone
SELECT ISDATE('2022-12-31') AS IsValidDate -- check if a string is a valid date
SELECT FORMAT(GETDATE(), 'dddd, MMMM dd, yyyy') AS FormattedCurrentDate -- format the current date in a specific format
SELECT TRY_CONVERT(DATE, '2022-02-30') AS TryConvertInvalidDate -- attempt to convert an invalid date string
SELECT SYSDATETIME() AS SystemDateTime -- get the system date and time
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-08:00') AS DateTimeInPST -- switch the current date and time to PST time zone
SELECT DATEADD(MONTH, -3, GETDATE()) AS DateThreeMonthsAgo -- subtract 3 months from the current date
SELECT DATEDIFF(HOUR, '2026-01-01 00:00:00', GETDATE()) AS NoOfHours -- calculate the difference in hours from a specific date and time to now
SELECT DATEPART(QUARTER, GETDATE()) AS CurrentQuarter -- get the current quarter of the year
SELECT DATENAME(MONTH, '2022-07-15') AS MonthNameFromDate -- get the month name from a specific date
SELECT EOMONTH('2022-02-10') AS EndOfMonthForGiven
SELECT CONVERT(date,GETDATE()) AS CurrentDate -- get the current date without time


-- Joins
-- Definition: A join is used to combine rows from two or more tables based on a related column between them. It allows you to retrieve data from multiple tables in a single query by specifying the join condition.

-- Cross join
-- Definition: A cross join returns the Cartesian product of the two tables, meaning it combines each row from the first table with every row from the second table. It does not require a join condition and can result in a large number of rows if both tables have many records.
SELECT * FROM Orders CROSS JOIN OrderItems -- get Cartesian product of Orders and OrderItems tables
SELECT c.Name, CONCAT(e.FirstName, ' ', e.LastName) AS FullName FROM Customers c CROSS JOIN Employees e -- combine Customers and Employees tables

-- Inner join
-- Definition: An inner join returns only the rows that have matching values in both tables based on the specified join condition. It filters out rows that do not have a match in either table.
SELECT o.OrderID, m.ItemName, oi.Quantity FROM Orders o 
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID 
INNER JOIN Menus m ON oi.MenuId = m.MenuId 
ORDER BY oi.Quantity DESC -- get matching records from Orders, OrderItems, and Menus tables with inner joins

-- Left join
-- Definition: A left join returns all rows from the left table, even if there are no matches in the right table. It keeps all rows from the left table and adds any matching rows from the right table.
SELECT c.Name, o.OrderID FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID -- get all customers with their orders using left join

-- Right join
-- Definition: A right join returns all rows from the right table, even if there are no matches in the left table. It keeps all rows from the right table and adds any matching rows from the left table.
SELECT o.OrderID, c.Name FROM Orders o RIGHT JOIN Customers c ON o.CustomerID = c.CustomerID -- get all orders with customer names using right join


-- Outer apply
-- Definition: OUTER APPLY is used to join a table to a table-valued function or subquery that returns a result set. It returns all rows from the left table and the matching rows from the right side, similar to a LEFT JOIN, but allows for more complex logic in the right side.
SELECT c.CustomerId, c.Name, c.Phone, LatestOrder.OrderId, LatestOrder.OrderDate, LatestOrder.[Status] FROM Customers c OUTER APPLY (
    SELECT TOP 1 * FROM Orders o WHERE O.CustomerId = C.CustomerId
) as LatestOrder -- get the latest order for each customer using outer apply

-- Cross apply
-- Definition: CROSS APPLY is similar to OUTER APPLY but only returns rows from the left table that have matching rows in the right side. It is used when you want to filter the left table based on the results of the right side.
SELECT c.CustomerId, c.Name, c.Phone, RecentOrder.OrderId, RecentOrder.OrderDate, RecentOrder.[Status] FROM Customers c CROSS APPLY (
    SELECT TOP 1 * FROM Orders o WHERE O.CustomerId = C.CustomerId ORDER BY o.OrderDate DESC
) as RecentOrder -- get the most recent order for each customer using cross apply


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


-- Except
-- Definition: EXCEPT returns the rows from the first SELECT statement that are not present in the second SELECT statement. It removes duplicates and only returns distinct rows from the first query that do not have a match in the second query.
SELECT FirstName, LastName FROM Employees
EXCEPT
SELECT Name AS FirstName, '' AS LastName FROM Customers -- get employees who are not customers using EXCEPT


-- Views
-- Definition: A view is a virtual table that is based on the result set of a SELECT statement. It does not store data itself but provides a way to simplify complex queries, encapsulate logic, and present data in a specific format. Views can be queried like regular tables and can also be used to restrict access to certain columns or rows of data.
SELECT * FROM INFORMATION_SCHEMA.VIEWS -- show all views in the current database
SELECT * FROM sys.views -- show all views in the current database using sys.views
DROP VIEW IF EXISTS EmployeeView -- drop the view named EmployeeView if it exists

GO
CREATE VIEW EmployeeView AS 
SELECT EmployeeID, FirstName, LastName, HireDate FROM Employees WHERE HireDate > '2020-01-01'; -- create a view named EmployeeView
GO

SELECT * FROM EmployeeView -- query the EmployeeView to get employees hired after 2020-01-01


-- Window functions
-- Definition: Window functions perform calculations across a set of table rows that are related to the current row. They allow you to compute values such as running totals, ranks, and moving averages without collapsing the result set like aggregate functions do. Window functions use the OVER() clause to define the window of rows for the calculation.
SELECT EmployeeID, FirstName, LastName, 
    ROW_NUMBER() OVER (ORDER BY HireDate) AS RowNum
FROM Employees -- assign a unique row number to each employee ordered by HireDate

SELECT FirstName, Salary, SUM(Salary) OVER() AS TotalSalary,
CAST( Salary * 100 / SUM(Salary) OVER() AS DECIMAL(10,2)) AS SalaryPercentage
FROM Employees -- calculate total salary and each employee's salary percentage of the total

SELECT FirstName, Salary, SUM(Salary) OVER(PARTITION BY Department) AS TotalSalary from Employees -- calculate total salary partitioned by Department

SELECT EmployeeID, FirstName, LastName, 
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees -- rank employees based on Salary in descending order

SELECT EmployeeID, FirstName, LastName, 
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank
FROM Employees -- assign dense rank to employees based on Salary in descending order


-- CTE
-- Definition: A Common Table Expression (CTE) is a temporary result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement. It is defined using the WITH keyword and provides a way to organize complex queries, improve readability, and enable recursive queries.
WITH EmployeeCTE AS (
    SELECT Department, AVG(Salary) AS AverageSalary FROM Employees GROUP BY Department
)
select * from Employees e JOIN EmployeeCTE cte ON e.Department = cte.Department
WHERE e.salary > cte.AverageSalary -- use a Common Table Expression (CTE) to calculate average salary by department and filter employees with above-average salary


-- Temporary tables
-- Definition: Temporary tables are used to store intermediate results temporarily during a session. They are created in the tempdb database and are automatically dropped when the session ends or when they are no longer needed. Temporary tables can be useful for storing data that is needed for complex queries or for breaking down large queries into smaller, more manageable parts.
CREATE TABLE #TempEmployees (EmployeeID INT, FirstName NVARCHAR(50), LastName NVARCHAR(50)) -- create a temporary table named #TempEmployees
INSERT INTO #TempEmployees (EmployeeID, FirstName, LastName) VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith') -- insert sample data into the temporary table
SELECT * FROM #TempEmployees -- query the temporary table to retrieve data


-- Stored procedures
-- Definition: A stored procedure is a precompiled collection of SQL statements that can be executed as a single unit. It can accept parameters, perform complex operations, and return results. Stored procedures are stored in the database and can be reused multiple times, providing a way to encapsulate logic and improve performance by reducing the need for repeated parsing and compilation of SQL statements.
CREATE PROCEDURE sp_getEmployeesByDepartment 
@department NVARCHAR(50) 
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, salary FROM Employees WHERE Department = @department -- create a stored procedure to get employees by department
END
EXEC sp_getEmployeesByDepartment @department = 'Sales' -- execute the stored procedure with a parameter value
DROP PROCEDURE sp_getEmployeesByDepartment -- drop the stored procedure

CREATE PROCEDURE sp_updateEmployeeSalary
@employeeId INT,
@salary DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees SET salary = @salary
    WHERE EmployeeID=@employeeId 
END
EXEC sp_updateEmployeeSalary @employeeId = 3, @salary = 40000 


-- Stored procedure output parameter
-- Definition: An output parameter in a stored procedure allows you to return a value from the procedure back to the caller. It is defined using the OUTPUT keyword and can be used to return calculated values, status messages, or any other information that needs to be passed back after the procedure execution.
CREATE PROCEDURE sp_getEmployeeAvgSalary
@department NVARCHAR(50),
@avgSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SET @avgSalary = (SELECT AVG(Salary) FROM Employees WHERE Department = @department)
END

DECLARE @avgSalary DECIMAL(10,2)
EXEC sp_getEmployeeAvgSalary 'Sales', @avgSalary OUTPUT -- execute the stored procedure with output parameter
SELECT @avgSalary -- retrieve the output parameter value


-- Stored procedure with condition
-- Definition: A stored procedure with a condition includes logic that allows it to perform different actions based on certain criteria. This can involve using IF statements, CASE statements, or other control flow mechanisms to determine the behavior of the procedure based on input parameters or data in the database.
CREATE PROCEDURE sp_updateEmployeeSalaryWithCondition
@employeeId INT,
@newSalary DECIMAL(10,2),
@message NVARCHAR(200) OUTPUT
AS 
BEGIN
    DECLARE @currentSalary DECIMAL(10,2)
    IF NOT EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @employeeId) -- check if the employee exists
    BEGIN
        SET @message = 'Employee not found';
        RETURN
    END
    SELECT @currentSalary = Salary from Employees WHERE EmployeeID = @employeeId; -- get the current salary of the employee
    IF @newSalary > @currentSalary
        BEGIN
        UPDATE Employees SET salary = @newSalary WHERE EmployeeID = @employeeId;
        SET @message = 'Salary updated successfully';
    END
    ELSE
    BEGIN
        SET @message = 'New salary is less than or equal to the current salary';
    END
END

DECLARE @message NVARCHAR(200), @newSalary DECIMAL(10,2)
EXEC sp_updateEmployeeSalaryWithCondition @employeeId = 3, @newSalary = 90000, @message = @message OUTPUT -- execute the stored procedure with condition
SELECT @message as message


-- User defined functions
-- Definition: A user-defined function (UDF) is a reusable function that you can create in SQL Server to perform specific calculations or operations. UDFs can accept parameters, return a single value (scalar function), or return a table (table-valued function). They allow you to encapsulate logic and can be used in queries just like built-in functions.

-- Scalar function
-- Definition: A scalar function returns a single value based on the input parameters. It can be used in SELECT statements, WHERE clauses, and other parts of a query where a single value is expected.
CREATE FUNCTION udf_getEmployeeCount
(
@department NVARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @count INT;
    SELECT @count = COUNT(*) FROM Employees WHERE Department = @department;
    RETURN @count;
END
SELECT dbo.udf_getEmployeeCount('Sales') as EmployeeCount -- call the user-defined function to get employee count

CREATE FUNCTION udf_getEmployeeAvgSalary
(
@department NVARCHAR(50)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @avgSalary DECIMAL(10,2);
    SELECT @avgSalary = AVG(Salary) FROM Employees WHERE Department = @department;
    RETURN @avgSalary;
END
SELECT dbo.udf_getEmployeeAvgSalary('Sales') as AvgSalary -- call the user-defined function to get average salary

CREATE FUNCTION udf_getEmployeeSalaryByDetails
(
    @employeeId INT,
    @department NVARCHAR(50)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @salary DECIMAL(10,2);
    SELECT @salary = Salary FROM Employees WHERE EmployeeID = @employeeId AND Department = @department;
    RETURN @salary;
END
SELECT dbo.udf_getEmployeeSalaryByDetails(1, 'Sales') as Salary -- call the user-defined function to get salary by employeeId and department


-- Table value function
-- Definition: A table-valued function returns a table data type and can be used in the FROM clause of a query. It allows you to return a result set that can be treated like a regular table, enabling you to perform joins, filters, and other operations on the returned data.
CREATE FUNCTION udf_getEmployeesByDepartment
(
    @department NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN(
    SELECT * FROM Employees WHERE Department = @department -- create a table value function to get employees by department
)
SELECT * FROM dbo.udf_getEmployeesByDepartment('Sales')

CREATE FUNCTION udf_getEmployeesBySalaryRange
(
    @minSalary DECIMAL(10,2),
    @maxSalary DECIMAL(10,2)
)
RETURNS TABLE
AS
RETURN(
    SELECT * FROM Employees WHERE Salary BETWEEN @minSalary AND @maxSalary -- create a table value function to get employees by salary range
)
SELECT * FROM dbo.udf_getEmployeesBySalaryRange(20000, 50000)


-- Indexing
-- Definition: Indexing is a database optimization technique that improves the speed of data retrieval operations on a table. An index is a data structure that allows the database engine to quickly locate and access the data without having to scan the entire table. Indexes can be created on one or more columns of a table and can significantly enhance query performance, especially for large datasets.
SET STATISTICS IO ON -- enable statistics IO to see index usage
SET STATISTICS TIME ON -- enable statistics time to see query execution time

CREATE INDEX idx_department ON Employees(Department) -- create an index on the Department column
SELECT * FROM Employees WHERE Department = 'Sales' -- query to test index usage
DROP INDEX idx_department ON Employees -- drop the index
EXEC sp_helpindex 'Employees' -- show indexes on the Employees table


-- Transactions
-- Definition: A transaction is a sequence of one or more SQL operations that are executed as a single unit of work. Transactions ensure data integrity and consistency by allowing you to commit changes if all operations succeed or roll back changes if any operation fails. This helps maintain the integrity of the database in case of errors or unexpected issues during the execution of SQL statements.
BEGIN TRANSACTION -- start a new transaction
    UPDATE Employees SET Salary = 50000 WHERE EmployeeID = 1 -- update salary for EmployeeID 1
    UPDATE Employees SET Salary = 60000 WHERE EmployeeID = 2 -- update salary for EmployeeID 2
COMMIT -- commit the transaction to save changes
BEGIN TRANSACTION -- start another transaction
    UPDATE Employees SET Salary = 70000 WHERE EmployeeID = 3 -- update salary for EmployeeID 3
ROLLBACK -- rollback the transaction to undo changes
SELECT * FROM Employees -- query to see the final state of Employees table after transactions


-- Error handling
-- Definition: Error handling in SQL Server allows you to manage errors that occur during the execution of SQL statements. It involves using TRY...CATCH blocks to handle errors gracefully and provide meaningful error messages or perform rollback operations when errors occur.
BEGIN TRY
    UPDATE Employees SET Salary = 50000 WHERE EmployeeID = 1 -- update salary for EmployeeID 1
    UPDATE Employees SET Salary = 60000 WHERE EmployeeID = 2 -- update salary for EmployeeID 2
    RAISERROR('An error occurred during the transaction.', 16, 1) -- raise an error to rollback the transaction
    UPDATE Employees SET Salary = 70000 WHERE EmployeeID = 3 -- update salary for EmployeeID 3
END TRY
BEGIN CATCH
    ROLLBACK -- rollback the transaction in case of error
    SELECT ERROR_MESSAGE() AS ErrorMessage -- return the error message
END CATCH


-- Example: Safe Money Transfer with Transaction
BEGIN TRY
    -- Start Transaction
    BEGIN TRANSACTION;

    -- Deduct amount from Employee 1
    UPDATE Employees
    SET Salary = Salary - 10000
    WHERE EmployeeID = 1;

    -- Check if update happened
    IF @@ROWCOUNT = 0
        THROW 50001, 'Employee 1 not found.', 1;

    -- Add amount to Employee 2
    UPDATE Employees
    SET Salary = Salary + 10000
    WHERE EmployeeID = 2;

    -- Check if update happened
    IF @@ROWCOUNT = 0
        THROW 50002, 'Employee 2 not found.', 1;

    -- Commit if everything successful
    COMMIT TRANSACTION;

    PRINT 'Transaction Successful';

END TRY
BEGIN CATCH

    -- Check transaction state before rollback
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    -- Return detailed error information
    SELECT  
        ERROR_NUMBER()    AS ErrorNumber,
        ERROR_MESSAGE()   AS ErrorMessage,
        ERROR_SEVERITY()  AS ErrorSeverity,
        ERROR_STATE()     AS ErrorState,
        ERROR_LINE()      AS ErrorLine,
        ERROR_PROCEDURE() AS ErrorProcedure;

END CATCH;


-- Triggers
-- Definition: A trigger is a special type of stored procedure that automatically executes in response to certain events on a table or view, such as INSERT, UPDATE, or DELETE operations. Triggers can be used to enforce business rules, maintain audit trails, or perform complex validations when data changes occur in the database.
CREATE TRIGGER trg_afterEmployeeUpdate
ON Employees
AFTER UPDATE -- specify that the trigger should execute after an UPDATE operation on the Employees table. INSERT and DELETE triggers can also be created by changing the trigger type.
AS
BEGIN
    IF(UPDATE(Salary)) -- check if the Salary column was updated
    BEGIN
        INSERT INTO AuditLogs (employeeID, oldSalary, newSalary, action, updateOn) -- insert a new record into the AuditLogs table to log the salary update
        SELECT d.EmployeeID, d.Salary, i.Salary, 'Salary Updated', GETDATE()
        FROM deleted d -- use the deleted table to get the old salary value before the update
        INNER JOIN inserted i ON d.EmployeeID = i.EmployeeID -- use the inserted table to get the new salary value after the update
    END
END

EXEC sp_helptext 'trg_afterEmployeeUpdate' -- view the definition of the trigger
EXEC sp_helptrigger 'Employees' -- show triggers on the Employees table
UPDATE Employees SET Salary = 20000 WHERE EmployeeID = 1 -- update salary to trigger the after update trigger
SELECT * FROM AuditLogs -- query the AuditLogs table to see the logged changes
DROP TRIGGER trg_afterEmployeeUpdate -- drop the trigger


-- Instead of trigger
-- Definition: An INSTEAD OF trigger is a type of trigger that executes in place of a stored procedure or a trigger, and is used to prevent the execution of a stored procedure or a trigger. It allows you to define custom logic that will be executed instead of the original operation, such as an INSERT, UPDATE, or DELETE statement. INSTEAD OF triggers are often used to implement complex business rules or to handle specific scenarios that cannot be easily achieved with regular triggers.
CREATE TRIGGER trg_preventEmployeeDelete
ON Employees
INSTEAD OF DELETE -- specify that the trigger should execute instead of a DELETE operation on the Employees table
AS
BEGIN
    SET NOCOUNT ON;

    -- Log attempted deletion
    INSERT INTO AuditLogs
    (
        employeeID, oldSalary, newSalary, action, updateOn
    )
    SELECT d.EmployeeID, d.Salary, NULL, 'Delete Attempted', GETDATE()
    FROM deleted d;

    -- Prevent deletion by throwing error
    THROW 50010, 'Deletion of Employees is not allowed.', 1;
END;

DELETE FROM Employees WHERE EmployeeID = 2 -- delete an employee to trigger the instead of delete trigger


-- Cursors
-- Definition: A cursor is a database object that allows you to retrieve and manipulate data row by row from a table or a result set. Cursors are used to iterate over a collection of records and perform operations on each record as needed.
DECLARE employee_cursor CURSOR FOR
SELECT EmployeeID, FirstName, LastName FROM Employees -- define a cursor to select employee details
OPEN employee_cursor -- open the cursor
FETCH NEXT FROM employee_cursor -- fetch the first record from the cursor
WHILE @@FETCH_STATUS = 0 -- loop until there are no more records to fetch
BEGIN
    -- Perform operations with the fetched data (e.g., print employee details)
    FETCH NEXT FROM employee_cursor -- fetch the next record from the cursor
END
CLOSE employee_cursor -- close the cursor
DEALLOCATE employee_cursor -- deallocate the cursor
SELECT * FROM Employees -- query to see all employees

-- Example: Cursor to get employees by department
DECLARE employee_cursor CURSOR FOR
SELECT EmployeeID, FirstName, LastName FROM Employees WHERE Department = @department -- define a cursor to select employees by department
OPEN employee_cursor -- open the cursor
FETCH NEXT FROM employee_cursor -- fetch the first record from the cursor
WHILE @@FETCH_STATUS = 0 -- loop until there are no more records to fetch
BEGIN
    -- Perform operations with the fetched data (e.g., print employee details)
    FETCH NEXT FROM employee_cursor -- fetch the next record from the cursor
END
CLOSE employee_cursor -- close the cursor
DEALLOCATE employee_cursor -- deallocate the cursor


-- Dynamic SQL
-- Definition: Dynamic SQL is a technique that allows you to construct and execute SQL statements dynamically at runtime. It enables you to build SQL queries as strings and execute them using the EXEC or sp_executesql commands. Dynamic SQL is useful when you need to create flexible queries that can change based on user input or other conditions.
DECLARE @sql NVARCHAR(MAX)
SET @sql = 'SELECT * FROM Employees WHERE Department = @department' -- construct a dynamic SQL query as a string
EXEC sp_executesql @sql, N'@department NVARCHAR(50)', @department = 'Sales' -- execute the dynamic SQL query with a parameter value


-- Database backup and restore
-- Definition: Database backup is the process of creating a copy of the database to protect against data loss or corruption. Database restore is the process of recovering a database from a backup. These operations are essential for maintaining data integrity and ensuring business continuity in case of hardware failures, software issues, or other disasters.
BACKUP DATABASE test_db TO DISK = 'C:\Backups\test_db.bak' -- create a backup of the database to a specified location
RESTORE DATABASE test_db FROM DISK = 'C:\Backups\test_db.bak' -- restore the database from the backup file


-- Import and export data
-- Definition: Importing data involves bringing data from external sources into the database, while exporting data means exporting data from the database to external sources.
-- Import data from a CSV file using BULK INSERT
BULK INSERT Employees
FROM 'C:\Data\employees.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');

-- Export data to a CSV file using BCP utility
EXEC xp_cmdshell 'bcp "SELECT * FROM Employees" queryout "C:\Data\employees_export.csv" -c -t, -T' -- export Employees data to a CSV file using BCP utility


-- Database security
-- Definition: Database security involves implementing measures to protect the database from unauthorized access, misuse, or attacks. This includes managing user permissions, encrypting sensitive data, and implementing authentication and authorization mechanisms to ensure that only authorized users can access and manipulate the database.
CREATE USER [username] FOR LOGIN [loginname] -- create a database user for a specific login
GRANT SELECT, INSERT, UPDATE ON Employees TO [username] -- grant specific permissions to the user on the Employees table
DENY DELETE ON Employees TO [username] -- deny delete permission to the user on the Employees table
REVOKE UPDATE ON Employees FROM [username] -- revoke update permission from the user on the Employees table
EXEC sp_addrolemember 'db_owner', [username] -- add the user to the db_owner role
EXEC sp_addrolemember 'db_datareader', [username] -- add the user to the db_datareader role
