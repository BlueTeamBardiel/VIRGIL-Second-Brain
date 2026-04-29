# CWE-532 - Insertion of Sensitive Information into Log Files

## What it is
Imagine a hotel security camera that records not just who enters a room, but also films guests typing their PIN numbers and speaking their passwords aloud — the recording meant to provide security *becomes* the vulnerability. CWE-532 occurs when an application writes sensitive data (passwords, session tokens, PII, API keys, credit card numbers) into log files, creating an unintended secondary exposure point. Logs are often less protected than the primary data stores they describe.

## Why it matters
In 2019, Twitter disclosed that plaintext passwords were written to internal logs before the hashing process completed, potentially exposing millions of credentials to internal staff with log access. An attacker who compromises a centralized logging system (like a SIEM or syslog server) gains access to credentials and tokens across every application feeding into it — effectively one breach becoming many.

## Key facts
- Log files typically have weaker ACLs than databases, are frequently backed up to less-secure locations, and are shared broadly with developers and operations staff
- Common culprits include debug-level logging left enabled in production, verbose error messages, and HTTP request/response logging that captures Authorization headers or POST bodies
- Mitigation requires **log scrubbing/masking** before write (not after), using allowlist-based logging rather than logging entire objects or request payloads
- PCI-DSS explicitly prohibits logging full Primary Account Numbers (PANs); HIPAA requires controls preventing PHI from appearing in logs
- Tools like **grep**, **Splunk**, or **log4j configurations** can inadvertently serialize sensitive object fields if logging is not tightly controlled

## Related concepts
[[Sensitive Data Exposure]] [[Log Management]] [[Insecure Direct Object Reference]] [[Credential Exposure]] [[Defense in Depth]]