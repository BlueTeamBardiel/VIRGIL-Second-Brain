# Log4net

## What it is
Like a ship's logbook that automatically records every event during a voyage, Log4net is a logging framework for .NET applications that captures, formats, and routes diagnostic messages to files, databases, or consoles. It is the .NET port of Apache's Log4j, providing developers structured visibility into application behavior at runtime.

## Why it matters
In incident response, Log4net-generated logs are often the **primary forensic artifact** used to reconstruct a breach timeline. For example, when an attacker achieves SQL injection against a .NET web application, Log4net error logs may contain the malicious payloads, affected queries, and exact timestamps — giving analysts the evidence chain needed to scope the incident and identify lateral movement.

## Key facts
- Log4net uses **appenders** to define log destinations (file, EventLog, SMTP, database) and **loggers** to define severity filtering — misconfigured appenders can expose sensitive data in world-readable log files
- Supports five severity levels: **DEBUG → INFO → WARN → ERROR → FATAL** — only messages at or above the configured threshold are recorded
- Unlike its Java sibling **Log4j (CVE-2021-44228)**, Log4net does **not** natively support JNDI lookups, so it was **not vulnerable** to Log4Shell — a critical exam distinction
- Log4net config files (XML-based) can be modified at runtime without restarting the application, which attackers can abuse if they gain write access to the config
- Sensitive data (passwords, PII, session tokens) can accidentally be written to logs via unfiltered exception messages — violating PCI-DSS and GDPR logging requirements

## Related concepts
[[Log4j]] [[SIEM Log Ingestion]] [[Application Logging Best Practices]] [[Log Tampering]] [[CVE-2021-44228]]