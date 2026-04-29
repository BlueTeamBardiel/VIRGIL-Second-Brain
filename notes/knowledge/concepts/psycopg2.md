# psycopg2

## What it is
Think of psycopg2 as a certified translator sitting between a Python application and a PostgreSQL database — it speaks both languages fluently and hands messages back and forth. Precisely, it is the most widely used PostgreSQL database adapter for Python, implementing the DB-API 2.0 specification to allow Python code to execute SQL queries against PostgreSQL databases.

## Why it matters
When developers use psycopg2 incorrectly — specifically by concatenating user input directly into SQL strings instead of using parameterized queries — they open the door to SQL injection attacks. An attacker targeting a Python/PostgreSQL web application could craft malicious input like `'; DROP TABLE users; --` that gets executed as raw SQL if the developer skips psycopg2's built-in parameter binding (`cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))`). The `%s` placeholder approach is psycopg2's primary defense mechanism, automatically escaping dangerous input before it reaches the database engine.

## Key facts
- **Parameterized queries are the defense**: Using `cursor.execute(query, params)` with tuple arguments prevents SQL injection by separating code from data.
- **String formatting is dangerous**: Using Python's `%` or f-strings to build SQL queries bypasses psycopg2's escaping — a common developer mistake flagged in code reviews.
- **Connection strings carry secrets**: psycopg2 connection strings contain database credentials (`host`, `dbname`, `user`, `password`) and are frequent targets of credential harvesting if exposed in source code or logs.
- **Autocommit behavior matters**: By default, psycopg2 wraps operations in transactions — misconfigured autocommit settings can affect data integrity during incident response or audit logging.
- **Mogrify for debugging**: The `cursor.mogrify()` method shows the final escaped query string, useful for verifying that parameterization is working correctly during security testing.

## Related concepts
[[SQL Injection]] [[Parameterized Queries]] [[Database Credential Exposure]] [[Input Validation]]