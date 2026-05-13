/*
=====================================================
ENTERPRISE SALES DATA WAREHOUSE
PROFESSIONAL INDEXING STRATEGY (FINAL, NO-ERROR)
=====================================================
- Dimension B-Tree Indexes (for lookups & filters)
- Fact Clustered Columnstore (for analytics)
- Join Optimization Indexes
- Safe & Idempotent
=====================================================
*/

-----------------------------------------------------
-- DIMENSION INDEXES
-----------------------------------------------------

PRINT 'Creating indexes for DimCustomer...';

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimCustomer') AND name = 'IX_DimCustomer_CustomerID')
    CREATE NONCLUSTERED INDEX IX_DimCustomer_CustomerID
    ON dim.DimCustomer(CustomerID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimCustomer') AND name = 'IX_DimCustomer_Email')
    CREATE NONCLUSTERED INDEX IX_DimCustomer_Email
    ON dim.DimCustomer(Email);
GO


PRINT 'Creating indexes for DimProduct...';

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimProduct') AND name = 'IX_DimProduct_ProductID')
    CREATE NONCLUSTERED INDEX IX_DimProduct_ProductID
    ON dim.DimProduct(ProductID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimProduct') AND name = 'IX_DimProduct_CategoryKey')
    CREATE NONCLUSTERED INDEX IX_DimProduct_CategoryKey
    ON dim.DimProduct(CategoryKey);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimProduct') AND name = 'IX_DimProduct_ProductName')
    CREATE NONCLUSTERED INDEX IX_DimProduct_ProductName
    ON dim.DimProduct(ProductName);
GO


PRINT 'Creating indexes for DimCategory...';

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimCategory') AND name = 'IX_DimCategory_CategoryID')
    CREATE NONCLUSTERED INDEX IX_DimCategory_CategoryID
    ON dim.DimCategory(CategoryID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimCategory') AND name = 'IX_DimCategory_CategoryName')
    CREATE NONCLUSTERED INDEX IX_DimCategory_CategoryName
    ON dim.DimCategory(CategoryName);
GO


PRINT 'Creating indexes for DimDate...';

-- فیلتر مستقیم روی تاریخ‌های تقویمی
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimDate') AND name = 'IX_DimDate_FullDate')
    CREATE NONCLUSTERED INDEX IX_DimDate_FullDate
    ON dim.DimDate(FullDate);
GO

-- فیلترهای سال/ماه برای گزارش‌های پرتکرار
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimDate') AND name = 'IX_DimDate_Year_Month')
    CREATE NONCLUSTERED INDEX IX_DimDate_Year_Month
    ON dim.DimDate(Year, Month);
GO

-- در صورت نیاز به جستجوی نام ماه یا روز هفته:
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimDate') AND name = 'IX_DimDate_MonthName')
    CREATE NONCLUSTERED INDEX IX_DimDate_MonthName
    ON dim.DimDate(MonthName);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dim.DimDate') AND name = 'IX_DimDate_DayOfWeekName')
    CREATE NONCLUSTERED INDEX IX_DimDate_DayOfWeekName
    ON dim.DimDate(DayOfWeekName);
GO


-----------------------------------------------------
-- FACT TABLE PREPARATION (REMOVE PK IF ANY)
-----------------------------------------------------

PRINT 'Checking and removing Primary Key on fact.FactSales (if exists)...';

DECLARE @PKName NVARCHAR(200);
SELECT @PKName = kc.name
FROM sys.key_constraints kc
WHERE kc.parent_object_id = OBJECT_ID('fact.FactSales')
  AND kc.type = 'PK';

IF @PKName IS NOT NULL
BEGIN
    EXEC ('ALTER TABLE fact.FactSales DROP CONSTRAINT [' + @PKName + ']');
END
GO


-----------------------------------------------------
-- FACT COLUMNSTORE INDEX
-----------------------------------------------------

PRINT 'Ensuring Clustered Columnstore Index on fact.FactSales...';

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('fact.FactSales')
      AND name = 'CCI_FactSales'
)
BEGIN
    CREATE CLUSTERED COLUMNSTORE INDEX CCI_FactSales
    ON fact.FactSales;
END
GO


-----------------------------------------------------
-- FACT JOIN PERFORMANCE INDEXES
-----------------------------------------------------

PRINT 'Creating join indexes for fact.FactSales...';

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('fact.FactSales') AND name = 'IX_FactSales_CustomerKey')
    CREATE NONCLUSTERED INDEX IX_FactSales_CustomerKey
    ON fact.FactSales(CustomerKey);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('fact.FactSales') AND name = 'IX_FactSales_ProductKey')
    CREATE NONCLUSTERED INDEX IX_FactSales_ProductKey
    ON fact.FactSales(ProductKey);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('fact.FactSales') AND name = 'IX_FactSales_DateKey')
    CREATE NONCLUSTERED INDEX IX_FactSales_DateKey
    ON fact.FactSales(DateKey);
GO


-----------------------------------------------------
-- FINISH
-----------------------------------------------------

PRINT '========================================';
PRINT 'INDEXING STRATEGY APPLIED SUCCESSFULLY';
PRINT 'FACT TABLE OPTIMIZED WITH COLUMNSTORE';
PRINT 'DIMENSIONS OPTIMIZED FOR LOOKUPS & JOINS';
PRINT '========================================';
