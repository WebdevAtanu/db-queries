-- Active: 1777266959161@@127.0.0.1@3306@test_db
SELECT CURDATE() -- current date

SELECT CURTIME() -- current time

SELECT NOW() -- current date and time

SELECT DAYNAME(CURDATE()) -- day of the week

SELECT MONTHNAME(CURDATE()) -- month of the year

SELECT DAYOFMONTH(CURDATE()) -- day of the month

SELECT DAYOFYEAR(CURDATE()) -- day of the year

SELECT DAYOFWEEK(CURDATE()) -- day of the week

SELECT DAYOFWEEK(CURDATE()) - 1 -- day of the week

SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y') -- format date

SELECT DATE_FORMAT(CURDATE(), '%M %D, %Y') -- format date

SELECT DATE_FORMAT(CURDATE(), '%M %D, %Y') -- format date

SELECT DATEDIFF(CURDATE(), '2022-01-01') -- date difference

SELECT DATE_ADD(CURDATE(), INTERVAL 10 DAY) -- add date

SELECT DATE_SUB(CURDATE(), INTERVAL 10 DAY) -- subtract date



