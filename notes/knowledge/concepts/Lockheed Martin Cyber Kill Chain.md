# Lockheed Martin Cyber Kill Chain

## What it is
Like a burglar who must first case the house, pick the lock, slip inside, and crack the safe — failing at any step ends the heist — the Kill Chain models an intrusion as a sequential chain of stages an attacker *must* complete in order. Developed by Lockheed Martin in 2011, it is a 7-phase framework describing the lifecycle of a targeted cyberattack, from initial reconnaissance through final objective achievement.

## Why it matters
During the 2013 Target breach, attackers followed the Kill Chain precisely: they reconnaissance'd a third-party HVAC vendor, delivered malware via phishing (weaponization/delivery), and ultimately exfiltrated 40 million credit card numbers. Defenders who had detected the C2 communication stage (Command & Control) could have broken the chain and prevented exfiltration — illustrating why early-stage detection is so operationally valuable.

## Key facts
- **7 phases in order:** Reconnaissance → Weaponization → Delivery → Exploitation → Installation → Command & Control (C2) → Actions on Objectives
- **Weaponization** is the only phase where the attacker operates entirely offline — defenders have zero visibility into it
- Breaking the chain at *any* phase stops the attack; defenders don't need to block all seven stages
- The model is **defender-centric**: each phase maps to specific defensive countermeasures (detect, deny, disrupt, degrade, deceive, destroy)
- Critics note it was designed for **APT/external intrusion** scenarios and underperforms against insider threats or attacks that skip phases (e.g., physical access skips delivery entirely)
- On Security+/CySA+ exams, **C2** is the phase associated with beaconing, IRC channels, and DNS tunneling for attacker communication

## Related concepts
[[MITRE ATT&CK Framework]] [[Advanced Persistent Threat]] [[Indicators of Compromise]] [[Diamond Model of Intrusion Analysis]] [[Threat Intelligence]]