-- Temporary tables
-- Definition: Temporary tables are used to store intermediate results temporarily during a session. They are created in the tempdb database and are automatically dropped when the session ends or when they are no longer needed. Temporary tables can be useful for storing data that is needed for complex queries or for breaking down large queries into smaller, more manageable parts.
CREATE TABLE #TempEmployees (EmployeeID INT, FirstName NVARCHAR(50), LastName NVARCHAR(50)) -- create a temporary table named #TempEmployees
INSERT INTO #TempEmployees (EmployeeID, FirstName, LastName) VALUES (1, 'John', 'Doe'), (2, 'Jane', 'Smith') -- insert sample data into the temporary table
SELECT * FROM #TempEmployees -- query the temporary table to retrieve data