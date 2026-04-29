# OpenEdge

## What it is
Think of it like a self-contained diner with its own kitchen, waitstaff, and cash register — Progress OpenEdge is an all-in-one application development platform that bundles its own database (OpenEdge RDBMS), application server, and business logic layer into a single proprietary stack. It uses the ABL (Advanced Business Language, formerly 4GL) programming language and is widely deployed in healthcare, finance, and manufacturing enterprise environments.

## Why it matters
In 2023, a critical authentication bypass vulnerability (CVE-2024-1403) was discovered in Progress OpenEdge, allowing unauthenticated attackers to gain administrative access to the OpenEdge Management and OpenEdge Explorer web interfaces. Organizations running unpatched OpenEdge instances in healthcare environments exposed sensitive patient databases directly — mirroring the MOVEit-style supply chain risk pattern where trusted enterprise middleware becomes the attack entry point.

## Key facts
- **CVE-2024-1403** is a CVSS 10.0 critical authentication bypass affecting OpenEdge versions prior to 11.7.19, 12.2.14, and 12.8.1
- OpenEdge runs on TCP port **20931** (admin server) and **8810** by default — knowing default ports helps during network enumeration
- The platform's proprietary ABL language means standard code auditing tools often miss vulnerabilities — increasing dwell time for attackers
- OpenEdge databases use `.db` and `.bi` (before-image) file extensions — relevant during incident response and data recovery
- Patch management is critical: Progress Software has been a recurring target (MOVEit, WS_FTP, OpenEdge) making their products high-priority assets for threat actors

## Related concepts
[[Authentication Bypass]] [[CVE Scoring and CVSS]] [[Enterprise Middleware Vulnerabilities]] [[Patch Management]] [[Default Port Enumeration]]