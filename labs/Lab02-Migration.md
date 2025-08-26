# Lab 02 — Migrate an Existing Table to Temporal

**Goal:** Turn an existing table into a system-versioned temporal table.

### Steps

1. Run `scripts/04-enable-temporal-on-existing-table.sql`.
2. Insert/Update/Delete a few rows into `dbo.Customer`.
3. Query time-travel on `dbo.Customer` using `FOR SYSTEM_TIME`.

### Checkpoint

- Confirm `sys.tables.temporal_type = 2` for `dbo.Customer`.
- Validate history is written to `dbo.CustomerHistory` on every change.
