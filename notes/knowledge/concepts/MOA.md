# MOA

## What it is
Like a recipe that lists every ingredient and cooking step so anyone can replicate a dish, a Method of Attack (MOA) documents the precise technical steps an adversary uses to compromise a system. It describes the *how* of an attack — the tools, techniques, and procedures (TTPs) executed in sequence to achieve a malicious objective.

## Why it matters
During a post-incident forensic investigation, analysts reconstruct the MOA to understand exactly how attackers pivoted from a phishing email to lateral movement and eventually exfiltrated data. Knowing the MOA lets defenders patch the specific vulnerabilities exploited, update detection signatures, and close the attack path before the adversary returns. Without documenting the MOA, organizations patch symptoms rather than the root technique.

## Key facts
- MOA is closely tied to the MITRE ATT&CK framework, which catalogs adversary techniques by tactic category (Initial Access, Execution, Persistence, etc.)
- MOA analysis feeds directly into threat intelligence reports and helps SOC teams build detection rules (e.g., SIEM correlation rules targeting that specific technique)
- Distinguishing MOA from *motive* is exam-critical: motive is *why* (financial gain, espionage), MOA is *how* (SQL injection, spear phishing)
- Red teams document their MOA in engagement reports so blue teams can validate whether their controls detected each step
- MOA is a component of a broader threat profile alongside Indicators of Compromise (IOCs) and adversary attribution

## Related concepts
[[MITRE ATT&CK]] [[Threat Intelligence]] [[TTPs]] [[Indicators of Compromise]] [[Kill Chain]]