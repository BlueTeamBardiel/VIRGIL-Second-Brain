# Lessons Learned Session

## What it is

In **Halo: Combat Evolved**, after the *Pillar of Autumn* falls and Master Chief escapes the ring, Cortana doesn't just file the mission report and move on. She rips apart every captured Covenant data fragment, replays every engagement, and walks the Chief through what the Flood actually is, what 343 Guilty Spark actually wanted, and why the ring was never a weapon *against* the Flood — it was a weapon that kills everything *to starve* the Flood. By Halo 2, that debrief is doctrine. The UNSC fights smarter because Cortana ran the post-mortem honestly. That's exactly what a lessons learned session does — it's the meeting after the incident where you tear apart your own response, find what failed, and rewrite the playbook so the next attack lands on hardened ground.

Technically: a **lessons learned session** is the final phase of the NIST SP 800-61 incident response lifecycle — **Post-incident Activity**. It is a structured review conducted after an incident closes, where responders, stakeholders, and leadership reconstruct the timeline, evaluate response effectiveness, capture new [[Indicators of Compromise]], and feed improvements back into detection, containment, and recovery capabilities. Output is documented, distributed, and tracked to closure.

## Why it matters

Every incident is paid tuition. If you don't run the debrief, you paid for the lesson and threw away the receipt. The same threat actor — or the same TTP from a different actor — will hit you again, and your MTTD will be identical because nothing in the SIEM changed. The lessons learned session is the only phase of IR that has compounding returns. Containment stops one incident. Lessons learned stops a category of incidents.

For CySA+ specifically: **Objective 3.2** explicitly tests post-incident activity, and CompTIA loves to ask which phase certain actions belong to. Updating playbooks, tuning [[SIEM]] rules, and adding new IoCs to threat intel feeds are post-incident — not containment, not recovery. Get the phase boundary wrong on the exam and you eat the question.

For your career: the analyst who can run a clean blameless debrief and produce written, actionable findings is the analyst who becomes IR lead. Everyone can stare at Splunk. Not everyone can write the document that changes how the org defends itself.

## Key facts

### Where it sits in the lifecycle

The NIST SP 800-61 four-phase model:

1. **Preparation**
2. **Detection and Analysis**
3. **Containment, Eradication, and Recovery**
4. **Post-incident Activity** ← lessons learned lives here

Lessons learned is *not* a separate fifth phase. It's the core deliverable of Post-incident Activity, alongside evidence retention decisions and final reporting.

### Timing

| Window | What happens |
|---|---|
| **Within 1–2 weeks of recovery** | Schedule the session. Memory decays fast. Slack threads disappear. |
| **Day-of session** | 60–90 minutes max. Longer and people stop talking. |
| **Within 1 week after** | Written report distributed to stakeholders. |
| **30/60/90 day reviews** | Track action items to closure. Half the value is the follow-through. |

Run it too early and the room is still emotional. Run it too late and the [[Forensic Timeline]] is foggy and the people who knew the details have moved to other tickets.

### Who attends

- **IR lead** — facilitates, owns the document
- **L1/L2 SOC analysts** who triaged the alert
- **System and network owners** of affected assets
- **Threat intel** — they need the new IoCs
- **Engineering / IT ops** — they own remediation
- **Legal and compliance** — if regulatory reporting or [[Legal Hold]] was in play
- **Executive sponsor** — for high-impact incidents only

Keep it small enough to be honest. Keep it broad enough to capture every angle.

### The seven questions

Every lessons learned session answers these. CompTIA's framing tracks NIST closely:

1. **What happened, and when?** Reconstruct the timeline from [[Log Analysis]] and evidence.
2. **How well did staff and management perform?** Did the on-call respond inside SLA?
3. **Were documented procedures followed? Were they adequate?** If the playbook was wrong, that's a finding.
4. **What information was needed sooner?** Detection gaps live here.
5. **Were any steps taken that might have inhibited the recovery?** Honest answers only.
6. **What would staff do differently?** Future-state.
7. **How can information sharing improve?** Cross-team, threat intel, ISAC participation.

### What the output captures

| Section | Content |
|---|---|
| **Executive summary** | Plain language, 1 paragraph, what hit us and what it cost. |
| **Timeline** | Reconstructed from [[Chain of Custody]] logs, SIEM events, and analyst notes. UTC timestamps. |
| **Scope and impact** | Hosts affected, data touched, dwell time, business impact in dollars where known. |
| **Root cause analysis** | The technical cause and the systemic cause. Both matter. |
| **What worked** | Detection rules that fired correctly, containment actions that held. Don't only document failure. |
| **What failed** | Detection gaps, response delays, missing telemetry, broken processes. |
| **New IoCs** | Hashes, IPs, domains, registry keys, [[YARA]] rules, behavioral signatures. |
| **Action items** | Owner, due date, success criteria. Tracked to closure. |
| **Playbook updates** | Specific edits to specific runbooks. |

### Where the new IoCs go

This is the operational payoff. Every IoC harvested from the incident must be pushed into:

- **[[SIEM]] correlation rules and watchlists**
- **EDR/XDR custom detections and block lists**
- **Firewall / proxy deny lists**
- **DNS sinkhole feeds**
- **[[Threat Intelligence Platform]] — internal and shared via STIX/TAXII**
- **[[Vulnerability Management]] scan signatures if the entry vector was a CVE**

An IoC that lives only in the incident report is an IoC that didn't earn its keep.

### Common action item categories

- **Detection gaps** — new SIEM rules, new EDR queries, new log sources (the incident exposed a blind spot in DNS or PowerShell logging? Fix it.)
- **Containment delays** — automation, SOAR playbook updates, isolation network segments pre-staged
- **Process failures** — escalation tree updated, on-call rota fixed, contact lists refreshed
- **Tooling gaps** — write blockers ordered, forensic VM updated, [[Network Segmentation]] tightened
- **Training** — tabletop the scenario again in 90 days
- **Compensating controls** — when full remediation will take quarters, what holds the line in the meantime
- **Re-imaging standards** — if hosts were rebuilt, is the gold image hardened?

### Blameless culture

The session is blameless or it is worthless. The moment one analyst gets thrown under the bus, every future debrief becomes a defensive theater piece and you stop learning. Frame failures as systemic — *the alert didn't reach the on-call because the paging rule was wrong*, not *Karen missed the alert*. The system failed Karen. Fix the system.

*The first incident where I watched a manager start the debrief by asking "who let this happen" was the last useful debrief that team ran for a year.*

### CompTIA exam traps

> **CompTIA exam trap:** Lessons learned is **Post-incident Activity**, not Recovery. Recovery ends when systems are restored to normal operations and monitoring is in place. Anything that happens after that — including the debrief, the report, the playbook updates — is Post-incident. CompTIA will offer "Recovery" as the wrong answer and it looks tempting.

> **CompTIA exam trap:** New IoCs are discovered during **Detection and Analysis** *and* refined during **Post-incident Activity**. The trap is asking where they get *added to the SIEM* — that's Post-incident, because it's a defensive improvement based on what was learned. Adding them mid-incident is detection. Institutionalizing them is lessons learned.

> **CompTIA exam trap:** Lessons learned is not the same as **root cause analysis (RCA)**. RCA is a technical deliverable that lives *inside* the lessons learned report. Lessons learned is broader — it covers process, people, tooling, and RCA. CompTIA may ask which is the parent activity.

> **CompTIA exam trap:** [[Legal Hold]] obligations may prevent destruction of evidence captured during the incident — *even after* lessons learned closes. Preservation timelines are driven by legal and regulatory requirements, not by IR phase. Don't wipe the forensic image because the ticket is closed.

### Validating that the lessons stuck

A session with no follow-through is a calendar event, not a control. Mechanisms that prove the lessons landed:

- **30/60/90 day action item review** — owner reports status
- **Re-run the tabletop** — same scenario, 6 months later, measure response time delta
- **Purple team exercise** — red team replays the TTPs, blue team should now catch them
- **MTTD / MTTR trend** — the metric should move
- **Audit trail** — playbook version history shows the update with a link back to the incident ticket

If none of these exist, the lessons didn't learn.

## SOC reality

- The 3am page is over. The host is re-imaged, the C2 domain is sinkholed, and Slack has gone quiet. Two days later the IR lead drops a calendar invite titled "IR-2026-0411 retro" and half the responders groan because they're already on a new incident. Show up anyway.
- L1 brings the alert timeline — when the rule fired, what they triaged first, what they escalated. L2 brings the [[Pivot Analysis]] of how they walked from the initial alert to the full scope. IR lead runs the room.
- The CISO asks three questions, every time: *What was the dwell time? What data was touched? What are we doing so this doesn't happen again?* Have those three answers written down before the meeting starts.
- Never promise leadership "this won't happen again." Promise specific, measurable improvements with owners and dates. "We will deploy EDR to the OT subnet by Q3" is a commitment. "We've learned our lesson" is vapor.
- The handoff: action items go into the engineering and SOC backlogs with the incident ticket linked. Threat intel pushes new IoCs out to peer orgs via [[ISAC]] / [[STIX/TAXII]] if your org shares. Legal confirms whether the [[Legal Hold]] persists or evidence can be aged out. Then — and only then — the incident is closed.

## Related concepts

[[Incident Response Lifecycle]] · [[NIST SP 800-61]] · [[Root Cause Analysis]] · [[Indicators of Compromise]] · [[SIEM]] · [[Threat Intelligence Platform]] · [[Chain of Custody]] · [[Legal Hold]] · [[Playbook]] · [[SOAR]] · [[Tabletop Exercise]] · [[MTTD]] · [[MTTR]] · [[Compensating Controls]] · [[Re-imaging]] · [[Forensic Timeline]] · [[STIX/TAXII]] · [[Post-incident Activity]]

*Source: VIRGIL knowledge base — 2026-05-11*