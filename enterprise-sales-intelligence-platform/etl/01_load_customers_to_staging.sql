USE enterprise_sales_staging;
GO

CREATE OR ALTER PROCEDURE stg.Load_Customers_From_OLTP
AS
BEGIN

    SET NOCOUNT ON;

    -------------------------------------------------
    -- Step 1: Clear staging table
    -------------------------------------------------
    TRUNCATE TABLE stg.Customers;

    -------------------------------------------------
    -- Step 2: Load data from OLTP
    -------------------------------------------------
    INSERT INTO stg.Customers (
        CustomerID,
        FirstName,
        LastName,
        Email,
        Phone,
        CreatedDate,
        LastModifiedDate
    )
    SELECT
        CustomerID,
        FirstName,
        LastName,
        Email,
        Phone,
        CreatedDate,
        LastModifiedDate
    FROM enterprise_sales_oltp.sales.Customers;

END
GO

--TEST
EXEC stg.Load_Customers_From_OLTP;
SELECT * 
FROM enterprise_sales_staging.stg.Customers;