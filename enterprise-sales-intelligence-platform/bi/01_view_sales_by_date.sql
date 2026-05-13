USE enterprise_sales_dw;
GO



IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bi')
    EXEC('CREATE SCHEMA bi');
GO


CREATE OR ALTER VIEW bi.vw_Sales_By_Date
AS
SELECT
    d.FullDate,
    d.Year,
    d.Month,
    d.MonthName,
    SUM(f.SalesAmount) AS TotalSales,
    SUM(f.Quantity) AS TotalQuantity,
    COUNT(*) AS NumberOfOrders
FROM fact.FactSales f
JOIN dim.DimDate d
    ON f.DateKey = d.DateKey
GROUP BY
    d.FullDate,
    d.Year,
    d.Month,
    d.MonthName;
GO

