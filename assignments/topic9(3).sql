USE InternMSSQLTraining;
GO

--Stored Procedures & Procedural Logic


-- Drop Procedure if Exists

IF OBJECT_ID('training.usp_GetCustomerOrders','P') IS NOT NULL
DROP PROCEDURE training.usp_GetCustomerOrders;
GO

-- Create Procedure

CREATE PROCEDURE training.usp_GetCustomerOrders

    @CustomerID INT,
    @FromDate DATE,
    @Status VARCHAR(30)=NULL
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY

    
    -- Validate Customer
    
    IF NOT EXISTS
    (
        SELECT 1
        FROM sales.Customers
        WHERE CustomerID=@CustomerID
    )
    BEGIN

        THROW 50001,
        'Invalid Customer ID.',
        1;

    END;

    
    -- Return Customer Orders
 
    SELECT

        o.OrderID,
        o.OrderNumber,
        o.OrderDate,
        o.OrderStatus,

        SUM
        (
            oi.Quantity * oi.UnitPrice
        ) AS GrossAmount,

        o.DiscountPercent,

        SUM
        (
            oi.Quantity
            * oi.UnitPrice
            *
            (1-(o.DiscountPercent/100.0))
        ) AS NetAmount

    FROM sales.Orders o

    INNER JOIN sales.OrderItems oi
    ON o.OrderID=oi.OrderID

    WHERE

        o.CustomerID=@CustomerID

        AND

        o.OrderDate>=@FromDate

        AND

        (
            @Status IS NULL
            OR
            o.OrderStatus=@Status
        )

    GROUP BY

        o.OrderID,
        o.OrderNumber,
        o.OrderDate,
        o.OrderStatus,
        o.DiscountPercent

    ORDER BY

        o.OrderDate DESC;

END TRY

BEGIN CATCH

    PRINT 'Procedure Error';

    PRINT ERROR_MESSAGE();

END CATCH

END;
GO


--EXECUTION TESTS

-- Test 1

EXEC training.usp_GetCustomerOrders

@CustomerID=1,
@FromDate='2025-01-01';


-- Test 2

EXEC training.usp_GetCustomerOrders

@CustomerID=2,
@FromDate='2025-01-01',
@Status='Completed';


-- Test 3

EXEC training.usp_GetCustomerOrders

@CustomerID=3,
@FromDate='2024-01-01',
@Status='Shipped';


-- Invalid Customer


EXEC training.usp_GetCustomerOrders

@CustomerID=99999,
@FromDate='2025-01-01';


-- Expected Output

/*

Valid Customer

Returns

OrderID
OrderNumber
OrderDate
OrderStatus
GrossAmount
DiscountPercent
NetAmount


Invalid Customer

Msg 50001

Invalid Customer ID.

*/
