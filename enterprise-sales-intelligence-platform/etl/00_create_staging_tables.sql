USE enterprise_sales_dw;
GO

CREATE TABLE stg.Customers
(
    CustomerID INT,
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Email NVARCHAR(200)
);
GO

CREATE TABLE stg.Categories
(
    CategoryID INT,
    CategoryName NVARCHAR(200)
);
GO

CREATE TABLE stg.Products
(
    ProductID INT,
    ProductName NVARCHAR(200),
    CategoryID INT,
    UnitPrice DECIMAL(10,2)
);
GO

CREATE TABLE stg.Orders
(
    OrderID INT,
    CustomerID INT,
    OrderDate DATE
);
GO

CREATE TABLE stg.OrderItems
(
    OrderItemID INT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2)
);
GO
