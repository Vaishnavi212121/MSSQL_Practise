USE InternMSSQLTraining;

-- 1. Active employees with salary between 700000 and 1300000

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    HireDate
FROM hr.Employees
WHERE Salary BETWEEN 700000 AND 1300000
ORDER BY Salary DESC,
         HireDate ASC;


-- 2. Distinct Customer States

SELECT DISTINCT
    StateName
FROM sales.Customers
ORDER BY StateName ASC;


-- 3. Employees without Phone Number

SELECT
    EmployeeID,
    FirstName,
    LastName
FROM hr.Employees
WHERE Phone IS NULL;



/*=========================================================
    Topic 4.2 - LIKE and TOP
=========================================================*/

-- 1. Products containing 'License'

SELECT
    ProductID,
    ProductName
FROM sales.Products
WHERE ProductName LIKE '%License%';


-- 2. Company starts with vowel OR City ends with 'e'

SELECT
    CustomerID,
    CompanyName,
    City
FROM sales.Customers
WHERE CompanyName LIKE 'A%'
   OR CompanyName LIKE 'E%'
   OR CompanyName LIKE 'I%'
   OR CompanyName LIKE 'O%'
   OR CompanyName LIKE 'U%'
   OR City LIKE '%e';


-- 3. Top 5 Highest Paid Employees

SELECT TOP (5)
    EmployeeID,
    FirstName,
    Salary
FROM hr.Employees
ORDER BY Salary DESC;


-- 4. Top 20 Percent Most Expensive Products

SELECT TOP (20) PERCENT WITH TIES
    ProductID,
    ProductName,
    UnitPrice
FROM sales.Products
ORDER BY UnitPrice DESC;




-- 1. Gold and Silver Customers from Maharashtra, Gujarat and Karnataka

SELECT
    CustomerID,
    CompanyName,
    CustomerTier,
    StateName
FROM sales.Customers
WHERE CustomerTier IN ('Gold','Silver')
AND StateName IN ('Maharashtra','Gujarat','Karnataka');


-- 2. Orders placed in 2025 except Cancelled Orders

SELECT
    OrderID,
    OrderNumber,
    OrderDate,
    OrderStatus
FROM sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'
AND OrderStatus <> 'Cancelled';


-- 3. Product Price Category

SELECT
    ProductID,
    ProductName,
    UnitPrice,
    CASE
        WHEN UnitPrice < 500 THEN 'Budget'
        WHEN UnitPrice BETWEEN 500 AND 2000 THEN 'Standard'
        ELSE 'Premium'
    END AS PriceCategory
FROM sales.Products;


-- 4. Employee Experience

SELECT
    EmployeeID,
    FirstName,
    HireDate,
    CASE
        WHEN HireDate >= DATEADD(YEAR,-2,GETDATE()) THEN 'New'
        WHEN HireDate >= DATEADD(YEAR,-8,GETDATE()) THEN 'Experienced'
        ELSE 'Senior'
    END AS ExperienceLevel
FROM hr.Employees;