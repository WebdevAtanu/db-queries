-- Joins
-- Definition: A join is used to combine rows from two or more tables based on a related column between them. It allows you to retrieve data from multiple tables in a single query by specifying the join condition.

-- Cross join
-- Definition: A cross join returns the Cartesian product of the two tables, meaning it combines each row from the first table with every row from the second table. It does not require a join condition and can result in a large number of rows if both tables have many records.
SELECT * FROM Orders CROSS JOIN OrderItems -- get Cartesian product of Orders and OrderItems tables

SELECT c.Name, CONCAT(e.FirstName, ' ', e.LastName) AS FullName
FROM Customers c CROSS JOIN Employees e -- combine Customers and Employees tables

-- Inner join
-- Definition: An inner join returns only the rows that have matching values in both tables based on the specified join condition. It filters out rows that do not have a match in either table.
SELECT o.OrderID, m.ItemName, oi.Quantity 
FROM Orders o
    INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
    INNER JOIN Menus m ON oi.MenuId = m.MenuId
ORDER BY oi.Quantity DESC -- get matching records from Orders, OrderItems, and Menus tables with inner joins

-- Left join
-- Definition: A left join returns all rows from the left table, even if there are no matches in the right table. It keeps all rows from the left table and adds any matching rows from the right table.
SELECT c.Name, o.OrderID
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
-- get all customers with their orders using left join

-- Right join
-- Definition: A right join returns all rows from the right table, even if there are no matches in the left table. It keeps all rows from the right table and adds any matching rows from the left table.
SELECT o.OrderID, c.Name
FROM Orders o RIGHT JOIN Customers c ON o.CustomerID = c.CustomerID -- get all orders with customer names using right join
