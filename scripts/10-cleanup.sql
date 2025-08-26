/* 10-cleanup.sql
   Tear down all demo objects (useful when you want to reset).
*/
USE master;
GO

IF DB_ID('TemporalDemo') IS NOT NULL
BEGIN
    ALTER DATABASE TemporalDemo SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TemporalDemo;
END
GO

PRINT 'TemporalDemo database dropped.';
