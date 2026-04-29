# SIEM & Log Management

## What it is
Think of a SIEM like a casino's surveillance room: dozens of cameras (log sources) feed into one central booth where analysts watch for card counters, thieves, and cheaters in real time. A Security Information and Event Management (SIEM) system aggregates, correlates, and analyzes log data from across an environment — firewalls, endpoints, servers, applications — to detect threats and support incident response. It combines Security Information Management (long-term storage, compliance) with Security Event Management (real-time alerting).

## Why it matters
During the Target breach (2013), HVAC vendor credentials were used to pivot into the payment network — alerts actually fired in Target's security tools, but the signals were buried in noise and never acted upon. A properly tuned SIEM with correlation rules for lateral movement and unusual after-hours access would have surfaced those alerts as high-priority incidents, potentially stopping 40 million stolen card numbers from leaving the network.

## Key facts
- **Log sources** typically include firewalls, IDS/IPS, Windows Event Logs, DNS servers, proxies, and authentication systems (Active Directory)
- **Correlation rules** link seemingly unrelated events (failed login + VPN connection + large data transfer) into a single meaningful alert
- **Retention policy** matters for compliance: PCI-DSS requires 12 months of log retention (3 months immediately accessible)
- **Normalization** converts logs from different vendors into a common format so the SIEM can compare apples to apples — without it, correlation breaks
- **UEBA (User and Entity Behavior Analytics)** is a modern SIEM capability that uses baselines to flag anomalous behavior rather than relying solely on static signatures

## Related concepts
[[Intrusion Detection Systems]] [[Threat Intelligence]] [[Incident Response]] [[Log Analysis]] [[Network Traffic Analysis]]