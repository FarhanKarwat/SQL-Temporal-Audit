# Enabling Temporal on an Existing Table (Migration)

Steps:
1. Ensure no unsupported data types (avoid deprecated `text/ntext/image`).
2. Add the period columns with defaults (required for existing data).
3. Declare the `PERIOD FOR SYSTEM_TIME`.
4. Turn `SYSTEM_VERSIONING` ON and point to a history table.

See `scripts/04-enable-temporal-on-existing-table.sql` for a safe pattern (with naming, defaults, and validation).
