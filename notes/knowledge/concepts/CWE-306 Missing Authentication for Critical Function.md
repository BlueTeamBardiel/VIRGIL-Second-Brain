# CWE-306 Missing Authentication for Critical Function

## What it is
Imagine a bank vault with a combination lock on the front door — but a side door that opens with a simple push. CWE-306 occurs when software performs a sensitive or destructive operation (password reset, admin configuration, data deletion) without verifying *who* is asking. The critical function exists behind no gate at all, not a weak gate — just open air.

## Why it matters
In 2022, attackers exploited unauthenticated API endpoints in Hikvision IP cameras (CVE-2021-36260) to execute arbitrary commands with no credentials required — just a crafted HTTP request to an exposed administrative function. Patching required firmware updates across millions of deployed devices, many of which remained unpatched in production networks for years. This is a textbook CWE-306: the function existed, it was powerful, and authentication simply wasn't enforced.

## Key facts
- CWE-306 is distinct from weak authentication (CWE-287) — the problem isn't *bad* credentials, it's the *complete absence* of a credential check
- Commonly surfaces in internal APIs, debug endpoints, IoT management interfaces, and legacy administrative panels that developers assumed were "not reachable" from outside
- CVSS scores for CWE-306 vulnerabilities frequently reach **9.8 (Critical)** because network-accessible, unauthenticated RCE requires zero user interaction
- Defense requires explicit authentication enforcement at the function level, not just at the perimeter — network segmentation alone is insufficient
- Appears on the **OWASP Top 10** as part of A07:2021 (Identification and Authentication Failures) and in **CISA's Known Exploited Vulnerabilities catalog** regularly

## Related concepts
[[Broken Access Control]] [[CWE-287 Improper Authentication]] [[Insecure Direct Object Reference]] [[Defense in Depth]] [[API Security]]