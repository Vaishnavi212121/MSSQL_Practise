USE InternMSSQLTraining;
GO

--Relationships

-- Drop Practice Table

IF OBJECT_ID('training.EmployeeOrders','U') IS NOT NULL
DROP TABLE training.EmployeeOrders;
GO

-- Create Parent Table

CREATE TABLE training.Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Create Child Table

CREATE TABLE training.EmployeeOrders
(
    OrderID INT PRIMARY KEY,
    EmployeeID INT,
    DepartmentID INT,

    CONSTRAINT FK_EmployeeOrders_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES training.Departments(DepartmentID)
);

-- Insert Parent Records

INSERT INTO training.Departments
VALUES
(1,'HR'),
(2,'Sales'),
(3,'Finance');

-- Insert Child Records

INSERT INTO training.EmployeeOrders
VALUES
(101,1,1),
(102,2,2),
(103,3,2),
(104,4,3);


SELECT *
FROM training.Departments;

SELECT *
FROM training.EmployeeOrders;

-- View Foreign Key

EXEC sp_helpconstraint 'training.EmployeeOrders';


-- INNER JOIN
-- Orders with Customer Details

SELECT
    o.OrderID,
    o.OrderNumber,
    o.OrderDate,
    c.CompanyName,
    c.City,
    c.StateName
FROM sales.Orders o
INNER JOIN sales.Customers c
ON o.CustomerID = c.CustomerID;



-- LEFT JOIN

-- All Customers with Orders

SELECT
    c.CustomerID,
    c.CompanyName,
    o.OrderID,
    o.OrderNumber
FROM sales.Customers c
LEFT JOIN sales.Orders o
ON c.CustomerID = o.CustomerID
ORDER BY c.CustomerID;



-- RIGHT JOIN
-- All Orders with Customer Details

SELECT
    c.CompanyName,
    o.OrderID,
    o.OrderNumber,
    o.OrderDate
FROM sales.Customers c
RIGHT JOIN sales.Orders o
ON c.CustomerID = o.CustomerID;


-- FULL OUTER JOIN

SELECT
    c.CustomerID,
    c.CompanyName,
    o.OrderID,
    o.OrderNumber
FROM sales.Customers c
FULL OUTER JOIN sales.Orders o
ON c.CustomerID = o.CustomerID;



-- CROSS JOIN

SELECT
    e.EmployeeID,
    e.FirstName,
    p.ProductName
FROM hr.Employees e
CROSS JOIN sales.Products p;


-- SELF JOIN

SELECT
    A.CustomerID AS Customer1,
    A.CompanyName AS Company1,
    B.CustomerID AS Customer2,
    B.CompanyName AS Company2,
    A.StateName
FROM sales.Customers A
INNER JOIN sales.Customers B
ON A.StateName = B.StateName
AND A.CustomerID < B.CustomerID
ORDER BY A.StateName;



-- Multiple Table JOIN

SELECT
    o.OrderID,
    o.OrderNumber,
    o.OrderDate,
    c.CompanyName,
    e.FirstName,
    e.LastName
FROM sales.Orders o
INNER JOIN sales.Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN hr.Employees e
ON o.SalesPersonID = e.EmployeeID
ORDER BY o.OrderDate DESC;


-- Join with Aggregate
SELECT
    c.CompanyName,
    COUNT(o.OrderID) AS TotalOrders
FROM sales.Customers c
LEFT JOIN sales.Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
ORDER BY TotalOrders DESC;



-- Employees with Orders Count
SELECT
    e.EmployeeID,
    e.FirstName,
    COUNT(o.OrderID) AS OrdersHandled
FROM hr.Employees e
LEFT JOIN sales.Orders o
ON e.EmployeeID = o.SalesPersonID
GROUP BY
    e.EmployeeID,
    e.FirstName
ORDER BY OrdersHandled DESC;