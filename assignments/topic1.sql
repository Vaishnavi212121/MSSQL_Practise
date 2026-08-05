SELECT @@VERSION;

SELECT SUSER_SNAME();

SELECT SYSDATETIME();

SELECT @@SERVERNAME AS ServerName;

SELECT DB_NAME() AS CurrentDatabase;
 


SELECT
    @@VERSION AS SQLServerVersion,
    SUSER_SNAME() AS CurrentUser,
    SYSDATETIME() AS CurrentDateTime,
    @@SERVERNAME AS ServerName,
    DB_NAME() AS CurrentDatabase;
    
SELECT name
FROM sys.databases;

SELECT name
FROM sys.databases
WHERE name='InternMSSQLTraining';

USE InternMSSQLTraining;


SELECT DB_NAME();

SELECT name
FROM sys.schemas


SELECT
    name AS DatabaseName,
    state_desc AS DatabaseState,
    recovery_model_desc AS RecoveryModel,
    create_date AS CreationDate
FROM sys.databases;


SELECT DB_NAME() AS CurrentDatabase;

USE InternMSSQLTraining;

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s
ON t.schema_id = s.schema_id
ORDER BY s.name, t.name;


SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='hr'
AND TABLE_NAME='Employees';


SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='sales'
AND TABLE_NAME='Orders';


SELECT COUNT(*) AS TotalTables
FROM sys.tables;

Select * from hr.EMployees;

Select * from hr.Departments;


EXEC sp_pkeys 'Employees', 'hr';


SELECT TOP 5 *
FROM hr.Employees;

SELECT TOP 10 *
FROM hr.Employees;

SELECT TOP 5 *
FROM sales.Customers;

SELECT TOP 5 *
FROM sales.Orders;

SELECT TOP 5 *
FROM sales.vw_OrderSummary;

SELECT COUNT(*) AS TotalRows
FROM hr.Employees;



-- 2.1.1 System Databases Information

SELECT
    name AS DatabaseName,
    state_desc AS DatabaseState,
    recovery_model_desc AS RecoveryModel,
    create_date AS CreationDate
FROM sys.databases;


SELECT DB_NAME() AS CurrentDatabase;

SELECT
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE,
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_SCHEMA = 'hr'
AND tc.TABLE_NAME = 'Employees';


SELECT
    KU.COLUMN_NAME AS PrimaryKeyColumn
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
ON TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
WHERE TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
AND TC.TABLE_SCHEMA = 'hr'
AND TC.TABLE_NAME = 'Employees';
