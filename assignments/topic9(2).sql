USE InternMSSQLTraining;

--COMMON TABLE EXPRESSIONS (CTE)

-- Build a CTE that calculates Order Totals
-- Then summarize Net Sales by Customer Tier

WITH OrderTotals
AS
(
    SELECT

        o.OrderID,
        o.CustomerID,

        SUM(oi.Quantity * oi.UnitPrice) AS GrossSales,

        SUM
        (
            oi.Quantity
            * oi.UnitPrice
            * (1 - (o.DiscountPercent / 100.0))
        ) AS NetSales

    FROM sales.Orders o

    INNER JOIN sales.OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY

        o.OrderID,
        o.CustomerID,
        o.DiscountPercent
)

SELECT

    c.CustomerTier,

    COUNT(*) AS TotalOrders,

    SUM(GrossSales) AS GrossSales,

    SUM(NetSales) AS NetSales

FROM OrderTotals ot

INNER JOIN sales.Customers c
ON ot.CustomerID = c.CustomerID

GROUP BY c.CustomerTier

ORDER BY NetSales DESC;


-- Two Chained CTEs
-- Highest Completed Order Per Year

WITH OrderTotals
AS
(
    SELECT

        o.OrderID,
        YEAR(o.OrderDate) AS OrderYear,

        SUM
        (
            oi.Quantity * oi.UnitPrice
            *
            (1-(o.DiscountPercent/100.0))
        ) AS NetSales

    FROM sales.Orders o

    INNER JOIN sales.OrderItems oi
    ON o.OrderID = oi.OrderID

    WHERE o.OrderStatus='Completed'

    GROUP BY

        o.OrderID,
        YEAR(o.OrderDate),
        o.DiscountPercent
),

HighestOrders
AS
(
    SELECT
        OrderID,
        OrderYear,
        NetSales,
        RANK() OVER
        (
            PARTITION BY OrderYear
            ORDER BY NetSales DESC
        ) AS SalesRank
    FROM OrderTotals
)

SELECT
OrderYear,
OrderID,
NetSales
FROM HighestOrders
WHERE SalesRank=1
ORDER BY OrderYear;


-- Recursive CTE
-- Employee Hierarchy


WITH EmployeeHierarchy
AS
(
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        ManagerID,
        1 AS LevelNo
    FROM hr.Employees
    WHERE ManagerID IS NULL
    UNION ALL

    SELECT

        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.ManagerID,
        h.LevelNo+1
    FROM hr.Employees e
    INNER JOIN EmployeeHierarchy h
    ON e.ManagerID=h.EmployeeID
)

SELECT *
FROM EmployeeHierarchy
ORDER BY
LevelNo,
EmployeeID
OPTION (MAXRECURSION 100);


-- MAXRECURSION Explanation


/*

MAXRECURSION 100

Prevents infinite recursion.
The recursion stops

1. when hierarchy ends

OR

2. after 100 recursive levels.

*/
