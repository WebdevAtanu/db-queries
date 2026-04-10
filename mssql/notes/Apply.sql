-- Outer apply
-- Definition: OUTER APPLY is used to join a table to a table-valued function or subquery that returns a result set. It returns all rows from the left table and the matching rows from the right side, similar to a LEFT JOIN, but allows for more complex logic in the right side.
SELECT c.CustomerId, c.Name, c.Phone, LatestOrder.OrderId, LatestOrder.OrderDate, LatestOrder.[Status] FROM Customers c OUTER APPLY (
    SELECT TOP 1 * FROM Orders o WHERE O.CustomerId = C.CustomerId
) as LatestOrder -- get the latest order for each customer using outer apply

-- Cross apply
-- Definition: CROSS APPLY is similar to OUTER APPLY but only returns rows from the left table that have matching rows in the right side. It is used when you want to filter the left table based on the results of the right side.
SELECT c.CustomerId, c.Name, c.Phone, RecentOrder.OrderId, RecentOrder.OrderDate, RecentOrder.[Status] FROM Customers c CROSS APPLY (
    SELECT TOP 1 * FROM Orders o WHERE O.CustomerId = C.CustomerId ORDER BY o.OrderDate DESC
) as RecentOrder -- get the most recent order for each customer using cross apply