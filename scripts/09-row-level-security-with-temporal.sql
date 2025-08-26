/* 09-row-level-security-with-temporal.sql
   Apply RLS so users only see rows for their DepartmentID.
   IMPORTANT: Apply the predicate to BOTH current and history tables.
*/
USE TemporalDemo;
GO

-- Clean previous demo
IF OBJECT_ID('security.fn_DepartmentPredicate','IF') IS NOT NULL DROP FUNCTION security.fn_DepartmentPredicate;
IF EXISTS (SELECT * FROM sys.security_policies WHERE name = 'sp_DepartmentFilter')
    DROP SECURITY POLICY sp_DepartmentFilter;
GO

-- Simple demo: set SESSION_CONTEXT('DeptId') to filter rows.
IF SCHEMA_ID('security') IS NULL EXEC('CREATE SCHEMA security AUTHORIZATION dbo;');
GO

CREATE FUNCTION security.fn_DepartmentPredicate(@DepartmentID INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS fn_result
WHERE CAST(SESSION_CONTEXT(N'DeptId') AS INT) IS NULL
   OR @DepartmentID = CAST(SESSION_CONTEXT(N'DeptId') AS INT);
GO

CREATE SECURITY POLICY sp_DepartmentFilter
ADD FILTER PREDICATE security.fn_DepartmentPredicate(DepartmentID) ON dbo.Employee,
ADD FILTER PREDICATE security.fn_DepartmentPredicate(DepartmentID) ON dbo.EmployeeHistory
WITH (STATE = ON);
GO

-- Demo usage:
EXEC sys.sp_set_session_context @key = N'DeptId', @value = 10;  -- Only DepartmentID = 10 visible

SELECT 'Current filtered' AS Info, * FROM dbo.Employee;
SELECT 'History filtered' AS Info, * FROM dbo.EmployeeHistory;
GO

-- Clear filter
EXEC sys.sp_set_session_context @key = N'DeptId', @value = NULL;
