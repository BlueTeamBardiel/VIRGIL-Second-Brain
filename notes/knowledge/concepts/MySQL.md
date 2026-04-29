# MySQL

## What it is
Think of MySQL like a massive filing cabinet where each drawer is a database, each folder is a table, and each document is a row — and SQL is the language you use to tell the librarian what to fetch. MySQL is an open-source relational database management system (RDBMS) that stores structured data in tables and responds to queries written in Structured Query Language (SQL). It's one of the most widely deployed database backends on the internet, powering applications from WordPress blogs to e-commerce platforms.

## Why it matters
SQL injection (SQLi) attacks directly target MySQL and similar databases by inserting malicious SQL syntax into input fields — a login form that accepts `' OR '1'='1` can trick MySQL into returning all user records without valid credentials. This is consistently listed in the OWASP Top 10 and has been responsible for massive breaches, including the 2008 Heartland Payment Systems compromise affecting 130 million card records. Defenders use parameterized queries and prepared statements to neutralize this attack vector entirely.

## Key facts
- MySQL runs on port **3306** by default — a key indicator in network scans and firewall rules
- **SQL injection** is the primary attack vector; classified as CWE-89 and an OWASP Top 10 vulnerability
- MySQL stores credentials in the `mysql.user` table; weak or default credentials (`root` with no password) are a common misconfiguration finding
- Data at rest in MySQL is **not encrypted by default** — Transparent Data Encryption (TDE) must be explicitly configured
- MySQL supports **role-based access control (RBAC)** via `GRANT` and `REVOKE` statements to enforce least privilege on database objects

## Related concepts
[[SQL Injection]] [[Database Hardening]] [[Parameterized Queries]] [[OWASP Top 10]] [[Least Privilege]]