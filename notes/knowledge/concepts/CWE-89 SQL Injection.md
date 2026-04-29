# CWE-89 SQL Injection

## What it is
Imagine ordering coffee and saying "I'll have a latte — and also fire everyone in the building." SQL injection works the same way: user input escapes its intended role and becomes executable command. Formally, it occurs when untrusted data is concatenated directly into a SQL query, allowing an attacker to alter the query's logic, retrieve unauthorized data, or modify the database.

## Why it matters
In 2008, Heartland Payment Systems suffered one of the largest breaches in history — over 130 million credit card numbers stolen — traced back to SQL injection against their web application. Proper parameterized queries would have treated the malicious input as literal data rather than executable SQL, preventing the entire attack chain.

## Key facts
- **Root cause**: String concatenation builds queries dynamically (e.g., `"SELECT * FROM users WHERE name='" + input + "'"`) instead of using parameterized statements or prepared statements.
- **Classic payload**: `' OR '1'='1` turns a login query into one that always evaluates true, bypassing authentication without knowing any credentials.
- **Blind SQLi** extracts data without error messages — attackers infer information from application behavior (true/false responses or time delays via `SLEEP()`).
- **Primary defense**: Parameterized queries / prepared statements — input is bound as a typed parameter, never interpreted as SQL syntax. Input validation and stored procedures with least-privilege DB accounts are secondary layers.
- **OWASP Top 10**: SQL injection has ranked #1 or in the top 3 for most of OWASP's history; it falls under the broader "Injection" category (A03:2021).

## Related concepts
[[Input Validation]] [[Parameterized Queries]] [[OWASP Top 10]] [[CWE-78 OS Command Injection]] [[Least Privilege]]