# File Integrity Monitor

## What it is
Like a museum security guard who photographs every painting at closing time and compares photos each morning to detect tampering, a File Integrity Monitor (FIM) takes cryptographic snapshots of files and alerts when those snapshots no longer match. It continuously or periodically hashes critical system files, configurations, and binaries, then flags any unauthorized changes to size, permissions, content, or timestamps.

## Why it matters
During the 2020 SolarWinds supply chain attack, attackers modified the legitimate Orion software build process to inject malicious code into a DLL. A properly deployed FIM monitoring the build pipeline's output files could have detected the hash mismatch between the expected and tampered DLL before distribution to thousands of organizations.

## Key facts
- FIM uses cryptographic hashing (typically SHA-256) to create a baseline; any delta in the hash value triggers an alert regardless of how small the file change is
- PCI DSS Requirement 11.5 explicitly mandates FIM deployment to monitor critical system files, configuration files, and content files
- FIM operates in two modes: **agent-based** (software on the monitored host) and **agentless** (network-based polling), with agent-based providing real-time detection
- Common FIM tools include Tripwire, OSSEC, and the built-in Windows File System auditing via Event ID 4663
- FIM is a detective control, not a preventive one — it identifies changes *after* they occur, making alert response speed critical to its effectiveness

## Related concepts
[[Tripwire]] [[HIDS]] [[Change Management]] [[Baseline Configuration]] [[Log Monitoring]]