# Endpoint Security

## What it is
Think of every laptop, phone, and workstation as a door into your house — endpoint security is the deadbolt, alarm sensor, and security camera on each individual door, rather than just a fence around the property. Precisely defined, endpoint security encompasses the tools, policies, and practices used to protect individual devices (endpoints) that connect to a network from compromise, malware, and unauthorized access. It operates on the principle that perimeter defenses alone fail once an attacker is already inside.

## Why it matters
In the 2020 SolarWinds supply chain attack, adversaries planted malicious updates that executed directly on thousands of endpoints inside trusted networks — firewalls never saw it coming because the threat originated from legitimate software. Organizations with robust endpoint detection and response (EDR) tools had behavioral telemetry that flagged the anomalous lateral movement; those relying only on perimeter security were blind until the damage was done.

## Key facts
- **EDR vs. AV**: Traditional antivirus uses signature matching; EDR uses behavioral analysis and telemetry to detect fileless malware and zero-days that have no known signature
- **Hardening** reduces attack surface: disable unused ports/services, enforce least privilege, and apply CIS Benchmarks — all testable Security+ concepts
- **Mobile Device Management (MDM)** enforces endpoint policies on smartphones, including remote wipe — critical for BYOD environments
- **Host-based firewalls and IDS (HIDS)** monitor traffic and system activity at the device level, independent of network-layer controls
- **Patch management** is the #1 endpoint control — unpatched vulnerabilities account for the majority of successful endpoint compromises per CISA data

## Related concepts
[[Endpoint Detection and Response (EDR)]] [[Mobile Device Management (MDM)]] [[Host-based Intrusion Detection System (HIDS)]] [[Patch Management]] [[Zero Trust Architecture]]