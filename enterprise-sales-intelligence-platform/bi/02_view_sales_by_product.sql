USE enterprise_sales_dw;
GO



CREATE OR ALTER VIEW bi.vw_Sales_By_Product
AS
SELECT
    p.ProductName,
    c.CategoryName,
    SUM(f.Quantity) AS TotalQuantitySold,
    SUM(f.SalesAmount) AS TotalRevenue
FROM fact.FactSales f
JOIN dim.DimProduct p
    ON f.ProductKey = p.ProductKey
JOIN dim.DimCategory c
    ON p.CategoryKey = c.CategoryKey
GROUP BY
    p.ProductName,
    c.CategoryName;
GO


