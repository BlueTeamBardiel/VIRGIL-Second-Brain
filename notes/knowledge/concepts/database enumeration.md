# database enumeration

## What it is
Like a burglar who, after picking a lock, methodically photographs every drawer label before stealing anything — database enumeration is the reconnaissance phase where an attacker systematically extracts structural and content information from a database (table names, column names, user accounts, version strings) before launching deeper exploitation. It typically follows successful SQL injection or credential compromise and maps out what's available to steal.

## Why it matters
During the 2017 Equifax breach, attackers used enumeration techniques after initial access to identify which database tables held Social Security numbers and credit data — without this mapping step, they couldn't have exfiltrated 147 million records with surgical precision. Defenders use the same knowledge to audit database exposure through tools like SQLMap and to ensure least-privilege access controls prevent unauthorized schema discovery.

## Key facts
- **Information Schema** is the primary target: querying `INFORMATION_SCHEMA.TABLES` and `INFORMATION_SCHEMA.COLUMNS` reveals the entire database structure without needing DBA privileges in many RDBMS platforms
- **SQLMap** automates database enumeration via SQL injection, identifying DBMS type, databases, tables, columns, and dumping data with a single command chain
- **Version fingerprinting** (`@@version` in MySQL/MSSQL, `v$version` in Oracle) is typically the first enumeration step — it determines which exploits apply
- **Blind enumeration** occurs when error messages are suppressed; attackers infer data through boolean-based or time-based responses (e.g., `IF` + `SLEEP()` in MySQL)
- **Stored procedures** like `xp_cmdshell` in Microsoft SQL Server can be enumerated and abused to pivot from database access to OS-level command execution

## Related concepts
[[SQL injection]] [[privilege escalation]] [[reconnaissance]] [[information schema]] [[blind SQL injection]]