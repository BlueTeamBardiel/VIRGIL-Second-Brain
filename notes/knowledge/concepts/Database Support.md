# Database Support

## What it is
Like a filing cabinet where every drawer needs its own lock, key, and access log, database support refers to the security controls, configurations, and maintenance practices that protect stored data from unauthorized access, corruption, or loss. Specifically, it encompasses authentication mechanisms, encryption, patching, auditing, and access control within database management systems (DBMS) like MySQL, Oracle, or Microsoft SQL Server.

## Why it matters
In 2017, attackers exploited an unpatched Apache Struts vulnerability to breach Equifax's systems and exfiltrate a database containing 147 million Social Security numbers — a direct consequence of poor patch management and inadequate database monitoring. Proper database support (timely patching, query auditing, and least-privilege access) would have dramatically reduced both the attack surface and the blast radius.

## Key facts
- **Least privilege principle**: Database accounts should be granted only the permissions required for their function — application accounts should never have DBA-level access
- **Encryption at rest and in transit**: Sensitive data must be encrypted using AES-256 (at rest) and TLS (in transit); unencrypted databases are a compliance violation under PCI-DSS and HIPAA
- **Database Activity Monitoring (DAM)**: Logs and alerts on all queries, schema changes, and failed login attempts — critical for detecting SQL injection and insider threats
- **Patching cadence**: CVEs targeting database engines (e.g., Oracle Critical Patch Updates) must be applied promptly; unpatched DBs are among the most common breach vectors
- **Default credential removal**: Many DBMSs ship with known default accounts (e.g., `sa` in MSSQL, `scott/tiger` in Oracle) that must be disabled or renamed immediately upon deployment

## Related concepts
[[SQL Injection]] [[Access Control]] [[Data Encryption]] [[Patch Management]] [[Database Activity Monitoring]]