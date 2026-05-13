USE enterprise_sales_dw;
GO

CREATE OR ALTER PROCEDURE dw.Load_FactSales
AS
BEGIN

TRUNCATE TABLE dw.FactSales;

INSERT INTO dw.FactSales
(
    CustomerKey,
    ProductKey,
    CategoryKey,
    DateKey,
    OrderID,
    Quantity,
    UnitPrice,
    TotalAmount
)

SELECT

dc.CustomerKey,
dp.ProductKey,
dcat.CategoryKey,
dd.DateKey,

o.OrderID,
oi.Quantity,
oi.UnitPrice,
oi.Quantity * oi.UnitPrice

FROM enterprise_sales_staging.stg.Orders o

JOIN enterprise_sales_staging.stg.OrderItems oi
ON o.OrderID = oi.OrderID

JOIN enterprise_sales_staging.stg.Products p
ON oi.ProductID = p.ProductID

JOIN enterprise_sales_dw.dw.DimCustomer dc
ON o.CustomerID = dc.CustomerID

JOIN enterprise_sales_dw.dw.DimProduct dp
ON p.ProductID = dp.ProductID

JOIN enterprise_sales_dw.dw.DimCategory dcat
ON p.CategoryID = dcat.CategoryID

JOIN enterprise_sales_dw.dw.DimDate dd
ON dd.FullDate = CAST(o.OrderDate AS DATE);

END
GO


EXEC dw.Load_FactSales;

--test--
SELECT TOP 10 * FROM dw.FactSales;

SELECT
c.CategoryName,
SUM(f.TotalAmount) AS TotalSales
FROM dw.FactSales f
JOIN dw.DimCategory c
ON f.CategoryKey = c.CategoryKey
GROUP BY c.CategoryName
ORDER BY TotalSales DESC;

