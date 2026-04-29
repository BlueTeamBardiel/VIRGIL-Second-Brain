# log files

## What it is
Think of log files as a ship's captain's log — a timestamped, sequential record of everything that happened aboard, written in the moment, not reconstructed afterward. Precisely: log files are system-generated records that capture events, errors, access attempts, and state changes across operating systems, applications, and network devices. They are the primary raw material for forensic investigation and real-time threat detection.

## Why it matters
During the 2020 SolarWinds attack, investigators relied heavily on log files from Azure Active Directory and on-premises systems to reconstruct lateral movement and identify compromised accounts — but many victims had insufficient log retention policies, creating critical blind spots. Proper log collection and preservation is the difference between a full incident reconstruction and educated guessing. Attackers know this, which is why log tampering and deletion (often targeting Windows Event Log service) is a standard post-compromise step.

## Key facts
- **Windows Event Logs** use three primary channels: Security (logon events, policy changes), System (OS events), and Application (software errors) — Event ID 4624 (successful logon) and 4625 (failed logon) are critical for CySA+
- **Syslog** (UDP/TCP port 514) is the standard protocol for forwarding logs from Linux systems and network devices to a centralized collector
- Log files should be forwarded to a **SIEM** (Security Information and Event Management) in real time; local-only logs can be deleted by an attacker with sufficient privileges
- **Log integrity** can be protected using write-once storage, cryptographic hashing, or sending logs off-system immediately — key for forensic admissibility
- Regulatory frameworks like **PCI-DSS** require log retention for a minimum of 12 months, with at least 3 months immediately available

## Related concepts
[[SIEM]] [[forensic analysis]] [[Windows Event Viewer]] [[syslog]] [[chain of custody]]