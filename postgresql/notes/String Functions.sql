-- string functions
SELECT UPPER(name) FROM person; -- convert the names in the 'person' table to uppercase
SELECT LOWER(name) FROM person; -- convert the names in the 'person' table to lowercase
SELECT LENGTH(name) FROM person; -- calculate the length of the names in the 'person' table
SELECT CONCAT(name, ' from ', city) AS description FROM person; -- concatenate the name and city into a description
SELECT CONCAT_WS(', ', id, name, city) FROM person; -- concatenate the names in the 'person' table using a custom separator
SELECT SUBSTRING(name FROM 1 FOR 3) AS short_name FROM person; -- extract the first 3 characters of the names in the 'person' table
SELECT REPLACE(name, 'A', 'O') AS modified_name FROM person; -- replace all occurrences of 'A' with 'O' in the names in the 'person' table
SELECT TRIM(name) FROM person; -- remove leading and trailing spaces from the names in the 'person' table
SELECT LEFT(name, 2) AS first_two_chars FROM person; -- extract the first 2 characters of the names in the 'person' table
SELECT RIGHT(name, 2) AS last_two_chars FROM person; -- extract the last 2 characters of the names in the 'person' table
SELECT POSITION('o' IN name) AS position_of_o FROM person; -- find the position of the letter 'o' in the names in the 'person' table
SELECT REVERSE(name) AS reversed_name FROM person; -- reverse the names in the 'person' table
SELECT LPAD(name, 10, '*') AS padded_name FROM person; -- pad the names in the 'person' table with '*' on the left to a total length of 10 characters
SELECT RPAD(name, 10, '*') AS padded_name FROM person; -- pad the names in the 'person' table with '*' on the right to a total length of 10 characters  
SELECT STRING_AGG(name, ', ') AS all_names FROM person; -- concatenate all names in the 'person' table into a single string separated by commas