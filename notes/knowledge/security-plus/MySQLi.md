# MySQLi

## What it is
Think of MySQLi as an upgraded telephone operator between your PHP application and a MySQL database — one who now demands callers prove their identity before connecting them. MySQLi (MySQL Improved) is a PHP extension that provides an enhanced, more secure interface for interacting with MySQL databases, replacing the deprecated `mysql_` functions. Its critical security upgrade is native support for **prepared statements**, which structurally separate SQL commands from user-supplied data.

## Why it matters
Before MySQLi's prepared statements became standard practice, attackers routinely exploited classic SQL injection by injecting payloads like `' OR '1'='1` into login forms, bypassing authentication entirely and dumping databases. A developer using `mysqli_prepare()` with parameterized queries renders this attack class ineffective because the database engine receives the query structure *before* any user input arrives, making malicious input treated as literal data rather than executable SQL. This distinction is the difference between a breached database and a hardened application.

## Key facts
- **Two interfaces**: MySQLi supports both procedural (`mysqli_query()`) and object-oriented (`$mysqli->query()`) syntax — OOP style is preferred in modern secure coding standards.
- **Prepared statements** bind parameters with `bind_param()`, using type specifiers (`s` = string, `i` = integer), preventing SQL injection at the architectural level.
- **Not a firewall substitute**: MySQLi prevents injection in *your* code but won't stop injections in third-party plugins or misconfigured stored procedures.
- **Real escape string**: `mysqli_real_escape_string()` is a fallback sanitization method but is considered weaker than prepared statements — avoid treating it as equivalent.
- **Deprecated predecessor**: `mysql_*` functions were removed in PHP 7.0; any legacy codebase still using them is immediately flagged as a high-risk vulnerability during code reviews.

## Related concepts
[[SQL Injection]] [[Prepared Statements]] [[Input Validation]] [[OWASP Top 10]]