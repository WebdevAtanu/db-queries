-- cross join
-- definition- to join all the rows of one table with all the rows of another table
SELECT * FROM employee
CROSS JOIN branch;

-- inner join
-- definition- to join all the rows of one table with all the rows of another table which are matching to each other
SELECT e.name, b.branch_name FROM employee e 
INNER JOIN branch b
ON b.employee_id = e.id;

-- left join
-- definition- to join all the rows of left table with the rows of another table which are matching to each other
SELECT * FROM employee e
LEFT JOIN branch b
ON b.employee_id = e.id;

-- right join
-- definition- to join all the rows of right table with the rows of another table which are matching to each other
SELECT * FROM branch b 
RIGHT JOIN employee e
ON b.employee_id = e.id;