# Injection Prevention

## What it is
Like a restaurant that only accepts orders from a printed menu — never from handwritten notes slipped into the kitchen — injection prevention ensures applications only process *intended* commands, never attacker-supplied code. It is the practice of neutralizing malicious input before it can be interpreted as executable instructions by interpreters like SQL engines, OS shells, or XML parsers. The goal is to eliminate the confusion between **data** and **instructions**.

## Why it matters
In 2017, the Equifax breach exposed 147 million records partly through Apache Struts exploitation involving improper input handling — a reminder that injection flaws consistently rank in OWASP's Top 10. A single unsanitized form field accepting `' OR '1'='1` can bypass authentication entirely, handing an attacker full database access without cracking a single password.

## Key facts
- **Parameterized queries (prepared statements)** are the gold-standard defense against SQL injection — they separate SQL code from user-supplied data at the database driver level
- **Input validation** (allowlisting acceptable characters/formats) is preferred over denylisting because attackers constantly find new bypass encodings
- **Output encoding** (e.g., HTML-encoding `<` as `&lt;`) prevents stored/reflected XSS, a distinct but related injection class
- **Least privilege** on database accounts limits blast radius — an injected query run as a read-only user can't `DROP TABLE`
- OWASP classifies injection as a **CWE-89** (SQL) and **CWE-79** (XSS) vulnerability family; Security+ exam treats input validation as the primary preventive control

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Parameterized Queries]] [[OWASP Top 10]]