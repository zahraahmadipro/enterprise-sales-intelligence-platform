USE enterprise_sales_staging;
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
