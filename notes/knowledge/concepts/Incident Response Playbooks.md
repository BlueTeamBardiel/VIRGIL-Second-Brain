# Incident Response Playbooks

## What it is
Think of a playbook like a surgeon's pre-op checklist: every step is written down *before* the crisis begins so that panic doesn't cause a critical step to be skipped. Precisely, an IR playbook is a documented, step-by-step procedural guide that defines exactly how a security team responds to a specific type of incident (ransomware, phishing, DDoS, insider threat, etc.). Each playbook maps to a threat category and prescribes roles, actions, escalation paths, and communication templates.

## Why it matters
During the 2021 Colonial Pipeline ransomware attack, responders had to make real-time decisions about shutting down operational technology under enormous pressure. Organizations with pre-built ransomware playbooks can execute containment (network isolation, backup verification, authority notification) in minutes rather than improvising for hours, directly limiting dwell time and blast radius.

## Key facts
- Playbooks operationalize the NIST SP 800-61 IR lifecycle: **Preparation → Detection → Containment → Eradication → Recovery → Lessons Learned**
- A playbook is *scenario-specific* (e.g., "ransomware playbook"), while an IR *plan* is the overarching governance document — exams test this distinction
- Effective playbooks assign **RACI roles** (Responsible, Accountable, Consulted, Informed) to prevent responders from stepping on each other
- Playbooks should include **communication templates** — pre-drafted notifications for legal, PR, and regulatory bodies (GDPR requires breach notification within 72 hours)
- Playbooks must be **tested via tabletop exercises** and updated after every major incident; a stale playbook can be worse than none

## Related concepts
[[Incident Response Plan]] [[Tabletop Exercises]] [[NIST SP 800-61]] [[SOAR Platforms]] [[Chain of Custody]]