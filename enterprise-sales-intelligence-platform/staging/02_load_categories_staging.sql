USE enterprise_sales_staging;
GO

CREATE OR ALTER PROCEDURE stg.Load_Categories_From_OLTP
AS
BEGIN

TRUNCATE TABLE stg.Categories;

INSERT INTO stg.Categories
(
    CategoryID,
    CategoryName
)
SELECT
    CategoryID,
    CategoryName
FROM enterprise_sales_oltp.production.Categories;

END
GO
