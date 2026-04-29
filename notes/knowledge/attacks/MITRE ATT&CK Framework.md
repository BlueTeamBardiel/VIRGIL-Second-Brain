# MITRE ATT&CK Framework

## What it is
Think of it as a universal field guide to adversary behavior — the way a birdwatcher's handbook catalogs every known species by observable traits. ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge) is a curated, structured knowledge base that documents how real-world threat actors operate, organized by **tactics** (the *why*), **techniques** (the *how*), and **sub-techniques** (the *exactly how*). It's built from observed intrusions, not theoretical threats.

## Why it matters
During the SolarWinds supply chain attack (2020), responders used ATT&CK to rapidly categorize SUNBURST malware behaviors — mapping its use of **T1195.002 (Compromise Software Supply Chain)** and **T1071.001 (Web Protocols for C2)** — which let different teams speak a shared language and prioritize detection gaps without reinventing terminology from scratch.

## Key facts
- The framework is organized into **14 tactics** for Enterprise (e.g., Initial Access, Execution, Persistence, Exfiltration, Impact)
- Contains **over 600 techniques and sub-techniques** across Enterprise, Mobile, and ICS matrices
- Each technique entry includes real **threat actor group examples** (e.g., APT29, Lazarus Group) and detection/mitigation guidance
- MITRE ATT&CK Navigator is a free tool that lets defenders **heat-map coverage** — visually showing which techniques your controls detect vs. leave blind
- Directly used in **threat intelligence sharing**, red/blue team exercises, and SOC detection engineering; CySA+ exam expects you to understand it as a defensive mapping tool, not just an offensive catalog

## Related concepts
[[Cyber Kill Chain]] [[Threat Intelligence]] [[NIST Cybersecurity Framework]] [[Indicators of Compromise]] [[Purple Teaming]]