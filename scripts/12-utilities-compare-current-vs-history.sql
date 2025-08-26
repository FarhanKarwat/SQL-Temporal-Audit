/* 12-utilities-compare-current-vs-history.sql
   Compare current row with its most recent history version for a PK.
*/
USE TemporalDemo;
GO

IF OBJECT_ID('dbo.usp_Temporal_Compare','P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Temporal_Compare;
GO

CREATE PROCEDURE dbo.usp_Temporal_Compare
    @EmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH LastHistory AS (
        SELECT TOP (1) * 
        FROM dbo.EmployeeHistory
        WHERE EmployeeID = @EmployeeID
        ORDER BY ValidTo DESC, ValidFrom DESC
    )
    SELECT 
        'Current' AS Source, * 
    FROM dbo.Employee WHERE EmployeeID = @EmployeeID
    UNION ALL
    SELECT 
        'History' AS Source, * 
    FROM LastHistory;
END
GO
