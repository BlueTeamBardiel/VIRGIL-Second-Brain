# Correlation

## What it is
Like a detective who notices that every time a particular suspect was seen near the docks, a shipment went missing — correlation in security is the process of linking disparate log events across multiple sources to reveal a pattern that no single log could expose alone. Precisely, it is the automated or manual process of aggregating and analyzing security events from different systems (firewalls, IDS, endpoints) to identify relationships indicating a threat. It is a core function of SIEM platforms.

## Why it matters
During a credential-stuffing attack, no single failed login looks alarming — one failure per account triggers nothing. A SIEM using correlation rules detects that 10,000 failed logins occurred across 500 accounts from 300 different IPs within 60 seconds, flagging it as a coordinated attack that threshold-based alerting on any single device would have missed entirely.

## Key facts
- **SIEM platforms** (e.g., Splunk, IBM QRadar, Microsoft Sentinel) are the primary tools that perform automated event correlation in enterprise environments
- **Correlation rules** define the logic: e.g., "if 5 failed logins from the same IP within 2 minutes → trigger alert"; these rules must be tuned to reduce false positives
- **Time synchronization (NTP)** is a prerequisite for accurate correlation — mismatched timestamps across devices destroy the ability to reconstruct event sequences
- **Alert fatigue** is a direct risk of poorly tuned correlation — too many false positives cause analysts to ignore or disable alerts
- On the **CySA+ exam**, correlation is tested in the context of threat hunting, incident response, and SIEM log analysis workflows

## Related concepts
[[SIEM]] [[Log Analysis]] [[Intrusion Detection System]] [[Threat Hunting]] [[Baseline]]