# SIEM Security

## What it is
Think of a SIEM like an air traffic control tower: dozens of planes (log sources) are constantly transmitting, and the tower synthesizes all signals into a single coherent picture, alerting controllers when flight paths dangerously intersect. A Security Information and Event Management (SIEM) system aggregates, normalizes, and correlates log data from across an enterprise — firewalls, endpoints, servers, applications — to detect threats in real time. It combines Security Information Management (long-term storage/analysis) with Security Event Management (real-time monitoring) into one platform.

## Why it matters
During the Target breach of 2013, an intrusion detection alert was generated when attackers moved laterally through the network — but it was never acted upon. A properly tuned SIEM with automated alerting and correlation rules could have flagged the anomalous internal traffic pattern and triggered an incident response workflow before 40 million card numbers were exfiltrated.

## Key facts
- **Correlation rules** are the core detection engine — they match patterns across multiple log sources (e.g., failed login + privilege escalation + large data transfer = insider threat alert)
- **Log normalization** converts heterogeneous log formats (Syslog, Windows Event Log, JSON) into a common schema so correlation is possible
- **Retention periods** matter for compliance: PCI-DSS requires 1 year of log retention, with 3 months immediately available
- **SIEM vs. SOAR**: SIEMs detect and alert; SOAR (Security Orchestration, Automation, and Response) platforms act on those alerts automatically
- Common SIEM platforms tested on CySA+: Splunk, IBM QRadar, Microsoft Sentinel, and ArcSight
- **Tuning** is critical — untuned SIEMs produce massive false positive rates that cause alert fatigue, a leading factor in missed breaches

## Related concepts
[[Log Management]] [[Security Orchestration Automation and Response]] [[Intrusion Detection System]] [[Threat Intelligence]] [[Incident Response]]