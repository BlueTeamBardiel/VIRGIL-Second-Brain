# Splunk Enterprise

## What it is
Think of it as a DVR for your entire network — instead of recording TV shows, it records every log, packet summary, and event across your infrastructure so you can rewind and replay exactly what happened. Splunk Enterprise is an on-premises data aggregation and analytics platform that ingests machine-generated data (logs, metrics, events) at scale, indexes it, and makes it searchable using its proprietary Search Processing Language (SPL). It functions as the backbone of many Security Operations Centers (SOCs) as a full-featured SIEM.

## Why it matters
During the SolarWinds supply chain attack (2020), organizations using Splunk were able to write custom SPL queries to hunt for the specific beacon patterns and lateral movement associated with SUNBURST malware — those without robust log aggregation had no visibility at all. Splunk's ability to correlate DNS request logs, authentication events, and network flows in a single query is exactly what separated teams that detected the intrusion from those that discovered it months later.

## Key facts
- **SPL (Search Processing Language)** is Splunk's query syntax; CySA+ candidates should recognize commands like `stats`, `eval`, `rex`, and `table`
- Splunk uses **forwarders** (Universal and Heavy) to ship log data to indexers — a critical architecture concept for deployment questions
- Data is organized into **indexes** and tagged with **sourcetypes** (e.g., `syslog`, `WinEventLog`) to enable targeted searches
- **Correlation searches** in Splunk Enterprise Security (ES) trigger **Notable Events**, which map directly to the SIEM alerting workflow tested on CySA+
- Licensing is volume-based (daily GB ingested), making log source prioritization a real-world cost and coverage tradeoff

## Related concepts
[[SIEM]] [[Log Management]] [[Security Operations Center (SOC)]] [[Threat Hunting]] [[SPL Queries]]