# OpenVAS

## What it is
Think of OpenVAS as a building inspector who carries a master list of every known structural defect ever recorded — it systematically walks through your network checking each system against that list. Precisely: OpenVAS (Open Vulnerability Assessment System) is a free, open-source vulnerability scanner that identifies security weaknesses in hosts by running thousands of Network Vulnerability Tests (NVTs) against target systems. It is the open-source fork of Nessus, maintained by Greenbone Networks under the Greenbone Vulnerability Management (GVM) framework.

## Why it matters
A security analyst at a mid-sized company runs a weekly OpenVAS scan and discovers an unpatched Apache server exposing CVE-2021-41773 (path traversal/RCE). Without that scheduled scan, an attacker could have exploited the public-facing server for initial access before the patch cycle even identified the gap — catching it early turns a potential breach into a routine patch ticket.

## Key facts
- OpenVAS uses a feed of **Network Vulnerability Tests (NVTs)** — numbering 50,000+ — updated regularly via the Greenbone Community Feed or paid Enterprise Feed
- It operates in a **client-server architecture**: the OpenVAS Scanner engine runs tests, while the Greenbone Security Assistant (GSA) provides the web UI
- Scans can be **credentialed (authenticated)** or **unauthenticated** — credentialed scans detect far more vulnerabilities by examining patch levels and configurations locally
- Results are **CVSS-scored**, making it directly applicable to risk prioritization workflows required in CySA+ scenarios
- OpenVAS is **not a replacement for penetration testing** — it identifies known vulnerabilities but cannot chain exploits or demonstrate actual impact

## Related concepts
[[Nessus]] [[Vulnerability Scanning]] [[CVSS Scoring]] [[Credentialed vs Uncredentialed Scans]] [[Patch Management]]