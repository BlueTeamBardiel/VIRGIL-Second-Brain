# SEM

## What it is
Like a librarian who doesn't just file books but *reads* them and flags anything suspicious, a Security Event Manager actively analyzes and correlates log data rather than just storing it. SEM (Security Event Manager) is the real-time monitoring and correlation component of security operations, focusing on immediate event analysis, alerting, and response — as opposed to long-term log storage. It is often paired with SIM (Security Information Manager) to form the combined SIEM platform.

## Why it matters
During an active brute-force attack, a SEM can correlate dozens of failed authentication events from the same source IP across multiple systems within seconds, trigger an automated alert, and initiate a firewall block — all before an analyst opens their laptop. Without real-time correlation, each failed login appears isolated and harmless; the SEM sees the pattern that exposes the attack. This is why SEM capabilities are critical during the *detection and containment* phases of incident response.

## Key facts
- SEM focuses on **real-time** event correlation and alerting; SIM focuses on **historical** log storage and analysis — together they form SIEM
- Uses **correlation rules** (e.g., "5 failed logins in 60 seconds = alert") to reduce noise and surface true positives
- Generates **alerts and automated responses**, making it directly tied to incident response workflows
- Relies on **normalized log data** from multiple sources (firewalls, IDS, endpoints) — log normalization is a prerequisite for accurate correlation
- On Security+/CySA+ exams, SEM is often tested as the *active/real-time* half of SIEM; expect questions distinguishing SEM from SIM by time-focus

## Related concepts
[[SIEM]] [[Log Management]] [[Security Orchestration Automation and Response]] [[Intrusion Detection System]] [[Incident Response]]