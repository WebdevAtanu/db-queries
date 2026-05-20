-- This SQL script creates a trigger to check the balance of customers before inserting or updating records in the customers table.
CREATE OR REPLACE FUNCTION check_customer_balance()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.balance < 0 THEN
        RAISE EXCEPTION 'Balance cannot be negative';
    END IF;

    RETURN NEW;
END;
$$;

-- Create the trigger that calls the function before inserting or updating records in the customers table.
CREATE OR REPLACE TRIGGER trg_check_customer_balance
    BEFORE INSERT OR UPDATE ON customer
    FOR EACH ROW
    EXECUTE FUNCTION check_customer_balance();

INSERT INTO customer (name, balance) VALUES ('John Doe', -100.00); -- This will raise an exception because the balance is negative.
UPDATE customer SET balance = -50.00 WHERE acc_no = 1; -- This will also raise an exception because the balance is negative.