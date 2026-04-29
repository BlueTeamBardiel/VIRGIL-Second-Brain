# CWE-89

## What it is
Imagine a librarian who follows written instructions on a note — but an attacker sneaks extra commands onto that note by adding `'; DROP TABLE books; --`. SQL Injection (SQLi) occurs when untrusted user input is concatenated directly into a SQL query, allowing attackers to alter the query's logic and interact with the database in unintended ways.

## Why it matters
In 2008, Heartland Payment Systems suffered one of the largest data breaches in history — over 130 million credit card numbers stolen — through SQL injection against their web application. A properly parameterized query would have treated the malicious input as data, not executable SQL, preventing the entire breach.

## Key facts
- **Root cause**: String concatenation of user input into SQL queries instead of using parameterized queries or prepared statements
- **Classic payload**: `' OR '1'='1` bypasses login authentication by making the WHERE clause always true
- **Two primary variants**: In-band SQLi (results returned directly), Blind SQLi (true/false or time-based inference when no output is shown)
- **Prevention**: Parameterized queries / prepared statements are the gold-standard fix; input validation and stored procedures with least privilege are defense-in-depth layers
- **OWASP Top 10**: SQLi falls under **A03:2021 – Injection**, consistently ranked among the most critical web vulnerabilities

## Related concepts
[[Input Validation]] [[OWASP Top 10]] [[Prepared Statements]] [[Blind SQL Injection]] [[CWE-20]]