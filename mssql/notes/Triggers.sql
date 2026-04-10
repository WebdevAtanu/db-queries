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
GO
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