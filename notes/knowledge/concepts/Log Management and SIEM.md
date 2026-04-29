# Log Management and SIEM

## What it is
Think of a SIEM like a casino's surveillance room: dozens of cameras (log sources) feed into one control center where analysts spot patterns no single camera could reveal alone. Log Management is the systematic collection, storage, and retention of event records from systems, devices, and applications; a SIEM (Security Information and Event Management) adds real-time correlation, alerting, and analysis across all those sources simultaneously.

## Why it matters
During the Target breach of 2013, attacker activity *was* logged — but no one correlated the alerts from the HVAC vendor's compromised credentials with the subsequent lateral movement toward the POS systems. A properly tuned SIEM with correlation rules linking anomalous authentication events to sensitive network segments would have surfaced the attack days earlier, before 40 million card numbers were exfiltrated.

## Key facts
- **Log sources** typically include firewalls, IDS/IPS, endpoints, DNS servers, authentication systems, and cloud services — diversity of sources is what enables meaningful correlation
- **Normalization** converts logs from different formats (Windows Event Log, syslog, CEF) into a common schema so the SIEM can compare apples to apples
- **Retention requirements** vary by compliance framework: PCI-DSS requires 12 months of logs (3 months immediately accessible); HIPAA requires 6 years
- **Use cases** for SIEMs include detecting brute-force attempts, impossible travel logins, data exfiltration via DNS tunneling, and insider threat indicators
- A **false positive** rate that's too high creates alert fatigue — a critical operational failure that caused analysts to ignore a valid intrusion alert at Target

## Related concepts
[[Intrusion Detection Systems]] [[Threat Intelligence]] [[Incident Response]] [[Security Monitoring]] [[Data Loss Prevention]]