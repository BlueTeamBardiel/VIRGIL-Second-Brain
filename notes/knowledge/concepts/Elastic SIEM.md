# Elastic SIEM

## What it is
Think of it like a control tower at an airport: every plane (log source) reports its position, and air traffic controllers (analysts) get a unified view to spot collisions before they happen. Elastic SIEM is a security information and event management platform built on the Elastic Stack (Elasticsearch, Logstash, Kibana), designed to ingest, normalize, and analyze security telemetry at scale for threat detection and investigation.

## Why it matters
During a ransomware intrusion, attackers typically move laterally for days before detonating their payload. Elastic SIEM's detection rules can correlate Windows Event Log 4624 (successful logon) spikes with unusual process creation events (Sysmon Event ID 1), surfacing the lateral movement chain in a timeline view — giving defenders a window to contain the threat before encryption begins.

## Key facts
- Uses the **Elastic Common Schema (ECS)** to normalize fields across diverse log sources (firewalls, endpoints, cloud), enabling consistent detection logic regardless of vendor.
- Ships with **prebuilt detection rules** mapped to the **MITRE ATT&CK framework**, allowing teams to immediately hunt for known adversary TTPs without writing rules from scratch.
- **Timelines** in Elastic SIEM function as collaborative investigation workspaces where analysts pin evidence, annotate findings, and build an incident narrative — directly relevant to CySA+ incident response workflows.
- Ingests data via **Beats agents** (Filebeat, Winlogbeat, Auditbeat) deployed on endpoints, making agent deployment the first step in expanding coverage.
- Elastic SIEM is now marketed under **Elastic Security**, which combines SIEM, endpoint detection (formerly Endgame), and cloud security posture management in one platform.

## Related concepts
[[SIEM]] [[MITRE ATT&CK]] [[Elastic Common Schema]] [[Log Aggregation]] [[Threat Hunting]]