# kill chain

## What it is
Like a heist movie where the crew must case the bank, forge IDs, cut the power, and crack the safe in sequence — if you stop any one step, the whole job fails. The **Cyber Kill Chain** (developed by Lockheed Martin) is a 7-stage model describing the sequential phases an attacker must complete to achieve their objective, from initial reconnaissance through final data exfiltration. The core insight is that defenders can break the attack at *any* stage to neutralize the threat.

## Why it matters
During the 2013 Target breach, attackers followed the kill chain precisely: they reconned a third-party HVAC vendor, delivered malware via phishing, installed a RAT, and then pivoted laterally to POS systems. Had defenders detected the unusual credential usage during the **lateral movement** phase, they could have stopped exfiltration of 40 million credit card numbers before it occurred.

## Key facts
- The 7 stages are: **Reconnaissance → Weaponization → Delivery → Exploitation → Installation → Command & Control (C2) → Actions on Objectives**
- Weaponization is the *only* stage where defenders have zero direct visibility — it happens entirely on the attacker's infrastructure
- Breaking the chain earlier is always cheaper; stopping at Delivery costs far less than responding after exfiltration
- The model is criticized for being perimeter-focused and less effective against insider threats or living-off-the-land (LotL) attacks
- MITRE ATT&CK was developed partly to address kill chain's limitations by mapping *specific adversary techniques* rather than broad phases

## Related concepts
[[MITRE ATT&CK]] [[lateral movement]] [[command and control]] [[threat intelligence]] [[indicators of compromise]]