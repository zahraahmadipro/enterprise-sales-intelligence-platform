USE enterprise_sales_dw;
GO

IF SCHEMA_ID('etl') IS NULL EXEC('CREATE SCHEMA etl');
GO

IF OBJECT_ID('etl.ETL_Control','U') IS NULL
BEGIN
    CREATE TABLE etl.ETL_Control
    (
        ControlID       INT IDENTITY(1,1) PRIMARY KEY,
        PipelineName    SYSNAME NOT NULL,
        LastWatermark   INT     NULL,   -- DateKey: yyyymmdd
        LastID          BIGINT  NULL,   -- Tie-breaker: e.g., OrderItemID
        LastRunAt       DATETIME2(3) NULL,
        CreatedAt       DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
        ModifiedAt      DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME()
    );

    CREATE UNIQUE INDEX UX_ETL_Control_PipelineName ON etl.ETL_Control(PipelineName);
END
GO
