SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Atanu
-- Create date: 04/10/2026
-- Description:	SP for filtering customer based on department and salary
-- =============================================
ALTER PROCEDURE sp_filterCustomer
    -- Add the parameters for the stored procedure here
    @department varchar(50),
    @salary decimal = 0
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Creating a temp table
    CREATE TABLE #tempData
    (
        EmployeeId INT,
        [Full Name] VARCHAR(50)
    )

    -- Insert data into the temp table
    INSERT INTO #tempData
        (EmployeeId, [Full Name])
    SELECT EmployeeID, CONCAT(FirstName,' ',LastName) as 'Full Name'
    FROM Employees
    WHERE Department= @department AND Salary>=@salary

    -- Check if data is exists or not
    IF EXISTS(SELECT 1
    FROM #tempData)
BEGIN
        SELECT *
        FROM #tempData
    END
ELSE
BEGIN
        SELECT 'No data found' AS Message;
    END

END
--exec sp_filterCustomer 'sales',10
GO

-- Alternative query without temp table
--ALTER PROCEDURE sp_filterCustomer 
--	@department VARCHAR(50), 
--	@salary DECIMAL = 0
--AS
--BEGIN
--	SET NOCOUNT ON;

--	IF EXISTS (
--		SELECT 1 
--		FROM Employees 
--		WHERE Department = @department 
--		AND Salary >= @salary
--	)
--	BEGIN
--		SELECT 
--			EmployeeID, 
--			CONCAT(FirstName, ' ', LastName) AS [Full Name]
--		FROM Employees 
--		WHERE Department = @department 
--		AND Salary >= @salary;
--	END
--	ELSE
--	BEGIN
--		SELECT 'No data found' AS Message;
--	END
--END;