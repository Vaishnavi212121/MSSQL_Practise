USE InternMSSQLTraining;



-- 1. Database Name, State, Recovery Model and Creation Date

SELECT
    name AS DatabaseName,
    state_desc AS DatabaseState,
    recovery_model_desc AS RecoveryModel,
    create_date AS CreationDate
FROM sys.databases;


-- 2. Current Database

SELECT DB_NAME() AS CurrentDatabase;


-- 3. List User Tables with Schema

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s
ON t.schema_id = s.schema_id
ORDER BY s.name, t.name;


-- 4. Columns and Data Types of sales.Orders

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='sales'
AND TABLE_NAME='Orders';



USE master;



-- Create Sandbox Database

IF DB_ID('InternSandbox_VSP') IS NULL
BEGIN
    CREATE DATABASE InternSandbox_VSP;
END



-- Use Database

USE InternSandbox_VSP;



SELECT DB_NAME();


-- Create Student Table

CREATE TABLE Student
(
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    City VARCHAR(50)
);


-- Verify Table

SELECT *
FROM sys.tables;


-- Return to Master

USE master;


-- Drop Database

IF DB_ID('InternSandbox_VSP') IS NOT NULL
BEGIN
    ALTER DATABASE InternSandbox_VSP
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE InternSandbox_VSP;
END


-- Verify Drop

SELECT *
FROM sys.databases
WHERE name='InternSandbox_VSP';




USE InternMSSQLTraining;



-- Single Row Insert

INSERT INTO training.LearnerScratch
(
    LearnerName,
    TopicName,
    Score,
    Notes
)
VALUES
(
    'Vaishnavi',
    'SQL Basics',
    90,
    'Single Row'
);



-- Multiple Row Insert

INSERT INTO training.LearnerScratch
(
    LearnerName,
    TopicName,
    Score,
    Notes
)
VALUES
('Vaishnavi','CRUD',91,'Multi Row'),
('Vaishnavi','Joins',92,'Multi Row'),
('Vaishnavi','Views',93,'Multi Row'),
('Vaishnavi','Functions',94,'Multi Row');



-- Read Data

SELECT
    LearnerName,
    TopicName,
    Score
FROM training.LearnerScratch
WHERE LearnerName='Vaishnavi';



-- Update

UPDATE training.LearnerScratch
SET Score=100
WHERE LearnerName='Vaishnavi';


SELECT @@ROWCOUNT AS RowsUpdated;



-- Verify Update

SELECT *
FROM training.LearnerScratch
WHERE LearnerName='Vaishnavi';



-- Delete One Row

DELETE TOP (1)
FROM training.LearnerScratch
WHERE LearnerName='Vaishnavi';



-- Verify Delete

SELECT *
FROM training.LearnerScratch
WHERE LearnerName='Vaishnavi';



-- Transaction Example

BEGIN TRAN;

UPDATE training.LearnerScratch
SET Score=50
WHERE LearnerName='Vaishnavi';

SELECT *
FROM training.LearnerScratch
WHERE LearnerName='Vaishnavi';

ROLLBACK;

SELECT *
FROM training.LearnerScratch
WHERE LearnerName='Vaishnavi';