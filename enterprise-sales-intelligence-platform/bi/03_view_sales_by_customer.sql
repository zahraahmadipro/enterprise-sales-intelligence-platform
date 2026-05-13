USE enterprise_sales_dw;
GO

CREATE OR ALTER VIEW bi.vw_Sales_By_Customer
AS
SELECT
    c.FullName AS CustomerName,
    c.Email,
    SUM(f.SalesAmount) AS TotalSpent,
    SUM(f.Quantity) AS TotalItems,
    COUNT(*) AS NumberOfOrders
FROM fact.FactSales f
JOIN dim.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.FullName,
    c.Email;
GO
