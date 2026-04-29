# Log Correlation

## What it is
Like a detective who notices that a broken window, missing silverware, AND muddy footprints all happened within the same hour — log correlation is the practice of combining events from multiple disparate sources to reveal patterns invisible in any single log. Precisely: it is the automated or manual process of linking related log entries across different systems (firewalls, endpoints, servers, authentication services) by time, IP, user, or behavior to identify security-relevant sequences of events.

## Why it matters
During a credential-stuffing attack, any single system might see only a handful of failed logins — below the alert threshold. But correlating authentication logs from 50 different web applications reveals the same source IPs hammering accounts across all services simultaneously, exposing the attack clearly. Without correlation, each system appears quiet; together, they scream compromise.

## Key facts
- **SIEM platforms** (Splunk, Microsoft Sentinel, QRadar) are the primary tools that automate log correlation in enterprise environments
- Correlation rules define the **conditions** (e.g., "5 failed logins across 3 systems within 60 seconds from the same IP") that trigger an alert
- **Time synchronization (NTP)** is critical — logs with mismatched timestamps produce false correlations or miss real ones entirely
- **Normalized log formats** (like CEF or LEEF) allow logs from heterogeneous sources to be compared apples-to-apples
- Log correlation is a core function distinguishing a **SIEM from a simple log aggregator** — aggregation collects; correlation finds meaning

## Related concepts
[[SIEM]] [[Security Logging]] [[Threat Detection]] [[Intrusion Detection System]] [[NTP Synchronization]]