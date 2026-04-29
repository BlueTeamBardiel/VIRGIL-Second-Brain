# Elastic Stack

## What it is
Think of it as a city's entire surveillance infrastructure — cameras (Beats) feeding footage to a dispatch center (Logstash), storing everything in a searchable archive (Elasticsearch), and displaying it on a live dashboard (Kibana). Elastic Stack (formerly ELK Stack) is an open-source log management and analytics platform that ingests, processes, stores, and visualizes large volumes of security event data in near real-time.

## Why it matters
During a ransomware investigation, a SOC analyst can query Elasticsearch across millions of Windows Event Logs to identify the exact moment a service account began executing PowerShell with encoded commands — a behavior invisible without centralized log aggregation. Elastic Stack is frequently deployed as a SIEM backbone, correlating endpoint, network, and application logs to surface indicators of compromise before damage spreads.

## Key facts
- **Four core components**: Beats (lightweight data shippers), Logstash (data processing pipeline), Elasticsearch (distributed search/analytics engine), Kibana (visualization and dashboarding)
- **Beats agents** include specialized collectors: Filebeat (logs), Winlogbeat (Windows events), Packetbeat (network traffic) — each targeting a specific data source
- Elasticsearch uses an **inverted index** structure, enabling sub-second searches across terabytes of log data
- Elastic Stack maps natively to the **Elastic Common Schema (ECS)**, standardizing field names to improve cross-source correlation — directly relevant to CySA+ threat hunting objectives
- In security contexts, Kibana dashboards can be configured with **detection rules aligned to MITRE ATT&CK** tactics, enabling automated alerting on adversary techniques

## Related concepts
[[SIEM]] [[Log Management]] [[Threat Hunting]] [[MITRE ATT&CK]] [[Security Monitoring]]