USE InternMSSQLTraining;
GO

--NORMALIZATION


-- Drop Practice Table

IF OBJECT_ID('training.DenormalizedOrders','U') IS NOT NULL
DROP TABLE training.DenormalizedOrders;
GO


-- Create Denormalized Table

SELECT
    o.OrderID,
    o.OrderNumber,
    o.OrderDate,
    c.CustomerID,
    c.CompanyName,
    c.City,
    p.ProductID,
    p.ProductName,
    oi.Quantity,
    oi.UnitPrice

INTO training.DenormalizedOrders

FROM sales.Orders o

INNER JOIN sales.Customers c
ON o.CustomerID=c.CustomerID

INNER JOIN sales.OrderItems oi
ON o.OrderID=oi.OrderID

INNER JOIN sales.Products p
ON oi.ProductID=p.ProductID;


-- View Data

SELECT *
FROM training.DenormalizedOrders;


-- Normalization Notes

/*

Insertion Anomaly

Cannot insert a new product unless an order exists.

Update Anomaly

Customer information is repeated in multiple rows.
Updating one row may leave inconsistent values.

Deletion Anomaly

Deleting the last order removes customer/product details.


3NF Design

Customers

CustomerID (PK)
CompanyName
City

Orders

OrderID (PK)
CustomerID (FK)
OrderDate

Products

ProductID (PK)
ProductName

OrderItems

OrderID (FK)
ProductID (FK)
Quantity
UnitPrice


1NF

Atomic values.

2NF

Partial dependency removed.

3NF

Transitive dependency removed.

*/
