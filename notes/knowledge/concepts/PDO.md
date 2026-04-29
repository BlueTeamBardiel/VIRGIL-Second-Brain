# PDO

## What it is
Think of PDO as a universal TV remote that works with any brand — instead of writing different code for MySQL, PostgreSQL, or SQLite, you use one consistent interface. PHP Data Objects (PDO) is a database abstraction layer in PHP that provides a unified API for interacting with multiple database types, critically supporting **prepared statements** that separate SQL code from user-supplied data.

## Why it matters
In 2008, the Heartland Payment Systems breach exposed 130 million credit card numbers largely through SQL injection — attackers injected malicious SQL into web forms because the application concatenated raw user input directly into queries. Had the application used PDO's prepared statements (`$stmt->bindParam()`), the injected payload would have been treated as literal data, not executable SQL, neutralizing the attack entirely.

## Key facts
- PDO's **prepared statements** use parameterized queries, binding user input as data rather than parsing it as SQL syntax — the primary defense against SQL injection
- PDO supports 12+ database drivers (MySQL, PostgreSQL, SQLite, MSSQL, etc.) through a single consistent interface
- Even with PDO, using `$pdo->query()` with raw string concatenation bypasses parameterization and reintroduces SQL injection risk
- PDO throws catchable `PDOException` objects, but exposing verbose database errors in production leaks schema information to attackers — error messages should be logged, not displayed
- PDO operates in two modes: **emulated** prepared statements (PHP-side, less secure) and **native** prepared statements (database-side, preferred) — set `PDO::ATTR_EMULATE_PREPARES` to `false` for true protection

## Related concepts
[[SQL Injection]] [[Prepared Statements]] [[Input Validation]] [[Database Security]] [[OWASP Top 10]]