# Retention & Governance

**SQL Server 2017+** supports a built-in **history retention policy**:

```sql
ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING = ON (
    HISTORY_TABLE = dbo.EmployeeHistory,
    HISTORY_RETENTION_PERIOD = 365 DAYS  -- or MONTHS/YEARS
));
```

- Cleanup is asynchronous and automatic when retention is set.
- On older versions, implement manual cleanup jobs (see `scripts/07-retention-and-cleanup.sql`).

Governance ideas:
- Limit who can query `FOR SYSTEM_TIME ALL` with sensitive columns.
- Apply **Row-Level Security** to both current and history tables consistently (see `scripts/09-row-level-security-with-temporal.sql`).
- Log and document schema changes (temporal does not track DDL).
