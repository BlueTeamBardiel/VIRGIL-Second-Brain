# NoSQL injection

## What it is
Like a bouncer who only checks for a specific fake ID format but gets confused when you hand them a laminated grocery list, NoSQL databases enforce looser query structures — which attackers exploit by injecting operators instead of strings. NoSQL injection is an attack where malicious input manipulates query logic in non-relational databases (MongoDB, CouchDB, Redis) by abusing their native query operators (e.g., `$gt`, `$where`) rather than SQL syntax. It bypasses authentication or exfiltrates data by turning user-supplied input into query control structures.

## Why it matters
In 2022, attackers targeting MongoDB-backed login forms used the payload `{"username": {"$gt": ""}, "password": {"$gt": ""}}` to match *all* users, effectively bypassing authentication entirely without knowing any credentials. This class of attack is increasingly relevant as organizations migrate from relational databases to document stores — but carry forward SQL-era assumptions about input safety.

## Key facts
- NoSQL injection exploits **operator injection** (e.g., `$ne`, `$gt`, `$where` in MongoDB) rather than SQL metacharacters like `'` or `--`
- Unlike SQL injection, NoSQL injection often arrives via **JSON body parameters** in REST APIs, not URL query strings
- The `$where` operator in MongoDB allows JavaScript execution, enabling **server-side JavaScript injection** — a higher-severity variant
- Defenses include **schema validation**, strict type-checking (rejecting objects where strings are expected), and using ODMs (like Mongoose) with whitelisted fields
- Classified under **A03:2021 – Injection** in the OWASP Top 10; examiners may ask you to distinguish it from SQL injection by data model, not just syntax

## Related concepts
[[SQL Injection]] [[OWASP Top 10]] [[Input Validation]] [[API Security]] [[Server-Side JavaScript Injection]]