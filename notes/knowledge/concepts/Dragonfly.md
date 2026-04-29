# Dragonfly

## What it is
Like a master spy who first cases a bank by posing as a janitor, then returns to rob it — Dragonfly is an advanced persistent threat (APT) group that uses a two-phase strategy: initial reconnaissance and infection, followed by deeper sabotage capability. Specifically, Dragonfly (also called Energetic Bear or HAVEX) is a Russian-linked threat actor that has systematically targeted Western energy sector organizations, ICS/SCADA systems, and critical infrastructure since at least 2011.

## Why it matters
In the Dragonfly 2.0 campaign (2015–2017), attackers achieved what security researchers called "the assets to cause blackouts" — they successfully penetrated U.S. and European energy grid operational networks. They accomplished this through spear-phishing, watering hole attacks on energy industry websites, and trojanizing legitimate ICS software installers downloaded by engineers, demonstrating that supply chain compromise is a primary vector against hardened OT environments.

## Key facts
- Dragonfly used **trojanized software packages** from legitimate ICS vendors (including Siemens, GE, and MB Connect Line) as a supply chain attack vector
- The group deployed the **HAVEX RAT** (Remote Access Trojan), which specifically scanned for OT/ICS devices using the OPC protocol
- Classified as a **nation-state APT**, attributed to Russian intelligence (FSB/GRU) with high confidence by US-CERT and DHS
- Dragonfly 2.0 reached the **operational technology (OT) layer** — beyond IT networks into actual control systems — a critical escalation threshold
- Attack lifecycle followed classic **APT kill chain** stages: weaponization via watering holes → lateral movement → credential harvesting → ICS reconnaissance

## Related concepts
[[Advanced Persistent Threat]] [[ICS/SCADA Security]] [[Supply Chain Attack]] [[Watering Hole Attack]] [[HAVEX Malware]]