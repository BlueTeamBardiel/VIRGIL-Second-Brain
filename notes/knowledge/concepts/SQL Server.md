# SQL Server

## What it is
Think of SQL Server like a massive filing cabinet with a very obedient clerk — you hand it a note with instructions, and it fetches exactly what you asked for, no questions asked. Microsoft SQL Server is a relational database management system (RDBMS) that stores, retrieves, and manages structured data using Transact-SQL (T-SQL). It runs as a service on Windows (and Linux since 2017) and is a cornerstone of enterprise application backends.

## Why it matters
SQL Server is a prime target in attacks because compromising it often means compromising everything — customer records, credentials, financial data. In a classic SQL injection attack, an attacker manipulates an unsanitized web form input to append `'; DROP TABLE users; --` to a query, executing arbitrary T-SQL commands against the backend SQL Server. The `xp_cmdshell` stored procedure is particularly dangerous: if enabled, it lets attackers execute OS-level commands directly from a SQL query, effectively turning a database breach into full server compromise.

## Key facts
- SQL Server listens on **TCP port 1433** (default) and UDP port 1434 for the SQL Server Browser service — both are common reconnaissance targets
- The built-in **`sa` (system administrator) account** with a blank or weak password is a classic misconfiguration that attackers actively scan for
- **`xp_cmdshell`** is disabled by default since SQL Server 2005; its presence enabled is a red flag during audits
- SQL Server supports **Windows Authentication and SQL Authentication** — Windows Auth is generally more secure due to Kerberos/NTLM integration
- SQL injection against SQL Server can leverage **`WAITFOR DELAY`** for blind time-based injection, confirming vulnerability without visible output

## Related concepts
[[SQL Injection]] [[Privilege Escalation]] [[Database Hardening]]