-- Stored procedures
-- Definition: A stored procedure is a precompiled collection of SQL statements that can be executed as a single unit. It can accept parameters, perform complex operations, and return results. Stored procedures are stored in the database and can be reused multiple times, providing a way to encapsulate logic and improve performance by reducing the need for repeated parsing and compilation of SQL statements.
CREATE PROCEDURE sp_getEmployeesByDepartment
    @department NVARCHAR(50)
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, salary
    FROM Employees
    WHERE Department = @department -- create a stored procedure to get employees by department
END
EXEC sp_getEmployeesByDepartment @department = 'Sales' -- execute the stored procedure with a parameter value
DROP PROCEDURE sp_getEmployeesByDepartment -- drop the stored procedure


GO
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
GO
CREATE PROCEDURE sp_getEmployeeAvgSalary
    @department NVARCHAR(50),
    @avgSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SET @avgSalary = (SELECT AVG(Salary)
    FROM Employees
    WHERE Department = @department)
END

GO
DECLARE @avgSalary DECIMAL(10,2)
EXEC sp_getEmployeeAvgSalary 'Sales', @avgSalary OUTPUT -- execute the stored procedure with output parameter
SELECT @avgSalary -- retrieve the output parameter value


-- Stored procedure with condition
-- Definition: A stored procedure with a condition includes logic that allows it to perform different actions based on certain criteria. This can involve using IF statements, CASE statements, or other control flow mechanisms to determine the behavior of the procedure based on input parameters or data in the database.
GO
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

    SELECT @currentSalary = Salary
    from Employees WHERE EmployeeID = @employeeId; -- get the current salary of the employee

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

GO
DECLARE @message NVARCHAR(200), @newSalary DECIMAL(10,2)
EXEC sp_updateEmployeeSalaryWithCondition @employeeId = 3, @newSalary = 90000, @message = @message OUTPUT-- execute the stored procedure with condition
SELECT @message as message
