/* 13-utilities-history-diff-by-key.sql
   Show a timeline of versions for a PK with diffs across key columns.
*/
USE TemporalDemo;
GO

IF OBJECT_ID('dbo.usp_Temporal_HistoryTimeline','P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Temporal_HistoryTimeline;
GO

CREATE PROCEDURE dbo.usp_Temporal_HistoryTimeline
    @EmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        EmployeeID,
        FirstName, LastName, Title, DepartmentID, Salary, Email,
        ValidFrom, ValidTo
    FROM dbo.Employee
    FOR SYSTEM_TIME ALL
    WHERE EmployeeID = @EmployeeID
    ORDER BY ValidFrom;
END
GO
