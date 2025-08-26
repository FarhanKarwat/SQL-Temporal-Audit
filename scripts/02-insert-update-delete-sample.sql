/* 02-insert-update-delete-sample.sql
   Generates sample history for temporal queries.
*/
USE TemporalDemo;
GO
SET NOCOUNT ON;

-- Insert a few employees
INSERT INTO dbo.Employee (EmployeeID, FirstName, LastName, Title, DepartmentID, Salary)
VALUES (1001,'Asha','Iyer','Developer',10,900000.00),
       (1002,'Rahul','Mehta','QA Engineer',20,700000.00),
       (1003,'Neha','Sharma','Manager',10,1500000.00);
GO

-- Update that creates a history row
WAITFOR DELAY '00:00:02';
UPDATE dbo.Employee SET Salary = Salary + 50000 WHERE EmployeeID = 1001;
GO

-- Another update for multiple versions
WAITFOR DELAY '00:00:02';
UPDATE dbo.Employee SET Title = 'Senior Developer', Salary = Salary + 150000 WHERE EmployeeID = 1001;
GO

-- Delete to move final version into history
WAITFOR DELAY '00:00:02';
DELETE dbo.Employee WHERE EmployeeID = 1002;
GO

SELECT 'Current rows' AS Info, * FROM dbo.Employee;
SELECT 'History rows' AS Info, * FROM dbo.EmployeeHistory ORDER BY EmployeeID, ValidFrom;
