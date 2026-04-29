# endpoint protection

## What it is
Think of it as a bouncer, security camera, and panic button all rolled into one device-level guardian — if something suspicious walks in, it gets flagged, stopped, or escorted out. Endpoint protection is a category of security controls deployed directly on user devices (laptops, phones, servers) to prevent, detect, and respond to threats at the point where users interact with data. It encompasses antivirus, EDR, host-based firewalls, application control, and device encryption working in concert.

## Why it matters
In the 2021 Kaseya VSA supply chain attack, threat actors exploited a trusted IT management agent running on thousands of endpoints to deploy REvil ransomware — bypassing perimeter defenses entirely. Organizations with robust endpoint protection platforms (EPP) that included behavioral analysis detected anomalous process activity and could isolate affected machines before encryption spread laterally across the network.

## Key facts
- **EDR (Endpoint Detection and Response)** goes beyond signature-based AV by recording telemetry — process trees, registry changes, network connections — enabling forensic investigation after compromise
- **NGAV (Next-Generation Antivirus)** uses machine learning and heuristics to catch zero-day malware that has no known signature
- **Application whitelisting** (now called application control) is considered one of the most effective endpoint controls per NIST and the ASD Essential Eight
- Host-based IPS (HIPS) monitors system calls and blocks exploit behavior at the OS level, distinct from network-based IPS
- **CIS Benchmark hardening** of endpoints — disabling unnecessary services, enforcing least privilege — is foundational before deploying any protection layer

## Related concepts
[[EDR]] [[antivirus]] [[application whitelisting]] [[host-based firewall]] [[zero-day exploit]]