USE InternMSSQLTraining;

--RELATIONSHIPS AND FOREIGN KEYS

-- Document Relationships

/*
One-to-Many Relationship
training.Departments (DepartmentID)
        |
        |----< training.EmployeeOrders (DepartmentID)

Many-to-Many Relationship
sales.Orders
        |
        |----< sales.OrderItems >----|
                                     |
                              sales.Products

Self-Referencing Relationship
hr.Employees.ManagerID -> hr.Employees.EmployeeID
(if ManagerID exists)
*/

------------------------------------------------------------

-- Drop Practice Table

IF OBJECT_ID('training.EmployeeOrders','U') IS NOT NULL
DROP TABLE training.EmployeeOrders;
GO

-- Parent Table

CREATE TABLE training.Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Child Table

CREATE TABLE training.EmployeeOrders
(
    OrderID INT PRIMARY KEY,
    EmployeeID INT,
    DepartmentID INT,

    CONSTRAINT FK_EmployeeOrders_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES training.Departments(DepartmentID)
);

-- Parent Data

INSERT INTO training.Departments
VALUES
(1,'HR'),
(2,'Sales'),
(3,'Finance');

-- Child Data

INSERT INTO training.EmployeeOrders
VALUES
(101,1,1),
(102,2,2),
(103,3,2),
(104,4,3);

------------------------------------------------------------

-- View Relationship Metadata

SELECT
    fk.name AS ForeignKeyName,
    OBJECT_NAME(fkc.parent_object_id) AS ChildTable,
    pc.name AS ChildColumn,
    OBJECT_NAME(fkc.referenced_object_id) AS ParentTable,
    rc.name AS ParentColumn
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
ON fk.object_id = fkc.constraint_object_id
JOIN sys.columns pc
ON pc.object_id = fkc.parent_object_id
AND pc.column_id = fkc.parent_column_id
JOIN sys.columns rc
ON rc.object_id = fkc.referenced_object_id
AND rc.column_id = fkc.referenced_column_id;

------------------------------------------------------------

--  Foreign Key Validation

BEGIN TRAN;

INSERT INTO training.EmployeeOrders
VALUES
(
105,
5,
100
);

ROLLBACK;

-- Expected:
-- The INSERT statement conflicted with the FOREIGN KEY constraint.

------------------------------------------------------------

-- Junction Table Explanation

/*
sales.OrderItems is a Junction Table.

One Order can contain many Products.
One Product can appear in many Orders.

Therefore OrderItems resolves the Many-to-Many relationship.
*/


 - JOINS

-- INNER JOIN

SELECT
    o.OrderID,
    o.OrderNumber,
    o.OrderDate,
    c.CompanyName
FROM sales.Orders o
INNER JOIN sales.Customers c
ON o.CustomerID = c.CustomerID;

---
--  LEFT JOIN

SELECT
    c.CustomerID,
    c.CompanyName,
    o.OrderID,
    o.OrderNumber
FROM sales.Customers c
LEFT JOIN sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


--  SELF JOIN

-- If ManagerID exists

SELECT
    e.FirstName + ' ' + e.LastName AS Employee,
    m.FirstName + ' ' + m.LastName AS Manager
FROM hr.Employees e
LEFT JOIN hr.Employees m
ON e.ManagerID = m.EmployeeID;

-- If ManagerID doesn't exist in your setup,
-- mention this in your submission.

------------------------------------------------------------
-- Q4 CROSS JOIN

SELECT
    Tier.CustomerTier,
    Flag.ActiveStatus
FROM
(
VALUES
('Gold'),
('Silver'),
('Bronze')
) AS Tier(CustomerTier)

CROSS JOIN

(
VALUES
('Active'),
('Inactive')
) AS Flag(ActiveStatus);

--FULL OUTER JOIN

SELECT
    c.CompanyName,
    o.OrderNumber
FROM sales.Customers c
FULL OUTER JOIN sales.Orders o
ON c.CustomerID = o.CustomerID;

/*
FULL OUTER JOIN returns

1. Matching rows
2. Customers without Orders
3. Orders without Customers
*/

--UNION,UNION, ALLEXCEPT,OUTER APPLY
-- UNION

SELECT City AS Location
FROM sales.Customers

UNION

SELECT Location
FROM hr.Departments;

--  UNION ALL

SELECT City AS Location
FROM sales.Customers

UNION ALL

SELECT Location
FROM hr.Departments;


-- EXCEPT

SELECT City
FROM sales.Customers

EXCEPT

SELECT ShippingCity
FROM sales.Orders;

-- OUTER APPLY

SELECT
    c.CompanyName,
    X.OrderNumber,
    X.OrderDate
FROM sales.Customers c

OUTER APPLY
(
    SELECT TOP (1)
        OrderNumber,
        OrderDate
    FROM sales.Orders o
    WHERE o.CustomerID = c.CustomerID
    ORDER BY OrderDate DESC
) X;
