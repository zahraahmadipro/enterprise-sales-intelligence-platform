USE enterprise_sales_staging;
GO

CREATE OR ALTER PROCEDURE stg.Load_Categories_From_OLTP
AS
BEGIN
    TRUNCATE TABLE stg.Categories;

    INSERT INTO stg.Categories
    (
        CategoryID,
        CategoryName
    )
    SELECT
        CategoryID,
        CategoryName
    FROM enterprise_sales_oltp.dbo.Categories;
END
GO


CREATE OR ALTER PROCEDURE stg.Load_Products_From_OLTP
AS
BEGIN
    TRUNCATE TABLE stg.Products;

    INSERT INTO stg.Products
    (
        ProductID,
        ProductName,
        CategoryID,
        UnitPrice
    )
    SELECT
        ProductID,
        ProductName,
        CategoryID,
        UnitPrice
    FROM enterprise_sales_oltp.dbo.Products;
END
GO


CREATE OR ALTER PROCEDURE stg.Load_Orders_From_OLTP
AS
BEGIN
    TRUNCATE TABLE stg.Orders;

    INSERT INTO stg.Orders
    (
        OrderID,
        CustomerID,
        OrderDate
    )
    SELECT
        OrderID,
        CustomerID,
        OrderDate
    FROM enterprise_sales_oltp.dbo.Orders;
END
GO


CREATE OR ALTER PROCEDURE stg.Load_OrderItems_From_OLTP
AS
BEGIN
    TRUNCATE TABLE stg.OrderItems;

    INSERT INTO stg.OrderItems
    (
        OrderItemID,
        OrderID,
        ProductID,
        Quantity,
        UnitPrice
    )
    SELECT
        OrderItemID,
        OrderID,
        ProductID,
        Quantity,
        UnitPrice
    FROM enterprise_sales_oltp.dbo.OrderItems;
END
GO


CREATE OR ALTER PROCEDURE stg.Load_Categories_From_OLTP
AS
BEGIN

TRUNCATE TABLE stg.Categories;

INSERT INTO stg.Categories
(
    CategoryID,
    CategoryName
)
SELECT
    CategoryID,
    CategoryName
FROM enterprise_sales_oltp.production.Categories;

END
GO

CREATE OR ALTER PROCEDURE stg.Load_Products_From_OLTP
AS
BEGIN

TRUNCATE TABLE stg.Products;

INSERT INTO stg.Products
(
    ProductID,
    ProductName,
    CategoryID,
    UnitPrice
)
SELECT
    ProductID,
    ProductName,
    CategoryID,
    UnitPrice
FROM enterprise_sales_oltp.production.Products;

END
GO

CREATE OR ALTER PROCEDURE stg.Load_Orders_From_OLTP
AS
BEGIN

TRUNCATE TABLE stg.Orders;

INSERT INTO stg.Orders
(
    OrderID,
    CustomerID,
    OrderDate
)
SELECT
    OrderID,
    CustomerID,
    OrderDate
FROM enterprise_sales_oltp.sales.Orders;

END
GO

CREATE OR ALTER PROCEDURE stg.Load_OrderItems_From_OLTP
AS
BEGIN

TRUNCATE TABLE stg.OrderItems;

INSERT INTO stg.OrderItems
(
    OrderItemID,
    OrderID,
    ProductID,
    Quantity,
    UnitPrice
)
SELECT
    OrderItemID,
    OrderID,
    ProductID,
    Quantity,
    UnitPrice
FROM enterprise_sales_oltp.sales.OrderItems;

END
GO



