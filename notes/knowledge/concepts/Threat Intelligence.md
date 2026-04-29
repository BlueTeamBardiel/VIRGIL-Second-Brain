# threat intelligence

## What it is
Like a neighborhood watch that doesn't just report break-ins but tracks *which crew* is operating, *what tools* they use, and *which houses* they target next — threat intelligence is the collection, analysis, and contextualization of data about adversaries to support proactive defense decisions. It transforms raw indicators (an IP address, a file hash) into actionable knowledge: who is attacking, how, and why.

## Why it matters
In 2020, the SolarWinds supply chain attack went undetected for months partly because defenders lacked threat intelligence linking the SUNBURST malware's C2 beacon patterns to known APT29 (Cozy Bear) TTPs. Organizations subscribed to threat intel feeds who received IOCs post-discovery could immediately hunt their own environments for matching artifacts and isolate compromised systems within hours rather than weeks.

## Key facts
- Threat intelligence has **three tiers**: Strategic (executive-level, geopolitical trends), Operational (campaign details, attacker motives), and Tactical (specific IOCs like hashes, IPs, domains)
- The **MITRE ATT&CK framework** is the standard vocabulary for mapping threat intel to adversary TTPs (Tactics, Techniques, and Procedures)
- **STIX/TAXII** is the open standard for formatting (STIX) and sharing (TAXII) threat intelligence between organizations and platforms
- **ISACs** (Information Sharing and Analysis Centers) are sector-specific organizations (e.g., FS-ISAC for finance) that distribute vetted threat intelligence to member companies
- Intelligence has a **half-life** — IP-based IOCs can become stale within 24–48 hours as attackers rotate infrastructure, while TTP-based intel remains valid much longer

## Related concepts
[[indicators of compromise]] [[MITRE ATT&CK]] [[security information and event management]]