USE enterprise_sales_dw;
GO

CREATE TABLE dw.FactSales
(
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,

    CustomerKey INT,
    ProductKey INT,
    CategoryKey INT,
    DateKey INT,

    OrderID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalAmount DECIMAL(12,2)
);
GO
