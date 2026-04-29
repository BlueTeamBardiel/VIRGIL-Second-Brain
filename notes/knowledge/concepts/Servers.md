# Servers

## What it is
Think of a server like a vending machine in a break room — it sits waiting, ready to dispense specific goods (files, web pages, emails) to anyone who makes the right request. Precisely, a server is a hardware or software system that listens on network ports for incoming client requests and responds with data or services according to defined protocols. Unlike workstations, servers are designed for continuous availability and handle multiple concurrent connections.

## Why it matters
In the 2017 Equifax breach, attackers exploited an unpatched Apache web server (CVE-2017-5638) running an outdated version of Apache Struts, ultimately exfiltrating data on 147 million people. This underscores that servers are high-value targets precisely because they are always-on, externally reachable, and often hold sensitive data — making patch management and attack surface reduction critical defensive priorities.

## Key facts
- Servers listen on well-known ports by default (HTTP: 80, HTTPS: 443, SSH: 22, FTP: 21, DNS: 53) — knowing these is essential for port scanning analysis and firewall rule design
- **Attack surface reduction**: disabling unnecessary services and closing unused ports is a foundational server hardening control (CIS Benchmarks, STIG)
- Servers can be **physical, virtual (VM), or containerized** — each introduces different isolation and patch management considerations
- **Server-side attacks** include remote code execution (RCE), directory traversal, and SQL injection targeting server-side applications
- **Hardening steps** include removing default credentials, disabling banner grabbing responses, applying least privilege to service accounts, and enabling logging for SIEM ingestion

## Related concepts
[[Attack Surface]] [[Patch Management]] [[Hardening]] [[Port Scanning]] [[Principle of Least Privilege]]