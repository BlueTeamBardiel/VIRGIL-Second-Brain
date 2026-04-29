# GVM

## What it is
Think of GVM like a building inspector who visits every room in your house, checks every outlet, window latch, and smoke detector against a master code book, then hands you a prioritized punch list. Greenbone Vulnerability Management (GVM) is an open-source vulnerability scanning framework — the successor to OpenVAS — that continuously discovers, assesses, and reports security weaknesses across networked assets using a regularly updated feed of Network Vulnerability Tests (NVTs).

## Why it matters
A security analyst at a mid-sized hospital runs a GVM authenticated scan against their internal network and discovers three unpatched Windows servers still vulnerable to EternalBlue (MS17-010) — the same exploit used in WannaCry. Without that scan, those servers remain silent targets; with it, the team can prioritize patching before ransomware operators do their own reconnaissance with similar tooling.

## Key facts
- GVM replaced the standalone OpenVAS project; the core scanner (openvas-scanner) feeds into a centralized **Greenbone Security Assistant (GSA)** web interface
- Uses **NVTs (Network Vulnerability Tests)** — a regularly updated plugin feed analogous to Nessus's NASL plugins — exceeding 100,000 checks
- Supports both **unauthenticated** (external attacker view) and **authenticated** (credentialed, deeper OS-level) scans; credentialed scans dramatically reduce false negatives
- Scan results are scored using **CVSS** (Common Vulnerability Scoring System), enabling risk-based prioritization for remediation
- Runs natively on Linux (commonly Kali or dedicated Greenbone appliances); default management port is **9390/TCP** for the GVM daemon (gvmd)

## Related concepts
[[Vulnerability Scanning]] [[OpenVAS]] [[CVSS]] [[Nessus]] [[Credentialed vs Uncredentialed Scans]]