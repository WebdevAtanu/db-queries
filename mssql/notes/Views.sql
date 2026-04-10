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