# MariaDB

## What it is
Think of MariaDB as a fork in a river — it branched off from MySQL in 2009 when Oracle acquired MySQL, ensuring the water kept flowing freely under open-source control. Precisely, MariaDB is an open-source relational database management system (RDBMS) that stores structured data in tables and responds to SQL queries, serving as a drop-in replacement for MySQL in most LAMP/LEMP stacks.

## Why it matters
MariaDB is a frequent SQL injection target because developers often assume default configurations are secure — but default installations may expose port 3306 externally and use weak or blank root passwords. An attacker who discovers an internet-facing MariaDB instance with default credentials can dump entire databases containing PII, password hashes, or session tokens, bypassing application-layer authentication entirely. Defenders must audit firewall rules to ensure 3306 is never publicly reachable and enforce credential hardening via `mysql_secure_installation`.

## Key facts
- **Default port: 3306** — same as MySQL; a common reconnaissance finding in network scans (Nmap service detection identifies it as `mysql`)
- **SQL injection risk**: Unsanitized input passed to MariaDB queries is one of the top OWASP vulnerabilities; parameterized queries are the primary mitigation
- **Authentication plugin**: MariaDB uses `unix_socket` authentication by default on some distros, meaning OS-level account compromise directly grants DB access
- **Privilege escalation vector**: Misconfigured `GRANT ALL PRIVILEGES` with wildcard hosts (`'user'@'%'`) allows remote connections from any IP
- **Data-at-rest encryption**: MariaDB supports tablespace encryption (Aria/InnoDB), but it is **not enabled by default** — a common compliance gap auditors flag

## Related concepts
[[SQL Injection]] [[Database Hardening]] [[Principle of Least Privilege]] [[Port Scanning]] [[LAMP Stack Security]]