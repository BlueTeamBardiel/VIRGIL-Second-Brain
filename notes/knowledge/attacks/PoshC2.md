# PoshC2

## What it is
Think of PoshC2 like a puppet master's control board: once you've planted your marionette (implant) on a victim machine, every string you pull runs back through a legitimate-looking web channel. PoshC2 is an open-source, proxy-aware command-and-control (C2) framework built on PowerShell and Python, designed to enable post-exploitation operations over HTTP/HTTPS. It allows attackers to maintain persistent, encrypted communication with compromised hosts while blending into normal web traffic.

## Why it matters
In a 2019 campaign targeting UK managed service providers, threat actors used PoshC2 implants to maintain long-term access to client networks, pivoting laterally across dozens of organizations from a single beachhead. Defenders monitoring for PoshC2 must look for encoded PowerShell execution, unusual HTTPS beacon intervals, and C2 URIs matching its default templates — all detectable via SIEM correlation rules and endpoint telemetry.

## Key facts
- PoshC2 uses **PowerShell, Python, and C# implants**, giving attackers flexibility across different victim environments and defense postures
- Default C2 communication uses **HTTP/HTTPS with randomized URIs** and configurable beacon sleep times to evade behavioral detection
- Includes built-in modules for **credential harvesting** (Mimikatz integration), lateral movement, and privilege escalation
- The framework supports **proxy-aware communication**, meaning implants route through corporate proxies without raising immediate alerts
- PoshC2 is tracked under **MITRE ATT&CK** techniques including T1059.001 (PowerShell), T1071.001 (Web Protocols), and T1090 (Proxy)

## Related concepts
[[Command and Control (C2)]] [[PowerShell Abuse]] [[MITRE ATT&CK Framework]] [[Living Off the Land (LOLBins)]] [[Beacon Traffic Analysis]]