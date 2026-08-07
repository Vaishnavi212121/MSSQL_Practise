USE InternMSSQLTraining;

--Views and Window Functions



-- Create or Alter View
-- training.vw_CustomerSales

IF OBJECT_ID('training.vw_CustomerSales','V') IS NOT NULL
DROP VIEW training.vw_CustomerSales;


CREATE VIEW training.vw_CustomerSales
AS
SELECT

    c.CustomerID,
    c.CompanyName,
    c.CustomerTier,

    COUNT(DISTINCT o.OrderID) AS OrderCount,

    SUM(oi.Quantity * oi.UnitPrice) AS GrossSales,

    SUM
    (
        oi.Quantity
        * oi.UnitPrice
        * (1-(o.DiscountPercent/100.0))
    ) AS NetSales

FROM sales.Customers c

INNER JOIN sales.Orders o
ON c.CustomerID=o.CustomerID

INNER JOIN sales.OrderItems oi
ON o.OrderID=oi.OrderID

GROUP BY

c.CustomerID,
c.CompanyName,
c.CustomerTier;
GO

-- View Result

SELECT *
FROM training.vw_CustomerSales
ORDER BY NetSales DESC;


-- Top 5 Customers by Net Sales

SELECT TOP (5)

CustomerID,
CompanyName,
CustomerTier,
OrderCount,
GrossSales,
NetSales

FROM training.vw_CustomerSales

ORDER BY NetSales DESC;


-- RANK

SELECT

EmployeeID,
FirstName,
LastName,
DepartmentID,
Salary,

RANK() OVER
(
PARTITION BY DepartmentID
ORDER BY Salary DESC
)
AS SalaryRank

FROM hr.Employees

ORDER BY
DepartmentID,
Salary DESC;



-- DENSE_RANK

SELECT
EmployeeID,
FirstName,
LastName,
DepartmentID,
Salary,
DENSE_RANK() OVER
(
PARTITION BY DepartmentID
ORDER BY Salary DESC
)
AS DenseSalaryRank
FROM hr.Employees
ORDER BY
DepartmentID,
Salary DESC;


-- Running Net Sales Total


SELECT
o.OrderID,
o.OrderDate,
c.CompanyName,
SUM
(
oi.Quantity * oi.UnitPrice
*
(1-(o.DiscountPercent/100.0))
)
AS NetSales,

SUM
(
oi.Quantity * oi.UnitPrice
*
(1-(o.DiscountPercent/100.0))
)
OVER
(
ORDER BY o.OrderDate,o.OrderID
ROWS UNBOUNDED PRECEDING
)
AS RunningNetSales

FROM sales.Orders o

INNER JOIN sales.Customers c
ON o.CustomerID=c.CustomerID

INNER JOIN sales.OrderItems oi
ON o.OrderID=oi.OrderID

GROUP BY

o.OrderID,
o.OrderDate,
c.CompanyName,
o.DiscountPercent

ORDER BY
o.OrderDate,
o.OrderID;



/*
Explanation

ROWS remain visible because
window functions do not collapse rows.

GROUP BY combines rows.

OVER() calculates values
while preserving every detail row.
*/
