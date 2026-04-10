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

-- Find 3rd highest salary
SELECT Salary
FROM (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk -- DENSE_RANK() ignores ties in rank 
    FROM Employees
) t
WHERE rnk = 3;

-- Customers with exactly one order
SELECT CustomerId
FROM Orders
GROUP BY CustomerId
HAVING COUNT(*) = 1;

-- Orders shipped late
SELECT *
FROM Orders
WHERE ShipDate > RequiredDate;

-- Products with no inventory
SELECT *
FROM Products
WHERE StockQuantity = 0;

-- Employees hired in the same month
SELECT HireDate, COUNT(*) AS Count
FROM Employees
GROUP BY HireDate
HAVING COUNT(*) > 1;

-- First order per customer
SELECT *
FROM Orders o
WHERE OrderDate = (
  SELECT MIN(OrderDate)
  FROM Orders
  WHERE CustomerId = o.CustomerId
);

-- Active users in the last 30 days
SELECT COUNT(DISTINCT UserId) AS ActiveUsers
FROM Logins
WHERE LoginDate >= DATEADD(day, -30, GETDATE());

-- Top 3 categories by revenue
SELECT TOP 3 p.CategoryId, SUM(oi.Price * oi.Quantity) AS Revenue
FROM OrderItems oi
JOIN Products p ON oi.ProductId = p.ProductId
GROUP BY p.CategoryId
ORDER BY Revenue DESC;

-- Customers who reordered the same product
SELECT CustomerId, ProductId, COUNT(*) AS TimesOrdered
FROM OrderItems oi
JOIN Orders o ON oi.OrderId = o.OrderId
GROUP BY CustomerId, ProductId
HAVING COUNT(*) > 1;

-- Find missing invoice numbers
WITH nums AS (
  SELECT n = ROW_NUMBER() OVER (ORDER BY InvoiceNumber)
  FROM Invoices
)
SELECT i.InvoiceNumber + 1 AS MissingInvoice
FROM Invoices i
JOIN nums n ON i.InvoiceNumber = n.n
WHERE i.InvoiceNumber + 1 <> n.n + 1;

-- Orders with amount null treated as zero
SELECT OrderId, ISNULL(TotalAmount, 0) AS TotalAmount
FROM Orders;

-- Customers without a shipping address
SELECT *
FROM Customers
WHERE ShippingAddress IS NULL OR ShippingAddress = '';

-- Average order value by customer
SELECT CustomerId, AVG(TotalAmount) AS AvgOrder
FROM Orders
GROUP BY CustomerId;

-- Products priced above 2x category average
SELECT *
FROM Products p
WHERE Price > 2 * (
  SELECT AVG(Price)
  FROM Products
  WHERE CategoryId = p.CategoryId
);

-- Monthly new users
SELECT FORMAT(CreatedAt, 'yyyy-MM') AS Month, COUNT(*) AS NewUsers
FROM Users
GROUP BY FORMAT(CreatedAt, 'yyyy-MM');

-- Employees with no sales
SELECT e.*
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeId = o.SalesRepId
WHERE o.OrderId IS NULL;

-- Delete records older than one year
DELETE FROM AuditLog
WHERE EventDate < DATEADD(year, -1, GETDATE());

-- Order items with inconsistent prices
SELECT *
FROM OrderItems
WHERE Price <> (
  SELECT Price
  FROM Products
  WHERE Products.ProductId = OrderItems.ProductId
);

-- Use CROSS APPLY to split comma list
SELECT u.UserId, item.value AS Tag
FROM Users u
CROSS APPLY STRING_SPLIT(u.TagsCsv, ',') AS item;

-- Same name in multiple tables example
SELECT t.TableName, c.ColumnName
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.COLUMN_NAME = 'CreatedAt';

-- Find sequential order count per customer
SELECT CustomerId,
  COUNT(*) AS OrdersInARow
FROM (
  SELECT CustomerId, OrderDate,
    ROW_NUMBER() OVER(PARTITION BY CustomerId ORDER BY OrderDate) -
    DENSE_RANK() OVER(PARTITION BY CustomerId ORDER BY CAST(OrderDate AS date)) AS grp
  FROM Orders
) t
GROUP BY CustomerId, grp;

-- Find records with only whitespace (not empty, but spaces)
SELECT *
FROM Users
WHERE LTRIM(RTRIM(Name)) = '';

-- Count NULL vs non-NULL values
SELECT 
  COUNT(*) AS Total,
  COUNT(Email) AS NonNullEmails,
  COUNT(*) - COUNT(Email) AS NullEmails
FROM Users;

-- Find records updated today
SELECT *
FROM Orders
WHERE CAST(UpdatedAt AS DATE) = CAST(GETDATE() AS DATE);

-- Find duplicate rows based on multiple columns
SELECT FirstName, LastName, COUNT(*)
FROM Employees
GROUP BY FirstName, LastName
HAVING COUNT(*) > 1;

-- Delete duplicate rows using CTE
WITH cte AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY Email ORDER BY UserId) rn
  FROM Users
)
DELETE FROM cte WHERE rn > 1;

-- Get nth highest salary (generic)
SELECT DISTINCT Salary
FROM Employees e1
WHERE (
  SELECT COUNT(DISTINCT Salary)
  FROM Employees e2
  WHERE e2.Salary > e1.Salary
) = 2; -- 3rd highest

-- Find gap between consecutive dates
SELECT OrderDate,
  DATEDIFF(DAY, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) AS GapDays
FROM Orders;

-- Find first non-null value per group
SELECT CustomerId,
  FIRST_VALUE(Address) OVER (PARTITION BY CustomerId ORDER BY CreatedAt) AS FirstAddress
FROM Customers;

-- Find last login per user using MAX join
SELECT u.*
FROM Users u
JOIN (
  SELECT UserId, MAX(LoginDate) AS LastLogin
  FROM Logins
  GROUP BY UserId
) l ON u.UserId = l.UserId;

-- Count orders per status in single row
SELECT
  SUM(CASE WHEN Status = 'Pending' THEN 1 ELSE 0 END) AS Pending,
  SUM(CASE WHEN Status = 'Delivered' THEN 1 ELSE 0 END) AS Delivered
FROM Orders;

-- Find percentage contribution of each category
SELECT CategoryId,
  SUM(Amount) * 100.0 / SUM(SUM(Amount)) OVER () AS Percentage
FROM Orders
GROUP BY CategoryId;

-- Find users with consecutive login days
SELECT UserId
FROM (
  SELECT UserId, LoginDate,
    DATEADD(DAY, -ROW_NUMBER() OVER (PARTITION BY UserId ORDER BY LoginDate), LoginDate) grp
  FROM Logins
) t
GROUP BY UserId, grp
HAVING COUNT(*) >= 3;

-- Pivot rows into columns
SELECT *
FROM (
  SELECT CategoryId, Amount FROM Orders
) src
PIVOT (
  SUM(Amount) FOR CategoryId IN ([1],[2],[3])
) p;

-- Unpivot columns into rows
SELECT ProductId, Attribute, Value
FROM Products
UNPIVOT (
  Value FOR Attribute IN (Price, StockQuantity)
) u;

-- Find top 2 products per category
WITH ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY CategoryId ORDER BY Price DESC) rn
  FROM Products
)
SELECT *
FROM ranked
WHERE rn <= 2;

-- Find rows where value increased compared to previous
SELECT *
FROM (
  SELECT *,
    LAG(Amount) OVER (ORDER BY OrderDate) AS PrevAmount
  FROM Orders
) t
WHERE Amount > PrevAmount;

-- Find median value
SELECT AVG(Salary) AS Median
FROM (
  SELECT Salary,
    ROW_NUMBER() OVER (ORDER BY Salary) rn,
    COUNT(*) OVER () cnt
  FROM Employees
) t
WHERE rn IN ((cnt+1)/2, (cnt+2)/2);

-- Find records with max value per group (JOIN method)
SELECT p.*
FROM Products p
JOIN (
  SELECT CategoryId, MAX(Price) AS MaxPrice
  FROM Products
  GROUP BY CategoryId
) m
ON p.CategoryId = m.CategoryId AND p.Price = m.MaxPrice;

-- Detect circular references (self join)
SELECT e1.EmployeeId, e2.EmployeeId
FROM Employees e1
JOIN Employees e2 ON e1.ManagerId = e2.EmployeeId
WHERE e2.ManagerId = e1.EmployeeId;

-- Find hierarchy level (recursive CTE)
WITH cte AS (
  SELECT EmployeeId, ManagerId, 1 AS Level
  FROM Employees
  WHERE ManagerId IS NULL
  UNION ALL
  SELECT e.EmployeeId, e.ManagerId, c.Level + 1
  FROM Employees e
  JOIN cte c ON e.ManagerId = c.EmployeeId
)
SELECT * FROM cte;

-- Split full name into first and last name
SELECT 
  LEFT(Name, CHARINDEX(' ', Name) - 1) AS FirstName,
  RIGHT(Name, LEN(Name) - CHARINDEX(' ', Name)) AS LastName
FROM Users;

-- Find overlapping date ranges per user
SELECT *
FROM Bookings b1
JOIN Bookings b2
ON b1.UserId = b2.UserId
AND b1.Id <> b2.Id
AND b1.StartDate <= b2.EndDate
AND b1.EndDate >= b2.StartDate;

-- Get week number and year
SELECT DATEPART(YEAR, OrderDate) AS Year,
       DATEPART(WEEK, OrderDate) AS WeekNo
FROM Orders;

-- Find stale records (not updated recently)
SELECT *
FROM Products
WHERE UpdatedAt < DATEADD(MONTH, -6, GETDATE());

-- Conditional update (only if changed)
UPDATE Users
SET Email = @Email
WHERE UserId = @Id AND Email <> @Email;

-- Find rows where all columns are NULL
SELECT *
FROM TableA
WHERE Col1 IS NULL AND Col2 IS NULL AND Col3 IS NULL;

-- Generate numbers (1–100)
WITH nums AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM nums WHERE n < 100
)
SELECT * FROM nums;

-- Find records with special characters
SELECT *
FROM Users
WHERE Name LIKE '%[^a-zA-Z0-9 ]%';

-- Count distinct combinations
SELECT COUNT(DISTINCT CONCAT(CustomerId, '-', ProductId))
FROM OrderItems;

-- Get JSON array length
SELECT JSON_QUERY(Data) AS JsonData,
       LEN(JSON_QUERY(Data)) AS Length
FROM Logs;

-- Find most recent non-null value
SELECT *
FROM (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY UserId ORDER BY CreatedAt DESC) rn
  FROM Users
  WHERE Phone IS NOT NULL
) t
WHERE rn = 1;