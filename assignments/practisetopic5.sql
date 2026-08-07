USE InternMSSQLTraining;



-- 1. Total Number of Employees

SELECT COUNT(*) AS TotalEmployees
FROM hr.Employees;


-- 2. Highest, Lowest and Average Salary

SELECT
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary,
    AVG(Salary) AS AverageSalary
FROM hr.Employees;


-- 3. Total Stock Available

SELECT
    SUM(StockQty) AS TotalStock
FROM sales.Products;


-- 4. Total Products in each Category

SELECT
    Category,
    COUNT(*) AS TotalProducts
FROM sales.Products
GROUP BY Category
ORDER BY TotalProducts DESC;


-- 5. Average Product Price by Category

SELECT
    Category,
    AVG(UnitPrice) AS AveragePrice
FROM sales.Products
GROUP BY Category
ORDER BY AveragePrice DESC;


-- 1. Categories having more than 2 products

SELECT
    Category,
    COUNT(*) AS ProductCount
FROM sales.Products
GROUP BY Category
HAVING COUNT(*) > 2;


-- 2. Cities having more than one customer

SELECT
    City,
    COUNT(*) AS CustomerCount
FROM sales.Customers
GROUP BY City
HAVING COUNT(*) > 1;


-- 3. Total Orders by Sales Person

SELECT
    SalesPersonID,
    COUNT(*) AS TotalOrders
FROM sales.Orders
GROUP BY SalesPersonID
ORDER BY TotalOrders DESC;


-- 1. Employees earning more than average salary

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM hr.Employees
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM hr.Employees
);


-- 2. Most Expensive Product(s)

SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM sales.Products
WHERE UnitPrice =
(
    SELECT MAX(UnitPrice)
    FROM sales.Products
);


-- 3. Customers who placed orders

SELECT
    CustomerID,
    CompanyName
FROM sales.Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM sales.Orders
);


-- 4. Customers who have not placed any orders

SELECT
    CustomerID,
    CompanyName
FROM sales.Customers
WHERE CustomerID NOT IN
(
    SELECT CustomerID
    FROM sales.Orders
);


-- 5. Products priced above category average

SELECT
    ProductID,
    ProductName,
    Category,
    UnitPrice
FROM sales.Products P
WHERE UnitPrice >
(
    SELECT AVG(UnitPrice)
    FROM sales.Products
    WHERE Category = P.Category
);
