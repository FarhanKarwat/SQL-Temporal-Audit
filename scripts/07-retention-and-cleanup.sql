/* 07-retention-and-cleanup.sql
   History retention policy (SQL Server 2017+) and a manual cleanup fallback.
*/
USE TemporalDemo;
GO

-- Attempt to set retention to 365 days (works on SQL 2017+ and Azure SQL)
BEGIN TRY
    ALTER TABLE dbo.Employee
    SET (SYSTEM_VERSIONING = ON (
        HISTORY_TABLE = dbo.EmployeeHistory,
        HISTORY_RETENTION_PERIOD = 365 DAYS
    ));
    PRINT 'Retention policy set to 365 DAYS (if supported by this SQL Server version).';
END TRY
BEGIN CATCH
    PRINT 'Retention policy not supported on this version. Implement manual cleanup.';
END CATCH
GO

/* Manual cleanup example (use with caution, keep periods consistent).
   This deletes very old history rows. Adjust cutoff as needed.
*/
DECLARE @cutoff DATETIME2 = DATEADD(YEAR, -3, SYSUTCDATETIME());

;WITH OldVersions AS (
    SELECT * FROM dbo.EmployeeHistory WITH (READPAST)
    WHERE ValidTo < @cutoff
)
-- Review first
SELECT COUNT(*) AS RowsToDelete FROM OldVersions;

-- Uncomment to delete after review:
-- DELETE H
-- FROM dbo.EmployeeHistory AS H
-- JOIN OldVersions AS O
--   ON O.EmployeeID = H.EmployeeID
--  AND O.ValidFrom   = H.ValidFrom
--  AND O.ValidTo     = H.ValidTo;
