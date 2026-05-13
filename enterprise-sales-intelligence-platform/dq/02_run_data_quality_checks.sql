USE enterprise_sales_dw;
GO


CREATE OR ALTER PROCEDURE dq.Run_Data_Quality_Checks
AS
BEGIN

SET NOCOUNT ON;

-------------------------------------------------
-- CHECK 1 : NULL KEYS IN FACT TABLE
-------------------------------------------------

DECLARE @IssueCount INT;

SELECT @IssueCount = COUNT(*)
FROM fact.FactSales
WHERE CustomerKey IS NULL
   OR ProductKey IS NULL
   OR DateKey IS NULL;

INSERT INTO dq.DataQualityLog
(CheckName, TableName, IssueCount, Status, Details)
VALUES
(
'Null Keys Check',
'fact.FactSales',
@IssueCount,
CASE WHEN @IssueCount = 0 THEN 'PASS' ELSE 'FAIL' END,
'Fact table should not contain NULL dimension keys'
);


-------------------------------------------------
-- CHECK 2 : ORPHAN FACT RECORDS
-------------------------------------------------

SELECT @IssueCount = COUNT(*)
FROM fact.FactSales f
LEFT JOIN dim.DimCustomer c ON f.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;

INSERT INTO dq.DataQualityLog
(CheckName, TableName, IssueCount, Status, Details)
VALUES
(
'Orphan Customer Check',
'fact.FactSales',
@IssueCount,
CASE WHEN @IssueCount = 0 THEN 'PASS' ELSE 'FAIL' END,
'Fact record references missing customer'
);


-------------------------------------------------
-- CHECK 3 : NEGATIVE SALES
-------------------------------------------------

SELECT @IssueCount = COUNT(*)
FROM fact.FactSales
WHERE SalesAmount < 0;

INSERT INTO dq.DataQualityLog
(CheckName, TableName, IssueCount, Status, Details)
VALUES
(
'Negative Sales Check',
'fact.FactSales',
@IssueCount,
CASE WHEN @IssueCount = 0 THEN 'PASS' ELSE 'FAIL' END,
'Sales amount cannot be negative'
);

END
GO


EXEC dq.Run_Data_Quality_Checks;


SELECT * FROM dq.DataQualityLog
ORDER BY CheckTime DESC;
