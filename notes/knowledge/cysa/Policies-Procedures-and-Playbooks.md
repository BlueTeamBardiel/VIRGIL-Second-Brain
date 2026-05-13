# Policies, Procedures, and Playbooks

## What it is

In **Metroid**, Samus drops onto Zebes with a logbook full of mission parameters — *recover the stolen Metroids, neutralize Mother Brain, do not engage Ridley without the Varia Suit.* That's policy: high-level authority from Galactic Federation command. Then there's the procedure — how to actually use a Morph Ball, when to switch to Ice Beam, the input sequence to bomb-jump out of a pit. And then there's the playbook: *Kraid's room — enter, drop to lower platform, Ice Beam the belly projectiles, missile the mouth on the third roar.* Three layers. Command sets the mission. Training sets the muscle memory. The playbook gets you through this specific boss without dying because you forgot where to stand.

That's exactly what policies, procedures, and playbooks do — they're the three-layer documentation stack that turns "we should respond to incidents" into people actually doing the right thing at 3am.

**Technical definition (CS0-003):** Policies are organizational-authority documents that establish what must be done and who owns it. Procedures are repeatable step-by-step instructions for executing a policy. Playbooks (sometimes called runbooks) are incident-specific or scenario-specific decision trees that walk a responder through detection, containment, eradication, and recovery actions for a defined event class — phishing, ransomware, DDoS, insider threat, lost laptop.

## Why it matters

If your IR program is just a Slack channel and three senior analysts who remember how the last incident went, you don't have an IR program. You have institutional knowledge that quits in two weeks.

**Career angle:** Writing playbooks is one of the highest-leverage things a CySA+ analyst does. One well-written ransomware playbook means the L1 on Saturday night doesn't have to wake up the IR lead — they execute the first 12 steps cleanly, preserve evidence, and escalate at the right gate. Promotion happens to analysts who reduce mean-time-to-contain by documenting tribal knowledge.

**Real-world stakes:** Auditors, cyber insurance underwriters, and post-breach regulators *will* ask for these documents. "We had a plan" doesn't count. "We had a written, version-controlled, tested plan" counts. After a breach, the difference between a $2M settlement and a $20M settlement is often whether you can produce dated playbooks and tabletop records.

**Exam relevance:** CS0-003 Objective 3.3 (preparation phase) and 4.2 (reporting/communication). CompTIA tests the distinction between the three documents constantly. They also test the position of playbooks inside the NIST SP 800-61 lifecycle — playbooks are a **Preparation** artifact that gets *executed* during Detection & Analysis and Containment, Eradication & Recovery, then *revised* during Post-incident Activity.

## Key facts

### The three layers, side by side

| Layer | Audience | Question it answers | Update cadence | Example |
|---|---|---|---|---|
| **Policy** | Executives, all staff | *What must we do, and who's accountable?* | Annually or on major regulatory change | "The organization will respond to security incidents in accordance with NIST SP 800-61. The CISO owns the IR program." |
| **Procedure** | Operations teams | *How do we do the thing, step by step?* | Quarterly or after process change | "To preserve a disk image: 1) Attach write blocker. 2) Hash with SHA-256. 3) Image with FTK Imager. 4) Re-hash and verify…" |
| **Playbook** | SOC analysts, IR responders | *In this specific incident, what do I do next?* | After every incident, every tabletop, every tool change | "Ransomware playbook: isolate host within 15min, capture volatile memory before reboot, notify legal within 1hr, do not pay without executive + counsel approval…" |

> **CompTIA exam trap:** Policy vs procedure vs playbook gets swapped on the exam. Remember: **policy = authority and the "what,"** **procedure = the "how" (general),** **playbook = the "how" (scenario-specific, with decision branches).** A document that says "report incidents to the SOC within 1 hour" is a *policy*. A document that says "when phishing email is reported, check sender SPF/DKIM, sandbox the attachment, query SIEM for other recipients, isolate any clicker hosts" is a *playbook*.

### What a playbook actually contains

A real IR playbook isn't prose. It's a structured decision tree with these sections:

- **Trigger conditions** — what events kick this playbook off (SIEM rule ID, EDR alert class, user report)
- **Severity classification matrix** — how to rate this incident (low/med/high/critical) with explicit criteria
- **Roles and RACI** — who is Responsible, Accountable, Consulted, Informed for each step
- **Detection and analysis steps** — log queries, EDR pivots, threat intel lookups, with exact tool syntax where possible
- **Containment actions** — network isolation commands, account disables, firewall rule pushes, with the change-control bypass authority noted
- **Eradication and recovery** — re-imaging procedures, password resets, IoC blocking, validation steps
- **Evidence preservation** — chain of custody requirements, what to capture before any destructive action
- **Communication plan** — who gets notified, in what order, on what timeline (legal, comms, execs, customers, regulators)
- **Escalation gates** — explicit "stop and call the IR lead" decision points
- **Post-incident hooks** — RCA template, lessons-learned meeting trigger, playbook revision owner

### Playbook scenarios that should exist before you need them

| Scenario | Why it's a playbook (not just procedure) |
|---|---|
| **Phishing report** | High-volume, repetitive, L1-executable, clear triage path |
| **Ransomware** | Time-critical, irreversible decisions, legal/exec involvement |
| **Business email compromise (BEC)** | Crosses IT, finance, legal — coordination playbook |
| **Lost or stolen device** | Compliance-driven (data breach notification clocks) |
| **Insider threat / data exfil** | HR and legal coordination from minute one |
| **DDoS** | Network team + ISP + WAF vendor handoffs |
| **Cloud account compromise** | Different containment surface than on-prem |
| **Third-party / supply chain breach** | Vendor management, contractual notification clocks |

### Preparation phase artifacts (NIST SP 800-61)

Playbooks live inside a larger Preparation package. CompTIA can ask which of these belongs where:

- **Incident response plan (IRP)** — the overall program document; references the policy, procedures, and playbooks
- **Communications plan** — who calls whom, public statements, regulator notifications
- **Business continuity (BC) plan** — how the business keeps running with degraded IT
- **Disaster recovery (DR) plan** — how IT systems get rebuilt after destructive events
- **Tooling readiness** — EDR deployed, SIEM tuned, forensic workstations imaged, jump bags packed
- **Training and tabletops** — the muscle memory layer

### Tabletop exercises — the playbook stress test

A tabletop is a discussion-based drill where IR staff walk through a scripted incident scenario against the playbook. No real systems get touched. The facilitator injects events ("the attacker just exfilled 2GB to a Russian IP — what do you do?") and the team responds verbally, using the actual playbook documents.

What tabletops catch:
- Playbook steps that reference tools nobody on shift can access
- Escalation paths to people who left the company eight months ago
- Communication gaps with legal, comms, or the executive team
- Contradictions between two playbooks that fire simultaneously
- Decision gates that are ambiguous under pressure

Run them at least annually. Quarterly if you're regulated. *A playbook that has never been walked through is fiction.*

### Post-incident activity — where playbooks get sharper

After every real incident, the playbook gets revised. The four post-incident outputs:

- **Forensic analysis** — what artifacts were collected, what they showed, the timeline reconstruction
- **Root cause analysis (RCA)** — the *technical and process* reason this happened (not just "the user clicked the link" — *why was the link clickable, why did the attachment execute, why did EDR not catch it*)
- **Lessons learned meeting** — blameless retro, usually 1–2 weeks after recovery, with everyone who touched the incident
- **Playbook + control updates** — the actual deliverable; what changed in the document, what detection got added, what training got assigned

> **CompTIA exam trap:** **Root cause analysis** is *not* the lessons-learned meeting. RCA is the technical/process investigation that produces findings. The lessons-learned meeting is the human review *of* those findings, where decisions about playbook updates and control changes get made. CompTIA can ask which produces what.

### Why playbooks pay off

| Benefit | What it looks like in ops |
|---|---|
| **Consistency** | The Saturday-night L1 responds to phishing the same way the Tuesday-morning L3 does |
| **Speed** | MTTR drops because decisions are pre-made, not invented under pressure |
| **Reduced decision fatigue** | Responders execute, not improvise — improvisation is reserved for the novel parts |
| **Onboarding velocity** | New hires reach productive triage in weeks, not quarters |
| **Auditability** | "We followed playbook IR-014 v3.2" is a defensible answer; "we did our best" is not |
| **Defensible posture** | Insurance, regulators, plaintiff's counsel all want to see documented, executed procedure |

## SOC reality

- **The alert doesn't come with a playbook attached.** L1 sees a SIEM rule fire — "Suspicious PowerShell encoded command on FINANCE-WK-04." They have 30 seconds to identify it as the trigger for the *Malicious Script Execution* playbook, open the doc, and start executing. If the playbook isn't tagged to the alert, the L1 freelances. Tag your playbooks to your detections.
- **Playbook drift is the silent killer.** The EDR vendor pushes an update that renames the isolation API endpoint. Your playbook still references the old one. Six months later, ransomware hits, the L1 follows step 3, the command errors out, and the host stays on the network for another 40 minutes while someone goes to find the IR lead. *Version control your playbooks like you version control code.*
- **The CISO will ask three things during the incident:** scope (how many hosts/accounts), impact (data out the door yes/no), and "are we executing the playbook?" If the answer to the third is "what playbook" — start your resume.
- **Never promise leadership "we've contained it" until the playbook's containment validation steps have passed.** Containment is a verified state, not an attempted action. The playbook should have explicit verification gates for exactly this reason.
- **The handoff:** L1 detects and executes the first 5–10 playbook steps → L2 takes over investigation and containment → IR lead owns eradication and external comms → legal and execs own notification decisions. The playbook names each handoff. If it doesn't, write that in before the next incident.

## Related concepts

[[Incident Response Plan]] · [[Incident Response Life Cycle]] · [[NIST SP 800-61]] · [[Tabletop Exercises]] · [[Business Continuity]] · [[Disaster Recovery]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Forensic Analysis]] · [[Chain of Custody]] · [[Communication Plan]] · [[RACI Matrix]] · [[Change Management]] · [[SOAR]]

*Source: VIRGIL knowledge base — 2026-05-11*