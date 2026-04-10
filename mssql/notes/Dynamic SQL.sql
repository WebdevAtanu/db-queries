-- Dynamic SQL
-- Definition: Dynamic SQL is a technique that allows you to construct and execute SQL statements dynamically at runtime. It enables you to build SQL queries as strings and execute them using the EXEC or sp_executesql commands. Dynamic SQL is useful when you need to create flexible queries that can change based on user input or other conditions.
DECLARE @sql NVARCHAR(MAX)
SET @sql = 'SELECT * FROM Employees WHERE Department = @department' -- construct a dynamic SQL query as a string
EXEC sp_executesql @sql, N'@department NVARCHAR(50)', @department = 'Sales' -- execute the dynamic SQL query with a parameter value
