USE enterprise_sales_dw;
GO

CREATE SCHEMA dw;
GO

CREATE TABLE dw.DimCustomer
(
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100)
);
GO

CREATE TABLE dw.DimCategory
(
    CategoryKey INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT,
    CategoryName NVARCHAR(100)
);
GO

CREATE TABLE dw.DimProduct
(
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    ProductName NVARCHAR(100),
    CategoryID INT,
    UnitPrice DECIMAL(10,2)
);
GO

CREATE TABLE dw.DimDate
(
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT
);
GO
