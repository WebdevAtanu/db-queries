-- relational operators
-- equal to
SELECT * FROM customer WHERE customer_id = 1;
-- not equal to
SELECT * FROM customer WHERE customer_id != 1;
-- greater than
SELECT * FROM customer WHERE customer_id > 1;
-- less than
SELECT * FROM customer WHERE customer_id < 1;
-- greater than or equal to
SELECT * FROM customer WHERE customer_id >= 1;
-- less than or equal to
SELECT * FROM customer WHERE customer_id <= 1;

-- logical operators
-- and
SELECT * FROM customer WHERE customer_id = 1 AND first_name = 'John';
-- or
SELECT * FROM customer WHERE customer_id = 1 OR first_name = 'John';
-- not
SELECT * FROM customer WHERE NOT customer_id = 1;

-- string operators
-- equal to
SELECT * FROM customer WHERE first_name = 'John';
-- not equal to
SELECT * FROM customer WHERE first_name != 'John';
-- greater than
SELECT * FROM customer WHERE first_name > 'John';
-- less than
SELECT * FROM customer WHERE first_name < 'John';
-- greater than or equal to
SELECT * FROM customer WHERE first_name >= 'John';
-- less than or equal to
SELECT * FROM customer WHERE first_name <= 'John';

-- between
SELECT * FROM customer WHERE customer_id BETWEEN 1 AND 10;
-- not between
SELECT * FROM customer WHERE customer_id NOT BETWEEN 1 AND 10;

-- in
SELECT * FROM customer WHERE customer_id IN (1, 2, 3);
-- not in
SELECT * FROM customer WHERE customer_id NOT IN (1, 2, 3);

-- like, not like
SELECT * FROM customer WHERE first_name LIKE 'John';
-- not like
SELECT * FROM customer WHERE first_name NOT LIKE 'John';

-- is null, is not null
SELECT * FROM customer WHERE first_name IS NULL;
-- is not null
SELECT * FROM customer WHERE first_name IS NOT NULL;

