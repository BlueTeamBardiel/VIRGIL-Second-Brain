# NIST SP 800-92

## What it is
Think of it as the official blueprint for a ship's black box — not just recording what happened, but specifying *how* to record, store, and analyze logs so investigators can actually use them. NIST SP 800-92 is the "Guide to Computer Security Log Management," a federal publication that defines policies, procedures, and best practices for generating, transmitting, storing, analyzing, and disposing of log data across an organization.

## Why it matters
During the 2020 SolarWinds breach, investigators relied heavily on log data to trace lateral movement across compromised networks — but many organizations discovered their logs were incomplete, misconfigured, or retained for too short a period to reconstruct the attack timeline. Organizations following SP 800-92's guidance on log retention periods and centralized aggregation were in a dramatically better position to perform forensic analysis and meet regulatory reporting requirements.

## Key facts
- Recommends a **tiered log management infrastructure**: individual systems generate logs, which flow to department-level aggregators, then to a centralized organizational log management system (SIEM)
- Addresses **four core functions**: log generation, transmission, storage/analysis, and disposal
- Emphasizes that logs should be **protected from unauthorized modification** — integrity is as critical as availability
- Recommends organizations define **log retention periods** based on legal, regulatory, and operational requirements (common guidance: 90 days online, 1 year archived)
- Covers **log normalization and correlation** — raw logs from firewalls, OS, and applications must be standardized to be usable in analysis

## Related concepts
[[SIEM]] [[Log Management]] [[Chain of Custody]] [[NIST SP 800-61]] [[Security Monitoring]]