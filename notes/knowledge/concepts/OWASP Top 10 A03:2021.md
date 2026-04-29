# OWASP Top 10 A03:2021

## What it is
Like a forger slipping a counterfeit painting into an art gallery's legitimate collection, injection attacks smuggle malicious commands into data channels that an application blindly executes as trusted instructions. Injection occurs when untrusted user-supplied input is sent to an interpreter — SQL, OS shell, LDAP, or XML parsers — without proper validation or escaping, causing the interpreter to execute unintended commands.

## Why it matters
In 2021, a poorly secured e-commerce site using raw SQL queries allowed an attacker to enter `' OR '1'='1` into a login field, bypassing authentication entirely and dumping the customer database containing 50,000 credit card numbers. The defense is parameterized queries (prepared statements), which separate code from data so user input can never be interpreted as SQL commands.

## Key facts
- **Moved down from #1** in 2017 to #3 in 2021, merging Cross-Site Scripting (XSS) into this category for the first time
- **SQL injection** is the most common subtype; others include OS command injection, LDAP injection, and NoSQL injection
- **Parameterized queries / prepared statements** are the primary mitigation — they prevent user input from being parsed as executable code
- **Input validation + allowlisting** (not just blocklisting) is a defense-in-depth layer — reject anything that doesn't match an expected format
- **OWASP recommends**: use a safe API, server-side input validation, escape special characters using the specific syntax for the interpreter, and use LIMIT to reduce mass data exposure in SQL

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Parameterized Queries]] [[OWASP Top 10]]