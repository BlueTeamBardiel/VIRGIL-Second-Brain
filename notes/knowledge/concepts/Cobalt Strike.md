# Cobalt Strike

## What it is
Think of it as a Swiss Army knife that a locksmith uses to teach lockpicking — legitimately designed for security professionals, but equally devastating in the wrong hands. Cobalt Strike is a commercial adversary simulation and red team framework that provides attackers (and defenders practicing offense) with tools for post-exploitation, lateral movement, and command-and-control (C2) operations. Its signature payload is the **Beacon** implant, a malleable agent that communicates stealthily with a C2 server over HTTP, HTTPS, or DNS.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used Cobalt Strike Beacons to maintain persistent access and move laterally across victim networks after initial compromise via trojanized software updates. Defenders monitoring for Cobalt Strike artifacts — such as characteristic memory patterns, JA3 TLS fingerprints, and default sleep timers — can detect intrusions that might otherwise blend into normal traffic.

## Key facts
- **Beacon** is the primary payload; it "phones home" to a Team Server and supports staging, lateral movement, credential harvesting, and pivoting
- Cobalt Strike uses **Malleable C2 profiles** to disguise traffic as legitimate services (e.g., mimicking Amazon or Google traffic patterns)
- Leaked and cracked versions of Cobalt Strike are widely used by APT groups and ransomware operators, making it one of the most commonly observed tools in real-world intrusions
- Detection signatures include **memory artifacts** (e.g., reflective DLL injection patterns) and default sleep/jitter values of 60 seconds / 0%
- MITRE ATT&CK maps Cobalt Strike usage across multiple tactics: **Execution, Persistence, Lateral Movement, Exfiltration (T1059, T1021, T1041)**

## Related concepts
[[Command and Control (C2)]] [[Lateral Movement]] [[Red Teaming]] [[MITRE ATT&CK Framework]] [[Reflective DLL Injection]]