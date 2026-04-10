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
    SELECT @count = COUNT(*)
    FROM Employees
    WHERE Department = @department;
    RETURN @count;
END
GO
SELECT dbo.udf_getEmployeeCount('Sales') as EmployeeCount -- call the user-defined function to get employee count


GO
CREATE FUNCTION udf_getEmployeeAvgSalary
(
@department NVARCHAR(50)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @avgSalary DECIMAL(10,2);
    SELECT @avgSalary = AVG(Salary)
    FROM Employees
    WHERE Department = @department;
    RETURN @avgSalary;
END
GO
SELECT dbo.udf_getEmployeeAvgSalary('Sales') as AvgSalary-- call the user-defined function to get average salary


GO
CREATE FUNCTION udf_getEmployeeSalaryByDetails
(
    @employeeId INT,
    @department NVARCHAR(50)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @salary DECIMAL(10,2);
    SELECT @salary = Salary
    FROM Employees
    WHERE EmployeeID = @employeeId AND Department = @department;
    RETURN @salary;
END
GO
SELECT dbo.udf_getEmployeeSalaryByDetails(1, 'Sales') as Salary -- call the user-defined function to get salary by employeeId and department


-- Table value function
-- Definition: A table-valued function returns a table data type and can be used in the FROM clause of a query. It allows you to return a result set that can be treated like a regular table, enabling you to perform joins, filters, and other operations on the returned data.
GO
CREATE FUNCTION udf_getEmployeesByDepartment
(
    @department NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN(
    SELECT * FROM Employees
    WHERE Department = @department -- create a table value function to get employees by department
)
GO
SELECT * FROM dbo.udf_getEmployeesByDepartment('Sales')


GO
CREATE FUNCTION udf_getEmployeesBySalaryRange
(
    @minSalary DECIMAL(10,2),
    @maxSalary DECIMAL(10,2)
)
RETURNS TABLE
AS
RETURN(
    SELECT * FROM Employees 
    WHERE Salary BETWEEN @minSalary AND @maxSalary -- create a table value function to get employees by salary range
)
GO
SELECT * FROM dbo.udf_getEmployeesBySalaryRange(20000, 50000)