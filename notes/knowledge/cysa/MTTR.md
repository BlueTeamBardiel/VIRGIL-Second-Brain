# MTTR — Mean Time to Repair

## What it is

In **Elden Ring**, you die to Malenia. You die again. By the twentieth attempt you've shaved the recovery loop down — you know which Site of Grace to spawn at, you sprint past the fog wall, you skip the dialogue, you've pre-allocated Crimson Tears, and your remembrance grind path is muscle memory. The first run from death-to-back-in-the-arena took eight minutes. Now it takes ninety seconds. That collapse in recovery time is what mature ops teams measure as **MTTR** — how fast can you get from "we're down" to "we're back up" once you know what hit you.

In plain English: MTTR is the average wall-clock time it takes to *fix* something after it broke. Not detect it. Not respond to it. **Repair** it. From the moment the incident is acknowledged to the moment the affected system is restored to operational state.

Technically, for CS0-003: **Mean Time to Repair** is a post-incident metric tracked during the **Post-incident Activity** phase of the NIST SP 800-61 lifecycle. It's calculated as total repair time across incidents divided by the number of incidents in the measurement window. It feeds the **Lessons Learned** report, drives **playbook** tuning, and gets quoted to leadership when they ask "how resilient are we, really?"

> **MTTR = Σ(repair time per incident) / number of incidents**

CompTIA's appendix expands MTTR specifically as **Mean Time to Repair**. The acronym is overloaded in the wild — vendors and DevOps teams use it for Respond, Resolve, Recover, Restore. On the exam, MTTR = Repair. Memorize that and move on.

## Why it matters

MTTR is the metric the CISO gets asked about in the board meeting. Detection metrics (MTTD) prove your sensors work. Repair metrics prove your *team* works. A short MTTD with a long MTTR means you see the fire instantly and then stand around watching it burn — which is most organizations, honestly.

Career-wise: every IR job posting that mentions "metrics-driven SOC" or "measurable outcomes" is asking whether you can move MTTR down quarter over quarter. That movement is what justifies headcount, tooling spend, and your raise.

Exam-wise: **Objective 3.3** explicitly calls out post-incident activity, lessons learned, and the preparation feedback loop. MTTR sits at the center of that loop — you measure it during post-incident, you attack it during preparation, you watch it drop in the next incident.

## Key facts

### The four MTT* metrics — CompTIA distinguishes them

| Acronym | Expansion | What it measures | Phase |
|---|---|---|---|
| **MTTD** | Mean Time to **Detect** | Compromise → alert raised | Detection & Analysis |
| **MTTA** | Mean Time to **Acknowledge** | Alert raised → analyst owns it | Detection & Analysis |
| **MTTR** | Mean Time to **Repair** | Acknowledged → system restored | Containment/Eradication/Recovery |
| **MTTRem** | Mean Time to **Remediate** | Vulnerability disclosed → patched in prod | Vulnerability management |

> **CompTIA exam trap:** MTTR is **Repair**, not Respond, not Resolve, not Recover. The exam will offer "Mean Time to Respond" as a distractor — it's not the appendix expansion. If MTTR shows up in an incident-response question, think *repair time after acknowledgment*. If it shows up in a vulnerability question, the answer is probably **MTTRem** (Mean Time to Remediate), not MTTR.

> **Second CompTIA trap:** MTTR and MTBF (Mean Time Between Failures) get paired in availability questions. MTBF is *reliability* — how long before the next failure. MTTR is *recoverability* — how long to fix it. **Availability = MTBF / (MTBF + MTTR)**. Drive MTTR down, availability goes up, even if failures keep happening.

### What goes into the MTTR clock

The MTTR stopwatch starts when the incident is **acknowledged** (analyst owns the ticket) and stops when the affected system is **restored to operational state**. Inside that window:

- **Triage** — scope, impact, blast radius
- **Containment** — isolate the host, kill the session, block the IP
- **Eradication** — remove the malware, kill the persistence, rotate the creds
- **Recovery** — re-image, restore from backup, validate, return to production
- **Validation** — confirm the threat is actually gone, not just quiet

If you stop the clock at containment, you're lying to yourself. The system isn't repaired until it's back in production and verified clean. *I have watched teams celebrate a 40-minute MTTR while the box was still sitting in quarantine VLAN three days later.*

### What drives MTTR down — the Preparation feedback loop

This is the part Objective 3.3 cares about. Post-incident measurement is pointless if it doesn't loop back into preparation. The artifacts that compress MTTR:

- **Playbooks** — pre-written, tested response procedures for specific incident classes (ransomware, BEC, credential compromise, DDoS). Analyst doesn't think; analyst executes.
- **Runbooks** — the technical step-by-step under the playbook. Exact commands, exact tool flags, exact rollback steps.
- **Incident Response Plan** — the org-level document that names roles, escalation paths, legal/comms triggers, and authority to act.
- **Training** — analysts who've never seen the alert before will be slow. Analysts who've seen it ten times in lab will be fast.
- **Tabletop exercises** — talking through a scenario at a conference table. Cheap, finds gaps in process before a real incident does. CompTIA loves this term.
- **Tools** — SOAR for automated containment, EDR with one-click isolate, golden images for fast re-image, IaC for fast rebuild.
- **BC/DR plans** — Business Continuity and Disaster Recovery. When repair is impossible in the original environment, you fail over. DR-readiness is a force multiplier on MTTR.

### The Post-incident Activity phase — where MTTR lives

NIST SP 800-61 lifecycle, phase four:

1. **Forensic analysis** — what artifacts remain, what was the entry vector, what did the adversary touch
2. **Root cause analysis (RCA)** — the *why*, not the *what*. Five Whys, fishbone, fault tree — whatever method, the output is a causal chain ending in a fixable upstream condition.
3. **Lessons learned** — written report, distributed to stakeholders, fed into preparation
4. **Metrics calculation** — MTTD, MTTA, MTTR, dwell time, number of hosts affected, dollars lost
5. **Playbook updates** — every incident should result in either a new playbook or an edit to an existing one. If nothing changed, you didn't learn.

The lessons-learned meeting is non-negotiable. CompTIA tests this directly: post-incident activity is *not* optional, and skipping it is one of the top blue-team failure modes.

### Reasonable MTTR targets

There is no universal "good" MTTR — it depends on incident class. Rough industry benchmarks:

| Incident class | "Good" MTTR | "Bad" MTTR |
|---|---|---|
| Commodity malware on endpoint | <2 hours | >8 hours |
| Credential compromise | <4 hours | >24 hours |
| Ransomware (single host) | <8 hours | >72 hours |
| Ransomware (enterprise) | days–weeks | months |
| Web app compromise | <12 hours | >72 hours |
| Nation-state APT eviction | weeks | months–years |

*The Verizon DBIR consistently shows median dwell time (closely related to MTTD + MTTR) measured in days for commodity attacks and weeks-to-months for targeted ones. If your numbers look heroic, audit your definitions before you brag.*

## CompTIA exam traps

> **Trap 1:** MTTR ≠ MTTRem. Mean Time to Repair is incident response. Mean Time to Remediate is vulnerability management (CVE disclosed → patch deployed). Different metric, different phase, different team often.

> **Trap 2:** MTTR starts at *acknowledgment*, not *occurrence*. If the breach happened on Monday and you didn't detect it until Friday, those four days are dwell time / MTTD, not MTTR. MTTR is the clock that starts when someone on your team is actively working the ticket.

> **Trap 3:** Lessons Learned is part of **Post-incident Activity**, the fourth phase — not Recovery. CompTIA will dangle "Recovery" as the obvious wrong answer for "where do you document lessons learned." Recovery is restoring service. Post-incident is reflecting on what happened.

> **Trap 4:** Root Cause Analysis is *not* the same as Forensic Analysis. Forensics tells you *what happened* (artifacts, timeline, IoCs). RCA tells you *why it happened* (the upstream condition that made it possible). The exam will conflate them — they're sequential, not interchangeable.

## SOC reality

- **The dashboard:** MTTR shows up as a tile on the SOC manager's quarterly metrics deck. Green if it's trending down, red if it's trending up, yellow if it's flat. The CISO's first question after a major incident is always "what's our MTTR look like for this category?"

- **What L1 actually does:** Acknowledges the ticket, which starts the MTTR clock. The honest L1 timestamps everything in the ticket — "11:42 isolated host via EDR, 11:51 confirmed persistence killed, 12:14 re-image initiated, 13:02 host returned to prod." That timeline is what feeds the metric. Sloppy timestamps = garbage MTTR data = garbage post-incident review.

- **What the IR lead asks:** "Have we contained?" then "have we eradicated?" then "have we validated?" The clock keeps running until all three are yes. *Never tell the IR lead "we're done" when you mean "we've isolated." Those are different states and one of them lets the adversary back in.*

- **What never to promise leadership:** A specific MTTR for an active incident. The honest answer is "based on similar incidents in the last quarter, the median repair time is X — we'll update you hourly." Promising a number you can't deliver is how SOC managers get fired.

- **The handoff:** L1 owns the clock during commodity incidents. L2/IR team takes over for anything involving lateral movement, data exfil, or business-critical systems. Legal and comms enter the picture for breach-notification-triggering events — and at that point, your MTTR is the least of your problems, but you still have to report it in the after-action.

## Related concepts

[[MTTD]] · [[MTTRem]] · [[Incident Response Plan]] · [[Playbooks]] · [[Runbooks]] · [[Tabletop Exercises]] · [[Post-incident Activity]] · [[Lessons Learned]] · [[Root Cause Analysis]] · [[Forensic Analysis]] · [[Business Continuity]] · [[Disaster Recovery]] · [[NIST SP 800-61]] · [[Containment Eradication Recovery]] · [[SOAR]]

*Source: VIRGIL knowledge base — 2026-05-11*