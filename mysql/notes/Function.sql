DROP FUNCTION IF EXISTS getCustomerNameByHighestPayment; -- Remove the function if it already exists to avoid errors when creating it again.

DELIMITER $$ -- Change the statement delimiter to allow for multiple statements in the function definition.

CREATE FUNCTION getCustomerNameByHighestPayment()
RETURNS VARCHAR(255) -- Specify the return type of the function, which is a string (customer name).
DETERMINISTIC -- Indicate that the function always returns the same result for the same input, which allows for optimization.
BEGIN
    DECLARE customerName VARCHAR(255);
    
    SELECT CONCAT(c.first_name, ' ', c.last_name) INTO customerName
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    ORDER BY p.amount DESC
    LIMIT 1; -- Retrieve the full name of the customer with the highest payment by joining the customers and payments tables, ordering by payment amount in descending order, and limiting the result to the top entry.
    
    RETURN customerName; -- Return the name of the customer with the highest payment.
END$$

DELIMITER ; -- Reset the statement delimiter back to the default.

SELECT getCustomerNameByHighestPayment(); -- Call the function to retrieve and display the name of the customer with the highest payment.