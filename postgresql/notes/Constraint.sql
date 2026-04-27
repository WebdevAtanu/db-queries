-- constraint
-- check constraint
CREATE TABLE employee
(
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary > 0) -- salary must be greater than 0
); 