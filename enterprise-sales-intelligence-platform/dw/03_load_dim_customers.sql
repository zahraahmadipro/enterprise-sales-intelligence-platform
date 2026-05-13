USE enterprise_sales_dw;
GO

CREATE OR ALTER PROCEDURE dw.Load_DimCustomer
AS
BEGIN

TRUNCATE TABLE dw.DimCustomer;

INSERT INTO dw.DimCustomer
(
    CustomerID,
    FirstName,
    LastName,
    Email
)
SELECT
    CustomerID,
    FirstName,
    LastName,
    Email
FROM enterprise_sales_staging.stg.Customers;

END
GO
