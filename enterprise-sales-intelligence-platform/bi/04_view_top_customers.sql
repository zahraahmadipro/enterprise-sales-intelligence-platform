USE enterprise_sales_dw;
GO

CREATE OR ALTER VIEW bi.vw_Top_Customers
AS
SELECT
   c.FullName,
    SUM(f.SalesAmount) AS TotalSpent
FROM fact.FactSales f
JOIN dim.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.FullName;
GO
