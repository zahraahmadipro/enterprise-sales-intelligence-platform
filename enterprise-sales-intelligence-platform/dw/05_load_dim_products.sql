USE enterprise_sales_dw;
GO

CREATE OR ALTER PROCEDURE dw.Load_DimProduct
AS
BEGIN

TRUNCATE TABLE dw.DimProduct;

INSERT INTO dw.DimProduct
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
FROM enterprise_sales_staging.stg.Products;

END
GO
