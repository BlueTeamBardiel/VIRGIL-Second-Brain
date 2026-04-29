# Microsoft Sentinel

## What it is
Think of it as a stadium's entire security operation — hundreds of cameras, metal detectors, and roving guards all feeding reports into one command center where analysts watch every entrance simultaneously. Microsoft Sentinel is a cloud-native Security Information and Event Management (SIEM) and Security Orchestration, Automation, and Response (SOAR) platform that ingests logs from across an environment, correlates them into alerts, and automates responses to threats.

## Why it matters
During a ransomware campaign, attackers often move laterally for weeks before detonating the payload. Sentinel's Analytics Rules can detect suspicious patterns — like an account logging in from two countries within 30 minutes (impossible travel) — and automatically trigger a Playbook (built on Azure Logic Apps) to disable the account and notify the SOC, stopping the attack before encryption begins.

## Key facts
- **SIEM + SOAR in one platform**: Sentinel combines log aggregation and correlation (SIEM) with automated response workflows called *Playbooks* (SOAR), reducing mean time to respond (MTTR).
- **Data Connectors**: Sentinel uses pre-built connectors to ingest data from Microsoft 365, Azure AD, firewalls, Linux syslog, and third-party tools like Palo Alto or Splunk.
- **KQL (Kusto Query Language)**: Analysts write detection and hunting queries in KQL — a key differentiator and exam-relevant skill for Sentinel-focused roles.
- **Workbooks**: Customizable dashboards that visualize ingested data; functionally similar to reports in traditional SIEMs.
- **Pricing model**: Billed by data ingestion (GB/day) or via Commitment Tiers — a common exam distractor when comparing cloud SIEM cost models to on-premises solutions.

## Related concepts
[[SIEM]] [[SOAR]] [[Log Aggregation]] [[Azure Active Directory]] [[Incident Response]]