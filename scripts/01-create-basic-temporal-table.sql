/* 01-create-basic-temporal-table.sql
   Creates a basic system-versioned temporal table and explicit history table.
*/
USE TemporalDemo;
GO

-- Drop if re-running
IF OBJECT_ID('dbo.Employee','U') IS NOT NULL
BEGIN
    ALTER TABLE dbo.Employee SET (SYSTEM_VERSIONING = OFF);
    DROP TABLE IF EXISTS dbo.EmployeeHistory;
    DROP TABLE dbo.Employee;
END
GO

-- Create current table with PERIOD columns
CREATE TABLE dbo.Employee
(
    EmployeeID      INT             NOT NULL CONSTRAINT PK_Employee PRIMARY KEY,
    FirstName       NVARCHAR(100)   NOT NULL,
    LastName        NVARCHAR(100)   NOT NULL,
    Title           NVARCHAR(100)   NULL,
    DepartmentID    INT             NULL,
    Salary          DECIMAL(18,2)   NOT NULL,
    ValidFrom       DATETIME2       GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo         DATETIME2       GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = OFF);
GO

-- Create explicit history table so we can index/name it as we like
CREATE TABLE dbo.EmployeeHistory
(
    EmployeeID      INT             NOT NULL,
    FirstName       NVARCHAR(100)   NOT NULL,
    LastName        NVARCHAR(100)   NOT NULL,
    Title           NVARCHAR(100)   NULL,
    DepartmentID    INT             NULL,
    Salary          DECIMAL(18,2)   NOT NULL,
    ValidFrom       DATETIME2       NOT NULL,
    ValidTo         DATETIME2       NOT NULL
);
GO

-- Turn on system versioning
ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING = ON (
    HISTORY_TABLE = dbo.EmployeeHistory
));
GO

-- Suggested history clustered index
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.EmployeeHistory') AND name = 'IXH_EmployeeHistory_BK_Period')
BEGIN
    CREATE CLUSTERED INDEX IXH_EmployeeHistory_BK_Period
    ON dbo.EmployeeHistory (EmployeeID, ValidTo, ValidFrom);
END
GO

PRINT 'Employee temporal table created.';
