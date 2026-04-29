# Dell PowerScale OneFS

## What it is
Think of it like a single giant hard drive that's secretly dozens of drives stitched together — a distributed filesystem that presents as one unified volume. Dell PowerScale OneFS is a scale-out NAS (Network-Attached Storage) operating system that manages petabyte-scale unstructured data across clusters of nodes, making them appear as a single filesystem with a single namespace.

## Why it matters
In 2023, CVE-2023-32484 and related vulnerabilities in OneFS allowed privilege escalation and remote code execution — attackers targeting healthcare and media companies used these flaws to pivot from compromised endpoints to the storage cluster, exfiltrating terabytes of sensitive data before detection. Because OneFS centralizes massive data stores, a single misconfiguration (like leaving the InsightIQ management interface exposed or using default admin credentials on the web UI) can result in catastrophic bulk data theft rather than a single-machine breach.

## Key facts
- OneFS runs on a hardened Linux kernel and uses a proprietary distributed lock manager — not a standard Windows/SMB-only system, so standard AD-centric security tools may miss its attack surface
- Supports multi-protocol access (SMB, NFS, HDFS, S3) — each protocol introduces its own misconfiguration risks and authentication vectors
- Role-Based Access Control (RBAC) is built-in, but the default "root" equivalent account (`admin`) has historically shipped with weak defaults in older versions
- Audit logging via the OneFS native auditing subsystem can forward to SIEM via CEF — critical for CySA+ scenarios involving NAS-targeted lateral movement
- CVE scoring for OneFS vulnerabilities frequently hits CVSS 9.x due to the blast radius of a compromised petabyte-scale storage node

## Related concepts
[[Network-Attached Storage Security]] [[Privilege Escalation]] [[CVE Vulnerability Scoring]] [[RBAC]] [[Lateral Movement]]