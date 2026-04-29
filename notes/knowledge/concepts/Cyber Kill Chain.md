# Cyber Kill Chain

## What it is
Like a surgeon who must complete seven distinct steps to perform an operation — skipping any one step means the procedure fails — attackers must complete each phase of an intrusion in sequence. Developed by Lockheed Martin in 2011, the Cyber Kill Chain is a 7-phase framework modeling the stages an adversary must execute to achieve their objective, from initial reconnaissance through final action on target.

## Why it matters
During the 2013 Target breach, attackers followed the Kill Chain precisely: they recon'd a third-party HVAC vendor, weaponized a phishing email, delivered it, exploited credentials, installed malware on POS systems, and exfiltrated 40 million card numbers. Defenders who understood the Kill Chain recognized that breaking *any single phase* — such as blocking the C2 beacon during the Command & Control stage — would have severed the entire attack chain before exfiltration occurred.

## Key facts
- The 7 phases in order: **Reconnaissance → Weaponization → Delivery → Exploitation → Installation → Command & Control (C2) → Actions on Objectives**
- Defenders gain an asymmetric advantage: attackers must succeed at *every* phase; defenders only need to disrupt *one*
- Weaponization involves pairing an exploit with a payload (e.g., embedding a RAT inside a malicious PDF — no attacker-target interaction occurs here)
- The model is criticized for being perimeter-focused and weak against insider threats and lateral movement in cloud environments
- MITRE ATT&CK was developed partly to address Kill Chain's limitations by mapping granular adversary *techniques*, not just sequential phases

## Related concepts
[[MITRE ATT&CK]] [[Diamond Model of Intrusion Analysis]] [[Indicators of Compromise]] [[Command and Control]] [[Threat Intelligence]]