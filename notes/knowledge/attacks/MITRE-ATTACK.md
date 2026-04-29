# MITRE-ATTACK

## What it is
Think of it as a universal field guide to predators — like how biologists catalog every known hunting behavior of dangerous animals. MITRE ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge) is a globally accessible, curated knowledge base of real-world adversary behaviors, organized by tactics (the *why*) and techniques (the *how*). It is built from observed threat intelligence, not theory, making it a living reference grounded in actual intrusions.

## Why it matters
During the 2020 SolarWinds breach, defenders used MITRE ATT&CK to rapidly map the attacker's behavior — identifying techniques like **T1195 (Supply Chain Compromise)** and **T1078 (Valid Accounts)** — which allowed incident responders to prioritize hunting and detection rules across thousands of affected organizations. Without a common language like ATT&CK, different teams would describe the same attack behavior in incompatible ways, slowing coordinated response.

## Key facts
- ATT&CK is organized into **14 tactics** (e.g., Initial Access, Persistence, Lateral Movement, Exfiltration) representing attacker goals at each stage
- Each tactic contains numbered **techniques** (e.g., T1059) and **sub-techniques** (e.g., T1059.001 for PowerShell)
- Three main matrices exist: **Enterprise**, **Mobile**, and **ICS** (Industrial Control Systems)
- ATT&CK is free and maintained by MITRE — it is *not* a compliance framework but a threat-informed defense tool
- **ATT&CK Navigator** is the official visualization tool used to map coverage gaps in detection and defenses

## Related concepts
[[Cyber Kill Chain]] [[Threat Intelligence]] [[MITRE D3FEND]] [[Indicators of Compromise]] [[Purple Teaming]]