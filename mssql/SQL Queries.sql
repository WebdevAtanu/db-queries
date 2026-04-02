-- Find rows with leading/trailing spaces
SELECT *
FROM Items
WHERE ItemName <> LTRIM(RTRIM(ItemName));

-- Trim spaces from all rows
UPDATE Items SET ItemName = LTRIM(RTRIM(ItemName));

-- Find NULL or empty strings
SELECT *
FROM Users
WHERE Email IS NULL OR Email = '';

-- Replace NULL with default value
UPDATE Users SET City = ISNULL(City, 'Unknown');

-- Find duplicate emails
SELECT Email, COUNT(*)
FROM Users
GROUP BY Email
HAVING COUNT(*) > 1;

-- Remove duplicates (keep lowest ID)
DELETE FROM Users
WHERE UserId NOT IN (
  SELECT MIN(UserId)
FROM Users
GROUP BY Email
);

-- Find numeric values stored as text
SELECT *
FROM Products
WHERE ISNUMERIC(Price) = 0;

-- Convert text date to proper date
UPDATE Orders
SET OrderDate = CONVERT(date, OrderDateText, 103);

-- Find invalid dates
SELECT *
FROM Orders
WHERE TRY_CONVERT(date, OrderDate) IS NULL;

-- Force uppercase data
UPDATE Users SET Name = UPPER(Name);

-- Total sales per month
SELECT FORMAT(OrderDate, 'yyyy-MM') AS Month, SUM(Amount) AS TotalSales
FROM Orders
GROUP BY FORMAT(OrderDate, 'yyyy-MM');

-- Top 5 selling products
SELECT TOP 5
  ProductId, SUM(Quantity) AS Sold
FROM OrderItems
GROUP BY ProductId
ORDER BY Sold DESC;

-- Customers who never ordered
SELECT c.*
FROM Customers c
  LEFT JOIN Orders o ON c.CustomerId = o.CustomerId
WHERE o.CustomerId IS NULL;

-- Orders with no items
SELECT o.*
FROM Orders o
  LEFT JOIN OrderItems oi ON o.OrderId = oi.OrderId
WHERE oi.OrderId IS NULL;

-- Revenue by category
SELECT c.CategoryName, SUM(oi.Price * oi.Quantity) AS Revenue
FROM OrderItems oi
  JOIN Products p ON oi.ProductId = p.ProductId
  JOIN Categories c ON p.CategoryId = c.CategoryId
GROUP BY c.CategoryName;

-- Highest order value per customer
SELECT CustomerId, MAX(TotalAmount) AS MaxOrder
FROM Orders
GROUP BY CustomerId;

-- Daily order count
SELECT CAST(OrderDate AS date) AS OrderDay, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CAST(OrderDate AS date);

-- Products never sold
SELECT *
FROM Products
WHERE ProductId NOT IN (
  SELECT DISTINCT ProductId
FROM OrderItems
);

-- Average order value
SELECT AVG(TotalAmount) AS AvgOrderValue
FROM Orders;

-- Orders above average value
SELECT *
FROM Orders
WHERE TotalAmount > (SELECT AVG(TotalAmount)
FROM Orders);

-- Latest order per customer
SELECT *
FROM Orders o
WHERE OrderDate = (
  SELECT MAX(OrderDate)
FROM Orders
WHERE CustomerId = o.CustomerId
);

-- Second highest salary
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees
WHERE Salary < (SELECT MAX(Salary)
FROM Employees);

-- Employees without manager
SELECT *
FROM Employees
WHERE ManagerId IS NULL;

-- Manager with most subordinates
SELECT ManagerId, COUNT(*) AS TeamSize
FROM Employees
GROUP BY ManagerId
ORDER BY TeamSize DESC;

-- Products higher than category average
SELECT *
FROM Products p
WHERE Price > (
  SELECT AVG(Price)
FROM Products
WHERE CategoryId = p.CategoryId
);

-- Orders with more than 5 items
SELECT OrderId
FROM OrderItems
GROUP BY OrderId
HAVING SUM(Quantity) > 5;

-- Customers ordering from multiple categories
SELECT o.CustomerId
FROM Orders o
  JOIN OrderItems oi ON o.OrderId = oi.OrderId
  JOIN Products p ON oi.ProductId = p.ProductId
GROUP BY o.CustomerId
HAVING COUNT(DISTINCT p.CategoryId) > 1;

-- Most recent record per user
WITH
  cte
  AS
  (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY UserId ORDER BY CreatedAt DESC) AS rn
    FROM Logins
  )
SELECT *
FROM cte
WHERE rn = 1;

-- Running total
SELECT OrderDate,
  SUM(Amount) OVER (ORDER BY OrderDate) AS RunningTotal
FROM Orders;

-- Rank products by sales
SELECT ProductId,
  RANK() OVER (ORDER BY SUM(Quantity) DESC) AS SalesRank
FROM OrderItems
GROUP BY ProductId;

-- Pagination (page 2, size 10)
SELECT *
FROM Products
ORDER BY ProductId
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- Optional search parameter
SELECT *
FROM Products
WHERE (@Name IS NULL OR Name LIKE '%' + @Name + '%');

-- Soft delete
UPDATE Users SET IsDeleted = 1 WHERE UserId = 5;

-- Fetch soft deleted rows
SELECT *
FROM Users
WHERE IsDeleted = 1;

-- Prevent divide by zero
SELECT Total / NULLIF(Count, 0)
FROM Stats;

-- Status mapping
SELECT OrderId,
  CASE Status
  WHEN 1 THEN 'Pending'
  WHEN 2 THEN 'Delivered'
  ELSE 'Cancelled'
END AS StatusText
FROM Orders;

-- Check existence
IF EXISTS (SELECT 1
FROM Users
WHERE Email = @Email)
PRINT 'Email Exists';

-- Update using join
UPDATE p
SET p.Price = p.Price * 1.1
FROM Products p
  JOIN Categories c ON p.CategoryId = c.CategoryId
WHERE c.Name = 'Electronics';

-- Delete using join
DELETE o
FROM Orders o
  JOIN Customers c ON o.CustomerId = c.CustomerId
WHERE c.IsBlocked = 1;

-- Archive old data
INSERT INTO OrdersHistory
SELECT *
FROM Orders
WHERE OrderDate < '2023-01-01';

-- Find missing sequence numbers
SELECT Id + 1 AS MissingId
FROM TableA
WHERE Id + 1 NOT IN (SELECT Id
FROM TableA);

-- Swap column values
UPDATE Users
SET FirstName = LastName,
    LastName = FirstName;

-- Detect overlapping bookings
SELECT *
FROM Bookings b1
  JOIN Bookings b2
  ON b1.RoomId = b2.RoomId
    AND b1.Id <> b2.Id
    AND b1.StartDate < b2.EndDate
    AND b1.EndDate > b2.StartDate;

-- Inactive users (30 days)
SELECT *
FROM Users
WHERE LastLogin < DATEADD(DAY, -30, GETDATE());

-- JSON extract
SELECT JSON_VALUE(Profile, '$.phone') AS Phone
FROM Users;

-- Comma-separated values
SELECT STRING_AGG(Name, ', ') AS ProductList
FROM Products;

-- Detect price changes
SELECT *,
  LAG(Price) OVER (ORDER BY UpdatedAt) AS OldPrice
FROM ProductPrices;

-- Updated records
SELECT *
FROM Orders
WHERE UpdatedAt > CreatedAt;

-- Time difference in minutes
SELECT DATEDIFF(MINUTE, StartTime, EndTime) AS DurationMinutes
FROM Sessions;

-- Most frequent status
SELECT TOP 1
  Status
FROM Orders
GROUP BY Status
ORDER BY COUNT(*) DESC;
