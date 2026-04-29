# Database Hardening

## What it is
Think of a database like a hospital pharmacy: powerful drugs are inside, but access requires ID badges, logged sign-ins, and locked cabinets — not just a single front door. Database hardening is the process of systematically reducing a database server's attack surface by removing default accounts, restricting privileges, encrypting sensitive data, and enforcing strict access controls.

## Why it matters
In the 2017 Equifax breach, attackers exploited an Apache vulnerability but then moved laterally to reach databases storing 147 million records — databases that had excessive privilege accounts and unencrypted Social Security Numbers at rest. Proper hardening (principle of least privilege + encryption at rest) would have dramatically limited the blast radius even after initial compromise.

## Key facts
- **Default credentials must be changed immediately** — databases like MySQL ship with a root account and blank password; leaving defaults is one of the most exploited misconfigurations
- **Principle of least privilege (PoLP)** applies per user, per application service account — a web app should only have SELECT/INSERT on its specific schema, never DBA-level access
- **Stored data should be encrypted at rest** using AES-256; encryption in transit requires TLS between application and database server
- **Audit logging must be enabled** — capturing failed logins, privilege escalations, and schema changes is required for both compliance (PCI-DSS, HIPAA) and forensic investigation
- **Remove unnecessary features and stored procedures** — for example, SQL Server's `xp_cmdshell` allows OS-level command execution and should be disabled unless explicitly required

## Related concepts
[[Principle of Least Privilege]] [[SQL Injection]] [[Encryption at Rest]] [[Access Control Lists]] [[Audit Logging]]