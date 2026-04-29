# Data Domain

## What it is
Think of a data domain like a zip code: it defines the valid range of values a piece of data is allowed to hold — "age" must be a positive integer under 150, not "DROP TABLE users." Precisely, a data domain is the set of permissible values, formats, and types that constrain a specific data attribute within a database or system. Enforcing domains is the first line of defense against malformed or malicious input reaching business logic.

## Why it matters
SQL injection attacks frequently succeed because applications fail to enforce data domain constraints at the input layer — an attacker submits `' OR 1=1--` into a field that should only accept a numeric customer ID. A properly enforced domain (integer only, range 1–999999) would reject that input before it ever touched the database query. Domain validation is therefore both a data integrity control and a security boundary.

## Key facts
- Data domains define **type, format, range, and allowed values** (e.g., an IP address field must match IPv4/IPv6 patterns, not free text)
- Violating domain constraints is a root cause of **injection vulnerabilities** (SQL, LDAP, XML, command injection)
- Domain enforcement should occur at **multiple layers**: client-side (UX only), application layer (authoritative), and database layer (last resort)
- In data classification frameworks, domain boundaries help define **data ownership and access control scope** — HR data domain vs. financial data domain
- **Input validation** is the security implementation of domain enforcement; allowlist validation (permit known-good) is stronger than denylist (block known-bad)

## Related concepts
[[Input Validation]] [[SQL Injection]] [[Data Classification]] [[Allowlist vs Denylist]] [[Database Security]]