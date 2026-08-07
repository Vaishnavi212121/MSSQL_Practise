USE InternMSSQLTraining;
GO

--USER DEFINED FUNCTIONS


-- Drop Scalar Function

IF OBJECT_ID('training.fn_NetAmount','FN') IS NOT NULL
DROP FUNCTION training.fn_NetAmount;
GO


-- Create Scalar Function

CREATE FUNCTION training.fn_NetAmount
(
    @GrossAmount DECIMAL(18,2),
    @DiscountPercent DECIMAL(5,2)
)
RETURNS DECIMAL(18,2)
AS
BEGIN

    RETURN
    (
        @GrossAmount
        -
        (@GrossAmount*@DiscountPercent/100.0)
    );

END;
GO


-- Use Scalar Function

SELECT

    o.OrderID,
    o.OrderNumber,

    SUM
    (
        oi.Quantity*oi.UnitPrice
    ) AS GrossAmount,

    o.DiscountPercent,

    training.fn_NetAmount
    (
        SUM(oi.Quantity*oi.UnitPrice),
        o.DiscountPercent
    )
    AS NetAmount

FROM sales.Orders o

INNER JOIN sales.OrderItems oi
ON o.OrderID=oi.OrderID

GROUP BY

o.OrderID,
o.OrderNumber,
o.DiscountPercent

ORDER BY
o.OrderID;

GO


--INLINE TABLE VALUED FUNCTION

-- Drop TVF

IF OBJECT_ID('training.fn_CustomerOrders','IF') IS NOT NULL
DROP FUNCTION training.fn_CustomerOrders;
GO


-- Create Inline TVF

CREATE FUNCTION training.fn_CustomerOrders
(
    @CustomerID INT
)

RETURNS TABLE

AS

RETURN
(

SELECT

    o.OrderID,
    o.OrderNumber,
    o.OrderDate,
    o.OrderStatus,
    SUM
    (
        oi.Quantity*oi.UnitPrice
    ) AS GrossAmount,
    o.DiscountPercent,
    training.fn_NetAmount
    (
        SUM(oi.Quantity*oi.UnitPrice),
        o.DiscountPercent
    )
    AS NetAmount
FROM sales.Orders o
INNER JOIN sales.OrderItems oi
ON o.OrderID=oi.OrderID
WHERE o.CustomerID=@CustomerID
GROUP BY
o.OrderID,
o.OrderNumber,
o.OrderDate,
o.OrderStatus,
o.DiscountPercent
);
GO


-- Execute TVF

SELECT *
FROM training.fn_CustomerOrders(1);

GO

SELECT *
FROM training.fn_CustomerOrders(2);

GO

--Difference Between Function and Stored Procedure


/*

FUNCTION

1. Returns a value or a table.
2. Can be used inside SELECT statements.
3. Cannot modify database tables.
4. Accepts input parameters.
5. Cannot use TRY...CATCH.

STORED PROCEDURE

1. Can return multiple result sets.
2. Can INSERT, UPDATE and DELETE.
3. Supports TRY...CATCH.
4. Can call other procedures.
5. Executed using EXEC.

*/


-- Optional Cleanup


/*

DROP FUNCTION training.fn_NetAmount;

DROP FUNCTION training.fn_CustomerOrders;

*/
