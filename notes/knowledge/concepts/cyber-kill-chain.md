# cyber-kill-chain

## What it is
Like a surgeon breaking down an operation into discrete, ordered steps where stopping at any stage prevents completion, the Cyber Kill Chain is Lockheed Martin's 7-phase framework modeling how adversaries execute attacks from first reconnaissance through final objective. Each phase represents a point where defenders can detect, deny, disrupt, degrade, deceive, or destroy the attacker's progress.

## Why it matters
During the 2013 Target breach, attackers followed a textbook kill chain: they reconnaissance'd Target's vendor portal, weaponized a phishing email, delivered it to HVAC contractor Fazio Mechanical, and eventually exploited that foothold to exfiltrate 40 million credit card numbers. Had defenders cut the chain at the lateral movement phase, the data breach never happens — the framework shows *exactly* where that intervention window existed.

## Key facts
- The 7 phases in order: **Reconnaissance → Weaponization → Delivery → Exploitation → Installation → Command & Control (C2) → Actions on Objectives**
- Weaponization happens entirely on the attacker's infrastructure — defenders have *zero* visibility into this phase
- Breaking the chain at early phases (Reconnaissance or Delivery) is exponentially cheaper than responding at Actions on Objectives
- A key criticism: the model is perimeter-focused and poorly models insider threats or attacks that begin inside the network
- MITRE ATT&CK was developed partly to address the Kill Chain's limitations by mapping specific adversary *techniques*, not just phases

## Related concepts
[[MITRE-ATT&CK]] [[threat-intelligence]] [[indicators-of-compromise]] [[lateral-movement]] [[command-and-control]]