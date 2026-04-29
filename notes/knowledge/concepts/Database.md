# Database

## What it is
Think of a database like a highly organized filing cabinet where every drawer, folder, and document can be instantly retrieved by a librarian who never forgets anything. Precisely, a database is a structured collection of data managed by a Database Management System (DBMS) that allows for efficient storage, retrieval, and manipulation of data through query languages like SQL. Most enterprise applications — from banking to healthcare — rely on relational databases (RDBMS) where data is organized into tables with defined relationships.

## Why it matters
In 2017, Equifax exposed 147 million records because attackers exploited an Apache Struts vulnerability to reach an unpatched, improperly segmented database containing Social Security numbers and financial data. This breach illustrates that the database is almost always the ultimate target — the attacker moves through the network specifically to reach it. Proper database hardening, least-privilege access controls, and encryption at rest directly reduce the blast radius when perimeter defenses fail.

## Key facts
- **SQL Injection (SQLi)** is the #1 database attack vector — unsanitized user input lets attackers execute arbitrary SQL commands, bypassing authentication or exfiltrating entire tables
- **Principle of least privilege** applied to databases means application accounts should only have SELECT/INSERT rights, never DROP or GRANT
- **Encryption at rest** (e.g., Transparent Data Encryption in SQL Server) protects database files if physical media is stolen
- **Database Activity Monitoring (DAM)** logs all queries and flags anomalies like bulk SELECT statements — a key detective control
- **NoSQL databases** (MongoDB, Redis) are not immune to injection — they face NoSQL injection attacks via JSON/BSON manipulation and are often misconfigured with no authentication by default

## Related concepts
[[SQL Injection]] [[Encryption at Rest]] [[Principle of Least Privilege]]