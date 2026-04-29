# System Hardening

## What it is
Think of a new house: it ships with unlocked windows, a default spare key under the mat, and an open garage — hardening means locking every entry point you don't actively need. Precisely, system hardening is the process of reducing a system's attack surface by disabling unnecessary services, removing default credentials, applying patches, and enforcing least-privilege configurations. The goal is to eliminate every foothold an attacker could exploit that isn't required for the system's legitimate function.

## Why it matters
In the 2017 Equifax breach, attackers exploited Apache Struts running on a system that was both unpatched and exposed unnecessary web-facing services — a hardened baseline would have caught the missing patch during configuration audits and potentially restricted the service's network exposure. A properly hardened system forces attackers to work harder with fewer options, turning a quick compromise into a difficult, noisy operation.

## Key facts
- **CIS Benchmarks** are the industry-standard hardening guides; they provide scored, level-based configurations for OSes, databases, and network devices
- Disabling **unnecessary ports and services** (e.g., Telnet, FTP, SMBv1) is a foundational hardening step tested on Security+
- **Default credential removal** is mandatory — devices shipped with admin/admin or root/root are trivially exploited via credential-stuffing automation
- **Group Policy Objects (GPOs)** in Windows environments enforce hardening settings (password complexity, account lockout, audit policies) at scale across a domain
- Hardening is distinct from patching — you can have a fully patched system that is still misconfigured and wide open

## Related concepts
[[Attack Surface Reduction]] [[Least Privilege]] [[Patch Management]] [[Configuration Management]] [[CIS Benchmarks]]