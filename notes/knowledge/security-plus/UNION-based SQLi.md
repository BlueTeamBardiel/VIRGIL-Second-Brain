# Union-based SQLi

## What it is
Imagine a restaurant where you order soup, but you secretly staple a second order form to yours that reads "also bring me everything in the safe." Union-based SQL injection works the same way: the attacker appends a `UNION SELECT` statement to a legitimate query, forcing the database to append rows from attacker-chosen tables to the original result set. This technique requires the injected query to match the column count and data types of the original query.

## Why it matters
In a 2023-style web app attack, a threat actor targeting a login portal injects `' UNION SELECT username, password, NULL FROM admin_users--` into a product search field. If the application reflects query results in the page body, the attacker receives a dump of admin credentials alongside normal product listings — no brute force required. Defenders use parameterized queries and Web Application Firewalls (WAFs) with UNION keyword detection to block this vector.

## Key facts
- **Column count matching is mandatory** — the attacker must identify the exact number of columns in the original query, typically using `ORDER BY` incrementing or `UNION SELECT NULL, NULL...` probing.
- **Data type alignment** matters — string data must align with string columns; mismatches cause database errors that reveal schema information.
- **Error messages are the attacker's roadmap** — verbose database errors accelerate column-count and type enumeration significantly.
- **UNION-based SQLi is an in-band technique** — results return directly in the HTTP response, distinguishing it from blind/inferential SQLi methods.
- **Mitigation is the same across SQLi types** — prepared statements with parameterized queries remain the gold-standard defense; input sanitization alone is insufficient.

## Related concepts
[[SQL Injection]] [[Blind SQL Injection]] [[Error-based SQLi]] [[Parameterized Queries]] [[Web Application Firewall]]