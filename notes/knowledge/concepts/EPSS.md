# EPSS

## What it is
Like a weather forecast for vulnerabilities — instead of telling you *how severe* a storm is, it tells you *how likely* it is to actually hit your neighborhood this week. The Exploit Prediction Scoring System (EPSS) is a machine learning-based model that estimates the **probability** (0–100%) that a given CVE will be actively exploited in the wild within the next 30 days. Developed by FIRST, it complements CVSS by adding exploitation likelihood to the severity picture.

## Why it matters
A security team staring at 3,000 vulnerabilities can't patch everything at once. A CVE might carry a CVSS score of 9.8 but have an EPSS score of 0.04% — meaning real-world exploitation is nearly nonexistent — while a CVSS 6.5 vulnerability might carry an EPSS of 87%, indicating active attacker tooling exists. Prioritizing by EPSS lets defenders focus remediation effort where actual exploitation risk is highest, rather than chasing theoretical severity.

## Key facts
- EPSS scores range from **0 to 1.0** (or 0–100%), representing the probability of exploitation within **30 days**
- EPSS is maintained by **FIRST** (Forum of Incident Response and Security Teams), the same body that manages CVSS
- It uses threat intelligence feeds, dark web data, honeypot telemetry, and IDS/IPS signals as model inputs
- EPSS v3 (released 2023) dramatically improved accuracy, with AUC scores above 0.86
- EPSS addresses a key CVSS weakness: CVSS measures **impact severity**, not **likelihood of exploitation** — the two are often uncorrelated
- Used in combination with CVSS and KEV (CISA's Known Exploited Vulnerabilities catalog) for robust vulnerability prioritization

## Related concepts
[[CVSS]] [[CVE]] [[Vulnerability Management]] [[CISA KEV Catalog]] [[Risk-Based Patching]]