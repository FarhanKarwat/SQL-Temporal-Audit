/* 06-indexing-best-practices.sql
   Adds helpful indexes for typical query patterns.
*/
USE TemporalDemo;
GO

-- Current table nonclustered index on DepartmentID for lookups
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.Employee') AND name = 'IX_Employee_Department')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Employee_Department ON dbo.Employee (DepartmentID);
END
GO

-- History table clustered index is already defined in 01 script.
-- Add a covering index for period-only scans (optional)
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.EmployeeHistory') AND name = 'IXH_EmployeeHistory_PeriodOnly')
BEGIN
    CREATE NONCLUSTERED INDEX IXH_EmployeeHistory_PeriodOnly
        ON dbo.EmployeeHistory (ValidFrom, ValidTo) INCLUDE (EmployeeID, Title, DepartmentID, Salary);
END
GO

PRINT 'Indexes created.';
