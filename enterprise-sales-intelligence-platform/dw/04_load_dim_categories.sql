USE enterprise_sales_dw;
GO

CREATE OR ALTER PROCEDURE dw.Load_DimCategory
AS
BEGIN

TRUNCATE TABLE dw.DimCategory;

INSERT INTO dw.DimCategory
(
    CategoryID,
    CategoryName
)
SELECT
    CategoryID,
    CategoryName
FROM enterprise_sales_staging.stg.Categories;

END
GO
