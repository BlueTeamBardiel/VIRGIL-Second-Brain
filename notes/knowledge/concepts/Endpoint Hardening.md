# Endpoint Hardening

## What it is
Think of a new laptop like a house straight from the contractor — doors unlocked, windows open, spare keys left under every mat. Endpoint hardening is the systematic process of closing those openings: disabling unnecessary services, removing default credentials, applying patches, and enforcing security policies to reduce the attack surface on workstations, servers, and mobile devices. The goal is to shrink what an attacker can reach before a single exploit is attempted.

## Why it matters
In the 2017 NotPetya outbreak, the malware spread laterally at devastating speed partly because thousands of Windows endpoints still had SMBv1 enabled — a decades-old protocol that should have been disabled years prior. Organizations that had hardened endpoints by disabling SMBv1 and applying MS17-010 were largely unaffected, demonstrating that configuration discipline stops attacks patches alone cannot.

## Key facts
- **CIS Benchmarks** and **DISA STIGs** are the industry-standard hardening baselines used to measure and enforce secure configurations on endpoints.
- Disabling **unnecessary services and ports** (e.g., Telnet, SMBv1, RDP where unused) directly reduces the number of exploitable entry points.
- **Application allowlisting** (e.g., Windows Defender Application Control) prevents unauthorized executables from running, blocking most malware by default.
- **Local Administrator Password Solution (LAPS)** ensures unique, rotated local admin passwords per machine, stopping credential-reuse lateral movement cold.
- Endpoint hardening is a core control in **NIST SP 800-53 (CM-6, CM-7)** and maps directly to CySA+ objectives around configuration management and vulnerability management.

## Related concepts
[[Attack Surface Reduction]] [[Configuration Management]] [[Patch Management]] [[Application Allowlisting]] [[Principle of Least Privilege]]