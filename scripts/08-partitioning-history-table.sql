/* 08-partitioning-history-table.sql
   Partition history by ValidTo (time-based). Requires Enterprise/Developer editions for partitioning.
*/
USE TemporalDemo;
GO

-- Demo-only: create filegroups/locations as needed in your environment.
-- Create partition function/scheme by year on ValidTo
IF NOT EXISTS (SELECT * FROM sys.partition_functions WHERE name = 'pf_EmployeeHistory_Year')
BEGIN
    CREATE PARTITION FUNCTION pf_EmployeeHistory_Year (datetime2)
    AS RANGE RIGHT FOR VALUES (
        ('2022-01-01'),('2023-01-01'),('2024-01-01'),('2025-01-01'),('2026-01-01')
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.partition_schemes WHERE name = 'ps_EmployeeHistory_Year')
BEGIN
    -- Using [PRIMARY] for all partitions in this demo. In production, map to different filegroups.
    CREATE PARTITION SCHEME ps_EmployeeHistory_Year
    AS PARTITION pf_EmployeeHistory_Year
    ALL TO ([PRIMARY]);
END
GO

-- Recreate clustered index on partition scheme
IF EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.EmployeeHistory') AND name = 'IXH_EmployeeHistory_BK_Period')
    DROP INDEX IXH_EmployeeHistory_BK_Period ON dbo.EmployeeHistory;
GO

CREATE CLUSTERED INDEX IXH_EmployeeHistory_BK_Period
ON dbo.EmployeeHistory (EmployeeID, ValidTo, ValidFrom)
ON ps_EmployeeHistory_Year(ValidTo);
GO

PRINT 'History table partitioned by ValidTo.';
