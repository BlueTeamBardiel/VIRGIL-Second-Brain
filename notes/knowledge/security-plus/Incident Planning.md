# Incident Planning

## What it is

In NBA 2K, before tip-off you set your defensive coverages, foul-trouble subs, ATO (after-timeout) plays, and end-of-game situational logic — so when LeBron drives the lane down two with 8 seconds left, your team already knows who's switching, who's helping, and who's fouling. That's exactly what **incident planning** does — it pre-decides your moves before the breach so nobody has to improvise at 3 a.m.

Technical definition: **Incident planning** is the documented preparation of policies, procedures, roles, communication paths, and response playbooks that an organization executes when a security event escalates into a confirmed incident.

## Why it matters

Without a plan, the first hour of an incident is wasted arguing about who's in charge, who calls legal, and whether to pull the plug on production. That hour is the difference between a contained ransomware event and a regulator-disclosed breach with statutory fines under [[GDPR]], [[HIPAA]], or [[PCI-DSS]]. On SY0-701 Objective **4.8**, you must know the **incident response process** (preparation → detection → analysis → containment → eradication → recovery → lessons learned), the **types of exercises** (tabletop, simulation, walkthrough), **training**, **root cause analysis**, **threat hunting**, and the role of **digital forensics**. CompTIA's favorite trap: confusing the **lifecycle phase order**, especially putting "eradication" before "containment," or mixing up **tabletop** (discussion) with **simulation** (hands-on).

## Key facts

### The NIST-aligned Incident Response Lifecycle (memorize the order)

| # | Phase | What happens |
|---|-------|--------------|
| 1 | **Preparation** | Build the IRP, train staff, stage tools, define [[Incident Response Team]] roles |
| 2 | **Detection** | Identify potential incidents via [[SIEM]], [[IDS/IPS]], user reports |
| 3 | **Analysis** | Validate the event, determine scope and severity, classify |
| 4 | **Containment** | Stop the bleeding — isolate hosts, block IPs, disable accounts |
| 5 | **Eradication** | Remove the malware, close the vulnerability, kill persistence |
| 6 | **Recovery** | Restore systems from clean backups, monitor for recurrence |
| 7 | **Lessons Learned** | Post-incident review; feed findings back into Preparation |

### Exercise types (high-frequency exam item)

| Exercise | Format | Effort | Purpose |
|----------|--------|--------|---------|
| **[[Tabletop Exercise]]** | Discussion-based, around a conference table | Low | Walk through scenarios verbally; validate roles and decisions |
| **[[Walkthrough]]** | Step-by-step review of the plan | Low–Medium | Confirm everyone understands the documented procedure |
| **[[Simulation]]** | Live, hands-on technical exercise | High | Test actual technical response under realistic conditions |

CompTIA trap: a **tabletop** never touches a keyboard. A **simulation** does.

### Core plan components

- **[[Incident Response Plan]] (IRP)** — the master document
- **[[Communication Plan]]** — who tells whom, when, and how (internal staff, executives, legal, regulators, customers, law enforcement, media)
- **[[Disaster Recovery Plan]] (DRP)** — restoring operations after major loss
- **[[Business Continuity Plan]] (BCP)** — keeping the business running during disruption
- **[[Continuity of Operations Plan]] (COOP)** — government/critical-function variant
- **Stakeholder management** — defined escalation paths

### Roles on the [[Incident Response Team]] (IRT/CSIRT)

- **Incident Response Manager** — calls the shots
- **Security Analyst / First Responder** — triage and initial containment
- **Forensic Investigator** — chain of custody, evidence handling
- **Threat Hunter** — proactive search for [[Indicators of Compromise]]
- **Legal Counsel** — disclosure obligations, [[Chain of Custody]] integrity
- **PR / Communications** — external messaging
- **Management / Executive Sponsor** — authorizes drastic action (taking prod offline)

### Supporting activities the objective names

- **Training** — recurring, role-specific, includes phishing simulations and IR drills
- **Testing** — exercises validate the plan actually works
- **[[Root Cause Analysis]] (RCA)** — determines *why* the incident happened, not just *what* did
- **[[Threat Hunting]]** — assumes breach; proactively searches the environment
- **[[Digital Forensics]]** — legal-grade evidence collection: **legal hold**, **chain of custody**, **acquisition**, **reporting**, **preservation**, **e-discovery**

### Order-of-volatility for evidence collection (forensics tie-in)

1. CPU registers, cache
2. RAM (memory)
3. Network state, running processes
4. Disk
5. Remote logs
6. Physical media / backups

Collect from most volatile to least. Get this backwards on the exam and you lose the point.

## Related concepts

[[Incident Response Plan]] · [[Tabletop Exercise]] · [[Digital Forensics]] · [[Chain of Custody]] · [[Root Cause Analysis]] · [[Threat Hunting]] · [[Business Continuity Plan]] · [[Disaster Recovery Plan]] · [[SIEM]] · [[Indicators of Compromise]] · [[Communication Plan]]

---
*Source: VIRGIL knowledge base — 2026-05-08*