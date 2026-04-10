-- Indexing
-- Definition: Indexing is a database optimization technique that improves the speed of data retrieval operations on a table. An index is a data structure that allows the database engine to quickly locate and access the data without having to scan the entire table. Indexes can be created on one or more columns of a table and can significantly enhance query performance, especially for large datasets.
SET STATISTICS IO ON -- enable statistics IO to see index usage
SET STATISTICS TIME ON -- enable statistics time to see query execution time

CREATE INDEX idx_department ON Employees(Department) -- create an index on the Department column
SELECT * FROM Employees WHERE Department = 'Sales' -- query to test index usage
DROP INDEX idx_department ON Employees -- drop the index
EXEC sp_helpindex 'Employees' -- show indexes on the Employees table