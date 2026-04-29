# Classifying Threats

## What it is
Like a hospital triage nurse sorting patients by severity and type before treatment begins, threat classification organizes potential attacks into structured categories so defenders know *what* they're facing and *how urgently* to respond. It is the systematic process of grouping threats by source (internal vs. external), intent (accidental vs. malicious), capability (script kiddie vs. nation-state), and method (malware, social engineering, physical intrusion).

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations that had pre-classified nation-state threats as a distinct category recognized the attack's signature faster — slow, stealthy, and targeting software update mechanisms — and could apply appropriate countermeasures. Without prior classification frameworks, defenders often apply consumer-grade defenses against APT-level adversaries, a catastrophic mismatch.

## Key facts
- **STRIDE** is Microsoft's threat classification model: Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege
- Threat actors are classified by motivation and capability: **script kiddies, hacktivists, organized crime, insider threats, nation-states (APTs)** — each requiring different defensive posture
- The **CVSS scoring system** classifies vulnerability-based threats by Attack Vector, Complexity, Privileges Required, and Impact to produce a 0–10 severity score
- **Structured threats** are coordinated and well-funded (APTs); **unstructured threats** are opportunistic and unsophisticated — Security+ tests you on this distinction explicitly
- Insider threats are subdivided into **malicious** (intentional sabotage/theft) and **unintentional** (negligent employees) — both appear on CySA+ scenarios requiring different response playbooks

## Related concepts
[[Threat Intelligence]] [[Risk Assessment]] [[STRIDE Model]] [[Attack Surface Analysis]] [[Vulnerability Management]]