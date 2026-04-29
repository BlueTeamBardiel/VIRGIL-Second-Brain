# Cursor

## What it is
Like a blinking text-insertion point in a word processor that tells the system "start writing here," a database or file cursor is a pointer that tracks the current position within a result set or data stream during sequential processing. It is a control structure that enables programs to iterate row-by-row through query results rather than loading everything into memory at once.

## Why it matters
Cursor-based vulnerabilities appear in SQL injection attacks where an attacker manipulates stored procedures that use cursors to iterate through sensitive tables — for example, exfiltrating every row of a `users` table one record at a time through a time-based blind injection loop. Defenders monitoring for abnormally high numbers of sequential database fetch operations can detect this pattern as an indicator of compromise.

## Key facts
- Cursors are commonly exploited inside **stored procedures**; if a stored procedure accepts unsanitized user input and uses a cursor to loop through data, the entire dataset can be enumerated through injection
- **Implicit cursors** are created automatically by the database engine for single-row operations; **explicit cursors** are programmer-declared and represent a larger attack surface due to custom logic
- Cursor-based data exfiltration can evade simple rate-limiting because each fetch appears as a legitimate, small database read
- In Oracle databases, the `DBMS_SQL` package allows dynamic cursor construction — a frequent target in privilege escalation attacks
- Security audits should review stored procedures for cursors operating on sensitive tables without proper **parameterized inputs** or role-based access controls

## Related concepts
[[SQL Injection]] [[Stored Procedures]] [[Blind SQL Injection]] [[Database Hardening]] [[Privilege Escalation]]