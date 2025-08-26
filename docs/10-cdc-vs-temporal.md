# CDC vs Temporal Tables (SQL Server)

This doc explains when to use **Change Data Capture (CDC)** vs **System-Versioned Temporal Tables**.

## Purpose
- **CDC**: Capture *row-level changes* (insert/update/delete) from the transaction log for **data integration** and ETL pipelines.
- **Temporal**: Keep **full prior row versions** automatically, enabling **time-travel queries** (`FOR SYSTEM_TIME`).

## Storage
- **CDC**: Stores **change deltas** in CDC system tables (per table) with metadata about the change.
- **Temporal**: Stores **entire previous row** in a **history table** managed by SQL Server.

## Queries
- **CDC**: Use table-valued functions like `cdc.fn_cdc_get_all_changes_<capture_instance>` to get changes over LSN/time.
- **Temporal**: Query with `FOR SYSTEM_TIME AS OF/FROM..TO/BETWEEN/ALL` to reconstruct the table at a point or range.

## Overhead
- **CDC**: Minimal on writes; async log reader job does the heavy lifting. Extra storage for change tables.
- **Temporal**: On every update/delete, SQL writes the prior version to history → more write amplification and storage.

## Auditing
- **CDC**: Good for integration; not “as-is” auditing (column defaults may differ; deletes can be hard to reason about).
- **Temporal**: Excellent for **audit/history** of data values as they looked to the app at each change.

## Retention
- **CDC**: Retention is configurable per capture instance via cleanup job.
- **Temporal**: Built-in `HISTORY_RETENTION_PERIOD` (SQL 2017+) or manual cleanup.

## Schema Changes
- **CDC**: Requires managing capture instances; re-init after schema changes.
- **Temporal**: For many DDL changes, toggle `SYSTEM_VERSIONING` OFF, update both current & history, back ON.

## Security
- Apply RLS and column-level security to **both** current/history (Temporal) or base/CDC tables (CDC).
- Limit access to CDC schema or history tables to least privilege.

## When to choose which?
- Choose **CDC** when feeding downstream systems, Kafka, or ETL that need *change streams*.
- Choose **Temporal** when you need **point-in-time** querying and **complete row history** for analytics or audit.

## Can I use both?
Yes. It’s common to enable **Temporal** for easy audit + **CDC** for integration streams. Be mindful of storage and index design.
