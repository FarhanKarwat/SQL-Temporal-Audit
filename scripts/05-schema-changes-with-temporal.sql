/* 05-schema-changes-with-temporal.sql
   Safe pattern for schema changes requiring history alignment.
*/
USE TemporalDemo;
GO

-- Add a new column to Employee (requires aligning history)
ALTER TABLE dbo.Employee SET (SYSTEM_VERSIONING = OFF);
GO

ALTER TABLE dbo.Employee ADD Email NVARCHAR(256) NULL;
ALTER TABLE dbo.EmployeeHistory ADD Email NVARCHAR(256) NULL;
GO

ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.EmployeeHistory));
GO

PRINT 'Added Email to Employee + EmployeeHistory.';
