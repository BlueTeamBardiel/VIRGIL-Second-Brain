# Log Aggregation

## What it is
Like a postal sorting facility that collects letters from hundreds of individual mailboxes and routes them to one central location for reading, log aggregation pulls event records from firewalls, servers, endpoints, and applications into a single centralized repository. It is the process of collecting, normalizing, and consolidating logs from disparate sources so analysts can query and correlate them from one place. Without it, investigating an incident means logging into dozens of systems individually — a forensic nightmare.

## Why it matters
During the 2020 SolarWinds supply chain attack, attackers deliberately suppressed local logs on compromised hosts to avoid detection. Organizations with centralized log aggregation (forwarding logs off-host in real time) retained evidence the attackers couldn't erase, while those relying solely on local logs lost critical forensic data. This is exactly why "log forwarding to a remote, append-only store" is a core hardening principle.

## Key facts
- **SIEM systems** (like Splunk, IBM QRadar, Microsoft Sentinel) depend on log aggregation as their data ingestion layer — no aggregation means no correlation
- **Syslog** (UDP/514 or TCP/6514 with TLS) is the most common protocol used to forward logs from network devices to an aggregation point
- **Log normalization** is a critical sub-step: converting different timestamp formats, field names, and severity levels into a common schema (e.g., CEF or LEEF)
- **Retention requirements** matter for compliance — PCI DSS requires one year of log retention with three months immediately available; aggregation platforms enforce this centrally
- An aggregation architecture should be **write-once/append-only** to ensure log integrity and support chain-of-custody for legal proceedings

## Related concepts
[[SIEM]] [[Syslog]] [[Log Management]] [[Security Monitoring]] [[Threat Detection]]