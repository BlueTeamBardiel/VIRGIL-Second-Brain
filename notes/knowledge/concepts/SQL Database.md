# SQL Database

## What it is
Think of a SQL database like a giant, meticulously organized filing cabinet where each drawer is a table, each folder is a row, and every label on the folder is a column — and a special language (SQL) lets you pull exactly the files you need in milliseconds. Formally, a SQL (Structured Query Language) database is a relational database management system (RDBMS) that stores data in structured tables with defined relationships, queried via standardized commands like SELECT, INSERT, UPDATE, and DELETE. Common implementations include MySQL, Microsoft SQL Server, PostgreSQL, and Oracle.

## Why it matters
SQL injection remains one of the most exploited vulnerability classes in web applications — an attacker who enters `' OR '1'='1` into a login form can bypass authentication entirely by manipulating the underlying SQL query logic. In 2008, Heartland Payment Systems suffered a breach exposing 130 million credit card records because attackers used SQL injection to reach backend databases storing unencrypted card data. Proper parameterized queries and input validation are the primary defenses.

## Key facts
- **SQL Injection (SQLi)** is a top OWASP vulnerability where unsanitized user input alters the intended SQL query structure
- **Parameterized queries / prepared statements** are the gold-standard defense — they separate code from data, making injection structurally impossible
- **Stored procedures** can reduce SQLi risk but are not immune if they dynamically construct queries internally
- **Principle of least privilege** applied to database accounts limits blast radius — a web app account should never have DROP TABLE permissions
- SQL databases typically run on well-known ports: MySQL (3306), MSSQL (1433), PostgreSQL (5432) — critical for firewall hardening and network scanning detection

## Related concepts
[[SQL Injection]] [[Input Validation]] [[Parameterized Queries]] [[Least Privilege]] [[OWASP Top 10]]