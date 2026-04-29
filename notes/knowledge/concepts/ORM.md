# ORM

## What it is
Think of ORM like a professional translator who stands between a diplomat (your application) and a foreign official (the database) — the diplomat never speaks the foreign language directly, the translator handles all communication through structured protocols. Object-Relational Mapping is a programming technique that converts data between incompatible type systems (objects in code vs. tables in a database) by abstracting raw SQL queries into method calls on objects.

## Why it matters
SQL injection remains one of the most exploited web vulnerabilities, and ORM frameworks like Hibernate or SQLAlchemy dramatically reduce this attack surface by using parameterized queries automatically instead of concatenating raw user input into SQL strings. However, ORM is not a silver bullet — developers who bypass the ORM to write "raw query escape hatches" (e.g., `session.execute(raw_sql)`) can reintroduce injection vulnerabilities, making these bypass points high-priority targets during code review and penetration testing.

## Key facts
- ORM frameworks use **parameterized queries by default**, which separates data from instructions and is the primary defense against SQL injection (CWE-89)
- **Lazy loading vulnerabilities** in ORMs can expose unintended data relationships if access controls aren't enforced at the application logic layer
- ORM does **not** replace input validation — malformed data can still corrupt business logic or trigger application errors
- Raw query methods in ORMs (e.g., Django's `raw()`, SQLAlchemy's `text()`) must be treated with the same scrutiny as hand-written SQL
- ORM-generated queries can be **verbose and slow**, sometimes pushing developers toward unsafe raw SQL for performance, creating a security/performance tradeoff to document in threat models

## Related concepts
[[SQL Injection]] [[Parameterized Queries]] [[Input Validation]] [[Secure Coding Practices]] [[Database Hardening]]