# Server hardening

## What it is
Think of a new server like a Swiss Army knife fresh out of the box — it comes with every blade open and ready, most of which you'll never use, each one a potential cut. Server hardening is the disciplined process of closing every unnecessary blade: disabling unused services, removing default accounts, applying patches, and configuring secure baselines to minimize the attack surface of a system before (and after) deployment.

## Why it matters
In 2021, attackers exploited default credentials and an unpatched Microsoft Exchange Server (ProxyLogon, CVE-2021-26855) to deploy web shells and move laterally across thousands of organizations. A hardened Exchange instance — with unnecessary services disabled, patches applied, and default accounts removed — would have closed the primary entry points attackers relied on. This single vulnerability chain compromised over 250,000 servers worldwide.

## Key facts
- **CIS Benchmarks** and **DISA STIGs** are the two primary industry-standard frameworks for server hardening checklists — know both for CySA+.
- Disabling unnecessary services reduces attack surface; the principle is called **minimization** or **least functionality** (NIST SP 800-53 CM-7).
- Default credentials must be changed immediately — they are catalogued publicly in databases like CIRT.net and exploited within minutes of exposure.
- **Group Policy Objects (GPOs)** in Windows environments are commonly used to enforce hardening settings at scale across multiple servers.
- Hardening is not a one-time event — it requires continuous validation through **configuration management** and periodic **security audits** to detect drift from the secure baseline.

## Related concepts
[[Attack surface reduction]] [[Least privilege]] [[Patch management]] [[Configuration management]] [[CIS Benchmarks]]