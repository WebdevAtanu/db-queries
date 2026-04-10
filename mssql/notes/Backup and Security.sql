-- Database backup and restore
-- Definition: Database backup is the process of creating a copy of the database to protect against data loss or corruption. Database restore is the process of recovering a database from a backup. These operations are essential for maintaining data integrity and ensuring business continuity in case of hardware failures, software issues, or other disasters.
BACKUP DATABASE test_db TO DISK = 'C:\Backups\test_db.bak' -- create a backup of the database to a specified location
RESTORE DATABASE test_db FROM DISK = 'C:\Backups\test_db.bak' -- restore the database from the backup file


-- Import and export data
-- Definition: Importing data involves bringing data from external sources into the database, while exporting data means exporting data from the database to external sources.
-- Import data from a CSV file using BULK INSERT
BULK INSERT Employees
FROM 'C:\Data\employees.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');

-- Export data to a CSV file using BCP utility
EXEC xp_cmdshell 'bcp "SELECT * FROM Employees" queryout "C:\Data\employees_export.csv" -c -t, -T' -- export Employees data to a CSV file using BCP utility


-- Database security
-- Definition: Database security involves implementing measures to protect the database from unauthorized access, misuse, or attacks. This includes managing user permissions, encrypting sensitive data, and implementing authentication and authorization mechanisms to ensure that only authorized users can access and manipulate the database.
CREATE USER [username] FOR LOGIN [loginname] -- create a database user for a specific login
GRANT SELECT, INSERT, UPDATE ON Employees TO [username] -- grant specific permissions to the user on the Employees table
DENY DELETE ON Employees TO [username] -- deny delete permission to the user on the Employees table
REVOKE UPDATE ON Employees FROM [username] -- revoke update permission from the user on the Employees table
EXEC sp_addrolemember 'db_owner', [username] -- add the user to the db_owner role
EXEC sp_addrolemember 'db_datareader', [username] -- add the user to the db_datareader role
