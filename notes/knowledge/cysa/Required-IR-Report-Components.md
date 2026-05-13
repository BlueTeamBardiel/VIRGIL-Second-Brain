# Required IR Report Components

## What it is

In **Helldivers 2**, when you finish an Operation, the game drops you into the post-mission debrief on the *Super Destroyer*. You see the planet, the mission objectives (completed or failed), kills broken out by faction, samples extracted, stratagems used, time elapsed, friendly-fire casualties (looking at you, 380mm barrage guy), and the medals awarded. Democracy Officer doesn't care about your feelings — he cares about the numbers. If you extracted with the data but lost three Helldivers to a Bile Titan you didn't call out, the report says exactly that. No vibes. No "we did our best." Just the facts that let High Command decide whether to keep pushing the front or pull back.

That's exactly what an incident response report does — it's the structured post-mission debrief that turns a chaotic intrusion into a document leadership, legal, regulators, and the next on-call analyst can actually use.

**Technical definition:** an IR report is the formal written record of an incident's lifecycle, capturing what was detected, when, by whom, what was affected, how it was contained, what evidence was preserved, what the root cause was, and what changes are recommended. CompTIA tests this under Objective 4.2 and they care a lot about which components are mandatory versus nice-to-have.

## Why it matters

The report is the artifact that outlives the incident. Six months from now, nobody remembers exactly when the SOC saw the first beacon. Twelve months from now, when [[Regulatory Reporting]] asks why notification was 71 hours instead of 72, the report is your defense. When [[Legal Hold]] starts a deposition, the report is the chronology counsel works from. When the SOC tunes detections to catch this attacker faster next time, the report is the playbook input.

Bad reports lose lawsuits, fail audits, miss disclosure windows, and let the same attacker walk back in through the same hole six months later. *A report that can't reconstruct the incident is the same as no report at all.*

CompTIA loves this objective because every component maps to a real-world consequence: missing **scope** means underestimating breach notification obligations; missing **timeline** breaks chain of custody; missing **root cause** guarantees recurrence; missing **recommendations** means the lessons learned tabletop produces nothing actionable.

## Key facts

### The mandatory components

CompTIA expects you to recognize all of these by name. The order below mirrors how the report actually reads:

| Component | What goes in it | Why it's required |
|---|---|---|
| **Executive summary** | 1 page. Plain English. What happened, impact, current status, recommended next steps. | C-suite reads this and nothing else. If the CEO can't brief the board from this section alone, it's failed. |
| **Who, what, when, where, why** (the 5 Ws) | Threat actor (suspected), affected systems/data, incident timestamps, location/business unit, attack motive if known | The factual spine of the report. Everything else hangs off this. |
| **Scope** | Systems, users, data, business units, third parties touched | Drives breach notification thresholds (GDPR, HIPAA, PCI-DSS, state laws) |
| **Impact** | Financial, operational, reputational, regulatory | Determines insurance claim, board reporting, [[Public Relations]] posture |
| **Timeline** | Detection → triage → containment → eradication → recovery → closure, with UTC timestamps | Drives [[MTTD]], [[MTTR]], [[MTTRem]] calculations and supports [[Chain of Custody]] |
| **Evidence** | Logs, packet captures, memory images, disk images, malware samples, hashes, screenshots — with custody records | Required for prosecution, civil litigation, insurance, regulator follow-up |
| **Root cause analysis** | The actual technical and process failure that let the incident happen — not just the proximate cause | "User clicked phish" is not RCA. *"No attachment sandboxing, no MFA on the VPN, no EDR on the finance subnet"* — that's RCA. |
| **Recommendations** | Specific, owned, dated corrective actions | This is the only section that prevents recurrence. Vague recommendations = guaranteed recurrence. |
| **Lessons learned** | What worked, what didn't, what the team will do differently — process not technical | Feeds the next [[Tabletop Exercise]] and updates the [[Incident Response Plan]] |

### Metrics and KPIs to include

The numbers leadership actually tracks:

- **MTTD (Mean Time to Detect)** — from initial compromise to first analyst alert. If the attacker dwelled 90 days, MTTD is 90 days. This number embarrasses people.
- **MTTR (Mean Time to Respond)** — from alert to containment action. Note the ambiguity: some shops define MTTR as "respond" (analyst acknowledges), others as "repair." Always define it in the report.
- **MTTRem (Mean Time to Remediate)** — from containment to full eradication and recovery. The number that determines when systems come back online.
- **Alert volume** — how many alerts fired related to this incident, how many were tuned out as false positives before someone connected the dots. *The "we had the alert but missed it" finding is the most common RCA pattern in the industry.*
- **Dwell time** — total time the adversary had access. Industry median is still measured in weeks, not hours.

### Stakeholder identification

The report must name who got told what, when. Different audiences read different sections:

- **Executives / board** — executive summary only
- **Legal counsel** — full report, with privilege markings; drives [[Legal Hold]] and litigation strategy
- **Compliance / privacy officer** — scope, impact, timeline; drives [[Regulatory Reporting]] decisions
- **Public Relations / Communications** — sanitized impact and status; drafts external statements
- **Customer communication team** — uses sanitized scope to draft customer notifications
- **Law enforcement** (FBI, Secret Service, local) — evidence, timeline, threat actor attribution; engaged via legal, never directly by the SOC
- **Media** — receives only what PR approves; the SOC never talks to media
- **Insurance carrier** — full report typically required for cyber claim payout
- **Regulators** — sector-specific (SEC, HHS for HIPAA, state AGs, EU DPAs for GDPR)
- **Affected customers** — receive notification letters based on regulatory triggers
- **Internal employees** — receive sanitized all-hands communication

### Incident declaration

The report must document **when the incident was formally declared** — not when the alert fired, but when leadership classified the event as an incident and activated the IR plan. This timestamp triggers regulatory clocks:

- **GDPR**: 72 hours from awareness of personal data breach
- **HIPAA**: 60 days for breaches affecting 500+ individuals
- **PCI-DSS**: immediately upon discovery, per payment brand requirements
- **CIRCIA** (US covered critical infrastructure): 72 hours for substantial cyber incidents, 24 hours for ransomware payments
- **SEC** (public companies): 4 business days for material cybersecurity incidents on Form 8-K

*If the declaration timestamp is wrong or missing, the regulator's first question is "when did you actually know" — and the answer better match your SIEM logs.*

### CompTIA exam traps

> **CompTIA exam trap:** **5 Ws vs 4 Ws.** The CompTIA objective lists "who, what, when, where" — note the absence of *why*. In practice, *why* is included; on the exam, don't pick an answer that adds extra Ws if the question quotes the objective verbatim. Read the stem carefully.

> **CompTIA exam trap:** **Root cause ≠ proximate cause.** "Phishing email" is the proximate cause. "No email attachment sandboxing, no MFA on remote access, no EDR coverage on the affected subnet" is the root cause. CompTIA will offer the proximate cause as the obvious wrong answer.

> **CompTIA exam trap:** **MTTR ambiguity.** If the question asks for "mean time to respond," that's alert-to-action. If it asks "mean time to repair/remediate," that's alert-to-full-recovery. Different numbers. The question wording is the tell.

> **CompTIA exam trap:** **Executive summary length.** It is *one page*, plain English, no jargon. If the answer choice says "comprehensive technical analysis of all artifacts" — that's not the executive summary, that's the body.

> **CompTIA exam trap:** **Lessons learned vs recommendations.** Recommendations are technical/process changes with owners and dates. Lessons learned are reflections on team performance. CompTIA distinguishes them.

### Communications discipline

The report documents **what was said externally** and **who approved it**:

- Customer notification letters (drafts and final, with send dates)
- Press statements (drafts and final, with PR sign-off)
- Regulatory filings (copies attached)
- Law enforcement engagement (point of contact, case number if assigned)
- Internal communications (all-hands timing, content)

*The "we'll keep this quiet" approach is how a $5M incident becomes a $50M class-action.* Every external statement gets logged in the report.

## SOC reality

- At 3am when the alert finally correlates, nobody is writing the report. The SOC lead opens a running incident channel in Slack or Teams, and someone gets assigned "scribe" — their only job is timestamping every action. That channel transcript becomes the timeline section three weeks later.
- The CISO's first three questions are always the same: **scope, impact, evidence preserved?** Not "who did it." Attribution is for the report; containment is for right now.
- L1 acknowledges and triages. L2 investigates and recommends containment. IR team executes containment, runs eradication, owns the report. Legal gets pulled in the moment the word "breach" enters the channel — not before, never after.
- Never promise leadership "we've contained it" until the EDR shows no new beacons for 24 hours minimum and the threat hunt comes back clean. *"Contained" is a word that ends careers when it turns out to be wrong.*
- The report gets drafted within 5 business days of incident closure. Lessons learned meeting within 10. If it slips past 30, it never gets written — and the next incident has no playbook to learn from.
- Insurance carrier wants the report. Auditor wants the report. The next analyst on-call wants the report. Write it like all three are reading it, because they are.

## Related concepts

[[Incident Response Plan]] · [[Chain of Custody]] · [[Lessons Learned]] · [[Root Cause Analysis]] · [[MTTD]] · [[MTTR]] · [[MTTRem]] · [[Regulatory Reporting]] · [[Legal Hold]] · [[Public Relations]] · [[Stakeholder Communication]] · [[Tabletop Exercise]] · [[Evidence Preservation]] · [[Executive Summary]] · [[GDPR]] · [[CIRCIA]]

*Source: VIRGIL knowledge base — 2026-05-11*