
--6

--EmployeeFullName and a lowercase company email using CONCAT and LOWER.
/*
Select EmployeeID,Concat(Firstname,' ',LastName) AS FullName
from hr.Employees
Select EmployeeID ,FirstName,LastName ,Upper(Email) As EmailUppercase
From hr.Employees*/

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS EmployeeFullName,
    LOWER(Email) AS CompanyEmail
FROM hr.Employees;

Select * from sales.Products

--Return product name length and the first eight characters of each product name.
SELECT
    ProductID,
    ProductName,
    LEN(ProductName) AS ProductNameLength,
    LEFT(ProductName,8) AS FirstEightCharacters
FROM sales.Products;

--Replace 'License' with 'Subscription' in display output without updating stored data
SELECT
    ProductID,
    ProductName,
    REPLACE(ProductName,'License','Subscription') AS DisplayName
FROM sales.Products;

--Extract the email domain using CHARINDEX and SUBSTRING. Handle NULL email values.
SELECT
    EmployeeID,
    Email,
    CASE
        WHEN Email IS NULL THEN 'No Email'
        ELSE SUBSTRING(
                Email,
                CHARINDEX('@',Email)+1,
                LEN(Email)
             )
    END AS EmailDomain
FROM hr.Employees;

--Calculate completed years of service using DATEDIFF and birthday-style correction.
SELECT
    EmployeeID,
    FirstName,
    HireDate,
    DATEDIFF(YEAR,HireDate,GETDATE())
    -
    CASE
        WHEN DATEADD(YEAR,DATEDIFF(YEAR,HireDate,GETDATE()),HireDate)>GETDATE()
        THEN 1
        ELSE 0
    END AS YearsOfService
FROM hr.Employees;

--Show each order date, month name, quarter number, and month-end date.
SELECT
    OrderID,
    OrderDate,
    DATENAME(MONTH,OrderDate) AS MonthName,
    DATEPART(QUARTER,OrderDate) AS QuarterNumber,
    EOMONTH(OrderDate) AS MonthEndDate
FROM sales.Orders;

--Return orders placed during the previous 12 complete months relative to a declared @AsOfDate.
DECLARE @AsOfDate DATE='2026-01-01';

SELECT
    OrderID,
    OrderDate
FROM sales.Orders
WHERE OrderDate>=DATEADD(MONTH,-12,@AsOfDate)
AND OrderDate<@AsOfDate;

--number of days between OrderDate and RequiredDate and flag late windows over 12 days.
SELECT
    OrderID,
    OrderDate,
    RequiredDate,
    DATEDIFF(DAY,OrderDate,RequiredDate) AS DaysDifference,
    CASE
        WHEN DATEDIFF(DAY,OrderDate,RequiredDate)>12
        THEN 'Late'
        ELSE 'On Time'
    END AS Status
FROM sales.Orders;
