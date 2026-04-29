# information_schema

## What it is
Think of it as the library catalog of a database — a special built-in database that lists every table, column, user, and privilege inside a relational database system. Precisely, `information_schema` is a standardized, read-only set of views defined by the SQL standard (ISO/IEC 9075) that exposes metadata about the database's own structure, available in MySQL, PostgreSQL, MariaDB, and others.

## Why it matters
During SQL injection attacks, `information_schema` is the attacker's first treasure map. After confirming injectable input, attackers query `information_schema.tables` to enumerate all table names, then `information_schema.columns` to identify columns holding credentials — all without prior knowledge of the database structure. This recon step is documented in virtually every SQLi exploitation chain, including the classic UNION-based extraction technique.

## Key facts
- The query `SELECT table_name FROM information_schema.tables WHERE table_schema=database()` is a textbook SQLi enumeration payload to list all tables in the current database.
- `information_schema.user_privileges` and `information_schema.schema_privileges` reveal what permissions each database account holds — critical for privilege escalation assessment.
- Access to `information_schema` cannot be fully revoked in MySQL; all authenticated users can read it by default, making it a reliable attacker resource.
- WAFs (Web Application Firewalls) commonly block the literal string `information_schema` as a detection rule; attackers bypass this using case variation (`InFoRmAtIoN_sCHeMa`) or whitespace tricks.
- Defenders use `information_schema` legitimately for database auditing — checking for unexpected tables, columns, or overprivileged accounts as part of configuration reviews.

## Related concepts
[[SQL Injection]] [[UNION-based Attack]] [[Database Enumeration]] [[Privilege Escalation]] [[WAF Bypass]]