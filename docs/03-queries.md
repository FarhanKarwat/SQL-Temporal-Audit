# Query Patterns (FOR SYSTEM_TIME)

Use `FOR SYSTEM_TIME` with one of the following:

- `AS OF <datetime2>` — point-in-time snapshot
- `FROM <start> TO <end>` — start inclusive, end exclusive
- `BETWEEN <start> AND <end>` — both inclusive
- `CONTAINED IN (<start>, <end>)` — rows fully contained in the interval
- `ALL` — returns current + history together

```sql
-- Point in time
SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF '2025-08-20T10:00:00'
WHERE EmployeeID = 1001;

-- Range
SELECT * FROM dbo.Employee
FOR SYSTEM_TIME FROM '2025-08-20T09:00:00' TO '2025-08-20T12:00:00'
WHERE EmployeeID = 1001;
```

### Time Zones

Use UTC consistently. Example conversion:

```sql
SELECT SYSDATETIMEOFFSET() AS LocalNow,
       SYSUTCDATETIME()    AS UtcNow,
       (SYSDATETIMEOFFSET() AT TIME ZONE 'UTC') AS LocalAsUtc;
```
