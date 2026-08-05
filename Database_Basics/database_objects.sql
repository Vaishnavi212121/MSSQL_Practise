-- List Schemas
SELECT name
FROM sys.schemas;

-- List Tables
SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s
ON t.schema_id=s.schema_id
ORDER BY s.name,t.name;

-- Count Tables
SELECT COUNT(*)
FROM sys.tables;

-- View Columns
SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='hr'
AND TABLE_NAME='Employees';

-- Primary Key
EXEC sp_pkeys 'Employees','hr';

-- Sample Records
SELECT TOP 5 *
FROM hr.Employees;

SELECT TOP 5 *
FROM sales.Customers;

SELECT TOP 5 *
FROM sales.Orders;

SELECT TOP 5 *
FROM sales.vw_OrderSummary;