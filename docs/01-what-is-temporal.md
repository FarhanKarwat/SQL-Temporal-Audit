# What are Temporal Tables? (Beginner)

**System-versioned temporal tables** automatically keep a full history of data changes over time. SQL Server manages two tables:

- **Current table**: holds the latest row version.
- **History table**: holds previous versions with their validity period.

Each row has two hidden semantics managed by SQL Server:

- `PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)`
- `ValidFrom`: when the row version became valid
- `ValidTo`: when it ceased to be valid

You query the table **as of a time** or across a time range using `FOR SYSTEM_TIME`.

### Why Temporal?

- Point-in-time recovery for rows (“time travel”)
- Complete audit history without triggers
- Simplifies Slowly Changing Dimension (SCD Type 2) patterns
- Debugging & forensic analysis

### Not Temporal

- **CDC** and **Change Tracking** are different features.
- Temporal tables store **full prior row versions**. CDC stores **change deltas** from the transaction log.
