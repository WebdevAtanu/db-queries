GO
CREATE VIEW EmployeeBranchView -- to create a view 
AS
SELECT e.id AS EmpId, 
e.name AS EmpName, 
b.branch_id AS BranchId, 
b.branch_name AS BranchName 
FROM employee e
INNER JOIN branch b ON e.id = b.employee_id;
GO

SELECT * FROM EmployeeBranchView; -- to select all the data from the view