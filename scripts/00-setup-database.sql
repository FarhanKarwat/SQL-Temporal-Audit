/* 00-setup-database.sql
   Creates a sandbox database and schema for temporal demos.
*/
SET NOCOUNT ON;

IF DB_ID('TemporalDemo') IS NULL
BEGIN
    PRINT 'Creating database TemporalDemo...';
    CREATE DATABASE TemporalDemo;
END
GO

USE TemporalDemo;
GO

IF SCHEMA_ID('audit') IS NULL
BEGIN
    EXEC('CREATE SCHEMA audit AUTHORIZATION dbo;');
END
GO

PRINT 'Database and schema ready.';
