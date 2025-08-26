# Advanced Patterns

- **SCD Type 2**: Temporal tables natively model SCD2. Use `AS OF` for point-in-time lookups in analytics.
- **Partitioned History**: Keep recent history hot, old partitions cold (archived filegroups).
- **Schema Changes**: For many column changes, temporarily set `SYSTEM_VERSIONING = OFF`, modify both tables, then turn it back ON.
- **Compare with CDC**: Use CDC for integration pipelines that want change deltas; use Temporal when you need full row versioning and easy time travel queries.
- **Troubleshooting**: If you see gaps/overlaps in periods, verify that `SYSTEM_VERSIONING` wasn't disabled during bulk ops.
