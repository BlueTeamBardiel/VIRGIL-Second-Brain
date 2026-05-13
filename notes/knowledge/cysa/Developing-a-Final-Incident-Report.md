# Developing a Final Incident Report

## What it is

In **Among Us**, the round ends and the discussion screen shows you everything: who got vented, where the bodies dropped, who faked Medbay scan, who called the emergency meeting in Electrical, and the exact moment Red was confirmed sus. The replay isn't the game — the game already happened. The replay is what the crew uses to decide who to trust next round and what tasks to never leave half-finished again. That's exactly what a final incident report does — it's the post-round breakdown that turns one bad lobby into permanent crew knowledge.

In plain English: after the incident is contained, eradicated, and the systems are back, somebody has to write the document that captures what hit you, how you knew, what you did, what it cost, and what changes so it doesn't happen the same way twice.

Technically: the final incident report is the formal written deliverable produced during the **Post-incident Activity** phase of the NIST SP 800-61 / CompTIA incident response lifecycle. It consolidates the timeline, root cause, evidence summary, containment/eradication/recovery actions, impact assessment, validation results, and lessons learned into a single authoritative artifact distributed to stakeholders — IR team, leadership, legal, compliance, and where required, regulators and affected parties.

## Why it matters

The incident is over. The report is forever. It's the document that gets cited in the next breach, the next audit, the next lawsuit, the next insurance claim, and the next time someone asks why the SIEM rule that would've caught this still isn't deployed.

CySA+ tests this directly under **Objective 3.2** (incident response activities) and **Objective 4.2** (incident response reporting and communication). CompTIA wants you to know what goes in the report, who gets it, when it goes out, and what legal/regulatory clocks are ticking against it (GDPR 72h notification, CIRCIA reporting windows, PCI DSS forensic requirements, state breach notification laws).

Career-wise: the report is how the SOC proves it did its job. A clean timeline with preserved evidence and a defensible root cause is the difference between "the team handled it" and "the team got handled." Write enough of these and you stop being an L2 analyst — you become the person leadership calls when something is on fire.

## Key facts

### Required elements (CompTIA-aligned)

| Section | What goes in it |
|---|---|
| **Executive summary** | One page max. What happened, when, scope, impact, status. Written for the CISO and the board — no acronyms without expansion. |
| **Incident timeline** | UTC timestamps, every confirmed event, mapped to detection → containment → eradication → recovery phases. The replay screen. |
| **Detection and analysis** | How the incident was discovered ([[SIEM]] alert, EDR detection, user report, third-party notification), what [[Indicators of Compromise]] fired, what [[Data and Log Analysis]] confirmed it. |
| **Scope** | Systems affected, accounts compromised, data classes exposed, network segments touched. Be exact — "47 endpoints in the finance VLAN" not "several systems." |
| **Impact** | Operational (downtime, degraded services), financial (response costs, lost revenue), data (records exposed, classification), regulatory (notification triggers), reputational. |
| **Evidence summary** | What was collected ([[Disk Imaging|disk images]], [[Memory Acquisition|memory captures]], pcaps, logs), where it's stored, who has access, [[Chain of Custody]] reference. |
| **Containment, eradication, recovery actions** | [[Isolation]] steps, malware removal, account resets, [[Re-imaging]], [[Compensating Controls]] applied, restoration validation. |
| **Root cause analysis** | The actual initial access vector and the control gap that let it work. Not "the user clicked a link" — "phishing email bypassed mail filter because DMARC policy was set to none and the URL category feed was 6 days stale." |
| **Validation results** | Evidence that eradication worked — clean scans, [[Threat Hunting|hunt queries]] that returned zero, monitoring windows with no recurrence. |
| **Lessons learned** | What worked, what didn't, what the team didn't have when it needed it. |
| **Recommendations** | Concrete, owned, dated. "Deploy EDR to remaining 12% of endpoints — owner: endpoint team — target: Q3" not "improve endpoint visibility." |
| **Appendices** | Full timeline, IoCs (hashes, IPs, domains), [[ATT&CK]] technique mapping, evidence inventory, supporting logs. |

### Timeline construction

The timeline is the spine of the report. Build it from authoritative sources, not memory:

- **SIEM** correlation logs with original event timestamps
- [[EDR]] process tree exports
- [[NetFlow]] / pcap session data
- Ticketing system entries (when was IR engaged, when was the bridge opened)
- Chat/Slack/Teams logs from the IR channel
- Email threads with leadership and external parties

**Always UTC.** Mixed time zones in a timeline is how you lose a regulator's confidence in five seconds. Normalize everything.

### Root cause analysis — the part everyone gets wrong

RCA is not "what was the malware." RCA is "what control should have stopped this and why didn't it." Use the **5 Whys** or a fishbone diagram. Common true root causes:

- Missing or misconfigured control (no MFA on VPN, EDR not deployed to subset)
- Detection gap ([[SIEM]] rule existed but was disabled after generating false positives)
- Process gap (vulnerability was known, sat in the queue 90 days, change board kept tabling)
- People gap (on-call analyst didn't have runbook access)
- Vendor gap (third-party software shipped vulnerable; no SBOM visibility)

*The malware is the symptom. The control gap is the disease. If your RCA names the malware as root cause, rewrite it.*

### Evidence integrity and chain of custody

Every piece of evidence cited in the report needs:

- **Acquisition method** (write-blocker model, imaging tool, command used)
- **Hash values** (SHA-256 minimum) captured at acquisition AND verified before report finalization — this is [[Validating Data Integrity]]
- **Chain of custody** log showing every transfer, every access, every storage location
- **[[Legal Hold]]** status — if litigation is anticipated or active, retention is non-negotiable and the report must reference the hold

If hashes don't match between acquisition and analysis, the evidence is contaminated. Note it. Don't hide it.

### Impact quantification

Leadership wants numbers. Estimate where you can, mark assumptions where you can't:

| Impact class | How to express it |
|---|---|
| **Operational** | Downtime in hours × affected user count × productivity baseline |
| **Financial — direct** | IR vendor fees, overtime, replacement hardware, forensic retainer |
| **Financial — indirect** | Lost revenue (use finance team's per-hour figure), SLA penalties |
| **Data** | Record count by classification (PII, PHI, PCI, IP) — drives notification scope |
| **Regulatory** | Which laws triggered, which deadlines, which authorities notified |
| **Reputational** | Mark qualitative. Don't fabricate a number. |

### CompTIA exam traps

> **CompTIA exam trap:** The final report is produced during **Post-incident Activity**, not Recovery. Recovery ends when systems are validated clean and back in production. The report is a *separate* phase deliverable. CompTIA will offer "Recovery" as a tempting wrong answer.

> **CompTIA exam trap:** **Lessons learned** is part of the report and the post-incident phase. It is NOT a separate phase in the CompTIA/NIST four-phase model (Preparation → Detection and Analysis → Containment, Eradication, and Recovery → Post-incident Activity). Some older frameworks list it separately — CompTIA does not.

> **CompTIA exam trap:** Root cause ≠ initial access vector. Initial access is *how* they got in (phishing). Root cause is *why that worked* (no DMARC, no user training refresh in 18 months, mail filter URL feed stale). The report must contain both, but they are not the same field.

> **CompTIA exam trap:** Chain of custody documentation must be **complete and continuous**. A single missing transfer entry can render evidence inadmissible. The report references the CoC log; it does not replace it.

### Distribution and classification

Not everyone gets the full report. Classify it:

- **Executive version** — exec summary, impact, top recommendations. Goes to board, CEO, CFO.
- **Technical version** — full document. Goes to IR team, SOC leadership, IT operations, security engineering.
- **Legal version** — full document plus evidence appendices. Goes to General Counsel, outside counsel, under attorney-client privilege if litigation is anticipated.
- **Regulator version** — scoped to what the regulation requires. Don't volunteer more than the statute demands without counsel's sign-off.

Mark every copy. Track distribution. The report itself becomes evidence.

## SOC reality

- The report gets written by whoever's most senior on the IR engagement, usually the IR lead or a senior analyst. L1s contribute timeline entries and IoC lists. Drafting takes 2–10 business days for a meaningful incident; major breaches run weeks.
- **The CISO will ask three things first:** Did we contain it? What's our regulatory exposure? When do affected parties get notified? Your report's executive summary needs to answer those before page two.
- **Never write "the threat actor has been eradicated"** as a flat declaration. Write "no indicators of persistence detected during the 14-day monitoring window across the affected segment." The first is a promise; the second is a finding. The first ends careers when the actor comes back.
- **The retro meeting is where the report earns its keep.** Walk leadership through the timeline, the RCA, the recommendations. If the recommendations don't have named owners and target dates by the end of that meeting, the report is decorative.
- **Recommendations age fast.** Six months later, audit will ask which recommendations were implemented. If the answer is "none," the next incident's report has to explain why the last one's lessons learned were ignored. That conversation is worse than the original incident.

## Related concepts

[[Incident Response Lifecycle]] · [[Post-incident Activity]] · [[Lessons Learned]] · [[Root Cause Analysis]] · [[Chain of Custody]] · [[Validating Data Integrity]] · [[Legal Hold]] · [[Evidence Acquisition]] · [[Preservation]] · [[Scope]] · [[Impact Analysis]] · [[Isolation]] · [[Re-imaging]] · [[Compensating Controls]] · [[Remediation]] · [[Data and Log Analysis]] · [[Indicators of Compromise]] · [[ATT&CK]] · [[SIEM]] · [[EDR]] · [[Breach Notification]] · [[Stakeholder Communication]]

*Source: VIRGIL knowledge base — 2026-05-11*