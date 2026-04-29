# Greenbone

## What it is
Think of Greenbone as a doctor who does full-body MRIs on your network every day, cataloguing every bruise, fracture, and tumor before attackers find them. Greenbone is an open-source vulnerability management platform built around OpenVAS (Open Vulnerability Assessment Scanner), providing authenticated and unauthenticated scanning, reporting, and remediation tracking across networked systems.

## Why it matters
During a CySA+ scenario: a security analyst inherits an undocumented network of 300 servers and needs a baseline vulnerability assessment within 48 hours. Deploying Greenbone Community Edition with authenticated credentials against each host reveals 12 critical CVEs — including an unpatched Apache Log4Shell instance — that would have provided an attacker remote code execution. Without scheduled scanning, that vulnerability could persist undetected for months.

## Key facts
- Greenbone is built on **OpenVAS**, which uses a continuously updated **NVT (Network Vulnerability Test) feed** — analogous to antivirus signature updates but for vulnerability checks
- The platform uses a **GSP (Greenbone Security Protocol)** architecture separating the scanner, manager daemon (gvmd), and web interface (GSA — Greenbone Security Assistant)
- Supports both **authenticated scanning** (agent-based, deeper visibility) and **unauthenticated scanning** (external attacker perspective)
- Vulnerabilities are scored using **CVSS** (Common Vulnerability Scoring System), allowing analysts to prioritize critical findings above a 7.0 threshold
- Greenbone Community Edition is free; **Greenbone Enterprise** appliances add compliance reporting for frameworks like **PCI-DSS and ISO 27001**

## Related concepts
[[OpenVAS]] [[Vulnerability Scanning]] [[CVSS]] [[Nessus]] [[Patch Management]]