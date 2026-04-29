# Qualys

## What it is
Think of Qualys like a building inspector who walks through every room of your house on a schedule, cataloging cracked foundations, faulty wiring, and unlocked windows — except the "house" is your entire network infrastructure. Qualys is a cloud-based vulnerability management platform that continuously scans networks, endpoints, web applications, and cloud environments to identify, prioritize, and track security vulnerabilities against known CVE databases.

## Why it matters
During the Log4Shell crisis (CVE-2021-44228), organizations using Qualys were able to run targeted scans within hours to identify every internet-facing and internal asset running vulnerable versions of Log4j — a task that would have taken weeks manually across thousands of hosts. Without continuous scanning, many organizations had no idea how deeply Log4j was embedded in third-party software and appliances, leaving them blind while attackers actively exploited the flaw.

## Key facts
- Qualys uses a **agent-based and agentless scanning** model; lightweight agents (Cloud Agents) provide continuous telemetry without requiring network-level access or credentials
- The **Qualys VMDR** (Vulnerability Management, Detection and Response) product maps findings directly to CVSS scores and integrates threat intelligence to prioritize which vulnerabilities are being actively exploited in the wild
- Qualys is **PCI DSS compliant** and commonly used to satisfy Requirement 11.3 (external vulnerability scanning must be performed by an Approved Scanning Vendor — Qualys holds ASV status)
- Qualys Web Application Scanning (WAS) maps to the **OWASP Top 10** and can detect SQL injection, XSS, and authentication flaws in web apps
- Scan results feed into **QRadar, Splunk, and ServiceNow** integrations, connecting vulnerability data to SIEM and ticketing workflows for remediation tracking

## Related concepts
[[Vulnerability Scanning]] [[CVSS Scoring]] [[CVE Database]] [[Patch Management]] [[Nessus]]