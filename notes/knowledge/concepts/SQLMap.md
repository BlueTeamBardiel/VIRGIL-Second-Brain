# sqlmap

## What it is
Think of sqlmap as a lockpick set that automatically tests every lock on a door until one opens — except the "locks" are database input fields and the "door" is your entire backend data store. sqlmap is an open-source penetration testing tool that automates the detection and exploitation of SQL injection vulnerabilities, capable of fingerprinting databases, dumping tables, and even escalating to OS-level access.

## Why it matters
During a red team engagement against a retail application, a tester runs sqlmap against a product search field and within minutes extracts the entire customer table — 50,000 credit card numbers, hashed passwords, and PII — without writing a single SQL statement manually. Defenders use sqlmap's behavior signatures to tune WAF rules and IDS alerts, specifically watching for its characteristic payloads like `' OR 1=1--` and time-based blind injection patterns.

## Key facts
- sqlmap supports five core injection techniques: boolean-based blind, time-based blind, error-based, UNION query-based, and stacked queries
- The `--os-shell` flag can spawn an interactive operating system shell if the database user has `FILE` privileges (common on misconfigured MySQL instances)
- sqlmap automatically detects the DBMS type (MySQL, MSSQL, Oracle, PostgreSQL, SQLite) and tailors payloads accordingly
- Using sqlmap without written authorization constitutes unauthorized access under laws like the CFAA — it is illegal on systems you don't own
- Detection evasion options include `--tamper` scripts (e.g., `space2comment.py`) that obfuscate payloads to bypass WAFs and signature-based IDS

## Related concepts
[[SQL Injection]] [[Web Application Firewall]] [[Penetration Testing]] [[Burp Suite]] [[OWASP Top 10]]