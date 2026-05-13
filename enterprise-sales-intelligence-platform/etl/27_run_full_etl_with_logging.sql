ALTER PROCEDURE etl.Run_Full_ETL_With_Logging
AS
BEGIN

DECLARE @RunID INT

INSERT INTO etl.ETL_RunLog (PipelineName, StartTime, Status)
VALUES ('Full_ETL_Pipeline', GETDATE(), 'Running')

SET @RunID = SCOPE_IDENTITY()

BEGIN TRY

-------------------------------------------------
-- STAGING LOAD
-------------------------------------------------

EXEC stg.Load_Customers_From_OLTP
EXEC stg.Load_Categories_From_OLTP
EXEC stg.Load_Products_From_OLTP
EXEC stg.Load_Orders_From_OLTP
EXEC stg.Load_OrderItems_From_OLTP

-------------------------------------------------
-- DIMENSIONS
-------------------------------------------------

EXEC dw.Load_DimCustomer
EXEC dw.Load_DimCategory
EXEC dw.Load_DimProduct

-------------------------------------------------
-- FACT
-------------------------------------------------

EXEC dw.Load_FactSales

-------------------------------------------------
-- DATA QUALITY
-------------------------------------------------

EXEC dq.Check_DimProduct
EXEC dq.Check_FactSales

-------------------------------------------------
-- SUCCESS
-------------------------------------------------

UPDATE etl.ETL_RunLog
SET
    EndTime = GETDATE(),
    Status = 'Success'
WHERE RunID = @RunID

END TRY

BEGIN CATCH

UPDATE etl.ETL_RunLog
SET
    EndTime = GETDATE(),
    Status = 'Failed',
    ErrorMessage = ERROR_MESSAGE()
WHERE RunID = @RunID

END CATCH

END


EXEC etl.Run_Full_ETL_With_Logging;
