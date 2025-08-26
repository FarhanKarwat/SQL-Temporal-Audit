# Lab 03 — Advanced: Retention, Partitioning, and RLS

**Goal:** Explore production-oriented features.

### Steps

1. Run `scripts/06-indexing-best-practices.sql`.
2. Run `scripts/07-retention-and-cleanup.sql` (note: retention requires SQL 2017+).
3. Run `scripts/08-partitioning-history-table.sql` on Developer/Enterprise edition.
4. Run `scripts/09-row-level-security-with-temporal.sql` and experiment with `SESSION_CONTEXT`.

### Checkpoint

- Verify history table has the partitioned clustered index.
- Verify filtered results under RLS when `DeptId` is set.
