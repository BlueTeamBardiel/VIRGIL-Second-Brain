# Threats, Vulnerabilities, and Mitigations

## What it is
Think of a bank vault: the *threat* is the robber who wants in, the *vulnerability* is the cheap lock on the side door, and the *mitigation* is the guard posted there. Precisely: a **threat** is any potential cause of harm to an asset; a **vulnerability** is a weakness that a threat can exploit; and a **mitigation** is a control that reduces the likelihood or impact of that exploitation.

## Why it matters
In 2021, attackers exploited an unpatched ProxyLogon vulnerability (CVE-2021-26855) in Microsoft Exchange servers — the threat actors were nation-state groups, the vulnerability was an unauthenticated SSRF flaw, and organizations that applied Microsoft's emergency patch within 48 hours largely avoided compromise. This case illustrates how all three concepts interact in real time under operational pressure.

## Key facts
- **Threat actors** are categorized by motivation and capability: nation-states, hacktivists, insider threats, script kiddies, and organized crime each carry different risk profiles.
- A vulnerability has a **CVSS score** (0–10) that quantifies severity based on attack vector, complexity, privileges required, and impact — critical is 9.0–10.0.
- **Threat × Vulnerability = Risk** — if no vulnerability exists, a threat cannot cause harm; if no threat exists, a vulnerability is inconsequential.
- Mitigations follow three control categories: **preventive** (firewalls), **detective** (SIEM alerts), and **corrective** (patching after exploitation).
- The **vulnerability management lifecycle** runs: identify → prioritize (by CVSS + asset criticality) → remediate → verify → report.

## Related concepts
[[Risk Management]] [[CVE and CVSS Scoring]] [[Threat Intelligence]] [[Patch Management]] [[Attack Surface Analysis]]