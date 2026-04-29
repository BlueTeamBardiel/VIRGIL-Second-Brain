# Threat Model

## What it is
Like a chess player who maps out every possible move an opponent might make before the game begins, a threat model is a structured analysis that identifies *who* might attack a system, *what* they want, *how* they could get it, and *what defenses* stand in the way. It is a formal methodology for anticipating adversarial behavior before systems are built or breached, transforming vague risk into actionable, prioritized security decisions.

## Why it matters
In 2013, Target's breach began through an HVAC vendor with network access — a third-party risk that a rigorous threat model would have flagged as a high-value attack path. Had Target mapped their supply chain as a threat vector and identified that vendor credentials could pivot into the payment network, compensating controls (network segmentation, least privilege) could have blocked the attack that exposed 40 million card numbers.

## Key facts
- **STRIDE** is the dominant threat modeling framework: Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege — each maps to a violated security property
- **DREAD** provides a scoring model for threat severity: Damage, Reproducibility, Exploitability, Affected Users, Discoverability
- Threat models identify **trust boundaries** — the lines where data or control passes between components of different privilege or ownership
- **Attack trees** are a visual tool within threat modeling: the root node is the attacker's goal; branches represent alternative methods to achieve it
- Threat modeling is most effective when done **during the design phase** (shift-left security), not after deployment — remediation costs increase exponentially as systems mature

## Related concepts
[[Attack Surface]] [[STRIDE Framework]] [[Attack Tree]] [[Defense in Depth]] [[Risk Assessment]]