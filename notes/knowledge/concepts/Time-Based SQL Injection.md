# Time-Based SQL Injection

## What it is
Like knocking on a wall to find a hidden room — if it's hollow, you hear a delay — time-based SQL injection infers hidden database data by measuring how long a query takes to respond. The attacker injects commands like `SLEEP(5)` or `WAITFOR DELAY` into SQL queries; a noticeable pause confirms the condition is true, even when the application returns no visible output. This is a **blind SQL injection** technique because the attacker never directly sees query results.

## Why it matters
In 2008, attackers used time-based blind SQL injection against Heartland Payment Systems to silently map database structure before exfiltrating 130 million card numbers — the application showed no error messages, making the reconnaissance nearly invisible. Defenders caught none of it in real time because response-time anomalies weren't being monitored at the application layer.

## Key facts
- Uses database-specific delay functions: `SLEEP(n)` in MySQL, `WAITFOR DELAY '0:0:n'` in MSSQL, `pg_sleep(n)` in PostgreSQL
- Classified as **blind/inferential SQL injection** — no data is returned directly in HTTP responses
- Works even when error messages are suppressed, making it dangerous against hardened applications
- Detectable through **anomalous response-time monitoring** and WAF rules that flag delay-function keywords
- Automated tools like **sqlmap** use time-based methods as a fallback when other injection types fail
- Parameterized queries (prepared statements) are the primary mitigation — they prevent injected SQL from being parsed as executable code

## Related concepts
[[Blind SQL Injection]] [[Boolean-Based SQL Injection]] [[SQL Injection]] [[Web Application Firewall]] [[Parameterized Queries]]