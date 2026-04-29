# CVSS

## What it is
Like the Richter scale for earthquakes, CVSS gives every vulnerability a standardized numeric score so organizations worldwide can compare severity using the same ruler. The Common Vulnerability Scoring System (CVSS) is an open framework that produces a 0.0–10.0 score by evaluating a vulnerability's attack vector, complexity, required privileges, user interaction, and impact on confidentiality, integrity, and availability.

## Why it matters
When Log4Shell (CVE-2021-44228) dropped in December 2021, it received a CVSS 3.1 base score of 10.0 — the maximum. That single number immediately communicated to security teams globally that this required emergency patching priority, enabling coordinated response without waiting for individual vendor assessments to align.

## Key facts
- **Three score groups:** Base (intrinsic severity, never changes), Temporal (changes as exploits/patches emerge), and Environmental (customized to your specific infrastructure)
- **Base score metrics split into two groups:** Exploitability metrics (Attack Vector, Attack Complexity, Privileges Required, User Interaction) and Impact metrics (Confidentiality, Integrity, Availability)
- **Severity ranges:** None (0.0), Low (0.1–3.9), Medium (4.0–6.9), High (7.0–8.9), Critical (9.0–10.0)
- **CVSS v3.1 added Scope metric** — distinguishing whether a vulnerability can impact components beyond its authorization boundary (e.g., a VM escape affecting the hypervisor)
- **CVSS scores vulnerabilities in isolation** — they don't account for asset value, threat intelligence, or existing compensating controls, which is why Environmental scores exist and why raw base scores alone can mislead patching prioritization

## Related concepts
[[CVE]] [[NVD]] [[Vulnerability Management]] [[Risk Scoring]] [[Patch Management]]