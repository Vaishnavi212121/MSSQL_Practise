# Topic 1: Introduction to Databases

## 📌 Objective

This topic introduces the fundamentals of databases, Database Management Systems (DBMS), Relational Database Management Systems (RDBMS), Microsoft SQL Server, and SQL Server-specific T-SQL features. It also demonstrates connecting to a SQL Server instance, executing SQL queries, and exploring the provided **InternMSSQLTraining** database.

---

# 1.1 Database, DBMS, and RDBMS

## Theory

### Database
A database is an organized collection of related data stored electronically for efficient access, retrieval, updating, and management.

### DBMS (Database Management System)
A DBMS is software that enables users to create, manage, retrieve, update, and manipulate data in a database.

**Examples**
- Microsoft SQL Server
- MySQL
- Oracle Database
- PostgreSQL

### Responsibilities of a DBMS

- Store and organize data
- Execute SQL queries
- Manage user authentication and security
- Maintain data integrity
- Support backup and recovery

### RDBMS (Relational Database Management System)

An RDBMS stores data in related tables consisting of rows and columns. Relationships between tables are established using Primary Keys and Foreign Keys.

---

## Database Hierarchy

```text
Server
└── Database
    └── Schema
        └── Table
            ├── Columns
            └── Rows
```

---

## Database Components

| Level | Example |
|--------|---------|
| Server | SQL Server Instance |
| Database | InternMSSQLTraining |
| Schema | hr |
| Table | Employees |
| Column | EmployeeID |
| Row | One employee record |

---

## Primary Key

**EmployeeID** uniquely identifies each employee in the `hr.Employees` table.

---

## Two Attributes

- **FirstName** – Stores the employee's first name.
- **Email** – Stores the employee's email address.

---

## Why is it a Relational Database?

The database contains multiple related tables connected using Primary Keys and Foreign Keys. For example, the `DepartmentID` in the `hr.Employees` table references the `DepartmentID` in the `hr.Departments` table, establishing a relationship between employees and departments.

---

## Responsibilities of SQL Server

- Stores and manages relational data.
- Executes SQL queries while maintaining security and data integrity.

---

## Practical Queries Executed

- Display SQL Server name
- Display current database
- List schemas
- List tables
- View Employees table
- View table columns
- Find primary key

---

# 1.2 SQL vs Microsoft SQL Server

## SQL

SQL (Structured Query Language) is the standard language used to create, retrieve, update, and manage data in relational databases.

### Standard SQL Example

```sql
SELECT ProductID,
       ProductCode,
       ProductName,
       Category,
       UnitPrice
FROM sales.Products;
```

---

## Microsoft SQL Server

Microsoft SQL Server is Microsoft's Relational Database Management System (RDBMS) used to create, store, and manage relational databases.

---

## T-SQL (Transact-SQL)

T-SQL is Microsoft's extension of SQL that provides additional programming features and SQL Server-specific functions.

### T-SQL Features Used

- TOP
- GETDATE()
- DB_NAME()

### T-SQL Examples

```sql
SELECT TOP (5) *
FROM sales.Products;

SELECT GETDATE();

SELECT DB_NAME();
```

---

## Difference Between SQL, SQL Server, and T-SQL

| SQL | SQL Server | T-SQL |
|-----|------------|--------|
| Standard query language | Microsoft's RDBMS | SQL Server extension of SQL |
| Used to manipulate data | Stores and manages databases | Adds SQL Server-specific functions and programming capabilities |

---

# 1.3 SQL Server and Instance Connection

## Objective

Verify that a SQL Server instance is running, establish a successful connection, execute SQL queries, and confirm that the training database is available.

---

## Environment

- SQL Server Instance
- Azure Data Studio / SQL Server Management Studio (SSMS)
- InternMSSQLTraining Database

---

## Connection Verification Queries

```sql
-- SQL Server Version
SELECT @@VERSION;

-- Current Login
SELECT SUSER_SNAME();

-- Current Date and Time
SELECT SYSDATETIME();

-- Server Name
SELECT @@SERVERNAME;

-- Current Database
SELECT DB_NAME();
```

---

## Database Verification

```sql
USE InternMSSQLTraining;
GO

SELECT COUNT(*) AS TotalEmployees
FROM hr.Employees;
```

The successful execution of these queries confirms that:

- SQL Server instance is running.
- Connection to the server is successful.
- Authentication is successful.
- The InternMSSQLTraining database is accessible.
- SQL queries execute without errors.

---

## Submission Evidence

Included screenshots:

- SQL Server connection
- Object Explorer showing **InternMSSQLTraining**
- Query output for:
  - `@@VERSION`
  - `SUSER_SNAME()`
  - `SYSDATETIME()`
- Successful execution of the training database

---

# Learning Outcomes

- Understood Database, DBMS, and RDBMS concepts.
- Learned SQL Server architecture and object hierarchy.
- Identified Server, Database, Schema, Table, Column, and Row.
- Explored the `hr.Employees` table and Primary Key.
- Learned the difference between SQL, SQL Server, and T-SQL.
- Executed Standard SQL and SQL Server-specific queries.
- Verified SQL Server connection and database accessibility.
- Successfully connected to the training database and executed SQL scripts.

---

# Technologies Used

- Microsoft SQL Server
- Azure Data Studio / SQL Server Management Studio (SSMS)
- SQL
- Transact-SQL (T-SQL)

---

# Repository Structure

```text
Topic-1/
│
├── README.md
├── Topic1.sql
└── Screenshots/
    ├── object-explorer.png
    ├── employees-table.png
    ├── products-query.png
    ├── query-results.png
    ├── sql-server-connection.png
    ├── version-query.png
    └── setup-success.png
```

---

