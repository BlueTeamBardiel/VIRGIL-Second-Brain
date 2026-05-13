# Security Events vs Security Incidents

## What it is

In **Dota 2**, every action on the map is logged — every last-hit, every ward placement, every Smoke of Deceit used, every TP scroll cast. Your minimap pings constantly: creeps dying mid-lane, a hero seen in river, a tower taking damage from siege creeps. Ninety percent of those pings are nothing. Background noise. The game running its normal economy.

Then your offlaner pings four times on the Roshan pit. The enemy team has been missing from lanes for forty seconds. Aegis timer is up. *That's* the moment the team has to stop farming and respond — because the pattern of pings now means something the individual pings did not.

That's exactly the difference between a security event and a security incident. Every ping is an **event** — an observable thing happened. The Roshan smoke gank is an **incident** — events correlated into something that violates the state you wanted to be in.

**Plain English:** A security event is anything observable on a system or network. A security incident is when one or more events confirm — or are about to confirm — that your security policy got violated. Every incident is built out of events. Not every event becomes an incident.

**Technical (CS0-003 / NIST SP 800-61 Rev. 2):**
- **Event** — any observable occurrence in a system or network. Neutral by definition. A user logging in is an event. A firewall denying a packet is an event. CPU spiking is an event.
- **Adverse event** — an event with negative consequences (system crash, malware execution, unauthorized disclosure).
- **Security incident** — a violation or imminent threat of violation of security policies, acceptable use policies, or standard security practices.

The classification is not academic. It controls who gets paged, what playbook runs, what timers start, and whether your legal team has a regulatory clock ticking.

## Why it matters

CompTIA Objective 3.3 sits on top of this distinction. The entire incident response lifecycle — preparation, detection and analysis, containment/eradication/recovery, post-incident — only triggers when an event gets *classified* as an incident. Misclassify and one of two things happens:

- **False negative:** real incident gets logged as a routine event, sits in the SIEM for 47 days, exfil completes, you find out from a customer.
- **False positive:** routine event escalated to incident, IR team mobilized at 2am, change board burned, executive trust burned, next real alert ignored.

CySA+ tests this because every domain 3 question assumes you know which side of the line you're on. Tabletop exercises, playbooks, BC/DR plans, forensic acquisition — none of them run on events. They run on declared incidents.

> **CompTIA exam trap:** A failed login is an **event**. A thousand failed logins from one source against one account in ten minutes is still — technically — a collection of events until an analyst (or a SIEM rule) classifies the pattern as a brute force *incident*. CompTIA will offer "incident" as the obvious answer for any suspicious-sounding scenario. Read carefully. If the question describes raw telemetry with no human or rule classification yet, it's an event.

## Key facts

### The classification line

| Dimension | Event | Incident |
|---|---|---|
| **Definition** | Observable occurrence | Violation or imminent violation of policy |
| **Volume** | Millions per day in mid-size enterprise | Single digits to dozens per day |
| **Triggers** | Logs, sensors, telemetry | Analyst declaration or rule-based correlation |
| **Owner** | SIEM, log pipeline | IR team, incident commander |
| **Clock** | None | Regulatory + SLA clocks start |
| **Examples** | Failed login, port scan, AV detection | Confirmed compromise, data exfil, ransomware |

### Events that commonly become incidents

- **Failed logins** → brute force / credential stuffing
- **AV/EDR detection** → confirmed malware execution
- **Port scan from external IP** → reconnaissance phase of intrusion
- **DLP alert on outbound traffic** → data exfiltration
- **Privilege escalation in audit log** → unauthorized access
- **Unusual outbound beaconing** → C2 communication
- **Login from impossible-travel geo** → account takeover

The promotion from event to incident requires *correlation, context, or confirmation*. A single AV alert that quarantined the file successfully might never get promoted. The same alert on a domain controller, with the file written by a service account that has no business writing executables, is a P1 incident before the analyst finishes typing the ticket.

### How [[Preparation]] makes this work

You cannot classify events at scale without preparation. CompTIA explicitly tests the preparation phase artifacts:

- **[[Incident Response Plan]]** — the document that defines what counts as an incident, who declares it, and what severity tiers exist. Without it, classification is a vibe.
- **[[Playbooks]]** — per-incident-type runbooks. Phishing playbook, ransomware playbook, insider threat playbook. Each starts with "criteria to declare this incident type."
- **[[Tabletop]] exercises** — paper-based walkthroughs where the team practices classification decisions before they cost real money. The CISO reads a scenario, the team decides: event or incident? What severity? Who do we call?
- **Training** — L1 analysts trained on the classification matrix. If an L1 cannot promote an event to an incident under defined criteria, the entire SOC throughput collapses.
- **Tools** — SIEM correlation rules, SOAR playbooks, EDR auto-containment. These automate the event→incident promotion for known patterns.
- **[[Business Continuity]] (BC) / [[Disaster Recovery]] (DR) plans** — define what level of incident triggers failover, what level triggers full DR invocation. The classification *directly* drives BC/DR activation.

### The severity matrix

Most mature SOCs run a tiered classification. CompTIA-style example:

| Tier | Definition | Example | Response |
|---|---|---|---|
| **Sev 1** | Critical business impact, active compromise | Ransomware spreading, exfil in progress | IR team + execs paged, war room opens |
| **Sev 2** | Confirmed compromise, contained scope | Single host malware, lateral movement attempts blocked | IR team paged, business hours |
| **Sev 3** | Suspicious activity, investigation needed | Anomalous logins, unconfirmed alerts | L2 analyst, ticket queue |
| **Sev 4** | Informational, policy-relevant | Failed scans, policy violations | L1 review, no escalation |

Events live below Sev 4. The matrix is the bridge.

### Post-incident activity — how the line gets redrawn

After every declared incident, CompTIA expects four post-incident activities (Objective 3.3):

1. **[[Forensic Analysis]]** — what artifacts confirm the timeline? Disk images, memory captures, log exports — all with [[Chain of Custody]] preserved.
2. **[[Root Cause Analysis]]** — not "the user clicked the link." That's the proximate cause. Root cause is "we have no email sandboxing and no MFA on the VPN." Five-whys it until you hit a control gap.
3. **[[Lessons Learned]]** — the formal retro. What detection fired? What detection should have fired and didn't? What was the dwell time? Did the playbook match reality?
4. **Plan updates** — IR plan, playbooks, detection rules, training all get revised based on lessons learned.

The point of post-incident activity is that *next time, this incident is detected as an event that auto-promotes earlier in the kill chain.* The classification line is not static. Every incident teaches you to redraw it lower — to catch the same pattern when it's still just three suspicious events instead of a confirmed breach.

*Every post-incident meeting that doesn't produce at least one new detection rule or one playbook update was a wasted meeting.*

### What gets logged but never becomes an incident

Critical for CySA+ understanding: most of what your SIEM ingests is *evidence of normal operation*. A SIEM that only logged incident-grade data would have nothing to correlate. You need the baseline noise to detect the deviation. This is why log retention is a compliance question (PCI DSS = 1 year, HIPAA = 6 years, etc.) and not just a storage question. The events you didn't classify as incidents today are the corpus that lets you reconstruct *yesterday's* incident when it surfaces tomorrow.

> **CompTIA exam trap:** "When does the regulatory notification clock start?" The clock starts when the incident is *declared*, not when the first event was logged. GDPR 72-hour notification, CIRCIA 72-hour for covered cyber incidents, HIPAA 60 days — all run from declaration/discovery, not from initial telemetry. This is also why backdating classification is legally radioactive.

> **CompTIA exam trap:** Don't confuse **event** (NIST) with **alert**. An alert is a *notification* generated by a tool, often based on rules that flag events of interest. Alerts are a subset of events. Incidents are declared from alerts (usually) but require human or automated classification. Event ⊇ Alert ⊃ Incident, roughly.

## SOC reality

- The L1 console at 3am shows ~40,000 events per hour. The classification dashboard shows three open incidents. Both numbers are normal. If the event count drops to zero, something is broken in the log pipeline — and that itself becomes an event that may become an incident.
- L1's job is not to investigate every event. It's to apply the classification matrix and escalate the ones that meet the bar. "Did I miss anything?" is the question that ends careers. The matrix exists so the answer is defensible.
- The IR lead's first question on a Sev 1 call is always the same: *"What's the scope, what's the impact, is evidence preserved?"* You do not have answers in the first five minutes. You have hypotheses. Say "hypothesis" out loud or you will commit to something wrong.
- Never tell leadership "this is just an event" until you have actually correlated it. The phrase analysts get fired for is *"we looked at it and closed it"* when the post-incident shows it was the first beacon of a four-month dwell.
- The handoff: L1 classifies → L2 investigates and confirms → IR lead declares incident and assigns commander → legal/comms/exec loop in at Sev 2+ → post-incident activity feeds back into preparation. The loop closes at lessons learned. If it doesn't close, the next incident will look identical to this one.

## Related concepts

[[Incident Response Lifecycle]] · [[NIST SP 800-61]] · [[Preparation Phase]] · [[Detection and Analysis]] · [[Containment Eradication Recovery]] · [[Post-Incident Activity]] · [[Playbooks]] · [[Tabletop]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Forensic Analysis]] · [[Chain of Custody]] · [[SIEM]] · [[SOAR]] · [[Business Continuity]] · [[Disaster Recovery]] · [[Indicators of Compromise]] · [[MTTD]] · [[MTTR]]

*Source: VIRGIL knowledge base — 2026-05-11*