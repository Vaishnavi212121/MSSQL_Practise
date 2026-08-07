USE InternMSSQLTraining;

-- 1. Display Employee Full Name

SELECT
    EmployeeID,
    CONCAT(FirstName,' ',LastName) AS FullName
FROM hr.Employees;


-- 2. Employee Email in Uppercase

SELECT
    EmployeeID,
    UPPER(Email) AS EmailUpperCase
FROM hr.Employees;


-- 3. Employee Email in Lowercase

SELECT
    EmployeeID,
    LOWER(Email) AS EmailLowerCase
FROM hr.Employees;


-- 4. Length of Product Name

SELECT
    ProductID,
    ProductName,
    LEN(ProductName) AS ProductNameLength
FROM sales.Products;


-- 5. First 3 Characters of Product Code

SELECT
    ProductID,
    ProductCode,
    LEFT(ProductCode,3) AS Prefix
FROM sales.Products;


-- 6. Last 4 Characters of Product Code

SELECT
    ProductID,
    ProductCode,
    RIGHT(ProductCode,4) AS Suffix
FROM sales.Products;


-- 7. Replace "License" with "Software"

SELECT
    ProductID,
    REPLACE(ProductName,'License','Software') AS NewProductName
FROM sales.Products;


-- 8. Remove Leading and Trailing Spaces

SELECT
    TRIM('     SQL Server Training     ') AS TrimmedText;


-- 1. Current Date and Time

SELECT GETDATE() AS CurrentDateTime;


-- 2. Current System Date and Time

SELECT SYSDATETIME() AS CurrentSystemDateTime;


-- 3. Employee Experience in Years

SELECT
    EmployeeID,
    FirstName,
    HireDate,
    DATEDIFF(YEAR,HireDate,GETDATE()) AS ExperienceYears
FROM hr.Employees;


-- 4. Add 30 Days to Today's Date

SELECT
    GETDATE() AS Today,
    DATEADD(DAY,30,GETDATE()) AS After30Days;


-- 5. Month and Year of Joining

SELECT
    EmployeeID,
    FirstName,
    MONTH(HireDate) AS JoiningMonth,
    YEAR(HireDate) AS JoiningYear
FROM hr.Employees;


-- 1. Replace NULL Phone Number

SELECT
    EmployeeID,
    FirstName,
    ISNULL(Phone,'Not Available') AS PhoneNumber
FROM hr.Employees;


-- 2. Replace NULL Email

SELECT
    EmployeeID,
    ISNULL(Email,'No Email') AS EmailAddress
FROM hr.Employees;


-- 1. Convert Salary to Integer

SELECT
    EmployeeID,
    Salary,
    CAST(Salary AS INT) AS SalaryInteger
FROM hr.Employees;


-- 2. Convert Salary using CONVERT

SELECT
    EmployeeID,
    Salary,
    CONVERT(INT,Salary) AS ConvertedSalary
FROM hr.Employees;


-- 3. Display Current Date in DD/MM/YYYY Format

SELECT
    CONVERT(VARCHAR,GETDATE(),103) AS TodayDate;


-- 4. Display Current Date in YYYY-MM-DD Format

SELECT
    CONVERT(VARCHAR,GETDATE(),23) AS ISODate;


-- 5. Convert GETDATE() to DATE

SELECT
    CAST(GETDATE() AS DATE) AS CurrentDate;
    
    
