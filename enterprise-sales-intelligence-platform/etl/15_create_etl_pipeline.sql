USE enterprise_sales_dw;
GO

CREATE OR ALTER PROCEDURE etl.Run_Pipeline
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RunID INT;
    DECLARE @ErrMsg NVARCHAR(MAX);

    ---------------------------------------------------------------
    -- 1) Start Run
    ---------------------------------------------------------------
    EXEC etl.StartRun
        @PipelineName = N'ESIP Full Pipeline',
        @RunID = @RunID OUTPUT;

    BEGIN TRY

        ---------------------------------------------------------------
        -- 2) STAGING LOAD
        ---------------------------------------------------------------
        EXEC etl.ExecuteStep @RunID,@StepName=N'Load Customers',@SqlCommand=N'EXEC stg.Load_Customers_From_OLTP';
        EXEC etl.ExecuteStep @RunID,@StepName=N'Load Categories',@SqlCommand=N'EXEC stg.Load_Categories_From_OLTP';
        EXEC etl.ExecuteStep @RunID,@StepName=N'Load Products',@SqlCommand=N'EXEC stg.Load_Products_From_OLTP';
        EXEC etl.ExecuteStep @RunID,@StepName=N'Load Orders',@SqlCommand=N'EXEC stg.Load_Orders_From_OLTP';
        EXEC etl.ExecuteStep @RunID,@StepName=N'Load OrderItems',@SqlCommand=N'EXEC stg.Load_OrderItems_From_OLTP';

        ---------------------------------------------------------------
        -- 3) DIMENSIONS
        ---------------------------------------------------------------
        EXEC etl.ExecuteStep @RunID,@StepName=N'Upsert DimCustomer',@SqlCommand=N'EXEC dim.Load_DimCustomer_Upsert';
        EXEC etl.ExecuteStep @RunID,@StepName=N'Upsert DimCategory',@SqlCommand=N'EXEC dim.Load_DimCategory_Upsert';
        EXEC etl.ExecuteStep @RunID,@StepName=N'Upsert DimProduct',@SqlCommand=N'EXEC dim.Load_DimProduct_Upsert';
        EXEC etl.ExecuteStep @RunID,@StepName=N'Load DimDate',@SqlCommand=N'EXEC dim.Load_DimDate';

        ---------------------------------------------------------------
        -- 4) FACT
        ---------------------------------------------------------------
        EXEC etl.ExecuteStep @RunID,@StepName=N'Load FactSales',@SqlCommand=N'EXEC fact.Load_FactSales_Incremental';

        ---------------------------------------------------------------
        -- 5) DATA QUALITY
        ---------------------------------------------------------------
        EXEC dq.Check_DimCustomer @RunID=@RunID;
        EXEC dq.Check_DimProduct  @RunID=@RunID;
        EXEC dq.Check_FactSales   @RunID=@RunID;

        ---------------------------------------------------------------
        -- 6) DQ SUMMARY
        ---------------------------------------------------------------
        EXEC dq.Build_DQ_Summary @RunID=@RunID;

        ---------------------------------------------------------------
        -- 7) END SUCCESS
        ---------------------------------------------------------------
        EXEC etl.EndRun
            @RunID=@RunID,
            @Status=N'Success';

    END TRY
    BEGIN CATCH

        SET @ErrMsg = ERROR_MESSAGE();

        EXEC etl.EndRun
            @RunID=@RunID,
            @Status=N'Failed',
            @ErrorMessage=@ErrMsg;

        THROW;

    END CATCH
END
GO


EXEC etl.Run_Pipeline;
