# Incident Response Lifecycle (NIST SP 800-61)

## What it is

In **Mass Effect**, the Normandy doesn't fight a Reaper invasion by improvising. Shepard spends the entire trilogy on **Preparation** — recruiting Garrus, Tali, Wrex, building loyalty missions, upgrading the ship's armor and Thanix cannons. When the Collectors hit, **Detection and Analysis** is EDI parsing the debris, Joker calling out "we've got incoming," and the squad confirming what hit them before they swing. **Containment, Eradication, and Recovery** is the suicide mission itself — vent the bugs, hold the line, get the crew out. Then back on the Normandy comes **Post-incident Activity**: the war-room debrief at the galaxy map, figuring out which loyalty choice got Thane killed and what to do differently before Earth burns.

That's exactly what the NIST SP 800-61 incident response lifecycle does — it's the four-phase loop the entire CSIRT runs every single time an incident fires, and the team that skipped preparation always loses someone in the vents.

**Technical definition:** NIST Special Publication 800-61 (Revision 2, *Computer Security Incident Handling Guide*) defines the four-phase incident response lifecycle that CompTIA tests verbatim: **Preparation → Detection and Analysis → Containment, Eradication, and Recovery → Post-incident Activity**. The phases form a closed loop — lessons learned from phase four feed directly back into phase one. CySA+ Objective 3.3 specifically tests phases one and four (preparation and post-incident), because that's where most organizations are weakest and where the real maturity gap lives.

## Why it matters

Detection and containment are loud and obvious — leadership notices when the SOC is on fire. Preparation and post-incident are quiet, unglamorous, and the first things cut when the quarter looks bad. They're also the only two phases that *prevent the next incident*. An organization with mature preparation contains incidents in hours instead of weeks. An organization with mature post-incident activity stops repeating the same breach every six months.

CompTIA tests this lifecycle hard. Expect questions that scramble the phase order, hide "Lessons Learned" inside the wrong phase, or ask which artifact belongs where (a playbook is preparation, a root cause analysis is post-incident, *not* the other way around). Objective 3.3 narrows the scope to phases one and four, but you have to know all four to answer correctly.

## Key facts

### The four phases, in order

| # | Phase | Purpose | Key Artifacts |
|---|---|---|---|
| 1 | **Preparation** | Build the capability before you need it | [[Incident Response Plan]], [[Playbooks]], CSIRT roster, [[Tabletop Exercises]], tooling, training |
| 2 | **Detection and Analysis** | Confirm something happened, scope it | [[IoC]] validation, [[SIEM]] alerts, [[EDR]] telemetry, timelines |
| 3 | **Containment, Eradication, and Recovery** | Stop the bleeding, remove the threat, restore service | Isolation decisions, malware removal, [[Backups]] restoration, monitoring for reinfection |
| 4 | **Post-incident Activity** | Learn so you don't repeat it | [[Root Cause Analysis]], [[Lessons Learned]] report, updated playbooks, evidence retention |

Memorize the order. CompTIA will reverse two phases in a distractor and dare you to pick it.

### Phase 1 — Preparation (Objective 3.3 deep dive)

This is everything you do *before* the pager goes off. The shape of phase one determines whether phase three is a controlled containment or a panicked re-image of every box.

**The [[Incident Response Plan]] (IRP)** — the master document. Defines scope, authority, CSIRT roles, escalation paths, communication trees, legal/HR/PR coordination, regulatory notification timelines. Approved by leadership and reviewed annually. Without it, the first thing the CISO asks at 3am is "who do I call?" and the answer is silence.

**[[Playbooks]]** — incident-type-specific runbooks. One for ransomware, one for [[BEC]], one for credential compromise, one for data exfiltration. Each playbook has triggers, decision trees, containment steps, evidence requirements, and explicit handoff points. The L1 analyst should be able to execute the first 30 minutes of a ransomware response without waking up the IR lead.

**Training** — tabletops, purple-team exercises, capture-the-flag drills, vendor IR retainers. The CSIRT that's never run a [[Tabletop Exercise]] discovers during the real incident that nobody knows the conference bridge number.

**Tooling** — the kit the analyst reaches for. [[SIEM]] with tuned correlation rules, [[EDR]] with response capability, [[SOAR]] for playbook automation, forensic acquisition tools ([[FTK Imager]], [[KAPE]]), [[Write Blockers]], network capture (Wireshark, Zeek), threat intel feeds, secure out-of-band comms (Signal, encrypted bridge — *never* the compromised corporate Teams).

**[[Business Continuity]] (BC) and [[Disaster Recovery]] (DR) plans** — BC keeps the business running during the incident (failover sites, manual processes, alternate workflows). DR restores the technology stack (backup restoration, [[RTO]]/[[RPO]] targets, rebuild procedures). CompTIA distinguishes between them and will test the difference.

> **CompTIA exam trap:** BC ≠ DR. **Business Continuity** keeps the *business operating* during disruption (alternate sites, manual processes, customer-facing continuity). **Disaster Recovery** restores *IT systems* (backup restoration, system rebuilds, RTO/RPO compliance). BC is the broader umbrella; DR is the technical subset. If the question is about how the call center keeps taking orders during the breach, that's BC. If it's about how Active Directory gets restored from backup, that's DR.

### Phase 2 — Detection and Analysis

Confirmation, not panic. The alert fires; the L1 analyst's job is to validate it's not noise before waking anyone up. Data sources: [[SIEM]] correlation alerts, IDS/IPS hits, [[EDR]] behavioral detections, antivirus quarantines, OS and application logs, network device telemetry, third-party MDR notifications, user reports.

The analyst builds a timeline: when did the [[IoC]] first appear, what process spawned what, what accounts touched what assets, where did the traffic egress. Documentation starts *here*, not after the fact.

### Phase 3 — Containment, Eradication, and Recovery

**Containment** has two flavors. *Short-term*: isolate the host from the network, disable the compromised account, block the C2 IP at the perimeter — buy time. *Long-term*: segment the affected enclave, deploy emergency patches, rotate credentials at scale, apply compensating controls until full eradication is possible.

**Eradication**: remove the malware, kill the persistence mechanisms (scheduled tasks, registry run keys, WMI subscriptions, malicious service accounts), close the initial access vector. Re-imaging is usually faster and safer than "cleaning."

**Recovery**: restore from known-good backups, validate integrity, return to production under heightened monitoring. *Reinfection within 30 days is the most common failure mode* — the IR team declared victory before the attacker's second backdoor woke up.

### Phase 4 — Post-incident Activity (Objective 3.3 deep dive)

This is where most organizations fail silently. The incident is contained, leadership is relieved, the IR team is exhausted, and the temptation is to close the ticket and move on. Don't.

**[[Forensic Analysis]]** — the deep dive. What was the *full* scope? Which artifacts confirm the attacker's dwell time? Are there second-stage implants we missed? This often happens in parallel with phase three but the final report belongs here.

**[[Root Cause Analysis]] (RCA)** — *not* "the attacker phished an employee." That's the proximate cause. RCA asks why phishing succeeded: no [[MFA]] on that account, no email sandboxing, no user training, no DMARC enforcement on the spoofed domain. Keep asking "why" until you hit a control gap you can actually fix. The "Five Whys" technique is standard.

**[[Lessons Learned]] meeting** — held within 1–2 weeks of incident closure, while memory is fresh. Attendees: CSIRT, affected business owners, leadership, legal. Agenda: what happened, what worked, what failed, what changes. Output is a written report with assigned action items and owners.

**Evidence retention** — preserve forensic artifacts per policy (typically 1–7 years depending on regulatory exposure). [[Chain of Custody]] must be maintained for anything potentially headed to litigation or law enforcement.

**Control updates** — feed findings back into preparation. New [[SIEM]] detection rules, updated playbooks, additional training, new tooling investments. *If the next incident looks identical to this one, post-incident activity failed.*

> **CompTIA exam trap:** "Lessons Learned" belongs to **Post-incident Activity**, not Recovery. CompTIA loves to put it in the wrong phase. Also: Root Cause Analysis is post-incident, *not* detection and analysis. Detection identifies the IoCs; RCA explains the underlying control failure.

> **CompTIA exam trap:** The lifecycle is a **loop**, not a line. Phase four feeds phase one. A question asking "after lessons learned, what's next?" — the answer is updating preparation artifacts (playbooks, training, controls), which is technically still phase four output flowing into the next preparation cycle.

### Tabletops vs other exercise types

| Exercise | Description | Cost | Realism |
|---|---|---|---|
| **Tabletop** | Discussion-based walkthrough of a scenario | Low | Low |
| **Walkthrough** | Step-by-step procedural review | Low | Low-Med |
| **Simulation** | Live drill against a non-production environment | Med-High | High |
| **Full-scale** | Red team executes against production with IR responding | High | Highest |

CompTIA expects you to know that tabletops are the cheapest, most common, and used to validate the *plan and communication paths* — not the technical controls.

## SOC reality

- The L1 analyst's phase-one reality is the playbook tab open in one window and the SIEM dashboard in the other. When the alert fires, the playbook tells you the first five steps before you have to think.
- The CISO's first three questions during an active incident, every single time: **"What's the scope? What's the impact? Is evidence preserved?"** If you can't answer all three, don't take the call yet.
- *Never tell leadership "we've contained it" until you've watched the network for 72 hours with no new IoCs.* Premature containment claims are how careers end — the attacker had a second backdoor and you just went on TV to say you didn't.
- The handoff chain: L1 validates → L2 scopes and contains → IR lead owns the response → Legal/Comms/Exec get pulled in based on severity → external IR retainer or law enforcement if it's beyond internal capability.
- Post-incident reports that don't assign action items with owners and deadlines are decorative. The metric isn't "did we write the report" — it's "did the next similar incident get caught faster." Track [[MTTD]] and [[MTTR]] trends across incidents; if they're not improving, post-incident activity is theater.

## Related concepts

[[Incident Response Plan]] · [[Playbooks]] · [[Tabletop Exercises]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Business Continuity]] · [[Disaster Recovery]] · [[RTO]] · [[RPO]] · [[Chain of Custody]] · [[Forensic Analysis]] · [[CSIRT]] · [[SIEM]] · [[EDR]] · [[SOAR]] · [[IoC]] · [[MTTD]] · [[MTTR]] · [[Cyber Kill Chain]] · [[MITRE ATT&CK]]

*Source: VIRGIL knowledge base — 2026-05-11*