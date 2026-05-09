# Incident Response

## What it is

In Mortal Kombat, the moment Scorpion lands "GET OVER HERE!" with the spear, your match doesn't end — you have a recovery window to block, break the combo, get back to neutral, and study the replay so it doesn't happen again. That's exactly what Incident Response does — it's the structured process of detecting an attack mid-combo, surviving it, and adapting before the next round.

**Incident Response (IR)** is the formal lifecycle an organization follows to prepare for, identify, contain, eradicate, recover from, and learn from cybersecurity incidents.

## Why it matters

Without a defined IR process, organizations make catastrophic decisions under pressure: wiping forensic evidence, paying ransoms blindly, missing breach notification deadlines, and re-infecting cleaned systems. Regulatory frameworks (HIPAA, PCI DSS, GDPR, SOX) require documented IR capability, and breach notification clocks (GDPR's 72 hours, state laws) start ticking the moment the incident is *reasonably suspected* — not when you finish investigating.

**Exam angle (Objective 4.8):** Candidates must know the **IR process steps in order**, the difference between **tabletop / walkthrough / simulation** exercises, the role of the **CSIRT**, and **digital forensics** concepts (chain of custody, order of volatility, legal hold). CompTIA's favorite trap: confusing **containment** with **eradication**, and confusing **lessons learned** with **root cause analysis** (lessons learned is broader — it covers the whole response, not just the technical cause).

## Key facts

### The IR Lifecycle (NIST SP 800-61 / SY0-701)

| # | Phase | What happens | Key artifact |
|---|-------|--------------|--------------|
| 1 | **[[Preparation]]** | Build the CSIRT, write the IR plan, deploy tooling, train staff, run exercises | IR plan, runbooks, jump kit |
| 2 | **[[Detection]]** (Identification) | SIEM alerts, IDS triggers, user reports — confirm an incident occurred | Incident ticket, initial scope |
| 3 | **[[Analysis]]** | Determine scope, severity, affected assets, attacker TTPs | Indicators of Compromise (IoCs) |
| 4 | **[[Containment]]** | Stop the bleeding — short-term (isolate host) and long-term (segment network) | Quarantined assets |
| 5 | **[[Eradication]]** | Remove malware, close vulnerabilities, evict the attacker | Clean systems |
| 6 | **[[Recovery]]** | Restore systems to production, monitor for recurrence | Service restored |
| 7 | **[[Lessons Learned]]** | Post-incident review, update controls, refine the plan | After-action report |

### Exercise Types (memorize the distinction)

| Exercise | Description | Cost / Risk |
|----------|-------------|-------------|
| **[[Tabletop Exercise]]** | Discussion-based — team talks through a scenario around a conference table | Low cost, no system impact |
| **[[Walkthrough]]** | Step-by-step review of the IR plan with role-play | Low-moderate |
| **[[Simulation]]** | Realistic injects, sometimes against actual systems | Higher cost, possible disruption |
| **[[Drill]]** | Practice of one specific function (e.g., backup restore) | Targeted |

### Key Roles

- **[[CSIRT]]** (Computer Security Incident Response Team) — the responders
- **[[Incident Commander]]** — single point of decision authority during the event
- **Communications lead** — handles internal/external messaging, regulators, press
- **Legal counsel** — advises on disclosure, evidence, attorney-client privilege
- **HR / Management** — for insider threat or personnel-impacting incidents

### Digital Forensics Essentials

- **[[Chain of Custody]]** — documented record of every person who handled evidence; broken chain = inadmissible
- **[[Order of Volatility]]** — collect most volatile data first: **CPU registers/cache → RAM → network state → disk → backups → archives**
- **[[Legal Hold]]** (litigation hold) — preserves data when litigation is anticipated; suspends normal retention/deletion
- **[[E-discovery]]** — process of producing electronically stored information for legal proceedings
- **Acquisition** — bit-for-bit forensic image (e.g., `dd`, FTK Imager); compute **[[hash]]** (SHA-256) before and after
- **Reporting** — neutral, factual, reproducible

### Threat Frameworks Referenced in IR

| Framework | Use |
|-----------|-----|
| **[[MITRE ATT&CK]]** | Catalog of adversary tactics, techniques, procedures (TTPs) |
| **[[Cyber Kill Chain]]** (Lockheed Martin) | 7 stages: Recon → Weaponization → Delivery → Exploitation → Installation → C2 → Actions on Objectives |
| **[[Diamond Model]]** | Adversary, Capability, Infrastructure, Victim |

### Containment Trap (CompTIA loves this)

**Short-term containment** ≠ **eradication**. Pulling the network cable contains. Reimaging the host eradicates. Patching the exploited vulnerability so it doesn't reoccur is *also* eradication. Bringing the system back online is recovery. Mixing these up loses points.

### Communication & Reporting

- **Stakeholder updates** on a defined cadence
- **Regulatory notification** windows: GDPR 72 hours, HIPAA 60 days, varying US state laws
- **Out-of-band communication** during incident (attacker may be in your email)
- **Root Cause Analysis (RCA)** — feeds Lessons Learned but is narrower; identifies *the* technical cause

## Related concepts

[[CSIRT]] · [[SIEM]] · [[SOAR]] · [[Playbook]] · [[Runbook]] · [[Chain of Custody]] · [[Order of Volatility]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[Digital Forensics]] · [[Tabletop Exercise]] · [[Business Continuity Plan]] · [[Disaster Recovery]] · [[Indicators of Compromise]] · [[Root Cause Analysis]] · [[Legal Hold]] · [[E-discovery]]

---
*Source: VIRGIL knowledge base — 2026-05-08*