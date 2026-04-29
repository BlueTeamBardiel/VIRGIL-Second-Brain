# Data Correlation

## What it is
Like a detective who notices that every time the butler left the room, a spoon went missing — data correlation is the process of connecting events across multiple sources to reveal patterns invisible in any single log alone. Precisely: it is the aggregation and analysis of log data from disparate systems (firewalls, IDS, endpoints, authentication servers) to identify relationships between events that together indicate a security incident.

## Why it matters
A single failed login looks like a mistyped password; 500 failed logins across 200 accounts in 3 minutes, correlated with a spike in outbound DNS traffic, looks like a credential-stuffing attack followed by data exfiltration. Security Operations Centers (SOCs) rely on SIEM platforms to perform this correlation automatically, reducing Mean Time to Detect (MTTD) from days to minutes.

## Key facts
- **SIEM tools** (Splunk, Microsoft Sentinel, QRadar) are the primary platforms used to automate data correlation across enterprise environments
- **Correlation rules** define the logical conditions that trigger alerts — e.g., "if 10 failed logins occur within 60 seconds from one IP, fire an alert"
- **False positive rate** is a critical tradeoff: overly broad correlation rules flood analysts; overly narrow rules miss sophisticated attacks
- **Time synchronization (NTP)** is a prerequisite for accurate correlation — mismatched timestamps across sources produce meaningless or misleading results
- On the **CySA+ exam**, data correlation is tested in the context of threat detection, log analysis, and SIEM configuration scenarios

## Related concepts
[[SIEM]] [[Log Analysis]] [[Threat Intelligence]] [[Intrusion Detection System]] [[Security Monitoring]]