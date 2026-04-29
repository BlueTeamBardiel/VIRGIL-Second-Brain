# Security Information and Event Management

## What it is
Think of a SIEM like a hospital's central monitoring station — dozens of patients' vitals stream in from scattered rooms, and nurses watch for dangerous patterns no single bedside monitor could detect alone. A SIEM aggregates and correlates log data from across an entire environment (firewalls, endpoints, servers, applications) in real time, enabling centralized threat detection, alerting, and forensic investigation.

## Why it matters
During the 2013 Target breach, attackers moved laterally from HVAC vendor credentials to the payment card environment over several weeks. A properly tuned SIEM with correlation rules watching for unusual authentication patterns and outbound data staging would have flagged the anomaly long before 40 million card numbers were exfiltrated — this is exactly the use case SIEMs are built for.

## Key facts
- **Two core functions**: Log Management (collection, storage, retention) + Event Correlation (rule-based pattern detection across sources)
- **SIEMs establish a baseline** of normal behavior, then alert on deviations — making them effective against insider threats and slow-burn APT activity
- **Common SIEM products**: Splunk, IBM QRadar, Microsoft Sentinel, ArcSight — frequently appear in exam scenarios
- **Key metric**: Mean Time to Detect (MTTD) — SIEMs exist specifically to reduce this number
- **Compliance driver**: PCI-DSS, HIPAA, and SOX all mandate log aggregation and review; a SIEM satisfies these requirements while adding detection capability
- SIEMs generate **alerts, not blocks** — response still requires human analysts or integration with SOAR platforms

## Related concepts
[[Log Management]] [[Security Orchestration Automation and Response]] [[Intrusion Detection System]] [[Threat Intelligence]] [[User and Entity Behavior Analytics]]