# error-based SQLi

## What it is
Imagine asking a librarian a deliberately confusing question — not to get a real answer, but to watch their confused expression reveal exactly which filing system they use. Error-based SQLi works the same way: an attacker injects malformed SQL syntax to trigger verbose database error messages that leak schema names, table names, version strings, and data types directly back in the HTTP response.

## Why it matters
In the 2008 Heartland Payment Systems breach, attackers used SQL injection techniques (including error-based reconnaissance) to enumerate database structure before exfiltrating over 130 million credit card records. Defenders counter this by configuring production databases to suppress verbose errors — replacing stack traces with generic "500 Internal Server Error" pages — removing the attacker's information feedback loop entirely.

## Key facts
- **Technique relies on verbose error output**: functions like MySQL's `EXTRACTVALUE()` or `UPDATEXML()` force the database to embed query results inside error messages
- **DBMS-specific**: payloads differ by platform — `convert(int, @@version)` works on MSSQL, while `exp(~(SELECT*FROM(SELECT version())x))` targets MySQL
- **First-stage recon tool**: attackers use error-based SQLi to map database structure before switching to UNION-based or blind techniques for full data extraction
- **Mitigated by error handling**: disabling `display_errors` in PHP, using custom error pages, and implementing a WAF blocks the information channel even if injection itself succeeds
- **Logged as anomalous**: IDS/SIEM rules trigger on repeated 500 errors from a single IP with SQL keywords in request parameters — a key CySA+ detection scenario

## Related concepts
[[SQL Injection]] [[UNION-based SQLi]] [[Blind SQLi]] [[Database Enumeration]] [[Web Application Firewall]]