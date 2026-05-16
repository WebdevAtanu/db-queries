DROP PROCEDURE IF EXISTS `getPaymentDetails`; -- This line ensures that if a stored procedure named 'getPaymentDetails' already exists, it will be dropped before creating a new one

DELIMITER $$ -- $$ is used to define the end of the stored procedure, allowing us to use semicolons within the procedure without prematurely ending it.

CREATE PROCEDURE getPaymentDetails() -- This line defines a new stored procedure named 'getPaymentDetails' that takes no parameters.
BEGIN
    SELECT payment.customer_id, payment.order_id, payment.amount, customer.first_name, customer.last_name FROM payment INNER JOIN customer ON payment.customer_id = customer.customer_id;
END $$ 
DELIMITER ; -- again, we reset the delimiter back to the default semicolon after defining the stored procedure.

CALL `getPaymentDetails`; -- It is used to execute the stored procedure and retrieve the payment details along with the customer's first and last names.


DROP PROCEDURE IF EXISTS `getPaymentDetailsByCustomerId`;

DELIMITER $$ -- Again, we change the delimiter to $$ to define another stored procedure without interference from semicolons.

CREATE PROCEDURE getPaymentDetailsByCustomerId(IN customer_id INT, OUT sumAmount DECIMAL(10,2)) -- This line defines a new stored procedure named 'getPaymentDetailsByCustomerId' that takes two parameters: 'customer_id' as an input parameter of type INT, and 'sumAmount' as an output parameter of type DECIMAL(10,2). The output parameter will hold the total amount of payments made by that customer.
BEGIN
    SELECT SUM(payment.amount)
    FROM payment 
    INNER JOIN customer ON payment.customer_id = customer.customer_id 
    WHERE payment.customer_id = customer_id -- This line filters the results to only include payments made by the specified customer ID.
    INTO sumAmount; -- This line assigns the result of the SELECT statement (the total amount of payments) to the output parameter 'sumAmount'.
END $$
DELIMITER ;

SET @sumAmount = 0; -- This line initializes a user-defined variable '@sumAmount' to 0, which will be used to store the output value from the stored procedure.

CALL `getPaymentDetailsByCustomerId`(1, @sumAmount); --  It is used to execute the stored procedure and retrieve the payment details for a specific customer based on the provided 'customer_id' and 'amount' parameters.

SELECT @sumAmount; -- This line retrieves the value stored in the user-defined variable '@sumAmount', which contains the total amount of payments made by the specified customer.