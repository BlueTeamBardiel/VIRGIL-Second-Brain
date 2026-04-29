# Monitoring and Logging

## What it is
Like a flight data recorder that captures every instrument reading before a crash, monitoring and logging continuously record system events, user actions, and network traffic so defenders can reconstruct exactly what happened during an incident. Monitoring is the real-time observation of activity, while logging is the persistent recording of discrete events with timestamps for later analysis.

## Why it matters
During the 2013 Target breach, attackers exfiltrated 40 million credit card records over several weeks — alerts did fire, but were ignored or not acted upon. Proper log aggregation and alert triage would have revealed the anomalous outbound traffic patterns early enough to contain the breach before mass data loss occurred.

## Key facts
- **SIEM (Security Information and Event Management)** aggregates logs from multiple sources, correlates events, and generates alerts — central tool for both Security+ and CySA+ exam scenarios
- **Syslog** (UDP 514 / TCP 6514 with TLS) is the standard protocol for forwarding log data to centralized collectors; knowing the ports is exam-relevant
- Logs must be protected from tampering via **write-once storage or forwarding to a remote server** — an attacker who compromises a host will often delete local logs to cover tracks
- **Retention policies** matter legally: PCI-DSS requires 12 months of log retention (3 months immediately accessible); HIPAA requires 6 years
- **NTP synchronization** across all devices is critical — logs from systems with mismatched clocks make timeline reconstruction during forensics nearly impossible

## Related concepts
[[SIEM]] [[Incident Response]] [[Network Traffic Analysis]] [[Threat Hunting]] [[Forensics]]