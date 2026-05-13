USE enterprise_sales_staging;
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



EXEC stg.Load_Customers_From_OLTP;
EXEC stg.Load_Categories_From_OLTP;
EXEC stg.Load_Products_From_OLTP;
EXEC stg.Load_Orders_From_OLTP;
EXEC stg.Load_OrderItems_From_OLTP;
