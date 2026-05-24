DELIMITER // -- This is the delimiter for the trigger definition
CREATE TRIGGER check_negative_payments -- This is the name of the trigger
BEFORE INSERT ON payment -- This trigger will execute before a new row is inserted into the payment table
FOR EACH ROW -- This specifies that the trigger will execute for each row that is inserted
BEGIN
    IF NEW.amount < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment amount cannot be negative'; -- This will raise an error if the amount being inserted is negative
    END IF;
END;
DELIMITER ; -- This resets the delimiter back to the default

