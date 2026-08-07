USE InternMSSQLTraining;
GO

--TRIGGER

-- Create Audit Schema

IF NOT EXISTS
(
SELECT *
FROM sys.schemas
WHERE name='audit'
)

EXEC('CREATE SCHEMA audit');
GO

-- Audit Table

IF OBJECT_ID('audit.ProductPriceAudit','U') IS NOT NULL
DROP TABLE audit.ProductPriceAudit;
GO

CREATE TABLE audit.ProductPriceAudit
(

AuditID INT IDENTITY PRIMARY KEY,

ProductID INT,

OldPrice DECIMAL(10,2),

NewPrice DECIMAL(10,2),

ChangedDate DATETIME DEFAULT GETDATE()

);
GO


-- Drop Trigger

IF OBJECT_ID('sales.trg_Products_PriceAudit','TR') IS NOT NULL
DROP TRIGGER sales.trg_Products_PriceAudit;
GO


-- Create Trigger

CREATE TRIGGER sales.trg_Products_PriceAudit
ON sales.Products
AFTER UPDATE
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO audit.ProductPriceAudit
(
ProductID,
OldPrice,
NewPrice
)

SELECT
d.ProductID,
d.UnitPrice,
i.UnitPrice
FROM inserted i
INNER JOIN deleted d
ON i.ProductID=d.ProductID
WHERE i.UnitPrice<>d.UnitPrice;
END;

GO


-- Test Trigger

BEGIN TRAN;

UPDATE sales.Products

SET UnitPrice=UnitPrice+100

WHERE ProductID IN (1,2);

SELECT *
FROM audit.ProductPriceAudit;

ROLLBACK;

-- Disable Trigger

DISABLE TRIGGER sales.trg_Products_PriceAudit
ON sales.Products;


-- Enable Trigger


ENABLE TRIGGER sales.trg_Products_PriceAudit

ON sales.Products;


-- Drop Trigger

-- DROP TRIGGER sales.trg_Products_PriceAudit;
