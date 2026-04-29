# SIEM - Security Information and Event Management

## What it is
Think of a SIEM as an air traffic control tower for your entire network — it doesn't fly the planes, but it watches every flight simultaneously, correlates patterns, and screams when two aircraft are on a collision course. Precisely: a SIEM is a platform that aggregates, normalizes, and correlates log data from across an environment (firewalls, endpoints, servers, applications) to detect threats in real time and support forensic investigation.

## Why it matters
During the Target breach of 2013, alerts were actually triggered in their FireEye security system — but no one acted on them. A properly tuned SIEM with automated alerting rules and escalation workflows could have surfaced those signals above the noise, potentially stopping 40 million stolen card numbers from leaving the network.

## Key facts
- SIEMs perform two core functions: **SIM** (Security Information Management — log storage/reporting) and **SEM** (Security Event Management — real-time correlation and alerting)
- **Log normalization** converts data from different formats (syslog, Windows Event Logs, NetFlow) into a common schema for correlation
- **Correlation rules** define conditions that trigger alerts — e.g., five failed logins followed by one success within 60 seconds triggers a brute-force alert
- Retention of logs is critical for compliance: **PCI DSS requires 12 months**, HIPAA requires 6 years
- Common SIEM platforms tested on exams: **Splunk**, **IBM QRadar**, **Microsoft Sentinel**, and **ArcSight**

## Related concepts
[[Log Management]] [[Security Orchestration Automation and Response (SOAR)]] [[Intrusion Detection System (IDS)]] [[Threat Intelligence]] [[User and Entity Behavior Analytics (UEBA)]]