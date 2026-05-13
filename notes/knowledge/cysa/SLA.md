# SLA — Service-level Agreement

## What it is

In **Apex Legends**, when you go down, your squadmates have **90 seconds** before your banner expires. After that, they need to physically run your banner to a respawn beacon and stand there channeling for several seconds while exposed. The clock is the contract. The whole squad plays around it — push the fight, hold the corner, third-party the team that wiped you — because everyone knows the window. Miss the window, the banner greys out, and you're not coming back this round.

That's exactly what an **SLA** does for vulnerability management — it's the clock everyone agreed to before the fight started, and it tells you when a finding goes from "tracked" to "you broke the contract."

Technical definition: a **Service-level Agreement** is a contractual commitment between a service provider and a customer (or between IT and the business) that defines measurable performance obligations — including, for our purposes, the maximum time allowed to remediate a vulnerability of a given severity. SLAs are legally binding when external; internal SLAs (sometimes called **OLAs** — operational-level agreements) are governance commitments enforced by leadership.

The cousin you'll see on the exam: **SLO** (Service-level Objective) is the internal target you aim for. The SLA is the floor you can't cross without consequences. SLO = "we want patches out in 10 days." SLA = "we owe the customer 14 days or we owe them money / we fail the audit."

## Why it matters

SLAs are the reason vulnerability management has teeth. Without one, a critical CVE sits in a Jira backlog until someone gets bored. With one, the clock is loud, the dashboard goes red, and someone at the change board has to explain themselves.

For CySA+, **Objective 4.1** puts SLA directly in the reporting-and-communication domain because the analyst's job isn't just finding vulns — it's negotiating, tracking, and reporting against the time contract. You will be asked about SLA in the context of prioritization, inhibitors to remediation, MOUs vs SLAs, and KPIs/metrics.

In the real war room, the SLA is the only reason a remediation ticket survives contact with a busy infrastructure team. "Critical, 7 days" is a number the CAB respects. "It would be nice if we patched this" is a number nobody respects.

## Key facts

### Typical vulnerability remediation SLA tiers

Numbers vary by org, but the shape is universal. Tie the tier to **CVSS** severity or your internal **risk score**.

| Severity | CVSS range | Typical SLA | Notes |
|---|---|---|---|
| Critical | 9.0–10.0 | 7–15 days | Often 48–72h for internet-facing or actively exploited |
| High | 7.0–8.9 | 30 days | PCI DSS bakes in this tier explicitly |
| Medium | 4.0–6.9 | 60–90 days | Usually quarterly patch cycle |
| Low | 0.1–3.9 | 180 days or "next major release" | Risk-accept candidates |
| Zero-day / KEV | n/a | Out-of-band, hours-to-days | CISA KEV list overrides the tier |

**PCI DSS 4.0** mandates: critical/high patched within **one month**, others within **three months**. **CISA BOD 22-01** requires federal agencies to patch [[KEV catalog]] entries within tight windows (often 14 days). These are SLAs imposed by regulators, not negotiated internally.

### SLA inputs — what makes the clock fair

An SLA you can't meet is worse than no SLA. The clock should reflect:

- **Affected hosts** count and exposure (internet-facing vs internal)
- **Risk score** — CVSS base + temporal + environmental, plus asset criticality
- **Compensating controls** already in place (WAF, segmentation, EDR detection rule)
- **Business process interruption** required to patch — can you reboot prod at 2pm?
- **Inhibitors to remediation** baked into the environment

### Inhibitors to remediation — why SLAs slip

CompTIA tests this list explicitly. These are the reasons a vuln blows past the clock:

- **MOU (Memorandum of Understanding)** — non-binding cooperation doc between parties. If the vulnerable system is run by a partner under an MOU (not an SLA), you can ask but can't compel.
- **SLA constraints from a vendor** — your cloud provider's uptime SLA may forbid the maintenance window you need.
- **Organizational governance** — change advisory board (CAB) cycles, executive sign-off requirements.
- **Business process interruption** — patching the ERP means taking finance offline.
- **Degrading functionality** — the patch breaks a downstream integration.
- **Legacy systems** — Windows Server 2008 with no vendor patch available.
- **Proprietary systems** — vendor controls the patch cadence and won't move.

> **CompTIA exam trap:** MOU vs SLA — an MOU is a non-binding statement of intent between parties; an SLA is a binding performance contract. If the question describes a missed remediation deadline because a partner *won't cooperate*, the inhibitor is the **MOU** (no enforcement mechanism). If it's because the *vendor's contract forbids the action*, the inhibitor is the **SLA**.

### SLA tracking — metrics and KPIs

The SLA is meaningless without measurement. Track:

- **MTTRem (Mean Time to Remediate)** — average days from detection to closure, broken down by severity
- **SLA compliance rate** — % of vulns closed within their tier's window
- **Aging report** — vulns past SLA, grouped by owner team
- **Recurrence rate** — % of vulns that come back after being marked closed (bad patch, config drift, image rebuild)
- **Trends** — month-over-month direction. A flat MTTRem with a rising vuln count means the team is drowning.
- **Top 10** — highest-risk open findings by risk score, named, with owners

> **CompTIA exam trap:** **MTTR vs MTTRem vs MTTD** — MTTD is detection time, MTTR (mean time to respond/repair, depending on framework) is the IR metric, **MTTRem** is the vulnerability-management remediation metric. CompTIA will offer all three as distractors. For an SLA-driven vuln program, the answer is **MTTRem**.

### SLA exceptions — the risk-accept path

Sometimes the clock can't be met. The formal process:

1. **Document** the inhibitor (legacy system, proprietary vendor, BPI cost)
2. **Apply compensating controls** — network segmentation, WAF rule, EDR detection, monitoring uplift
3. **Get signoff** from the risk owner (business, not security — security recommends, business accepts)
4. **Set a review date** — risk acceptance isn't forever; it expires
5. **Report** the exception in the compliance report and to the steering committee

A risk-accepted vuln doesn't disappear from the dashboard. It moves to a different lane with its own review SLA.

### Stakeholders — who signs, who owns, who reports

- **CISO** — owns the SLA framework, reports to the board
- **Vulnerability management team** — measures, reports, escalates
- **System owners** — own remediation execution and SLA compliance for their assets
- **Risk committee / GRC** — owns exceptions and risk acceptance
- **Audit / compliance** — verifies SLA performance against regulatory requirements (PCI, HIPAA, SOX, FedRAMP)

The **action plan** in a vuln report names the owner, the SLA deadline, the compensating control if any, and the escalation path if the date slips. Without those four items, it's not a plan, it's a wish.

### Changing business requirements

SLAs are not set in stone. When the business changes — new product line, new regulation, M&A activity, a shift to internet-facing services — the SLA tiers should be revisited. An org that bought a fintech subsidiary inherits PCI DSS scope and has to tighten its critical SLA from 30 days to one month *yesterday*. Likewise, decommissioning a legacy segment can loosen SLAs on the rest of the estate.

### SLA in compliance reports

Compliance reports — to auditors, to the board, to regulators — almost always include SLA performance. Auditors want to see:

- The documented SLA policy
- The measurement methodology
- The compliance rate
- The exception register with sign-offs
- Trend lines proving the program is improving (or honest evidence it isn't)

A flat or rising aging report with no remediation strategy in the narrative is how a clean technical program still fails an audit.

## SOC reality

- The vulnerability dashboard at 9am Monday shows three numbers: open critical count, count past SLA, and the named owner of each one. The third number is the only one that drives action — anonymous tickets die.
- "Past SLA" doesn't mean the analyst pulled the cable. It means the analyst opens the escalation ticket, names the owner, names the inhibitor, and books time on the next CAB. The clock breaking is a *reporting* event, not a *containment* event.
- The CISO's question is never "what's our CVSS coverage?" It's "what's our SLA compliance rate, what's the trend, and which three findings will burn us if we get audited next week?"
- Never promise the business an SLA you don't control the inputs for. If patching depends on a vendor release cadence you don't own, your SLA starts the day the patch is *available*, not the day the CVE is published. Write that into the policy or you'll own a metric you can't move.
- Compensating controls are how you survive the gap between SLA reality and SLA aspiration. *A WAF rule blocking the exploit path is not remediation — it is a stay of execution, and the change board will ask when the real fix lands every single meeting until it does.*

## Related concepts

[[Vulnerability management lifecycle]] · [[CVSS]] · [[KEV catalog]] · [[Risk score]] · [[Compensating controls]] · [[MOU]] · [[OLA]] · [[SLO]] · [[MTTRem]] · [[Patching]] · [[Configuration management]] · [[Legacy systems]] · [[Proprietary systems]] · [[Change advisory board]] · [[Risk acceptance]] · [[Compliance reports]] · [[PCI DSS]] · [[Stakeholder identification]] · [[Action plans]] · [[Recurrence]] · [[Top 10]]

*Source: VIRGIL knowledge base — 2026-05-11*