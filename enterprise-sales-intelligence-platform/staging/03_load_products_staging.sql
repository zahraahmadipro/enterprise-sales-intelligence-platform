USE enterprise_sales_staging;
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
