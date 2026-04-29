# PostgreSQL

## What it is
Think of PostgreSQL like a meticulously organized warehouse with a strict librarian who enforces complex rules about what gets stored where — unlike simpler systems that just pile boxes in rows. It is an open-source, object-relational database management system (RDBMS) known for ACID compliance, extensibility, and support for complex queries, stored procedures, and JSON data types.

## Why it matters
During a web application penetration test, a misconfigured PostgreSQL instance running as a privileged OS user can be exploited via SQL injection to execute OS commands using the `COPY TO/FROM PROGRAM` feature — turning a database vulnerability into full server compromise. Defenders must audit PostgreSQL role privileges, disable superuser access for application accounts, and ensure the `pg_hba.conf` file restricts connections to trusted hosts only.

## Key facts
- PostgreSQL runs on default port **5432**; exposure of this port externally is a common misconfiguration finding
- The `\copy` meta-command and `COPY ... TO PROGRAM` feature can execute arbitrary OS commands when the database user has **SUPERUSER** privileges — a critical privilege escalation vector
- PostgreSQL supports **Row-Level Security (RLS)**, allowing fine-grained access control that limits what rows individual users can read or modify
- Authentication is controlled by **pg_hba.conf**, which defines connection rules by IP, user, and database — misconfiguring this to `trust` auth allows passwordless login
- Unlike MySQL, PostgreSQL uses **schemas** as namespaces within a database, meaning improper schema permissions can expose sensitive tables across application boundaries

## Related concepts
[[SQL Injection]] [[Privilege Escalation]] [[Database Hardening]]