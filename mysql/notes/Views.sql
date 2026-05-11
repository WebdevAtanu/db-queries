-- views
-- description- view is a virtual table based on the result of a query

-- create a view
GO
CREATE VIEW cus_payments AS
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS full_name, payment.amount
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GO

SELECT * FROM cus_payments
