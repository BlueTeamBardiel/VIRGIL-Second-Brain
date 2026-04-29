# FortiAnalyzer

## What it is
Think of it as the black box flight recorder for your entire network — it collects, stores, and analyzes log data from every Fortinet device so you can reconstruct exactly what happened and when. FortiAnalyzer is Fortinet's centralized log management and security analytics platform that aggregates logs from FortiGate firewalls, FortiClient endpoints, FortiMail, and other Fortinet products. It transforms raw log data into structured reports, dashboards, and threat intelligence for SOC analysts.

## Why it matters
During a ransomware incident response, investigators need to answer: which host was patient zero, which lateral movement paths were used, and which data left the network? FortiAnalyzer provides the centralized log retention and correlation engine to answer these questions — without it, logs scattered across dozens of individual FortiGate appliances would require manual aggregation and likely exceed local storage limits. It also enables compliance reporting for frameworks like PCI-DSS and HIPAA that mandate log retention and audit trails.

## Key facts
- FortiAnalyzer uses **ADOMs (Administrative Domains)** to logically separate log data from different customers or business units — critical for MSSPs managing multiple tenants
- Supports **log compression and encryption in transit (TLS)** between Fortinet devices and the analyzer appliance
- Provides **Event Correlation** rules that trigger alerts when multiple log events match a defined attack pattern — functioning as a lightweight SIEM
- Default log retention and search leverage a **SQL-based database**, enabling structured queries against historical events
- Available as hardware appliance, virtual machine (FortiAnalyzer-VM), or cloud-hosted — all licensed by **GB/day ingestion rate**

## Related concepts
[[SIEM]] [[Log Management]] [[Security Monitoring]] [[FortiGate]] [[Incident Response]]