# DBMS

## What it is
Think of a DBMS like a hyper-organized librarian who not only stores every book in a massive warehouse, but controls who can check books out, enforces the rules for adding new books, and keeps a log of every transaction. A Database Management System (DBMS) is software that creates, reads, updates, and deletes structured data while enforcing access controls, integrity constraints, and concurrent user access. Examples include MySQL, PostgreSQL, Microsoft SQL Server, and Oracle.

## Why it matters
In 2017, the Equifax breach exposed 147 million records because attackers exploited an Apache Struts vulnerability to reach backend Oracle databases that weren't properly segmented or access-controlled. Attackers who can reach an unprotected DBMS can dump entire tables with a single SQL query — making database hardening and least-privilege account configuration critical defensive priorities.

## Key facts
- **SQL injection** is the primary attack vector against DBMS systems; it manipulates query logic by injecting malicious SQL through unsanitized user input
- DBMSs use **roles and privileges** (e.g., `GRANT`, `REVOKE`) to enforce least-privilege — a web app should never connect with a DBA-level account
- **Stored procedures** and **parameterized queries** are the two primary mitigations against SQL injection at the application-database interface
- Most enterprise DBMSs support **audit logging** — recording who queried what data and when — which is critical for forensic investigations and compliance (PCI-DSS, HIPAA)
- **Database Activity Monitoring (DAM)** tools sit inline or passively and alert on anomalous query patterns, functioning like an IDS specifically for database traffic

## Related concepts
[[SQL Injection]] [[Least Privilege]] [[Data at Rest Encryption]] [[Access Control]] [[Audit Logging]]