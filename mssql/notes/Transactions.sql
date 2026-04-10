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
        THROW 50001, 'Employee 1 not found.', 1; -- 50001 is a custom error code

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