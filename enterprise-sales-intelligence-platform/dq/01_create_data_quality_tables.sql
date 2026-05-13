USE enterprise_sales_dw;
GO


IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dq')
EXEC('CREATE SCHEMA dq');
GO

CREATE TABLE dq.DataQualityLog
(
    DQCheckID INT IDENTITY(1,1) PRIMARY KEY,
    CheckName NVARCHAR(200),
    TableName NVARCHAR(200),
    IssueCount INT,
    CheckTime DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50),
    Details NVARCHAR(MAX)
);
GO
