# Logging and Monitoring

## What it is
Like a flight data recorder that captures every throttle input and altitude change so investigators can reconstruct exactly what happened during a crash, logging and monitoring continuously records system events and analyzes them in real time to detect anomalies. Logging is the collection and storage of timestamped event records; monitoring is the active analysis of those logs to identify threats, policy violations, or operational failures.

## Why it matters
During the Target breach of 2013, attackers moved laterally through the network for weeks before discovery — FireEye alerts fired, but no one acted on them. Mature logging and monitoring with automated alerting and clear escalation paths would have dramatically reduced attacker dwell time, which averaged 197 days industry-wide at the time. This is why SIEM platforms correlating logs across endpoints, firewalls, and servers are now considered baseline security architecture.

## Key facts
- **SIEM** (Security Information and Event Management) aggregates logs from multiple sources, correlates events, and generates alerts — tools include Splunk, IBM QRadar, and Microsoft Sentinel
- **Log sources** include firewalls, IDS/IPS, DNS servers, authentication systems, and endpoints — diversity of sources directly improves detection capability
- **NTP synchronization** across all log sources is critical; mismatched timestamps destroy log correlation and chain-of-custody integrity
- **OWASP identifies "Insufficient Logging & Monitoring"** as a Top 10 vulnerability because undetected breaches cause far greater damage than detected ones
- **Retention requirements** vary by regulation: PCI-DSS mandates 12 months of log retention (3 months immediately available); HIPAA requires 6 years for audit controls documentation

## Related concepts
[[SIEM]] [[Intrusion Detection Systems]] [[Incident Response]] [[Security Auditing]] [[SOAR]]