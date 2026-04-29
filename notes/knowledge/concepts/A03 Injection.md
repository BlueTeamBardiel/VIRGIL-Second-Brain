# A03 Injection

## What it is
Imagine a restaurant kitchen where a customer can shout commands to the chef by writing them on their order form. If the kitchen doesn't verify what's actually an order versus what's an instruction, the chef might execute malicious commands instead of cooking.

Injection attacks occur when untrusted user input is concatenated into commands (SQL, OS, LDAP, etc.) that are then executed by an interpreter. The interpreter can't distinguish between intended program logic and injected malicious code.

## Why it matters
SQL injection remains the #1 web vulnerability because it bypasses authentication and exposes entire databases. A single unvalidated input field in a login form can let attackers extract passwords, credit cards, and personal data—or modify/delete records entirely. This is why SQLi caused the 2013 Target breach affecting 40 million customers.

## Key facts
- **Parameterized queries (prepared statements)** are the gold standard defense—they treat user input as data, never as executable code
- **Input validation alone is insufficient**—sanitization can be bypassed; you must assume all input is hostile
- **Blind SQL injection** allows attackers to extract data bit-by-bit even when error messages aren't displayed
- **NoSQL databases** are vulnerable too; framework-specific injection exists in MongoDB, Elasticsearch, and others
- **Second-order injection** occurs when malicious input is stored, then later executed by another user

## Related concepts
[[Input Validation]] [[Command Injection]] [[OWASP Top 10]] [[Parameterized Queries]] [[XSS]]