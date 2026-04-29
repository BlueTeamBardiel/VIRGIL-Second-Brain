# MITRE ATT&CK

## What it is
Think of it as a bird-watcher's field guide, but instead of cataloging species by plumage and habitat, it catalogs adversaries by *how* they actually behave during attacks. MITRE ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge) is a curated, publicly available framework that organizes real-world attacker behaviors into a structured matrix of Tactics (the *why*) and Techniques (the *how*). It is built from observed threat intelligence, not theoretical scenarios.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat hunters used ATT&CK mappings to rapidly identify that the SUNBURST malware used **T1195.002** (Compromise Software Supply Chain) and **T1027** (Obfuscated Files or Information), allowing defenders across multiple organizations to align detection rules to the same vocabulary and share actionable intelligence efficiently. Without a common framework, each team would have been describing the same threat in incompatible terms.

## Key facts
- The matrix is organized into **14 Tactics** (Enterprise), representing attacker goals such as Initial Access, Persistence, Lateral Movement, and Exfiltration
- Each Tactic contains multiple **Techniques** and **Sub-techniques** — over 400 techniques exist in the Enterprise matrix
- ATT&CK covers three main technology domains: **Enterprise**, **Mobile**, and **ICS** (Industrial Control Systems)
- **Navigator** is MITRE's free web tool for visualizing and heat-mapping ATT&CK coverage against your detection controls
- CySA+ exam expects candidates to use ATT&CK for **threat hunting**, **gap analysis**, and mapping **detection coverage** to specific adversary behaviors

## Related concepts
[[Cyber Kill Chain]] [[Threat Intelligence]] [[Indicators of Compromise]] [[SIGMA Rules]] [[Purple Teaming]]