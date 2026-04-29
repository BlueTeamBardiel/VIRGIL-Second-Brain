# RDBMS

## What it is
Think of an RDBMS like a library where every book references every other book through a card catalog — pull one card, and you can trace connections across the entire collection. A Relational Database Management System is software that stores data in structured tables with defined relationships between them, enforcing data integrity through schemas, primary keys, and foreign key constraints. Examples include MySQL, PostgreSQL, Microsoft SQL Server, and Oracle.

## Why it matters
SQL injection attacks directly target RDBMS systems by inserting malicious query syntax into input fields — a classic attack where entering `' OR '1'='1` into a login form can bypass authentication entirely by manipulating the underlying SQL query. Defenders must enforce parameterized queries and prepared statements to prevent user input from ever being interpreted as executable SQL. In a 2017 breach of Equifax, unsanitized input paths contributed to attackers extracting 147 million records from backend relational databases.

## Key facts
- **SQL injection** is the #1 RDBMS attack vector; OWASP consistently ranks it in the Top 10 web vulnerabilities
- RDBMS systems use **ACID properties** (Atomicity, Consistency, Isolation, Durability) to ensure transaction integrity — relevant when assessing data reliability after an incident
- **Privilege escalation** risk: over-privileged database accounts (e.g., using `root` for app connections) amplify the blast radius of a successful injection
- **Database activity monitoring (DAM)** tools watch query patterns in real time and alert on anomalous RDBMS behavior — a core CySA+ defensive control
- Stored procedures can *reduce* injection risk but introduce **second-order injection** vulnerabilities if inputs are stored and later executed unsanitized

## Related concepts
[[SQL Injection]] [[Parameterized Queries]] [[Principle of Least Privilege]] [[Database Activity Monitoring]] [[Data at Rest Encryption]]