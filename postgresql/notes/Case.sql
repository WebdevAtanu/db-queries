SELECT name, salary,
    CASE WHEN salary>=30000 THEN 'High'
    WHEN salary BETWEEN 15000 AND 30000 THEN 'Medium'
ELSE 'Low' END AS sal_cat
FROM employee

