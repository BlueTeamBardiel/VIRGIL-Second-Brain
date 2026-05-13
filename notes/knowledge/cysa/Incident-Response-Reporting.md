# Incident Response Reporting

## What it is

In **DOTA 2**, the post-game screen tells you everything: who died to whom, when Roshan got taken, gold-per-minute curves, the exact second the Radiant ancient cracked, which hero built what items, and the replay timestamp where the team-fight at Roshpit decided the match. The losing captain doesn't get to argue "we played well" — the scoreboard, the net-worth graph, and the replay are right there. That's exactly what incident response reporting does — it's the post-game screen for a security incident, and everyone from the L1 analyst to the CEO reads a different panel of it.

**Plain English:** when an incident is over (and often while it's still running), you write down what happened, what you did, what it cost, and what changes so it doesn't happen again. Different audiences get different versions of the same truth.

**Technical definition:** [[Incident Response]] reporting is the structured documentation of an incident's lifecycle — detection, triage, containment, eradication, recovery, and post-incident review — produced for technical, executive, legal, regulatory, customer, and public audiences. It is required by [[NIST SP 800-61]], most regulatory frameworks ([[GDPR]], [[HIPAA]], [[PCI DSS]], [[CIRCIA]]), and any cyber-insurance policy worth the paper.

## Why it matters

The report is where the incident becomes institutional memory. No report, no lessons learned. No lessons learned, you get hit by the same TTP six months later and the board asks why.

It's also where careers live and die. A clean, defensible report with preserved [[Chain of Custody]] keeps the company out of regulatory fines and keeps the SOC out of the deposition chair. A sloppy report with gaps in the [[Timeline]] is how an insurance claim gets denied and how plaintiff's counsel finds the wedge.

**Exam relevance:** Objective **CS0-003 4.2** — this is the entire objective. Stakeholder mapping, [[MTTD]] / [[MTTR]] / [[MTTRem]], executive summary structure, regulatory timelines, root cause analysis — all live here.

## Key facts

### The audiences and what they actually want

| Audience | What they read | What they ignore |
|---|---|---|
| **Executives / Board** | Executive summary, business impact in dollars, regulatory exposure, "are we okay?" | Hash values, packet captures, registry keys |
| **Legal / Counsel** | Timeline, evidence list, chain of custody, what was said to whom and when | Performance metrics, KPIs |
| **Regulators** | Scope of affected data, notification timeline, controls in place at time of incident | Hero narrative of how the SOC saved the day |
| **Customers** | What data of theirs was touched, what they need to do, what you're doing | Internal attribution theories |
| **Law enforcement** | IoCs, attacker infrastructure, attribution data, evidence integrity | Business impact narrative |
| **Public / Media (via PR)** | Approved statement, talking points, FAQ | Anything not pre-approved by legal |
| **Technical teams** | Full forensic detail, IoCs, root cause, recommendations, ATT&CK mapping | Executive narrative |

One incident, seven different reports — or one master report with audience-specific extracts. Either way, the technical truth has to be identical across all of them or someone's lying to someone.

### The executive summary structure

The exec summary is one page. Maximum. Executives skim. Lead with the answer, not the methodology.

- **What happened** — one sentence in plain English. "On May 3, an attacker accessed our HR file share for 14 hours and copied employee records."
- **Scope and impact** — how many records, which systems, dollar estimate, regulatory triggers
- **Status** — contained, eradicated, recovered, or still in progress (do not lie about this)
- **Root cause** — one sentence, no jargon
- **What we're doing** — short-term containment and long-term remediation
- **What we need from leadership** — budget, legal engagement, board notification, customer comms approval

### The "who, what, when, where, why, how" — the five Ws plus how

This is the spine of every incident narrative. CompTIA calls it out by name in objective 4.2.

- **Who** — threat actor (named or unnamed), affected users, responding team members
- **What** — type of incident (ransomware, data exfil, account compromise, BEC, DDoS)
- **When** — initial compromise, first detection, containment, eradication, recovery (all in UTC, no exceptions)
- **Where** — affected systems, network segments, geographies, data classifications
- **Why** — motivation if known (financial, espionage, hacktivist) and root cause
- **How** — initial access vector, TTPs, ATT&CK technique IDs, kill-chain mapping

### Metrics and KPIs that show up on the slide deck

| Metric | Formula | What "good" looks like |
|---|---|---|
| **MTTD** (Mean Time to Detect) | Time from compromise to detection | Hours to days; under an hour is elite |
| **MTTR** (Mean Time to Respond) | Time from detection to first response action | Minutes for high-severity |
| **MTTRem** (Mean Time to Remediate) | Time from detection to full eradication + recovery | Days to weeks depending on scope |
| **Alert volume** | Alerts per analyst per shift | Trends matter more than raw number — sudden spikes = noisy rule or active campaign |
| **False positive rate** | FP / total alerts | Under 10% on tuned rules; over 30% means tuning is broken |
| **Dwell time** | Initial access → detection | Industry median is still measured in weeks — your goal is hours |

**MTTR is the trap term.** Half the industry uses MTTR for "respond" and half uses it for "repair/remediate." Define which one you mean in the report, every time. CompTIA distinguishes [[MTTR]] (respond) from [[MTTRem]] (remediate) — know the difference.

### Root cause analysis — not "the attacker"

The attacker is not the root cause. The attacker is the threat. The root cause is the **condition that let the threat succeed**.

- "Phishing email" is not a root cause. "MFA was not enforced on the VPN" is.
- "Ransomware" is not a root cause. "Backup credentials were stored in the same domain as production" is.
- "Insider threat" is not a root cause. "No DLP on the file share, no UEBA on the user, terminated employee retained access for 11 days" is.

Use the **5 Whys** or a fishbone diagram. Stop when you hit something you can actually fix — a control gap, a process gap, a configuration drift, a governance failure.

### Lessons learned — the post-incident review

Held within 1–2 weeks of recovery. Blameless. The point is not to find who screwed up; it is to find what conditions made screwing up possible.

- What worked
- What didn't
- What was missing (tooling, runbooks, training, access)
- What gets added to the [[Playbook]]
- What detection rules get written from new IoCs
- What gets fed back into tabletop exercises

The output is action items with owners and due dates. Lessons learned that don't generate tracked tickets are theater.

### Regulatory reporting timelines

Miss these and the fine is bigger than the incident.

| Regulation | Timeline | Trigger |
|---|---|---|
| **GDPR** | 72 hours to supervisory authority | Any personal data breach with risk to rights/freedoms |
| **CIRCIA** (US) | 72 hours for substantial incidents, 24 hours for ransom payment | Covered critical infrastructure entities |
| **HIPAA Breach Rule** | 60 days to affected individuals; HHS for 500+ | PHI breach |
| **PCI DSS** | "Immediately" to card brands and acquirer | Cardholder data compromise |
| **SEC** (public companies) | 4 business days on Form 8-K | Material cybersecurity incident |
| **State breach laws** | Varies — most are 30–90 days | PII exposure |

### Incident declaration

Declaration is a switch, not a vibe. Someone — usually the IR lead or duty manager — formally declares an incident, which triggers the playbook: bridge open, legal notified, evidence preservation order issued, comms hold until approved messaging exists. Pre-declaration the SOC is investigating an event. Post-declaration the org is responding to an incident. The distinction matters for billing, for legal hold, and for who gets paged at 2am.

### CompTIA exam traps

> **CompTIA exam trap:** MTTD vs MTTR vs MTTRem. MTTD = compromise to detection. MTTR = detection to first response. MTTRem = detection to full remediation. CompTIA will give you scenarios and ask which metric is improving. If detection got faster, MTTD dropped. If you patched the vuln faster, MTTRem dropped. Don't conflate.

> **CompTIA exam trap:** Root cause is not the attacker or the malware. Root cause is the control failure that allowed it. If the answer choice says "phishing email" or "Emotet variant," it's wrong. If it says "lack of email filtering" or "user training gap," it's right.

> **CompTIA exam trap:** Executive summary vs technical report. Executives get business impact and status. Technical teams get IoCs and TTPs. CompTIA will hand you a scenario with a CEO asking a question and a wrong answer that gives the CEO a packet capture. Match audience to content.

> **CompTIA exam trap:** 72-hour GDPR clock starts when you become aware of the breach, not when it occurred. Same for CIRCIA. Awareness ≠ confirmation — you can notify with partial information and update later. Waiting until you have the full story is how fines happen.

## SOC reality

- At 3am the alert says "possible data exfil — 4.2GB to unknown S3 bucket." The L1's first action is to acknowledge, open the IR ticket, and page the L2. Not to remediate. Not to call the CEO. Acknowledge, document, escalate.
- The CISO's first three questions in the bridge are always the same: **what's the scope, what's the impact, is evidence preserved?** If you can't answer those, say "investigating" — never guess. Guessing in a bridge call shows up in the post-incident report as misinformation.
- Never tell leadership "we've contained it" until you actually have. "Contained" means the attacker has no active access and cannot regain it through known vectors. A quiet attacker is not a contained attacker. *I have watched a team declare containment at hour 6 and find the same C2 beacon on a different segment at hour 30. The report had to be rewritten and the regulator was not amused.*
- The report you write at hour 4 is wrong. The report you write at week 2 is closer. The final report at week 6 is what gets filed. Version everything. Date everything. Never delete a draft — it's discoverable.
- Handoff path: **L1 detects → L2 triages → IR lead declares → legal engages → PR drafts external comms → executive briefed → regulators notified (if required) → customers notified (if required) → post-incident review scheduled.** Skip a step and someone will ask why in the deposition.

## Related concepts

[[Incident Response]] · [[Chain of Custody]] · [[MTTD]] · [[MTTR]] · [[MTTRem]] · [[NIST SP 800-61]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[GDPR]] · [[CIRCIA]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Playbook]] · [[Tabletop Exercise]] · [[Evidence Acquisition]] · [[Stakeholder Communication]]

*Source: VIRGIL knowledge base — 2026-05-11*