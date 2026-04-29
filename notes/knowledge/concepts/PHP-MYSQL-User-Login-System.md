# PHP-MYSQL-User-Login-System

## What it is
Think of it like a bouncer at a club checking a guest list stored in a back room — PHP is the bouncer handling the door, MySQL is the guest list database, and the login form is the velvet rope. Precisely, it is a web authentication architecture where PHP scripts accept user credentials via HTTP forms, query a MySQL database to validate those credentials, and establish session tokens to maintain authenticated state across requests.

## Why it matters
This exact stack is the attack surface for one of the most historically exploited vulnerability classes: SQL injection. An attacker submitting `' OR '1'='1` into a login field can manipulate the underlying MySQL query to return true regardless of credentials, bypassing authentication entirely — a technique responsible for countless data breaches including the 2012 Yahoo Voices compromise.

## Key facts
- **SQL Injection** targets the PHP-MySQL boundary; unparameterized queries like `SELECT * FROM users WHERE username='$_POST[user]'` are the classic vulnerable pattern
- **Prepared statements** (using PDO or MySQLi with bound parameters) are the primary defense, separating code from data at the database driver level
- **Password storage** must use `password_hash()` with bcrypt/Argon2 — MD5 or SHA1 stored passwords remain common forensic findings in breach dumps
- **Session fixation and hijacking** attacks target the PHP session token issued post-login; mitigations include `session_regenerate_id(true)` after authentication
- **OWASP A07 (Identification and Authentication Failures)** and **A03 (Injection)** directly map to this stack's most common weaknesses — both are Security+/CySA+ exam staples

## Related concepts
[[SQL-Injection]] [[Session-Hijacking]] [[Prepared-Statements]] [[Password-Hashing]] [[OWASP-Top-10]]