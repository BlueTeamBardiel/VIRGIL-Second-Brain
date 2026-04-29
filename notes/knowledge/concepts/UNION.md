# UNION

## What it is
Like a plumber splicing two separate pipes into one flow, `UNION` merges the result sets of two SELECT queries into a single output stream. In SQL, it is a set operator that appends the rows from a second query onto the results of the first, provided both queries return the same number of columns with compatible data types.

## Why it matters
UNION-based SQL injection is one of the most powerful data extraction techniques an attacker can use against a vulnerable web application. By injecting a payload like `' UNION SELECT username, password FROM users--`, an attacker forces the database to return credential data alongside the application's intended query results — dumping the entire users table directly into the browser response. Defenders use WAF rules and parameterized queries to block this technique.

## Key facts
- **Column count must match:** A UNION attack requires the injected query to have the same number of columns as the original — attackers probe this with `ORDER BY` incrementing or `UNION SELECT NULL,NULL,NULL` patterns.
- **Data type compatibility:** Each column in the injected query must have a compatible type; attackers use `NULL` placeholders to find which columns accept string data for exfiltration.
- **UNION vs. UNION ALL:** `UNION` removes duplicate rows; `UNION ALL` keeps them — attackers often prefer `UNION ALL` to avoid losing data.
- **Error-based detection:** If column counts mismatch, the database throws an error — these error messages can themselves leak schema information.
- **Mitigation:** Parameterized queries (prepared statements) eliminate UNION injection by separating code from data; input validation and least-privilege database accounts reduce blast radius.

## Related concepts
[[SQL Injection]] [[Error-Based SQL Injection]] [[Blind SQL Injection]] [[Parameterized Queries]] [[Web Application Firewall]]