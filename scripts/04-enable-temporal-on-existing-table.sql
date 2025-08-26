/* 04-enable-temporal-on-existing-table.sql
   Safely enables temporal on an existing (heap or clustered) table.
   This demo creates a sample table first, then migrates it.
*/
USE TemporalDemo;
GO

-- Demo: Existing table without temporal
IF OBJECT_ID('dbo.Customer','U') IS NOT NULL
BEGIN
    IF (SELECT temporal_type FROM sys.tables WHERE object_id = OBJECT_ID('dbo.Customer')) = 2
        ALTER TABLE dbo.Customer SET (SYSTEM_VERSIONING = OFF);
    DROP TABLE IF EXISTS dbo.CustomerHistory;
    DROP TABLE dbo.Customer;
END
GO

CREATE TABLE dbo.Customer
(
    CustomerID  INT           NOT NULL CONSTRAINT PK_Customer PRIMARY KEY,
    Name        NVARCHAR(200) NOT NULL,
    Email       NVARCHAR(200) NULL,
    Region      NVARCHAR(50)  NULL,
    CreatedUtc  DATETIME2     NOT NULL CONSTRAINT DF_Customer_CreatedUtc DEFAULT SYSUTCDATETIME()
);
GO

INSERT INTO dbo.Customer(CustomerID, Name, Email, Region)
VALUES (1,'Acme Retail','ops@acme.example','West'),
       (2,'Globex','info@globex.example','South');
GO

-- 1) Add period columns with defaults (required for existing data)
ALTER TABLE dbo.Customer
ADD ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL
        CONSTRAINT DF_Customer_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo   DATETIME2 GENERATED ALWAYS AS ROW END   NOT NULL
        CONSTRAINT DF_Customer_ValidTo DEFAULT CONVERT(DATETIME2,'9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);
GO

-- 2) Create explicit history table
CREATE TABLE dbo.CustomerHistory
(
    CustomerID  INT           NOT NULL,
    Name        NVARCHAR(200) NOT NULL,
    Email       NVARCHAR(200) NULL,
    Region      NVARCHAR(50)  NULL,
    CreatedUtc  DATETIME2     NOT NULL,
    ValidFrom   DATETIME2     NOT NULL,
    ValidTo     DATETIME2     NOT NULL
);
GO

-- 3) Turn on system versioning
ALTER TABLE dbo.Customer
SET (SYSTEM_VERSIONING = ON (
    HISTORY_TABLE = dbo.CustomerHistory
));
GO

-- 4) Index history
CREATE CLUSTERED INDEX IXH_CustomerHistory_BK_Period
ON dbo.CustomerHistory (CustomerID, ValidTo, ValidFrom);
GO

PRINT 'Temporal enabled on existing table.';
