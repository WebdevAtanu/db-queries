-- Date functions
SELECT GETDATE() AS CurrentDateTime -- get the current date and time
SELECT DATEADD(YEAR,2,GETDATE()) AS DateAfterTwoYears -- add 2 years to the current date
SELECT DATEDIFF(DAY,'2026-01-01',GETDATE()) AS NoOfDays -- calculate the difference in days from 2026-01-01 to today
SELECT DATEPART(MONTH,GETDATE()) AS CurrentMonth -- get the current month
SELECT DATENAME(WEEKDAY,GETDATE()) AS CurrentWeekdayName -- get the name of the current weekday
SELECT EOMONTH(GETDATE()) AS EndOfCurrentMonth -- get the end date of the current month
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+05:00') AS DateTimeInDifferentTimeZone -- switch the current date and time to a different time zone
SELECT ISDATE('2022-12-31') AS IsValidDate -- check if a string is a valid date
SELECT FORMAT(GETDATE(), 'dddd, MMMM dd, yyyy') AS FormattedCurrentDate -- format the current date in a specific format
SELECT TRY_CONVERT(DATE, '2022-02-30') AS TryConvertInvalidDate -- attempt to convert an invalid date string
SELECT SYSDATETIME() AS SystemDateTime -- get the system date and time
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-08:00') AS DateTimeInPST -- switch the current date and time to PST time zone
SELECT DATEADD(MONTH, -3, GETDATE()) AS DateThreeMonthsAgo -- subtract 3 months from the current date
SELECT DATEDIFF(HOUR, '2026-01-01 00:00:00', GETDATE()) AS NoOfHours -- calculate the difference in hours from a specific date and time to now
SELECT DATEPART(QUARTER, GETDATE()) AS CurrentQuarter -- get the current quarter of the year
SELECT DATENAME(MONTH, '2022-07-15') AS MonthNameFromDate -- get the month name from a specific date
SELECT EOMONTH('2022-02-10') AS EndOfMonthForGiven
SELECT CONVERT(date,GETDATE()) AS CurrentDate -- get the current date without time