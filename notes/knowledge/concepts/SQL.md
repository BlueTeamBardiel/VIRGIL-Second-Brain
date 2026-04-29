# SQL

## What it is
Think of SQL like a librarian who speaks one universal language — you hand them a request slip, and they fetch, sort, or modify any record in the building. SQL (Structured Query Language) is the standardized language used to interact with relational databases, allowing users to create, read, update, and delete (CRUD) data stored in tables. It underpins nearly every web application that stores user data, transactions, or credentials.

## Why it matters
SQL injection (SQLi) remains one of the most exploited attack vectors in web applications — an attacker who enters `' OR '1'='1` into a login field can trick a poorly written query into bypassing authentication entirely and dumping the entire user database. The 2008 Heartland Payment Systems breach, which exposed 130 million credit card numbers, began with SQL injection. Defenders counter this with parameterized queries (prepared statements) and input validation, which separate data from executable code.

## Key facts
- SQL injection is classified under **A03:2021 – Injection** in the OWASP Top 10
- **Blind SQL injection** returns no direct output; attackers infer data through true/false responses or timing delays (`SLEEP()` / `WAITFOR DELAY`)
- **Parameterized queries** (prepared statements) are the primary mitigation — they treat user input as data, never as executable SQL
- Common SQL commands relevant to attacks: `SELECT`, `UNION`, `DROP`, `INSERT`, `--` (comment operator used to truncate queries)
- Web Application Firewalls (WAFs) can detect and block SQLi patterns but are not a substitute for secure coding practices

## Related concepts
[[SQL Injection]] [[Input Validation]] [[OWASP Top 10]] [[Web Application Firewall]] [[Parameterized Queries]]