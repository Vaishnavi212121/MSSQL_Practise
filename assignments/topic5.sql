--5

Select * from hr.Employees;

--Employee count and average salary by department

SELECT
    DepartmentID,
    COUNT(*) AS EmployeeCount,
    AVG(Salary) AS AverageSalary
FROM hr.Employees
GROUP BY DepartmentID;

/*
SELECT
    d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount,
    AVG(e.Salary) AS AverageSalary
FROM hr.Employees e
INNER JOIN hr.Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;
*/

---Departments having average salary greater than 90000

SELECT
    DepartmentID,
    AVG(Salary) AS AverageSalary
FROM hr.Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 90000;

/*
SELECT
    d.DepartmentName,
    AVG(e.Salary) AS AverageSalary
FROM hr.Employees e
INNER JOIN hr.Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING AVG(e.Salary) > 90000;
*/


Select * from sales.Orders

Select * from sales.OrderItems

--Gross sales by year and order status (excluding cancelled orders)
SELECT
    YEAR(o.OrderDate) AS OrderYear,
    o.OrderStatus,
    SUM(oi.Quantity * oi.UnitPrice) AS GrossSales
FROM sales.Orders o
INNER JOIN sales.OrderItems oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus <> 'Cancelled'
GROUP BY
    YEAR(o.OrderDate),
    o.OrderStatus
ORDER BY
    OrderYear,
    o.OrderStatus;

--ROLLUP (Yearly subtotal and grand total)
SELECT
    YEAR(o.OrderDate) AS OrderYear,
    o.OrderStatus,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM sales.Orders o
INNER JOIN sales.OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
ROLLUP
(
    YEAR(o.OrderDate),
    o.OrderStatus
);

--Employees earning above the company average salary
Select * from hr.Employees
Where Salary > (
Select Avg(Salary) From hr.Employees)

--Customers having at least one completed order (EXISTS)
SELECT
    CustomerID,
    CompanyName
FROM sales.Customers c
WHERE EXISTS
(
    SELECT 1
    FROM sales.Orders o
    WHERE o.CustomerID = c.CustomerID
      AND o.OrderStatus = 'Completed'
);

--Employees earning above their department average (Correlated Subquery)
SELECT
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    Salary
FROM hr.Employees e
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM hr.Employees
    WHERE DepartmentID = e.DepartmentID
);

--Top 5 customers by total sales (Inline View)
SELECT TOP (5)
    CustomerID,
    CompanyName,
    TotalSales
FROM
(
    SELECT
        c.CustomerID,
        c.CompanyName,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
    FROM sales.Customers c
    INNER JOIN sales.Orders o
        ON c.CustomerID = o.CustomerID
    INNER JOIN sales.OrderItems oi
        ON o.OrderID = oi.OrderID
    GROUP BY
        c.CustomerID,
        c.CompanyName
) AS CustomerSales
ORDER BY TotalSales DESC;
