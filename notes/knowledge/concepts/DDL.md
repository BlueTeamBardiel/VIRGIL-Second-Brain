# DDL

## What it is
Like a city planner who decides where roads, buildings, and zones go before anyone moves in — DDL (Data Definition Language) is the subset of SQL commands that defines the *structure* of a database rather than the data itself. Commands like `CREATE`, `ALTER`, `DROP`, and `TRUNCATE` build, modify, or destroy tables, schemas, and indexes.

## Why it matters
An attacker who achieves sufficient database privileges can use DDL commands to cause catastrophic, hard-to-recover damage — executing `DROP TABLE users;` destroys entire datasets instantly, far more devastating than stealing rows one at a time. This is why principle of least privilege is critical: application accounts should rarely, if ever, need DDL permissions. Security audits should verify that web application database users are restricted to DML (SELECT, INSERT, UPDATE) only, never DDL.

## Key facts
- **Four core DDL commands**: `CREATE` (build new objects), `ALTER` (modify existing), `DROP` (permanently delete), `TRUNCATE` (empty a table without logging individual rows — making forensic recovery harder)
- **TRUNCATE vs DELETE**: TRUNCATE is a DDL operation and typically cannot be rolled back in many RDBMS configurations; DELETE is DML and is transactional — a critical forensic distinction
- **Privilege separation**: Separating DDL privileges (typically DBAs only) from DML privileges (applications) is a core database hardening control mapped to CIS Benchmarks
- **SQL injection scope**: Most SQL injection exploits target DML, but second-order or elevated-privilege injection reaching DDL is classified as a higher-severity finding
- **Audit logging**: DDL events should trigger alerts in a SIEM — legitimate applications almost never issue DDL commands at runtime, making them strong anomaly indicators

## Related concepts
[[SQL Injection]] [[Principle of Least Privilege]] [[Database Activity Monitoring]] [[DML]] [[Privilege Escalation]]