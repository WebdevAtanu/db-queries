-- This script updates the EmployeeId in the Salary table based on the EmployeeId from the Employee table.
-- It uses a cursor to iterate through the EmployeeIds and updates the Salary table accordingly.
DECLARE @EmpId uniqueidentifier -- Assuming EmployeeId is of type uniqueidentifier.

DECLARE tempcur CURSOR FOR -- Declare a cursor to select EmployeeIds from the Employee table.
SELECT EmployeeId
FROM Employee

OPEN tempcur -- Open the cursor to start fetching data.

FETCH NEXT FROM tempcur INTO @EmpId -- Fetch the first EmployeeId into the variable @EmpId.

WHILE @@FETCH_STATUS = 0 -- Loop until there are no more EmployeeIds to fetch.
BEGIN
    UPDATE TOP (1) Salary
    SET EmployeeId = @EmpId -- Update the Salary table with the current EmployeeId.

    FETCH NEXT FROM tempcur INTO @EmpId
END

CLOSE tempcur
DEALLOCATE tempcur


-- Alternatively, you can use a Common Table Expression (CTE) to achieve the same result without using a cursor. This method is more efficient and easier to read.
WITH
    EmpCTE
    AS
    (
        SELECT EmployeeId, ROW_NUMBER() OVER (ORDER BY EmployeeId) AS rn
        FROM Employee -- Select EmployeeId and assign a row number to each employee based on the order of EmployeeId.
    ),
    SalCTE
    AS
    (
        SELECT *, ROW_NUMBER() OVER (ORDER BY SalaryId) AS rn
        FROM Salary -- Select all columns from Salary and assign a row number to each salary record based on the order of SalaryId.
    )
UPDATE s
SET s.EmployeeId = e.EmployeeId -- Update the EmployeeId in the Salary table to match the EmployeeId from the Employee table based on the row numbers.
FROM SalCTE s -- Select from the Salary CTE.
    JOIN EmpCTE e -- Join the Employee CTE on the condition that the row numbers match in a cyclic manner.
    ON ((s.rn - 1) % (SELECT COUNT(*) -- Get the total count of employees to ensure the row numbers cycle through the EmployeeIds.
    FROM Employee)) + 1 = e.rn -- This condition ensures that the EmployeeIds are assigned to Salary records in a round-robin fashion based on their row numbers.