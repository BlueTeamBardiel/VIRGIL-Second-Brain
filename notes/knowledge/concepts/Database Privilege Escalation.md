# Database Privilege Escalation

## What it is
Imagine a hotel guest who finds a master keycard left in a supply closet — suddenly they can open every room, not just their own. Database privilege escalation works the same way: an attacker with low-level database access exploits misconfigurations, vulnerabilities, or stored procedures to gain elevated permissions (such as DBA or `sysadmin` rights) far beyond what was originally granted.

## Why it matters
In the 2008 Heartland Payment Systems breach, attackers who gained initial database footholds leveraged SQL injection to escalate privileges and ultimately exfiltrate 130 million credit card numbers. Defenders must audit stored procedures and user-defined functions specifically because these objects can be granted elevated execution contexts that cascade unintended permissions to lower-privileged users.

## Key facts
- **EXECUTE AS** clauses in SQL Server stored procedures can grant a low-privileged user temporary elevated rights during execution — a common escalation vector
- **PUBLIC role misconfiguration** in Oracle and PostgreSQL is a frequent culprit; overly permissive grants to PUBLIC give every authenticated user dangerous capabilities
- **xp_cmdshell** in Microsoft SQL Server, if enabled, allows OS-level command execution from within the database — a critical post-exploitation pivot point
- Principle of Least Privilege (PoLP) applied to database accounts is the primary countermeasure; service accounts should never hold DBA-level permissions
- **Chained privilege escalation** occurs when an attacker moves: low-priv DB user → stored procedure exploit → DBA role → OS shell, each step using the previous foothold

## Related concepts
[[SQL Injection]] [[Principle of Least Privilege]] [[Stored Procedure Abuse]] [[Vertical Privilege Escalation]] [[Database Hardening]]