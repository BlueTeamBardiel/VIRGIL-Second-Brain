# Logging

## What it is
Like a ship's captain recording every course change, weather event, and crew action in a logbook, a computer system continuously writes timestamped records of events — logins, file access, errors, configuration changes — to a persistent log file. Logging is the systematic collection and storage of these event records to support auditing, troubleshooting, and forensic investigation.

## Why it matters
During the 2013 Target breach, attackers moved laterally through the network for weeks before detection — logs existed but weren't being actively monitored or correlated. Proper centralized logging fed into a SIEM would have triggered alerts on the anomalous credential usage and lateral movement patterns, potentially cutting the dwell time from weeks to hours.

## Key facts
- **Log types to know**: Security logs (authentication events), System logs (OS activity), Application logs (software errors), and Network logs (firewall/IDS traffic) — all distinct and exam-tested
- **Syslog** (port 514 UDP, or 6514 TCP for TLS) is the standard protocol for shipping logs to a centralized server; know the severity levels 0 (Emergency) through 7 (Debug)
- **Log integrity** matters: attackers routinely delete or tamper with logs post-compromise; WORM storage (Write Once Read Many) and remote logging protect against this
- **Retention policies** are legally significant — HIPAA requires 6 years, PCI-DSS requires 1 year minimum (3 months immediately accessible)
- **Timestamps and NTP synchronization** are critical for forensic reconstruction; logs with unsynchronized clocks create gaps and contradictions in timelines

## Related concepts
[[SIEM]] [[Audit Trails]] [[Chain of Custody]] [[Non-repudiation]] [[Log Management]]