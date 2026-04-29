# OWASP Top 10 A03:2021 - Injection

## What it is
Imagine ordering coffee and the barista writes your name on the cup — but you write your name as "'; DROP TABLE orders; --" and the machine actually executes it. Injection occurs when untrusted user-supplied data is sent to an interpreter (SQL, OS shell, LDAP, XML) as part of a command or query, causing unintended execution. The interpreter cannot distinguish between intended instructions and malicious data because input is never properly validated or sanitized.

## Why it matters
In 2008, Heartland Payment Systems suffered a breach exposing 130 million credit card numbers via SQL injection — attackers inserted malicious SQL through a web form to dump the entire database. Proper parameterized queries (prepared statements) would have completely neutralized the attack by separating data from executable code, treating all input as literal values rather than query logic.

## Key facts
- **SQL Injection** is the most common subtype; others include OS Command Injection, LDAP Injection, and XML/XPath Injection
- **Parameterized queries and stored procedures** are the primary defenses — they bind data to typed placeholders before query compilation
- **Input validation** (allowlisting) and **output encoding** are secondary controls; never rely solely on blacklisting
- Injection moved from **#1 to #3** in OWASP 2021, now combined with Cross-Site Scripting under the broader injection category
- Automated tools like **SQLMap** can detect and exploit SQL injection automatically, making unpatched apps trivially exploitable
- Blind SQL Injection (Boolean-based, Time-based) extracts data **without visible error messages**, bypassing naive defenses

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Parameterized Queries]] [[OWASP Top 10]]