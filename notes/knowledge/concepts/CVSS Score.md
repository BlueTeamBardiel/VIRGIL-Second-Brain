# CVSS Score

## What it is
Think of it like a restaurant health inspection score: it doesn't tell you what's on the menu, just how dangerous eating there might be. The Common Vulnerability Scoring System (CVSS) is a standardized, open framework that assigns vulnerabilities a numerical severity score from 0.0 to 10.0, allowing organizations to objectively compare and prioritize remediation efforts across different systems and vendors.

## Why it matters
When the Log4Shell vulnerability (CVE-2021-44228) dropped in December 2021, its CVSS score of 10.0 immediately signaled to every security team worldwide that this required emergency patching — no further debate needed. Organizations used that single number to justify bypassing normal change management processes and pushing emergency fixes within hours, preventing ransomware groups from establishing footholds before patches could be deployed.

## Key facts
- CVSS v3.1 calculates scores across three metric groups: **Base** (intrinsic vulnerability properties), **Temporal** (exploit maturity and patch availability), and **Environmental** (organization-specific impact adjustments)
- Base Score ranges map to severity ratings: 0.0 = None, 0.1–3.9 = Low, 4.0–6.9 = Medium, 7.0–8.9 = High, 9.0–10.0 = Critical
- Key Base metrics include **Attack Vector** (Network, Adjacent, Local, Physical), **Attack Complexity**, **Privileges Required**, **User Interaction**, and **CIA Impact** ratings
- CVSS is maintained by FIRST (Forum of Incident Response and Security Teams) and is used by the NVD (National Vulnerability Database) to score all published CVEs
- CVSS measures *severity*, not *risk* — a 10.0 vulnerability on an air-gapped system may be lower priority than a 6.5 vulnerability exposed to the internet

## Related concepts
[[CVE]] [[Vulnerability Management]] [[Risk Prioritization]] [[National Vulnerability Database]] [[Patch Management]]