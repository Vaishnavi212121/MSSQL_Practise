USE InternMSSQLTraining;
GO

-- 1. Server Name
SELECT @@SERVERNAME AS ServerName;

-- 2. Current Database
SELECT DB_NAME() AS Current Database;

-- 3. Show All Databases
SELECT name
FROM sys.databases;

-- 4. Show All Schemas
SELECT name
FROM sys.schemas;

-- 5. Show All Tables
SELECT TABLE_SCHEMA,
       TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE='BASE TABLE';

-- 6. Show HR Tables
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='hr';

-- 7. Show Columns of Employees Table
SELECT COLUMN_NAME,
       DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='hr'
AND TABLE_NAME='Employees';

-- 8. Show Employee Records
SELECT *
FROM hr.Employees;

-- 9. First Five Employees
SELECT TOP (5) *
FROM hr.Employees;

-- 10. Count Employees
SELECT COUNT(*) AS TotalEmployees
FROM hr.Employees;

-- 11. Primary Key
EXEC sp_pkeys 'Employees','hr';

-- 12. Constraints
EXEC sp_helpconstraint 'hr.Employees';

-- 13. Standard SQL Query
SELECT ProductID,
       ProductCode,
       ProductName,
       Category,
       UnitPrice
FROM sales.Products;

-- 14. SQL Server (T-SQL) Examples

SELECT TOP (5) *
FROM sales.Products;

SELECT GETDATE();

SELECT DB_NAME();

SELECT @@VERSION;

SELECT SUSER_NAME();


