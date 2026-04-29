# Nessus

## What it is
Like a building inspector who checks every door, window, pipe, and electrical outlet for code violations before a tenant moves in — Nessus is a vulnerability scanner that systematically probes hosts for known misconfigurations, missing patches, and exploitable weaknesses. Developed by Tenable, it performs credentialed and non-credentialed scans against live systems, comparing findings against a continuously updated plugin database tied to CVE identifiers.

## Why it matters
During a routine internal audit, a security team runs a credentialed Nessus scan against a Windows file server and discovers it's missing MS17-010 patches — the exact vulnerability exploited by EternalBlue and WannaCry. Without that scan, the server sits as a silent entry point; with it, the team patches before an attacker pivots laterally across the entire domain.

## Key facts
- Nessus uses **plugins** (over 170,000+) to check for specific vulnerabilities; each plugin maps to a CVE and produces a CVSS severity score (Critical, High, Medium, Low, Info)
- **Credentialed scans** provide deeper results by logging into the target — finding locally installed software versions and registry-level misconfigurations that unauthenticated scans miss
- **Nessus Essentials** (free) is limited to 16 IP addresses; **Nessus Professional** and **Tenable.io** are commercial products used in enterprise environments
- Outputs can be exported as **.nessus XML, PDF, or CSV** for integration with SIEMs or ticketing systems during remediation workflows
- Nessus is **passive-scan capable** via Tenable's Network Monitor component but defaults to active scanning, which can trigger IDS/IPS alerts if not whitelisted

## Related concepts
[[Vulnerability Scanning]] [[OpenVAS]] [[CVSS Scoring]] [[Credentialed vs Non-Credentialed Scans]] [[Patch Management]]