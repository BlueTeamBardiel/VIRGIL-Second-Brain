# Root Cause Analysis (RCA)

## What it is

In **Tekken**, you eat a wall combo from Bryan Fury for 87% of your health and lose the round. The casual reaction is "Bryan is broken." The replay tells a different story: you whiffed a hopkick at frame 14, Bryan whiff-punished with b+1, that put you in stun, the stun gave him the wall carry, the wall splat opened the juggle, the juggle ended you. The hopkick whiff was the **root cause**. The wall splat was the most painful moment but it was just a downstream consequence. If you don't fix the hopkick habit, you eat the same combo next round — maybe from Kazuya, maybe from Jin, the character doesn't matter. The bad neutral does.

That's what Root Cause Analysis does — it scrubs the replay backward past the catastrophic moment to find the *original* decision or condition that made the catastrophe possible.

Technically: **RCA is the systematic investigation, after an incident is contained, to identify the underlying condition (technical, procedural, or human) whose presence allowed the incident chain to execute.** It is the analysis step inside [[Post-Incident Activity]] in the [[NIST SP 800-61]] lifecycle. The output feeds [[Lessons Learned]], [[Recommendations]], and the corrective actions tracked to closure.

RCA is **not blame assignment**. RCA is prevention.

## Why it matters

CySA+ Objective 4.2 names RCA explicitly as an element of incident response reporting. CompTIA tests whether you understand that the post-incident write-up needs more than a timeline and an impact statement — it needs a defensible answer to *"why did this happen, and what changes so it doesn't happen the same way again?"*

In real ops, RCA is what separates a SOC that keeps eating the same intrusion every quarter from one that compounds its defenses. Skipping RCA means you treated the symptom (ransomware on the file server) and never touched the cause (a domain admin account with a 2019 password that nobody had MFA'd). The next attacker walks through the same door.

It also matters for [[Regulatory Reporting]]. Auditors, cyber insurers, and post-breach litigation will all ask: *what was the root cause, and what did you change?* "We rebuilt the server" is not an answer. "The root cause was an unpatched Exchange CVE; we have since deployed automated patch SLAs for internet-facing services and added a compensating WAF rule" is an answer.

## Key facts

### The RCA mindset

RCA is forensic, not adversarial. You are reconstructing a chain of events to find the earliest link you can break. Three rules:

- **Past the symptom.** Ransomware encrypting files is the symptom. The phishing email was the entry. The lack of macro blocking was the cause. Don't stop at the encryption.
- **No single human is the root cause.** "Bob clicked the link" is not a root cause. It's a contributing factor. The root cause is the *system* that allowed Bob's click to matter — no email sandboxing, no EDR behavioral blocking, no network segmentation between Bob's laptop and the file server.
- **Stop at actionable.** RCA can recurse forever ("why was there no sandbox? because there was no budget. why no budget? because…"). Stop when you've reached a layer the org can actually change.

### The RCA workflow

| Step | What you do | Output |
|---|---|---|
| 1. Collect | Pull every relevant artifact — SIEM logs, EDR telemetry, ticket history, [[Chain of Custody]] evidence, interview notes | Raw evidence bundle |
| 2. Timeline | Build a unified timeline across sources with timestamps in UTC | Master incident timeline |
| 3. Decompose | Break the incident into discrete events; for each, ask "what made this possible?" | Event-by-event causal chain |
| 4. Identify | Separate **root cause** (the breakable link) from **contributing factors** (made it worse but weren't the entry) | RCA statement |
| 5. Recommend | Propose corrective actions, mapped to specific controls | Recommendations list |
| 6. Document | Write the RCA section of the incident report | Final RCA artifact |

### Root cause vs contributing factors

This distinction is where most analysts trip. The exam tests it. So does the post-mortem meeting.

- **Root cause:** the condition whose removal would have prevented the incident chain from starting or progressing past a critical gate.
- **Contributing factors:** conditions that made the incident worse, faster, or harder to contain — but were not the entry point.

Example incident: attacker exploits an unpatched VPN appliance, dumps credentials, lateral-moves to a file server, deploys ransomware.

- **Root cause:** the VPN appliance was 14 months behind on patches because it was excluded from the patch management cycle as a "critical uptime" asset.
- **Contributing factors:** flat network (no segmentation between VPN concentrator and file servers), no MFA on service accounts, EDR was in detect-only mode on the file server, [[MTTD]] for lateral movement was 71 hours.

The patch is the root cause. The flat network is a contributing factor. Fixing only the patch leaves you exposed to the next CVE. Fixing only the segmentation leaves the entry door wide open. The report names both, but priority-ranks the root cause.

### Common RCA techniques

NIST doesn't mandate a method. Pick one and use it consistently:

- **5 Whys.** Ask "why?" five times. Each answer becomes the next question's subject. Crude but fast. Good for small incidents.
- **Fishbone (Ishikawa) diagram.** Maps causes across categories — people, process, technology, environment. Good for incidents with multiple parallel contributors.
- **Fault tree analysis.** Top-down logical tree from the failure event down to root causes via AND/OR gates. Engineering-heavy. Used in safety-critical environments and mature SOCs.
- **Event timeline + causal chain.** Most common in IR. Lay out the timeline, mark each event, identify the causal link between events, find the earliest breakable link.

### What goes in the RCA section of the report

The RCA is one section of the larger [[Incident Response Reporting]] artifact. It typically contains:

- **Incident summary** — one paragraph, executive-readable
- **Timeline** — Who, What, When, Where (Why is the RCA itself, How is the technique mapping)
- **Evidence references** — pointers to the [[Chain of Custody]]-preserved artifacts, not the artifacts themselves
- **Root cause statement** — single clear sentence naming the breakable link
- **Contributing factors** — bulleted, ranked by impact
- **Recommendations** — corrective actions, each mapped to an owner and a target date
- **Metrics** — [[MTTD]], [[MTTR]], [[MTTRem]], alert volume context

### How RCA feeds the rest of the report

| RCA output | Feeds into |
|---|---|
| Root cause statement | [[Executive Summary]] — leadership reads this first |
| Recommendations | [[Lessons Learned]] meeting agenda |
| Contributing factors | Control gap analysis, next budget cycle |
| Timeline | [[Regulatory Reporting]] (GDPR 72h, CIRCIA, sector-specific) |
| Evidence references | [[Legal Hold]], potential litigation, insurance claim |
| Metrics deltas | SOC KPI dashboard, board reporting |

### CompTIA exam traps

> **CompTIA exam trap:** RCA is **not** part of Containment, Eradication, and Recovery. It happens during **Post-incident Activity** — phase 4 of the NIST SP 800-61 lifecycle. CompTIA will offer "Containment" as a tempting wrong answer because RCA *informs* containment decisions in the next incident. The phase question is about *when the analysis itself happens*.

> **CompTIA exam trap:** Root cause ≠ first event in the timeline. The first event is often reconnaissance or initial access. The root cause is the *condition* that allowed that event to succeed. "Attacker sent a phishing email" is the first event. "No DMARC enforcement and no attachment sandboxing" is the root cause.

> **CompTIA exam trap:** "Human error" is not an acceptable root cause on the exam or in a real report. If a human action was part of the chain, the root cause is the *missing control* that should have caught or prevented the human action. CompTIA wants systemic thinking.

> **CompTIA exam trap:** RCA output goes to [[Lessons Learned]], but they are not the same thing. RCA identifies *why*. Lessons learned captures *what we as an org are changing*. Different artifacts, different audiences, sometimes confused in answer choices.

## SOC reality

- The 3am alert never tells you the root cause. It tells you the symptom — "ransomware.exe spawned on FILESVR-04." Root cause is a week of investigation later, after the incident is contained and someone on the IR team finally has time to scrub the timeline backward.
- The CISO's first three questions in the post-incident meeting are always: *what was the root cause, what's our exposure to it elsewhere, and what are we changing?* If you walk in without an answer to question one, the meeting goes badly for you.
- Never name a person as the root cause in writing. Ever. *"User clicked the link"* lands in HR files, lawsuits, and discovery. Write the systemic condition instead: *"endpoint email client rendered macro-enabled attachment without sandbox inspection."* Same fact, different blast radius.
- The lessons-learned meeting is the post-raid wipe debrief. RCA is the replay you watched before the meeting so you have receipts. Show up without the replay and someone with a louder voice writes the narrative for you.
- Cyber insurance underwriters and breach counsel will read your RCA. Write it like an adult professional document — defensible, evidence-cited, no speculation. *If it isn't in the evidence, it doesn't go in the RCA.*
- Track recommendations to closure. The number-one failure mode in mature SOCs isn't bad RCA — it's good RCA whose corrective actions never got implemented because no one owned the ticket. *An RCA without a tracked remediation is a confession, not a control.*

## Related concepts

[[Post-Incident Activity]] · [[Lessons Learned]] · [[Incident Response Reporting]] · [[Executive Summary]] · [[NIST SP 800-61]] · [[MTTD]] · [[MTTR]] · [[MTTRem]] · [[Chain of Custody]] · [[Regulatory Reporting]] · [[Legal Hold]] · [[Recommendations]] · [[Stakeholder Identification]] · [[Timeline Analysis]]

*Source: VIRGIL knowledge base — 2026-05-11*