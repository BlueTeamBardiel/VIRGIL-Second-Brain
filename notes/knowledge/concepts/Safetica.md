# Safetica

## What it is
Think of it as a security guard who not only watches the exits but reads every document being carried out and decides whether it's allowed to leave. Safetica is a Data Loss Prevention (DLP) and insider threat protection platform that monitors, classifies, and controls data movement across endpoints, email, cloud, and removable media. It enforces organizational data policies by detecting sensitive content and blocking or alerting on unauthorized transfers in real time.

## Why it matters
A disgruntled employee at a financial firm attempts to exfiltrate customer PII by copying records to a personal USB drive before resigning. Safetica's endpoint agent detects the file classification (personal data containing SSNs and account numbers), blocks the transfer based on policy, and generates an audit log with the user's identity, timestamp, and attempted destination — giving the security team actionable forensic evidence without relying on perimeter controls.

## Key facts
- Safetica operates as an **agent-based DLP solution**, deploying lightweight software on Windows and macOS endpoints to enforce policies at the device level.
- It performs **content inspection and data classification** using keywords, regex patterns, and file type analysis to identify sensitive data (PII, PHI, PCI-DSS-relevant data).
- Safetica provides **UEBA (User and Entity Behavior Analytics)** capabilities, establishing behavioral baselines to flag anomalous data access patterns indicative of insider threats.
- It maps directly to compliance frameworks including **GDPR, HIPAA, and ISO 27001**, generating audit-ready reports for regulatory evidence.
- Safetica can operate in **monitoring-only mode** (shadow mode) before enforcement, allowing organizations to tune policies without disrupting legitimate workflows.

## Related concepts
[[Data Loss Prevention]] [[Insider Threat]] [[User and Entity Behavior Analytics]] [[Endpoint Detection and Response]] [[Data Classification]]