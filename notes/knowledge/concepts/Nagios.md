# Nagios

## What it is
Think of Nagios as a hospital's vital-signs monitor — constantly checking pulse, blood pressure, and oxygen levels, and screaming an alert the moment something flatlines. Precisely, Nagios is an open-source IT infrastructure monitoring platform that continuously polls network services, host resources, and system metrics, triggering alerts when thresholds are breached or services go dark. It operates on an agent-based or agentless model using plugins to check everything from CPU load to HTTP response codes.

## Why it matters
In a real-world defense scenario, a SOC team running Nagios detected an unusual spike in outbound DNS queries from an internal host — a classic indicator of DNS tunneling used for data exfiltration. Without continuous service monitoring, that anomaly would have blended into background noise for days. Nagios's alerting threshold rules surfaced the behavior within minutes, allowing analysts to isolate the compromised host before sensitive data left the network.

## Key facts
- Nagios Core is free and open-source; Nagios XI is the commercial version with enhanced dashboards and reporting — both are CySA+-relevant monitoring tools
- Uses a **plugin architecture** — checks are executed via scripts (e.g., `check_http`, `check_disk`) making it highly extensible
- Communicates with remote hosts using **NRPE** (Nagios Remote Plugin Executor) for agent-based checks or **SNMP** for agentless polling
- Supports **passive checks** (hosts push data to Nagios) and **active checks** (Nagios pulls data on a schedule), a key architectural distinction
- Misconfigured Nagios instances have been exploited in the wild — attackers have leveraged authenticated RCE vulnerabilities (e.g., CVE-2016-9565) to pivot through monitoring infrastructure

## Related concepts
[[SIEM]] [[SNMP]] [[Continuous Monitoring]] [[Network Baseline]] [[Intrusion Detection System]]