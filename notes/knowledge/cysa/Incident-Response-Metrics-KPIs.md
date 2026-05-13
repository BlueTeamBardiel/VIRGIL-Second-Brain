# Incident Response Metrics & KPIs

## What it is

In **Battlefield**, the end-of-round scoreboard tells you what actually happened. Not the kills — the *useful* numbers. Time to neutralize the M-COM, flag captures per minute, squad revive rate, average time-to-respawn after a wipe. A squad that drops 40 kills but loses every objective is statistically a losing squad. The scoreboard doesn't care about your highlight reel; it cares whether you held Bandar Desert long enough to win the round. That's exactly what IR metrics do — they strip out the noise and tell leadership whether the SOC actually defended anything, or just generated a lot of activity.

In plain English: incident response metrics are how you prove the SOC is working. Numbers, trends, and time intervals that let a CISO say "we detected this in 8 minutes" instead of "we have a great team."

**Technical definition (CS0-003 4.2):** Incident response metrics and KPIs are quantitative measurements of detection, response, and remediation performance, captured per-incident and trended over time. They feed [[Incident Response Reporting]], [[Executive Summary]] briefings, regulatory disclosures, and post-incident [[Lessons Learned]] reviews. The big four under CompTIA's lens: **Mean Time to Detect (MTTD)**, **Mean Time to Respond (MTTR)**, **Mean Time to Remediate (MTTRem)**, and **Alert Volume**.

## Why it matters

The SOC is a cost center until it can prove value. Metrics are how you survive budget season. They're also how a [[CISO]] answers the question regulators, auditors, and the board actually ask: *"How long was the attacker inside, and what did you do about it?"* CompTIA tests these heavily in Domain 4.0 because reporting and communication is where junior analysts get murdered on the exam — they know what an IoC is, they don't know what MTTD means or who gets the executive summary.

Real-world: the [[Mandiant M-Trends]] report tracks global median dwell time. In 2014 it was 205 days. In 2023 it dropped to 10 days. That delta is the entire industry getting better at MTTD. If your org's MTTD is 60 days, you're behind the curve and the auditors know it.

**Exam relevance:** Objective CS0-003 4.2 — "Explain the importance of incident response reporting and communication." Expect questions on metric definitions, when each is used, who receives which report, and timeline obligations for regulatory and law enforcement notification.

## Key facts

### The four core metrics

| Metric | What it measures | Formula | "Good" looks like |
|---|---|---|---|
| **MTTD** (Mean Time to Detect) | Time from compromise → SOC detection | Detection timestamp − Initial compromise timestamp | Hours, not days. Median industry: ~10 days. Mature SOC: <24h. |
| **MTTR** (Mean Time to Respond) | Time from detection → IR activation / containment action | Containment timestamp − Detection timestamp | Minutes for P1; hours for P2. |
| **MTTRem** (Mean Time to Remediate) | Time from detection → full eradication and recovery | Recovery-complete timestamp − Detection timestamp | Days to weeks depending on scope. Tracked per-incident, trended. |
| **Alert Volume** | Count of alerts generated per time window | Sum of alerts (raw) / Sum of escalated (signal) | Ratio matters more than raw count. Watch the trend. |

> **CompTIA exam trap:** MTTR is ambiguous in the wild — some shops use it for "respond," others for "repair/remediate." On the exam, **MTTR = Mean Time to Respond**, and **MTTRem = Mean Time to Remediate**. CompTIA will offer both as distractor options. Read the question stem carefully.

### MTTD — dwell time, in your house, drinking your coffee

MTTD is the headline metric. It's how long the adversary lived inside the network before anyone noticed. Every day of dwell time is another day of [[Lateral Movement]], [[Persistence]], and [[Data Exfiltration]] preparation.

- **Measured from** the actual compromise (forensic-confirmed timestamp from logs, not the alert)
- **Measured to** the first confirmed detection — not the first noisy alert that got closed as false positive
- **Reduced by** better [[SIEM]] correlation, [[EDR]] coverage, [[Threat Hunting]], and high-fidelity [[Detection Engineering]]

*The hard lesson: MTTD only exists in retrospect. You don't know your real MTTD until forensics tells you when the breach actually started. The "detection time" you brag about in Q3 might get rewritten in Q4 when IR finds an older artifact.*

### MTTR — the speed of the response, not the fix

MTTR is from detection to *response action* — isolating the host, blocking the IP, disabling the account. It is **not** the full cleanup. A 4-minute MTTR with a 14-day MTTRem is a SOC that triages fast and remediates slow — common in shops with great L1 but no patching authority.

### MTTRem — the full repair, change board and all

MTTRem captures the whole tail: containment, eradication, recovery, validation. This is where [[Inhibitors to Remediation]] (legacy systems, MOUs, business-process interruption) show up as schedule slip. A high MTTRem with a low MTTR usually means the SOC can detect and isolate, but the org can't patch.

### Alert volume — the metric leadership misreads

Alert volume on its own is useless. Two readings of the same number:
- **10,000 alerts/day, 50 escalated:** healthy tuning. Signal-to-noise 0.5%.
- **10,000 alerts/day, 9,800 escalated:** broken tuning OR active breach. Either way, your analysts are drowning.

Track these derived metrics instead:

- **Escalation rate** = escalated / total
- **False positive rate** = closed-as-FP / total
- **Analyst load** = alerts per analyst per shift
- **Time-to-triage** = mean time an alert sits in the queue before someone touches it

> **CompTIA exam trap:** "Alert volume" alone is the *least useful* of the four core metrics. If a question asks which metric best demonstrates SOC effectiveness, the answer is almost never raw volume — it's MTTD, MTTR, or a derived signal ratio.

### Incident reporting structure (who gets what)

CompTIA 4.2 expects you to know the audience for each report.

| Audience | Report type | Content |
|---|---|---|
| **Executive leadership / Board** | [[Executive Summary]] | Scope, impact, business risk, cost, remediation status. No packet captures. One page. |
| **Technical teams / IR** | Full incident report | Timeline, IoCs, [[Root Cause Analysis]], TTPs, evidence chain |
| **Legal counsel** | Legal hold + privileged report | Evidence preservation, [[Chain of Custody]], potential liability |
| **[[Regulatory Reporting]] bodies** | Breach notification | Per statute — GDPR 72h, CIRCIA timelines, HIPAA 60d, PCI per contract |
| **Law enforcement** | LE referral | When criminal activity confirmed; coordinate with legal first |
| **Public Relations / Media** | Public statement | Approved language only. Never the SOC's job to draft. |
| **Customers** | Customer communication | Required by law in most breach scenarios; templated, legal-approved |

### The five W's of incident reporting

Every incident report — at every level of audience — answers **Who, What, When, Where, Why** (and How, but CompTIA leans on the five):

- **Who** — threat actor (attributed or not), affected users, [[Stakeholder Identification]]
- **What** — assets impacted, data classification, [[Scope]] and [[Impact]]
- **When** — initial compromise, detection, containment, recovery (the **Timeline**)
- **Where** — systems, network segments, geographic, cloud regions
- **Why** — [[Root Cause Analysis]]: the vulnerability, misconfiguration, or human factor that opened the door

### Incident declaration

A SOC ticket is not an incident. **Incident declaration** is the formal moment a triaged alert is elevated — usually by an IR lead or duty manager — into a tracked incident with assigned severity, scope, and stakeholders. This timestamp is the official starting gun for MTTR and many regulatory clocks.

### Lessons learned — the metric that compounds

[[Lessons Learned]] meetings are held within ~2 weeks of recovery. Output: **Recommendations** — concrete, owner-assigned, deadline-bound action items. Detection gaps, playbook revisions, tooling investments, training needs. The lessons learned doc feeds next quarter's metric improvements; without it, you re-fight the same incident.

### Regulatory and legal timelines

> **CompTIA exam trap:** Memorize the headline timelines. GDPR: **72 hours** to supervisory authority. CIRCIA (US covered entities, post-2024 rule): **72 hours** for cyber incidents, **24 hours** for ransom payments. HIPAA: **60 days** to affected individuals. PCI-DSS: per acquirer contract (typically immediate). CompTIA loves swapping these.

[[Law Enforcement]] involvement is a **legal-led decision**, not a SOC decision. FBI, Secret Service (financial crime), or local LE depending on jurisdiction and crime type. Engage *through* legal counsel — direct SOC-to-FBI contact can compromise privilege and evidence handling.

## SOC reality

- The 3am alert fires. Your MTTD clock started 6 days ago when the attacker phished a contractor — you just don't know it yet. The number you brag about Monday morning will get rewritten Friday after forensics finishes the timeline reconstruction.
- The CISO will ask three things, in order: **"Scope? Impact? Is evidence preserved?"** If you can answer those in the first 30 minutes, you've earned the room's trust for the next 30 hours.
- Never tell leadership "we've contained it" until you've validated containment. Premature all-clears are how careers end. The phrase is *"we have isolated the affected hosts pending validation."*
- Alert volume metrics get weaponized by bad managers. If your boss measures you on "alerts closed per shift," they will incentivize closing real incidents as false positives. Push back. The metric that matters is escalation accuracy, not throughput.
- Regulatory clocks start at **incident declaration** or **awareness of breach** depending on statute — both are usually earlier than you'd like. Legal owns the disclosure decision, but the SOC owns the timestamp evidence that proves when the org knew. Document obsessively.
- The lessons-learned meeting is where junior analysts get blamed and senior architects get protected. Push for a blameless retro structure — Google's SRE postmortem template is the industry reference. *Blame finds a person; root cause finds a system.*

## Related concepts

[[Incident Response]] · [[Incident Response Plan]] · [[NIST SP 800-61]] · [[Lessons Learned]] · [[Root Cause Analysis]] · [[Chain of Custody]] · [[Executive Summary]] · [[Stakeholder Identification]] · [[Regulatory Reporting]] · [[Law Enforcement]] · [[SIEM]] · [[EDR]] · [[Threat Hunting]] · [[Inhibitors to Remediation]] · [[Detection Engineering]] · [[Dwell Time]] · [[Containment Eradication Recovery]]

*Source: VIRGIL knowledge base — 2026-05-11*