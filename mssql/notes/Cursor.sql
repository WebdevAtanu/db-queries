-- Cursors
-- Definition: A cursor is a database object that allows you to retrieve and manipulate data row by row from a table or a result set. Cursors are used to iterate over a collection of records and perform operations on each record as needed.
DECLARE employee_cursor CURSOR FOR SELECT EmployeeID, FirstName, LastName FROM Employees -- define a cursor to select employee details

OPEN employee_cursor -- open the cursor

FETCH NEXT FROM employee_cursor -- fetch the first record from the cursor

WHILE @@FETCH_STATUS = 0 -- loop until there are no more records to fetch
    BEGIN
        -- Perform operations with the fetched data here
        FETCH NEXT FROM employee_cursor -- fetch the next record from the cursor
    END
CLOSE employee_cursor -- close the cursor
DEALLOCATE employee_cursor -- deallocate the cursor


-- Example: Cursor to get employees by department and update their salary
DECLARE @EmployeeID INT;
DECLARE @FirstName VARCHAR(50);
DECLARE @LastName VARCHAR(50);

-- Declare cursor
DECLARE employee_cursor CURSOR FOR
SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE Department = 'Sales';

-- Open cursor
OPEN employee_cursor;

-- Fetch first row into variables
FETCH NEXT FROM employee_cursor INTO @EmployeeID, @FirstName, @LastName;

-- Loop through rows
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Update current employee
    UPDATE Employees 
    SET Salary = Salary * 1.05 
    WHERE EmployeeID = @EmployeeID;

    -- Fetch next row
    FETCH NEXT FROM employee_cursor 
    INTO @EmployeeID, @FirstName, @LastName;
END

-- Cleanup
CLOSE employee_cursor;
DEALLOCATE employee_cursor;