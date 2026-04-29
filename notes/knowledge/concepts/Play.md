# Play

## What it is
Like a theater rehearsal where actors walk through every scene before opening night, a "play" in cybersecurity is a documented, step-by-step procedure that defines exactly how a team responds to a specific threat scenario. Precisely defined, a play (or playbook entry) is a predefined workflow that orchestrates people, tools, and decisions in response to a particular security event — such as a ransomware infection or credential stuffing attack.

## Why it matters
During a live ransomware incident, seconds matter and panic kills judgment. A well-written play tells the SOC analyst exactly which systems to isolate first, which stakeholders to notify, and which forensic artifacts to preserve — removing guesswork under pressure. Organizations without plays routinely make containment errors (like wiping logs) that destroy the evidence needed for prosecution or insurance claims.

## Key facts
- Plays are individual action sequences within a **playbook**; a playbook is the full collection of plays for an organization's threat library
- SOAR (Security Orchestration, Automation, and Response) platforms execute plays automatically — triggering firewall blocks, ticket creation, or user account disables without human intervention
- Effective plays follow a **trigger → action → decision → outcome** structure, mapping each step to a specific tool or responsible role
- Plays are mapped to **MITRE ATT&CK techniques** (e.g., T1486 Data Encrypted for Impact) to ensure coverage aligns with real adversary behavior
- NIST SP 800-61 (Computer Security Incident Handling Guide) provides the foundational framework from which most enterprise plays are derived

## Related concepts
[[Playbook]] [[SOAR]] [[Incident Response]] [[MITRE ATT&CK]] [[Security Orchestration]]