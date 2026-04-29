# File Integrity Monitoring

## What it is
Like a museum curator who photographs every artifact and checks each morning whether anything has been moved, scratched, or swapped — File Integrity Monitoring (FIM) continuously tracks cryptographic hashes of files and alerts when those hashes change unexpectedly. It detects unauthorized modifications to critical system files, configurations, and logs by comparing current state against a known-good baseline.

## Why it matters
During the 2020 SolarWinds supply chain attack, attackers modified the legitimate Orion software build process to inject a malicious DLL. A properly deployed FIM solution monitoring build artifacts and binaries could have flagged the unexpected hash change in SolarWinds.Orion.Core.BusinessLayer.dll before distribution — potentially catching the compromise before it propagated to thousands of downstream organizations.

## Key facts
- FIM is a **PCI DSS requirement** (Requirement 11.5) for monitoring critical system files, configuration files, and content files in cardholder data environments
- Baseline hashes are typically generated using **SHA-256** or stronger algorithms; MD5 is considered insufficient due to collision vulnerabilities
- FIM operates in two modes: **agent-based** (software runs on the monitored host) and **agentless** (hashes pulled remotely via API or protocol)
- Critical files to monitor include `/etc/passwd`, `/etc/shadow`, Windows SAM registry hive, web application files, and system binaries — not every file (alert fatigue kills effectiveness)
- FIM is a **detective control**, not preventive — it identifies changes after they occur and must be paired with change management to distinguish authorized from unauthorized modifications

## Related concepts
[[Tripwire]] [[Change Management]] [[Security Baseline]] [[Host-Based Intrusion Detection System]] [[Log Integrity]]