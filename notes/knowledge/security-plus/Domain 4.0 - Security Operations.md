# Domain 4.0 - Security Operations

## What it is
Think of Security Operations as the 24/7 emergency dispatch center for your organization — constantly monitoring radio chatter, triaging incidents, and coordinating response teams before a house fire becomes an entire neighborhood ablaze. Precisely, Security Operations encompasses the ongoing processes, tools, and personnel responsible for monitoring environments, detecting threats, responding to incidents, and maintaining the defensive posture of an organization in real time.

## Why it matters
In the 2020 SolarWinds supply chain attack, organizations *without* mature security operations failed to detect anomalous SUNBURST beacon traffic hiding in legitimate DNS queries for months. Security teams with proper log aggregation, behavioral baselines, and incident response playbooks were able to identify the indicators of compromise far earlier and contain lateral movement before crown-jewel data was exfiltrated.

## Key facts
- **SIEM** (Security Information and Event Management) is the central nervous system of Security Operations — it aggregates logs, correlates events, and generates alerts for analyst review
- The **incident response lifecycle** (Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned) is NIST SP 800-61's framework, and it's directly testable on Security+ and CySA+
- **Mean Time to Detect (MTTD)** and **Mean Time to Respond (MTTR)** are the key KPIs used to measure SOC effectiveness
- **Threat hunting** is *proactive* — analysts actively search for hidden threats without waiting for automated alerts, distinguishing it from passive monitoring
- Vulnerability scans should run on a **credentialed** basis to produce accurate severity ratings; uncredentialed scans underreport findings

## Related concepts
[[Incident Response]] [[SIEM]] [[Threat Hunting]] [[Vulnerability Management]] [[Digital Forensics]]