# INSERT

## What it is
Like a waiter who, instead of writing your order on a notepad, just shouts it directly into the kitchen — raw and unfiltered — a database INSERT attack occurs when user-supplied input is passed directly into a SQL `INSERT` statement without sanitization, allowing an attacker to inject malicious SQL code. Precisely, it is a variant of SQL Injection (SQLi) that targets `INSERT INTO` queries, enabling attackers to manipulate what data gets written into a database.

## Why it matters
During user registration flows, an attacker might enter a username like `admin',(SELECT password FROM users WHERE username='admin'),'hacked@email.com')--` to silently write stolen credentials into a new row. This technique has been used to plant backdoor accounts in web applications, effectively giving attackers persistent access without triggering typical authentication alerts.

## Key facts
- INSERT injection targets the `VALUES` clause of a SQL `INSERT` statement, making it distinct from WHERE-clause injection but equally dangerous
- Unlike SELECT-based SQLi, INSERT attacks write attacker-controlled data *into* the database, enabling stored/persistent XSS payloads or privilege escalation
- A successful INSERT injection can create rogue admin accounts, bypass registration logic, or corrupt data integrity
- Parameterized queries (prepared statements) and stored procedures are the primary defenses; they treat user input as data, never as executable SQL
- Web Application Firewalls (WAFs) can detect suspicious INSERT patterns, but obfuscation techniques (e.g., comment injection, case variation) can bypass signature-based rules

## Related concepts
[[SQL Injection]] [[Stored XSS]] [[Parameterized Queries]] [[Web Application Firewall]] [[Input Validation]]