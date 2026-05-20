GO
CREATE FUNCTION GetCustomerBalanceByAccNo
(
    p_accNo INT -- account number of the customer whose balance needs to be retrieved
)

RETURNS DECIMAL(18, 2) -- the function will return the balance of the customer as a decimal value
AS $$

BEGIN
    RETURN (SELECT balance FROM customer WHERE acc_no = p_accNo); -- retrieves the balance of the customer with the specified account number
END;

$$ LANGUAGE plpgsql; -- This is the language used for PostgreSQL functions
GO

SELECT GetCustomerBalanceByAccNo(1); -- calls the function to get the balance of the customer with account number 1
DROP FUNCTION GetCustomerBalanceByAccNo; -- drops the function.


-- Creating a function to retrieve the details of a customer
GO
CREATE OR REPLACE FUNCTION getCustomerDetailsByAccNo -- creates a function to retrieve the details of a customer based on their account number
(
    p_accNo INT -- account number of the customer whose details need to be retrieved
)

RETURNS TABLE (
    AccNo INT,
    CusName VARCHAR(255),
    CusBalance DECIMAL(18, 2)
) 
AS $$

BEGIN
    RETURN QUERY 
    SELECT acc_no AS AccNo, name AS CusName, balance AS CusBalance
    FROM customer WHERE acc_no = p_accNo; -- retrieves the account number, name, and balance of the customer with the specified account number
END;

$$ LANGUAGE plpgsql; -- This is the language used for PostgreSQL functions
GO

SELECT * FROM getCustomerDetailsByAccNo(3); -- calls the function to get the details of the customer with account number 3
DROP FUNCTION getCustomerDetailsByAccNo; -- drops the function.
