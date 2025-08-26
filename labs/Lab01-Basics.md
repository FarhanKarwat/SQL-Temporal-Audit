# Lab 01 — Temporal Basics

**Goal:** Create a temporal table and observe history being generated.

### Steps

1. Run `scripts/00-setup-database.sql`.
2. Run `scripts/01-create-basic-temporal-table.sql`.
3. Run `scripts/02-insert-update-delete-sample.sql`.
4. Inspect results:
   - `SELECT * FROM dbo.Employee;`
   - `SELECT * FROM dbo.EmployeeHistory ORDER BY EmployeeID, ValidFrom;`
5. Run `scripts/03-time-travel-queries.sql` and try changing the `AS OF` time.
6. (Optional) Add your own UPDATE/DELETE operations and re-run the queries.

### Checkpoint

- Do you see multiple versions for EmployeeID 1001?
- Did the delete for 1002 move the final version into history?
