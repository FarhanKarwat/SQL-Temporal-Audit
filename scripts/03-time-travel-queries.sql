/* 03-time-travel-queries.sql
   Explore FOR SYSTEM_TIME query forms (variable-based to avoid parser quirks).
*/
USE TemporalDemo;
GO
SET NOCOUNT ON;

DECLARE @Now   DATETIME2 = SYSUTCDATETIME();
DECLARE @AsOf  DATETIME2 = DATEADD(SECOND, -5,  @Now);
DECLARE @From  DATETIME2 = DATEADD(SECOND, -20, @Now);
DECLARE @To    DATETIME2 = @Now;

SELECT @Now AS UtcNow;

-- All versions (current + history)
SELECT * 
FROM dbo.Employee
FOR SYSTEM_TIME ALL
ORDER BY EmployeeID, ValidFrom;

-- Point-in-time snapshot
SELECT * 
FROM dbo.Employee
FOR SYSTEM_TIME AS OF @AsOf
WHERE EmployeeID = 1001;

-- Range (start inclusive, end exclusive)
SELECT * 
FROM dbo.Employee
FOR SYSTEM_TIME FROM @From TO @To
WHERE EmployeeID IN (1001,1002);
