USE enterprise_sales_dw;
GO

CREATE OR ALTER PROCEDURE etl.Run_Full_ETL
AS
BEGIN
    SET NOCOUNT ON;

    PRINT '===== ETL PIPELINE STARTED =====';

    ------------------------------------------------
    -- Load Staging Tables
    ------------------------------------------------
    PRINT 'Loading Staging Tables...';

    EXEC enterprise_sales_staging.stg.Load_Customers_From_OLTP;
    EXEC enterprise_sales_staging.stg.Load_Categories_From_OLTP;
    EXEC enterprise_sales_staging.stg.Load_Products_From_OLTP;
    EXEC enterprise_sales_staging.stg.Load_Orders_From_OLTP;
    EXEC enterprise_sales_staging.stg.Load_OrderItems_From_OLTP;

    ------------------------------------------------
    -- Load Dimensions
    ------------------------------------------------
    PRINT 'Loading Dimension Tables...';

    EXEC dw.Load_DimCustomer;
    EXEC dw.Load_DimCategory;
    EXEC dw.Load_DimProduct;

    ------------------------------------------------
    -- Load Fact Table
    ------------------------------------------------
    PRINT 'Loading Fact Table...';

    EXEC dw.Load_FactSales;

    PRINT '===== ETL PIPELINE COMPLETED SUCCESSFULLY =====';

END
GO


EXEC etl.Run_Full_ETL;
