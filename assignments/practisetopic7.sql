USE InternMSSQLTraining;


-- ALTER TABLE

-- Drop table if it already exists

IF OBJECT_ID('training.EmployeeTraining','U') IS NOT NULL
DROP TABLE training.EmployeeTraining;
GO

----------------------------------------------------------
-- Create Table
----------------------------------------------------------

CREATE TABLE training.EmployeeTraining
(
    TrainingID INT PRIMARY KEY,
    EmployeeID INT,
    CourseName VARCHAR(100)
);

Select * from training.EmployeeTraining

-- View Table Structur

EXEC sp_help 'training.EmployeeTraining';

-- Add New Column


ALTER TABLE training.EmployeeTraining
ADD TrainingDate DATE;


-- Add Duration Column

ALTER TABLE training.EmployeeTraining
ADD DurationDays INT;


-- Add Completion Status


ALTER TABLE training.EmployeeTraining
ADD Status VARCHAR(20);


-- Modify Column Size


ALTER TABLE training.EmployeeTraining
ALTER COLUMN CourseName VARCHAR(200);


-- Rename Column (SQL Server)

EXEC sp_rename
'training.EmployeeTraining.Status',
'TrainingStatus',
'COLUMN';


-- Drop Column

ALTER TABLE training.EmployeeTraining
DROP COLUMN DurationDays;


-- Verify Structure


EXEC sp_help 'training.EmployeeTraining';


-- Constraints
---

ALTER TABLE training.EmployeeTraining
ADD CONSTRAINT DF_TrainingStatus
DEFAULT 'Pending'
FOR TrainingStatus;


-- Add CHECK Constraint


ALTER TABLE training.EmployeeTraining
ADD CONSTRAINT CK_TrainingDate
CHECK (TrainingDate <= GETDATE());


-- Add UNIQUE Constraint


ALTER TABLE training.EmployeeTraining
ADD CONSTRAINT UQ_Course
UNIQUE(EmployeeID,CourseName);


EXEC sp_helpconstraint 'training.EmployeeTraining';



INSERT INTO training.EmployeeTraining
(
TrainingID,
EmployeeID,
CourseName,
TrainingDate
)
VALUES
(
1,
101,
'SQL Server Basics',
'2026-08-01'
);


SELECT *
FROM training.EmployeeTraining;


INSERT INTO training.EmployeeTraining
(
TrainingID,
EmployeeID,
CourseName,
TrainingDate
)
VALUES
(
2,
102,
'T-SQL',
'2026-08-02'
);


SELECT *
FROM training.EmployeeTraining;


-- Test UNIQUE Constraint


/*
Expected Error

INSERT INTO training.EmployeeTraining
VALUES
(
3,
101,
'SQL Server Basics',
'2026-08-03',
'Completed'
);
*/




SELECT *
FROM training.EmployeeTraining;
