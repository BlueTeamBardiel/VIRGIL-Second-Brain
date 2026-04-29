# Elastic Agent

## What it is
Think of it as a Swiss Army knife deployed on every endpoint — one tool that replaces the need to carry separate knives for logging, threat detection, and network monitoring. Elastic Agent is a unified, single-deployment agent from Elastic that collects logs, metrics, and security telemetry from hosts and ships it to the Elastic Stack (SIEM/ELK). It replaces the older model of installing separate Beats agents (Filebeat, Metricbeat, Winlogbeat) for each data type.

## Why it matters
During an incident response to a ransomware attack, analysts need endpoint telemetry — process trees, file creation events, and network connections — available immediately. With Elastic Agent deployed fleet-wide and managed through Fleet Server, a SOC analyst can centrally push a new integration (e.g., enabling Windows Defender logs) to 10,000 endpoints in minutes without touching each machine, dramatically shrinking the detection gap during active compromise.

## Key facts
- **Fleet-managed**: Elastic Agent is centrally controlled via Fleet Server, enabling policy updates, integration installs, and agent upgrades at scale without manual SSH access.
- **Integrations replace custom parsers**: Pre-built integrations handle ingestion and normalization for hundreds of data sources (AWS CloudTrail, Cisco ASA, Sysmon), mapping fields to the Elastic Common Schema (ECS).
- **Elastic Defend**: The security-specific integration within Elastic Agent provides EDR capabilities — malware prevention, process injection detection, and memory threat alerts — directly on the endpoint.
- **Tamper protection**: Elastic Agent supports tamper protection settings to prevent unauthorized uninstallation or configuration changes by malware attempting to blind the SIEM.
- **ECS normalization**: All collected data is mapped to Elastic Common Schema, enabling cross-source correlation rules without field-name mismatches.

## Related concepts
[[SIEM]] [[Endpoint Detection and Response (EDR)]] [[Log Aggregation]] [[Elastic Common Schema (ECS)]] [[Fleet Management]]