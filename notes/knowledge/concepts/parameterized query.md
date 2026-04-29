# parameterized query

## What it is
Think of it like a Mad Libs template: the structure of the sentence is printed in advance, and user input can only fill the blank — it can never rewrite the sentence itself. Formally, a parameterized query (also called a prepared statement) separates SQL code from user-supplied data by pre-compiling the query structure and binding input values as typed parameters afterward. The database engine treats those bound values as pure data, never as executable code.

## Why it matters
In the 2008 Heartland Payment Systems breach, attackers injected malicious SQL through unparameterized web forms to exfiltrate over 130 million credit card numbers. Had the application used parameterized queries, the injected payload `' OR 1=1 --` would have been treated as a harmless string literal rather than executable SQL logic, and the breach could not have occurred through that vector.

## Key facts
- Parameterized queries are the **primary defense against SQL injection (SQLi)**, one of OWASP's Top 10 vulnerabilities for over a decade.
- They work because the query plan is **compiled before user input arrives** — input is bound as a parameter of a known type, not concatenated into the query string.
- Unlike input sanitization (blacklisting bad characters), parameterized queries are **context-aware and structurally safe** — they don't rely on guessing what's dangerous.
- Supported natively in virtually every modern language/framework: `PreparedStatement` in Java, `PDO` in PHP, `@parameter` syntax in .NET, `%s` with `execute()` in Python's DB-API.
- Parameterized queries do **not** protect against second-order SQL injection if stored data is later used unsafely, or against other injection types (OS command injection, LDAP injection).

## Related concepts
[[SQL injection]] [[input validation]] [[stored procedures]] [[OWASP Top 10]] [[defense in depth]]