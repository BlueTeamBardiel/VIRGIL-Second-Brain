# Incident Response Lifecycle

## What it is
Like a hospital trauma team that triages, stabilizes, investigates, and then reviews what went wrong — incident response is the structured playbook organizations follow when a security breach occurs. It is a repeating framework of phases designed to detect, contain, eradicate, and recover from security incidents while preserving evidence and preventing recurrence.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations that had mature IR lifecycles were able to rapidly move from **Detection** into **Containment** by isolating affected Orion software instances and revoking compromised credentials — while organizations without defined playbooks spent weeks just confirming they were breached. A documented lifecycle compresses response time directly, limiting dwell time and blast radius.

## Key facts
- **NIST SP 800-61** defines four phases: **Preparation → Detection & Analysis → Containment, Eradication & Recovery → Post-Incident Activity**
- **SANS/PICERL** model uses six phases: Preparation, Identification, Containment, Eradication, Recovery, Lessons Learned
- **Preparation** is the only proactive phase — it includes building playbooks, training teams, and deploying detection tooling *before* an incident
- **Post-Incident Activity** (Lessons Learned) feeds back into Preparation, making the lifecycle truly cyclical, not linear
- The **order of volatility** rule during evidence collection (RAM → running processes → disk) is applied specifically in the Detection & Analysis phase

## Related concepts
[[Chain of Custody]] [[Digital Forensics]] [[SIEM]] [[Threat Intelligence]] [[Business Continuity Planning]]