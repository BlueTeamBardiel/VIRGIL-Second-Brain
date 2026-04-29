# SIEM Architecture

## What it is
Think of a SIEM like an air traffic control tower: dozens of planes (log sources) transmit data constantly, and controllers (correlation engines) synthesize all of it into a single coherent picture to catch near-misses before they become disasters. Precisely, a Security Information and Event Management (SIEM) system aggregates, normalizes, and correlates log and event data from across an enterprise environment in real time. It combines Security Information Management (SIM) and Security Event Management (SEM) into a unified platform for threat detection and compliance reporting.

## Why it matters
During the Target breach (2013), attackers' lateral movement and data exfiltration generated logs across network devices, endpoints, and the POS environment — a properly tuned SIEM correlating those events could have flagged the anomaly before 40 million card numbers left the building. SIEM correlation rules detecting "outbound traffic spike + new admin account creation + after-hours login" in sequence is exactly the kind of chained logic that turns raw noise into actionable alerts.

## Key facts
- **Core components**: Log collectors (agents/agentless), a normalizer/parser, a correlation engine, a datastore (often a SIEM-optimized SIEM like Elasticsearch), and a dashboard/alerting layer
- **Normalization** converts heterogeneous log formats (syslog, Windows Event Logs, CEF, LEEF) into a common schema so correlation rules apply uniformly
- **Retention** is critical for compliance — PCI-DSS requires one year of log storage; SIEM must balance hot (searchable) vs. cold (archived) storage costs
- **Tuning** reduces false positives; an untuned SIEM can generate thousands of daily alerts, causing alert fatigue and analyst burnout
- **SIEM vs. SOAR**: SIEM detects and alerts; SOAR (Security Orchestration, Automation, and Response) automates the response workflow triggered by SIEM alerts

## Related concepts
[[Log Management]] [[Security Orchestration Automation and Response]] [[Threat Intelligence Feeds]] [[Correlation Rules]] [[Event Normalization]]