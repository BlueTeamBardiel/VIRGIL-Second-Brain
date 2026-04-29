# TheHive

## What it is
Think of TheHive as a shared incident command post — like firefighters from multiple stations coordinating on one radio channel with a shared whiteboard. Technically, it is an open-source, scalable Security Incident Response Platform (SIRP) that allows multiple analysts to collaborate on security cases, investigations, and tasks in real time. It integrates natively with threat intelligence tools like MISP and Cortex to enrich observables and automate analysis.

## Why it matters
During a ransomware outbreak affecting 40 endpoints, a SOC team uses TheHive to create a single case, assign tasks to different analysts (network isolation, forensic imaging, stakeholder notification), and track every observable — hashes, IPs, domains — through Cortex analyzers without duplicate work. Without a platform like TheHive, the same team would coordinate through email threads and spreadsheets, guaranteeing missed indicators and slower containment.

## Key facts
- TheHive uses a **case-and-task model**: cases represent incidents, tasks are assigned to individual analysts, and observables (IOCs) are attached and analyzed automatically
- **Cortex** is TheHive's companion analysis engine — it runs analyzers and responders against observables (e.g., VirusTotal lookups, IP reputation checks) via API
- **MISP integration** allows bi-directional sharing: import threat intel into cases or export confirmed IOCs back to the community
- TheHive supports **role-based access control (RBAC)**, making it suitable for MSSPs managing multiple client organizations in isolated tenants
- Cases can be created automatically from **SIEM alerts** (e.g., Splunk, Elastic) via API or webhook, enabling near-real-time incident ticketing

## Related concepts
[[MISP]] [[Cortex]] [[Security Orchestration Automation and Response (SOAR)]] [[Incident Response Lifecycle]] [[Indicators of Compromise (IOCs)]]