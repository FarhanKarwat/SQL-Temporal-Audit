/* 03-time-travel-queries.sql
   Explore FOR SYSTEM_TIME query forms.
*/
USE TemporalDemo;
GO

DECLARE @Now DATETIME2 = SYSUTCDATETIME();
SELECT @Now AS UtcNow;

-- Show all versions (current + history)
SELECT * 
FROM dbo.Employee
FOR SYSTEM_TIME ALL
ORDER BY EmployeeID, ValidFrom;

-- Pick a point-in-time (5 seconds ago)
SELECT * 
FROM dbo.Employee
FOR SYSTEM_TIME AS OF DATEADD(SECOND, -5, @Now)
WHERE EmployeeID = 1001;

-- Time range (inclusive/exclusive boundaries)
SELECT * 
FROM dbo.Employee
FOR SYSTEM_TIME FROM DATEADD(SECOND, -20, @Now) TO @Now
WHERE EmployeeID IN (1001,1002);
