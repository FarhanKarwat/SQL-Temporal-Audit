# FAQ

**Q: Can I update period columns?**  
No. They are **system-managed** (`GENERATED ALWAYS`).

**Q: Do deletes keep history?**  
Yes. The prior version is stored in the history table; the current row is removed.

**Q: Can I drop columns?**  
Turn `SYSTEM_VERSIONING = OFF`, apply matching DDL to both current and history, then turn it back ON.

**Q: What about time zone?**  
Use UTC (`SYSUTCDATETIME()` defaults) to avoid ambiguity.
