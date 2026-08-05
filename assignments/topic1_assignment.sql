SELECT name
FROM sys.schemas;

SELECT
s.name,
t.name
FROM sys.tables t
JOIN sys.schemas s
ON t.schema_id=s.schema_id;

EXEC sp_pkeys 'Employees','hr';

SELECT TOP 5 *
FROM hr.Employees;