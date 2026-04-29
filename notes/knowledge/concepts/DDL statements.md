# DDL statements

## What it is
Think of DDL like a city planner who designs the streets and zones before any residents move in — they don't manage the traffic, they define the layout itself. Data Definition Language (DDL) is the subset of SQL used to create, modify, or destroy the *structure* of a database — tables, schemas, indexes, and views — rather than manipulating the data inside them. Core commands include `CREATE`, `ALTER`, `DROP`, and `TRUNCATE`.

## Why it matters
During a SQL injection attack, an attacker who achieves sufficient privilege escalation can execute DDL commands to cause catastrophic, often irreversible damage — for example, running `DROP TABLE users;` deletes the entire table structure and its data instantly, bypassing transaction logs in some configurations. Unlike DML (INSERT/UPDATE/DELETE), many DDL operations trigger an implicit commit, meaning they cannot be rolled back, making them a favorite for destructive payloads in advanced SQL injection or insider threat scenarios.

## Key facts
- `DROP` removes a table entirely (structure + data); `TRUNCATE` removes all rows but preserves structure — both are DDL, not DML
- DDL statements typically require elevated database privileges (e.g., `db_ddladmin` in SQL Server), making privilege escalation a prerequisite for DDL-based attacks
- Because DDL causes implicit commits in most RDBMS (MySQL, Oracle), changes are permanent and cannot be rolled back within a transaction
- Defense: apply the **principle of least privilege** — application accounts should only have DML rights (SELECT, INSERT, UPDATE), never DDL rights
- `TRUNCATE` often bypasses triggers and foreign key checks, making it faster and more dangerous than `DELETE` for data destruction

## Related concepts
[[SQL Injection]] [[Privilege Escalation]] [[Database Security Controls]]