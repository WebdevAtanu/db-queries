CREATE INDEX idx_customer_country ON customer(country); -- This index will improve the performance of queries that filter customers by their country.

CREATE INDEX idx_customer_country_email ON customer(country, email); -- This composite index will enhance the performance of queries that filter customers by both country and email.
