
--7
--Add ReviewerName VARCHAR(80) NULL to training.LearnerScratch.
ALTER TABLE training.LearnerScratch
ADD ReviewerName VARCHAR(80) NULL;

--ReviewerName for existing rows, then alter the column to NOT NULL
UPDATE training.LearnerScratch
SET ReviewerName = 'Vaishnavi';

ALTER TABLE training.LearnerScratch
ALTER COLUMN ReviewerName VARCHAR(80) NOT NULL;

--Add ReviewedAt DATETIME2(0) with a default that also applies to existing rows
ALTER TABLE training.LearnerScratch
ADD ReviewedAt DATETIME2(0)
CONSTRAINT DF_LearnerScratch_ReviewedAt
DEFAULT SYSDATETIME()
WITH VALUES;

--Create and drop a temporary practice column, verifying metadata after each action
ALTER TABLE training.LearnerScratch
ADD TempColumn VARCHAR(20);

EXEC sp_help 'training.LearnerScratch';

ALTER TABLE training.LearnerScratch
DROP COLUMN TempColumn;

EXEC sp_help 'training.LearnerScratch';

INSERT INTO training.LearnerScratch
(LearnerName, TopicName, Score, AttemptDate, Notes, ReviewerName, ReviewedAt)
VALUES
('Vaishnavi','SQL Basics',90,'2026-08-07','Good Progress','Trainer',GETDATE()),
('Rahul','Joins',80,'2026-08-06','Needs Practice','Trainer',GETDATE()),
('Sneha','Subqueries',NULL,'2026-08-05','Pending Review','Trainer',GETDATE());

--Add CK_LearnerScratch_Score to require Score between 0 and 100 or NULL
ALTER TABLE training.LearnerScratch
ADD CONSTRAINT CK_LearnerScratch_Score
CHECK (Score BETWEEN 0 AND 100 OR Score IS NULL);

--Insert or update a valid score and show success.
UPDATE training.LearnerScratch
SET Score = 85
WHERE LearnerName = 'Vaishnavi';

SELECT *
FROM training.LearnerScratch
WHERE LearnerName = 'Vaishnavi';

--Attempt a score of 120 and capture the expected failure

/* The UPDATE statement conflicted with the CHECK constraint
'CK_LearnerScratch_Score'.

UPDATE training.LearnerScratch
SET Score = 120
WHERE LearnerName = 'Vaishnavi';
*/

--Query sys.check_constraints, drop the constraint, and add it back
SELECT *
FROM sys.check_constraints
WHERE name = 'CK_LearnerScratch_Score';

ALTER TABLE training.LearnerScratch
DROP CONSTRAINT CK_LearnerScratch_Score;

ALTER TABLE training.LearnerScratch
ADD CONSTRAINT CK_LearnerScratch_Score
CHECK (Score BETWEEN 0 AND 100 OR Score IS NULL);
