# Schema

## What it is
Think of a schema like an architectural blueprint for a database — it defines exactly where the rooms are, what goes in them, and what the doors connect to. Precisely, a schema is the formal structure that defines how data is organized in a database: the tables, columns, data types, relationships, and constraints. It is metadata that describes the shape of data, not the data itself.

## Why it matters
SQL injection attacks frequently target schema enumeration as a first step — attackers use payloads like `UNION SELECT table_name FROM information_schema.tables` to extract the database blueprint before going after sensitive data. Once an attacker knows your schema, they know exactly which tables hold credentials, PII, or financial records and can craft precise extraction queries. Defending against this means restricting access to `information_schema` views and using least-privilege database accounts.

## Key facts
- **Information Schema** is a built-in metadata schema in most SQL databases (MySQL, PostgreSQL, MSSQL) that attackers enumerate to map the database structure.
- **Schema validation** is a key defense in input handling — JSON Schema and XML Schema Definition (XSD) can reject malformed input before it reaches application logic.
- In **NoSQL injection** (e.g., MongoDB), schema-less designs create their own risk: no enforced structure means unexpected field injection can alter query logic.
- **Principle of least privilege** applied to schemas means application accounts should have no `SELECT` rights on `information_schema` or system catalog tables.
- Schema changes (migrations) in CI/CD pipelines are a **supply chain risk vector** — malicious schema alterations can create backdoor columns or drop audit log tables.

## Related concepts
[[SQL Injection]] [[Database Security]] [[Input Validation]] [[Least Privilege]] [[NoSQL Injection]]