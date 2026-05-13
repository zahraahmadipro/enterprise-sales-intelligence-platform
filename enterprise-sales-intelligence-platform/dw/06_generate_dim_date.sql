USE enterprise_sales_dw;
GO

DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2030-12-31';

WHILE @StartDate <= @EndDate
BEGIN

INSERT INTO dw.DimDate
(
    DateKey,
    FullDate,
    Year,
    Quarter,
    Month,
    Day
)
VALUES
(
    CONVERT(INT, FORMAT(@StartDate,'yyyyMMdd')),
    @StartDate,
    YEAR(@StartDate),
    DATEPART(QUARTER,@StartDate),
    MONTH(@StartDate),
    DAY(@StartDate)
);

SET @StartDate = DATEADD(DAY,1,@StartDate);

END


EXEC dw.Load_DimCustomer;
EXEC dw.Load_DimCategory;
EXEC dw.Load_DimProduct;
