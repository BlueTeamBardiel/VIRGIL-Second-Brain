# Credentialed vs. Uncredentialed Scanning

## What it is
Think of it like the difference between a home inspector who has a key to every room versus one who can only walk around the outside and peer through windows. Credentialed scanning provides the scanner with valid login credentials (admin accounts, SSH keys, WMI access) to examine a system from the inside, while uncredentialed scanning probes a target externally, inferring vulnerabilities only from what's visible over the network.

## Why it matters
In the 2021 Colonial Pipeline breach, attackers exploited a VPN account — a vulnerability that an uncredentialed scan would likely miss entirely since it requires authenticated access to enumerate installed software versions and patch levels. A credentialed scan of that endpoint would have surfaced the outdated, unpatched VPN client, giving defenders the opportunity to remediate before attackers arrived.

## Key facts
- **Credentialed scans** produce significantly fewer false positives and dramatically more false negative reduction — they can read registry keys, installed package lists, and local config files directly
- **Uncredentialed scans** simulate what an external attacker sees: open ports, service banners, and network-exposed vulnerabilities only
- Credentialed scans require a **dedicated, least-privilege scanning account** — never use a domain admin credential to avoid credential exposure risk
- On Windows targets, credentialed scanning typically uses **WMI or SMB**; on Linux, **SSH** is the standard protocol
- Security+ and CySA+ both emphasize that credentialed scanning is preferred for **compliance audits** (PCI-DSS, HIPAA) because it provides complete patch visibility

## Related concepts
[[Vulnerability Scanning]] [[Patch Management]] [[Least Privilege]] [[False Positives and False Negatives]] [[Agent-Based vs. Agentless Scanning]]