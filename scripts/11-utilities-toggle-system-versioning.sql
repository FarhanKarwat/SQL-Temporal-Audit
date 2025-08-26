/* 11-utilities-toggle-system-versioning.sql
   Helper proc: Toggle SYSTEM_VERSIONING for a given table, preserving history link.
*/
USE TemporalDemo;
GO

IF OBJECT_ID('dbo.usp_Temporal_Toggle','P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Temporal_Toggle;
GO

CREATE PROCEDURE dbo.usp_Temporal_Toggle
    @SchemaName SYSNAME,
    @TableName  SYSNAME,
    @Enable     BIT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @full NVARCHAR(512) = QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName);
    DECLARE @history NVARCHAR(512);

    SELECT @history = QUOTENAME(OBJECT_SCHEMA_NAME(history_object_id)) + '.' + QUOTENAME(OBJECT_NAME(history_object_id))
    FROM sys.tables WHERE object_id = OBJECT_ID(@full);

    IF @Enable = 0
    BEGIN
        DECLARE @sql NVARCHAR(MAX) = N'ALTER TABLE ' + @full + N' SET (SYSTEM_VERSIONING = OFF);';
        EXEC sp_executesql @sql;
    END
    ELSE
    BEGIN
        IF @history IS NULL
        BEGIN
            RAISERROR('History table not found; create it first.', 16, 1);
            RETURN;
        END
        DECLARE @sql NVARCHAR(MAX) = N'ALTER TABLE ' + @full + N' SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE=' + @history + N'));';
        EXEC sp_executesql @sql;
    END
END
GO
