-- Create a stored procedure to update the balance of a customer in the database using PL/PGSQL
CREATE PROCEDURE UpdateCustomerBalance(
    p_accNo INT, -- account number of the customer whose balance needs to be updated
    p_Amount DECIMAL(18, 2) -- amount to be added to the customer's balance
)

LANGUAGE plpgsql -- This is the language used for PostgreSQL stored procedures

AS $$ -- $$ is used to define the body of the stored procedure

BEGIN
    UPDATE customer
    SET balance = balance + p_Amount
    WHERE acc_no = p_accNo;
END;

$$; -- End of the stored procedure definition

CALL UpdateCustomerBalance(1, 1000); -- calls the stored procedure to update the balance of the customer with account number 1 by adding 1000 to it.
DROP PROCEDURE UpdateCustomerBalance; -- drops the stored procedure.