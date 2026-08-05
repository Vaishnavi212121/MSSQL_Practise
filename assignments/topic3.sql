USE InternMSSQLTraining;



-- Drop table if already exists

IF OBJECT_ID('training.DataTypePractice','U') IS NOT NULL
DROP TABLE training.DataTypePractice;
GO

-- Create Table

CREATE TABLE training.DataTypePractice
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeName NVARCHAR(100),
    Amount DECIMAL(10,2),
    JoiningDate DATE,
    CreatedAt DATETIME2,
    IsActive BIT,
    Notes VARCHAR(200) NULL
);

-- View Table Structure

EXEC sp_help 'training.DataTypePractice';

--------------------------------------------------------

-- Insert Row 1

INSERT INTO training.DataTypePractice
(
EmployeeName,
Amount,
JoiningDate,
CreatedAt,
IsActive,
Notes
)
VALUES
(
'Vaishnavi',
45000.50,
'2026-08-10',
SYSDATETIME(),
1,
'First Record'
);

--------------------------------------------------------

-- Insert Row 2 (Unicode)

INSERT INTO training.DataTypePractice
(
EmployeeName,
Amount,
JoiningDate,
CreatedAt,
IsActive,
Notes
)
VALUES
(
'Ram',
60000,
'2026-07-15',
SYSDATETIME(),
1,
'Unicode Name'
);

--------------------------------------------------------

-- Insert Row 3 (NULL Notes)

INSERT INTO training.DataTypePractice
(
EmployeeName,
Amount,
JoiningDate,
CreatedAt,
IsActive,
Notes
)
VALUES
(
'Amit',
52000,
'2026-06-20',
SYSDATETIME(),
0,
NULL
);

--------------------------------------------------------

-- View Data

SELECT *
FROM training.DataTypePractice;

--------------------------------------------------------

-- Check Data Types

SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='training'
AND TABLE_NAME='DataTypePractice';

--------------------------------------------------------

-- SQL_VARIANT_PROPERTY Example

SELECT
SQL_VARIANT_PROPERTY(CAST(100 AS SQL_VARIANT),'BaseType') AS IntegerType,
SQL_VARIANT_PROPERTY(CAST(500.55 AS SQL_VARIANT),'BaseType') AS DecimalType,
SQL_VARIANT_PROPERTY(CAST(GETDATE() AS SQL_VARIANT),'BaseType') AS DateTimeType;


-- Drop Table

IF OBJECT_ID('training.ProjectAssignments','U') IS NOT NULL
DROP TABLE training.ProjectAssignments;
GO

--------------------------------------------------------

-- Create Table with Constraints

CREATE TABLE training.ProjectAssignments
(
AssignmentID INT PRIMARY KEY,

AssignmentCode VARCHAR(20)
CONSTRAINT UQ_AssignmentCode UNIQUE,

EmployeeID INT NOT NULL,

Status VARCHAR(20)
CONSTRAINT DF_ProjectStatus
DEFAULT 'Pending'
);

--------------------------------------------------------

-- Insert Valid Row

INSERT INTO training.ProjectAssignments
(
AssignmentID,
AssignmentCode,
EmployeeID
)
VALUES
(
1,
'PRJ101',
101
);

--------------------------------------------------------

-- Insert Valid Row

INSERT INTO training.ProjectAssignments
(
AssignmentID,
AssignmentCode,
EmployeeID
)
VALUES
(
2,
'PRJ102',
102
);

--------------------------------------------------------

-- Verify Data

SELECT *
FROM training.ProjectAssignments;


INSERT INTO training.ProjectAssignments
(
AssignmentID,
AssignmentCode,
EmployeeID
)
VALUES
(
5,
'PRJ105',
105
);

--------------------------------------------------------

-- Final Data

SELECT *
FROM training.ProjectAssignments;

--------------------------------------------------------

-- View Constraints

EXEC sp_helpconstraint 'training.ProjectAssignments';
