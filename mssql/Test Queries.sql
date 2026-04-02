-- Date Conversion
SELECT CONVERT(varchar, GETDATE(), 0) -- 0 = smalldatetime
SELECT CONVERT(varchar, GETDATE(), 1) -- 1 = datetime
SELECT CONVERT(varchar, GETDATE(), 101) -- 101 = datetime2
SELECT CONVERT(varchar, GETDATE(), 2) -- 2 = datetimeoffset
SELECT CONVERT(varchar, GETDATE(), 102) -- 102 = smalldatetime
SELECT CONVERT(varchar, GETDATE(), 3) -- 3 = time
SELECT CONVERT(varchar, GETDATE(), 103) -- 103 = date

SELECT CAST(23.3 AS varchar) 
SELECT CAST('2026-12-01' AS datetime)