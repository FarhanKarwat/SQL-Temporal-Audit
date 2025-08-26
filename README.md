# SQL Temporal Audit — Beginner to Advanced

A hands‑on guide to **SQL Server System-Versioned Temporal Tables**. This repo includes:

- Step‑by‑step labs and runnable T‑SQL scripts
- Clear docs from basics → advanced
- Best practices for performance, retention, and governance

> **Supported versions**: SQL Server 2016+ (Temporal), SQL Server 2017+ (history retention policy). Azure SQL Database is also supported.

## Quick Start

1. Open **SQL Server Management Studio (SSMS)**.
2. Create a *sandbox* database and objects by running the scripts in `scripts/` **in order**:
   - `00-setup-database.sql`
   - `01-create-basic-temporal-table.sql`
   - `02-insert-update-delete-sample.sql`
   - `03-time-travel-queries.sql`
3. Explore more advanced topics with the remaining scripts.
4. Read `docs/` for explanations and diagrams.

> ⚠️ Always test in a **non‑production** environment first.

## Repository Structure

```
├─ docs/                 # Concept explanations (Beginner → Advanced)
├─ scripts/              # Runnable T‑SQL scripts, numbered in order
├─ labs/                 # Lab guides with step‑by‑step checkpoints
├─ diagrams/             # Mermaid diagrams used in docs
├─ LICENSE
├─ .gitignore
└─ README.md
```

## Common Tasks

- **Add temporal to an existing table** → `scripts/04-enable-temporal-on-existing-table.sql`
- **Change schema safely** → `scripts/05-schema-changes-with-temporal.sql`
- **Set retention policy** (SQL 2017+) → `scripts/07-retention-and-cleanup.sql`
- **Partition history** → `scripts/08-partitioning-history-table.sql`
- **Tune performance** → `scripts/06-indexing-best-practices.sql` and `docs/05-performance-and-indexing.md`

## CLI (optional)

If you use `sqlcmd`:

```bat
sqlcmd -S . -E -i scripts\00-setup-database.sql
sqlcmd -S . -E -i scripts\01-create-basic-temporal-table.sql
```

---

Contributions welcome via PRs and issues.
