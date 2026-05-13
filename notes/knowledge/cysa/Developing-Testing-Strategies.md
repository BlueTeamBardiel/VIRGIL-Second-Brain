# Developing Testing Strategies

## What it is

In **Dark Souls**, you don't fight Ornstein and Smough cold. You run Sen's Fortress first, you farm titanite at the Darkroot Garden, you summon Solaire in front of the fog gate to see what his AI does against the duo before you burn humanity to do it for real. The whole game is a testing strategy — every bonfire is a checkpoint where you assess what killed you, adjust the build, and run it back. The boss didn't change. *You did.*

That's exactly what a testing strategy does for a SOC. Before the real incident hits, you walk the fog gate over and over — tabletop exercises, walkthroughs, simulations, methodology-driven assessments — so that when the actual alert fires at 3am, your hands already know the moveset.

Technically: developing testing strategies is the **Preparation** phase activity where the security team selects, schedules, and executes structured exercises and assessment methodologies that validate the incident response plan, playbooks, BC/DR procedures, and the team's ability to execute them. The output is gap data — what the plan says vs what the team actually did under pressure.

## Why it matters

A plan you never tested is a plan that doesn't exist. The first time you read the IR playbook should not be at 3am with ransomware spreading. Every IR retro you'll ever sit in will have one bullet: *"we had a runbook for this but nobody had practiced it."*

Testing strategies are how Preparation stops being theater. Tabletop exercises catch the gaps in decision authority. Methodology-driven assessments (OSSTMM, OWASP WSTG) catch the gaps in technical coverage. Both feed the same loop: find the weakness in the cold, not in the dark.

Exam relevance: **CS0-003 Objective 3.3** explicitly lists Preparation activities including training, tabletop exercises, playbooks, BC/DR, and the IR plan itself. Objective 1.4 and 2.5 lean on testing methodologies for vulnerability work. CompTIA will test whether you know which exercise type fits which goal.

## Key facts

### Exercise types — pick the right tool for the gap

| Exercise | What it is | When to run | Cost / disruption |
|---|---|---|---|
| **Tabletop** | Discussion-based walkthrough of a scenario. People at a table, no systems touched. | Validate decision authority, comms, escalation. Quarterly minimum. | Low. Half a day. |
| **Walkthrough** | Step-by-step procedural review of a specific playbook. | After playbook updates, onboarding new team members. | Low. |
| **Simulation** | Live exercise against a non-production environment. Red team or scripted scenario. | Annually. After major architecture changes. | Medium. |
| **Full interruption / live fire** | Production-impacting exercise. Failover, isolation drills. | Annually for BC/DR. Carefully scoped. | High. Can cause real outage. |
| **Parallel test** | DR site brought online alongside prod, no cutover. | Validating DR capacity without risking prod. | Medium. |

### Tabletop exercises — the cheap, high-value workhorse

Tabletops are the bonfire conversations of IR. No one is dying, but you're walking through *what would we do if* — scenarios narrated by a facilitator, with IR team, legal, comms, IT ops, and at least one executive in the room.

What good tabletops produce:

- **Decision gaps** — who actually authorizes pulling a critical server offline? Spoiler: the runbook says "IR lead." The CIO disagrees. That argument needs to happen in a conference room, not at 3am.
- **Comms gaps** — when do we notify legal? Customers? Regulators? The 72-hour GDPR clock starts when, exactly?
- **Tool gaps** — "we'd pull the EDR timeline." Cool. Who has the credentials? Is the licensed seat assigned to the person on call?
- **Playbook drift** — the runbook references a SIEM dashboard that was decommissioned eight months ago.

> **CompTIA exam trap:** A tabletop exercise does NOT touch production systems. If the question describes "isolating the affected host in a sandbox environment to observe behavior," that's a **simulation** or **functional exercise**, not a tabletop. Tabletop = people talking through a scenario. Anything that touches a real system is past tabletop.

### Testing methodologies — the technical assessment side

Beyond IR exercises, testing strategies cover **how you assess systems** for weaknesses that would become incidents. Two methodologies CompTIA expects you to recognize:

**OSSTMM — Open Source Security Testing Methodology Manual.** Maintained by ISECOM. Covers five channels:

1. Human security (social engineering, awareness)
2. Physical security (locks, doors, badges)
3. Wireless communications
4. Telecommunications
5. Data networks

OSSTMM is broad. It produces a **RAV** (Risk Assessment Value) — a quantitative score of operational security. The exam wants you to know: OSSTMM is **methodology**, not toolkit. It tells you *what to test and how to score it*, not which Nmap flag to use.

**OWASP Web Security Testing Guide (WSTG).** Web-app specific. Covers:

- Information gathering
- Configuration & deployment management testing
- Identity management
- Authentication testing
- Authorization testing
- Session management
- Input validation (SQLi, XSS, command injection)
- Error handling
- Cryptography
- Business logic
- Client-side testing
- API testing

WSTG complements the **OWASP Top 10** (the awareness document) by providing the actual test procedures. Top 10 says "Broken Access Control is #1." WSTG tells you the exact checks to run to find it.

> **CompTIA exam trap:** OWASP Top 10 ≠ OWASP WSTG ≠ OWASP ASVS. **Top 10** = awareness (the most critical web risks). **WSTG** = testing procedures (how to find them). **ASVS** (Application Security Verification Standard) = requirements (what secure looks like at levels 1/2/3). Easy to swap on the exam.

### Other methodologies to recognize

| Methodology | Scope | One-liner |
|---|---|---|
| **NIST SP 800-115** | Technical testing | US government technical assessment guide |
| **PTES** | Pentest execution | Penetration Testing Execution Standard — phases of a pentest engagement |
| **ISSAF** | Information systems assessment | Older, broader assessment framework |
| **MITRE ATT&CK** | Adversary behavior | Not a testing methodology per se, but used to scope purple team exercises |

### Training — the layer under everything

Testing strategies fail if the people aren't trained. CompTIA lists training under Preparation explicitly:

- **Role-based training** — IR lead, forensic analyst, comms lead, legal contact each need different drills
- **Security awareness training** — broader workforce, phishing simulations, reporting culture
- **Certification & continuing education** — keeps the team current with threat landscape
- **Cross-training** — when your only Splunk admin is on vacation during the incident, you lose hours

### Playbooks, IR plan, BC/DR — what testing actually validates

Testing exists to validate documents that would otherwise be fiction:

- **Incident Response Plan** — the strategic document. Authority, scope, definitions, escalation tree.
- **Playbooks / runbooks** — tactical, per-scenario. "Ransomware detected on endpoint" is a different playbook from "credential compromise on cloud admin account."
- **Business Continuity (BC) plan** — how the business keeps functioning during the incident. Critical functions, RTO/RPO, alternate sites.
- **Disaster Recovery (DR) plan** — how IT systems get restored. Backup verification, failover procedures, restoration sequencing.

A tabletop validates the IR plan. A walkthrough validates a specific playbook. A parallel test validates DR. A full-interruption test validates BC. *They are not interchangeable.*

> **CompTIA exam trap:** BC ≠ DR. **BC** = keeping the business running (people, processes, alternate workspaces). **DR** = restoring the IT systems (backups, failover, infrastructure). DR is a subset of BC. Question wording will mix them — read carefully.

### Post-incident activity — the testing strategy feedback loop

Testing strategies don't stop at preparation. Post-incident activity feeds the next cycle:

- **Lessons learned meeting** — held within 1–2 weeks of incident closure. Blameless. What worked, what didn't, what's missing.
- **Root cause analysis (RCA)** — the *why*, not the *what*. "Phishing email landed" is not a root cause. "No DMARC enforcement on inbound mail + no MFA on the impacted account" is.
- **Forensic analysis** — produces the evidence trail and the IOCs to feed back into detection.
- **Plan updates** — the playbook gets new steps. The tabletop scenario library gets a new entry based on the real incident. The DR test gets a new failure mode to validate against.

Every real incident is a free, expensive tabletop. *The retro is where preparation gets sharpened — skip it and you'll fight the same boss again next quarter with the same build.*

## SOC reality

- The first tabletop you run will be a disaster. Half the runbook references will be wrong, the escalation tree will name two people who left last year, and the legal contact's number will route to a fax machine. **That's the point.** You found that in a conference room instead of at 3am.
- L1 analyst's first tabletop interaction: they sit quietly while directors argue about who calls the CEO. Real value is watching the dysfunction surface — write it all down, because the after-action report is the actual deliverable.
- What the CISO asks after a tabletop: *"What gap did we find that, if we'd hit it for real, would have made this a board-level incident?"* Answer with one specific finding and one owner. Not five. One that gets fixed.
- Never tell leadership "we're prepared" because you ran a tabletop. The honest version: *"we've validated the plan against scenario X; we have gaps in scenarios Y and Z and they're tracked."* Preparation is a posture, not a state.
- Escalation pattern: tabletop findings → playbook updates (IR lead owns) → next tabletop validates the fix → annual full simulation stress-tests the whole stack. If your tabletop findings aren't generating tickets, the tabletop is theater.

## Related concepts

[[Incident Response Plan]] · [[Playbooks]] · [[Tabletop Exercises]] · [[Business Continuity]] · [[Disaster Recovery]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Forensic Analysis]] · [[OWASP]] · [[OWASP Top 10]] · [[OSSTMM]] · [[Penetration Testing]] · [[Red Team Exercises]] · [[Purple Teaming]] · [[NIST SP 800-61]] · [[MITRE ATT&CK]] · [[Security Awareness Training]]

*Source: VIRGIL knowledge base — 2026-05-11*