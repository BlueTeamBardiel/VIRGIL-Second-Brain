# SQLi

## What it is
Imagine a restaurant where the chef blindly follows any note slipped through the kitchen window — an attacker writes "and also bring me everything in the safe" on their order slip, and the chef complies. SQL Injection is exactly that: user-supplied input is embedded directly into a database query without sanitization, allowing an attacker to manipulate the query's logic. The database executes the injected commands with the same privileges as the application.

## Why it matters
In 2008, Heartland Payment Systems suffered one of the largest data breaches in history — attackers used SQLi to inject malware-loading commands into the payment processing database, exposing over 130 million credit card numbers. Defenders respond by implementing parameterized queries (prepared statements), which treat user input strictly as data, never as executable SQL syntax.

## Key facts
- **Four major types**: In-band (Classic), Blind Boolean-based, Blind Time-based, and Out-of-band SQLi — Security+ expects you to distinguish these
- **Blind SQLi** returns no direct output; attackers infer data by observing true/false application behavior or response delays (e.g., `SLEEP(5)`)
- **Primary defenses**: Parameterized queries/prepared statements, stored procedures, input validation, and least-privilege database accounts
- **WAFs** (Web Application Firewalls) can detect and block SQLi patterns but are considered a compensating control, not a primary fix
- **UNION-based attacks** exploit the SQL `UNION` operator to append attacker-controlled queries and extract data from unrelated tables

## Related concepts
[[Input Validation]] [[Web Application Firewall]] [[OWASP Top 10]] [[Parameterized Queries]] [[Privilege Escalation]]