USE InternMSSQLTraining;
GO


--INDEXING 

-- Query Before Creating Index

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT
    CustomerID,
    SalesPersonID,
    ShippingCity
FROM sales.Orders
WHERE OrderStatus <> 'Cancelled'
AND OrderDate BETWEEN '2025-01-01' AND '2025-12-31';


-- Create Composite Nonclustered Index

CREATE NONCLUSTERED INDEX IX_Orders_Status_Date

ON sales.Orders
(
    OrderStatus,
    OrderDate
)

INCLUDE
(
    CustomerID,
    SalesPersonID,
    ShippingCity
);


-- Execute Same Query Again

SELECT
    CustomerID,
    SalesPersonID,
    ShippingCity
FROM sales.Orders
WHERE OrderStatus <> 'Cancelled'
AND OrderDate BETWEEN '2025-01-01' AND '2025-12-31';


-- View Index


SELECT
    name,
    type_desc
FROM sys.indexes
WHERE object_id=OBJECT_ID('sales.Orders');

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
