# Metrics and KPIs

## What it is

In **Super Mario 64**, the castle has a star counter in the corner. You don't unlock Bowser by vibes — you unlock him at 70 stars. The counter is brutal and honest: it doesn't care that you tried hard on Cool, Cool Mountain, it cares that you grabbed the star. Same with the timer on Bowser in the Dark World — you either pulled his tail and threw him into the bomb on time, or you didn't. The numbers are the scoreboard. Mario doesn't get to argue with them.

That's exactly what SOC metrics and KPIs do — they're the star counter for your incident response program. Leadership doesn't care how hard the analysts worked last quarter; they care whether the numbers moved in the right direction.

**Technical definition (CS0-003):** Metrics are quantitative measurements of SOC and IR performance. KPIs (Key Performance Indicators) are the specific metrics tied to business objectives, reported up the chain to demonstrate the program is detecting threats faster, responding faster, and reducing dwell time. Domain 4.0 tests whether you know which metric measures what, what "good" looks like, and what to do when the numbers go sideways.

## Why it matters

Metrics are how the SOC justifies its budget. When the CFO asks "what did we get for $4M last year?", "we stopped a lot of bad stuff" is not an answer. "MTTD dropped from 14 days to 6, MTTR from 48 hours to 11, alert tuning cut false-positive volume by 62%, and we closed 89% of criticals inside SLA" is an answer.

Metrics are also how you spot rot. A creeping MTTD means detection logic is getting stale. A spiking alert volume with flat true-positive rate means tuning is broken. A widening gap between MTTR and MTTRem means you're stopping fires but not fixing the wiring.

**Exam relevance:** Objective 4.2 specifically calls out metrics and KPIs as a required component of incident response reporting. CompTIA will test MTTD vs MTTR vs MTTRem — the three are *not* the same, and the exam loves to swap definitions.

## Key facts

### The three "mean time" metrics — know these cold

| Metric | Full name | What it measures | Clock starts | Clock stops |
|---|---|---|---|---|
| **MTTD** | Mean Time to Detect | How long an intrusion sat undetected | Initial compromise | Alert fires / analyst sees it |
| **MTTR** | Mean Time to Respond | How long from detection to containment | Alert triaged | Threat contained / isolated |
| **MTTRem** | Mean Time to Remediate | How long from detection to full eradication + recovery | Alert triaged | Root cause fixed, systems restored |

**Formula (generic):** `Mean Time = Σ(time per incident) / number of incidents`

What "good" looks like depends on the org, but rough industry benchmarks:
- **MTTD:** under 24 hours is strong. The 2023 industry average was around 200+ days before detection in unprepared orgs — that's the gap your program closes.
- **MTTR:** under 4 hours for criticals is the target most mature SOCs aim at.
- **MTTRem:** days to weeks, depending on patch cycle and change windows.

> **CompTIA exam trap:** MTTR is ambiguous in the wild — some shops call it "Mean Time to Respond," others "Mean Time to Repair," others "Mean Time to Recover." For CS0-003, MTTR = **Mean Time to Respond** (detection → containment). MTTRem = remediation (the full fix). If the question describes "time to fully restore service and close the root cause," that's MTTRem, not MTTR.

### Alert volume metrics

- **Total alerts per day/week/month** — raw firehose number
- **True-positive rate (TPR)** — alerts that were real threats / total alerts
- **False-positive rate (FPR)** — tuned-out noise / total alerts
- **Escalation rate** — L1 → L2 → IR. High rate = L1 undertrained or detection logic too broad
- **Alert-to-incident ratio** — how many alerts it takes to find one real incident

A SOC drowning in alerts is a SOC that misses the real one. *I have watched a P1 sit in a queue for 6 hours behind 400 tuned-but-not-suppressed Windows event 4625 alerts. The metric that would have caught it was FPR — but nobody was reporting it.*

### Vulnerability management metrics

- **Vulnerabilities by severity** (Critical / High / Medium / Low) over time
- **Top 10 most exploited / most prevalent** — focuses remediation effort
- **SLA compliance rate** — % of criticals patched inside 7 days, highs inside 30, etc.
- **Mean time to patch** — separate from MTTRem; specific to vuln management
- **Recurrence rate** — vulns that came back after being marked fixed. *This one quietly tells you your patching pipeline is broken.*
- **Coverage** — % of assets actually being scanned. A scanner that misses 30% of the fleet is reporting a flattering lie.

Zero-days are hard to trend by definition — you can't graph what didn't have a CVE yesterday. Track them separately: number disclosed, number affecting your stack, time-to-mitigation-or-compensating-control.

### Detection efficacy metrics

- **Detection coverage by [[MITRE ATT&CK]] technique** — how many TTPs your rules actually catch. Mature SOCs map every detection to ATT&CK and report coverage gaps.
- **Mean dwell time** — how long an adversary lived in your network before eviction. Closely related to MTTD but measured per incident, not aggregate.
- **Detections per data source** — are your endpoint logs pulling weight? Your firewall? Your cloud audit logs?

### Business impact metrics

- **Cost per incident** — analyst hours + downtime + recovery + regulatory exposure
- **Downtime / availability** — minutes of service outage attributable to security events
- **Records affected** — for data breach reporting (this number triggers GDPR 72h, state breach laws, etc.)
- **Customer churn post-incident** — slow signal but real

### What goes in the executive report

The CISO doesn't read the SIEM. They read your slide. The exec summary metric set is typically:

1. **MTTD / MTTR / MTTRem** trends (quarter over quarter)
2. **Incident count by severity**
3. **Top 3 risks** — what could hit us next, what we're doing about it
4. **SLA compliance** — are we meeting the targets we promised
5. **Budget burn vs program maturity** — are we getting value

> **CompTIA exam trap:** The executive summary is *not* the technical report. It's the top-of-page, plain-English, no-acronym, business-impact version. If the exam asks what an executive summary contains and the option says "packet captures and IOC hashes," that's the technical report, not the summary.

### Stakeholder reporting cadence

| Audience | Cadence | What they want |
|---|---|---|
| SOC manager | Daily | Alert volume, queue depth, on-call load |
| CISO | Weekly / monthly | MTTD/MTTR trends, top risks, SLA compliance |
| Executive board | Quarterly | Program maturity, budget justification, business impact |
| Regulators | Per-incident, per law | Breach notification, scope, affected records |
| Customers | Per-incident, when applicable | What happened, what data, what we're doing |
| Law enforcement | Per-incident, when applicable | Timeline, IOCs, suspect attribution if known |
| Public relations / media | Per-incident, when applicable | Approved statement only — never let analysts freelance |

### Lessons learned and the post-incident metric

Every closed incident should generate one delta in a metric somewhere — a new detection rule, a tuned alert, a patched gap, a playbook update. *If the post-mortem produces no metric change, the post-mortem didn't happen.* That's the test.

### CompTIA exam traps

> **CompTIA exam trap:** Don't confuse **MTBF (Mean Time Between Failures)** with **MTTR**. MTBF is a reliability metric (how often does it break), MTTR is a response metric (how fast do we fix it when it does). MTBF shows up in BC/DR questions; MTTR shows up in IR questions.

> **CompTIA exam trap:** Alert volume is *not* a quality metric by itself. A SOC with 10,000 alerts/day isn't better than one with 500 — it's probably worse, because it's drowning. CompTIA will offer "increase alert volume" as a wrong answer to "how do we improve detection." The right answer is improve TPR and coverage.

> **CompTIA exam trap:** "Lessons learned" is a phase, not a document. The deliverable is an after-action report (AAR) or post-incident review. CompTIA may ask which IR phase produces the metric changes — answer: **post-incident activity**.

## SOC reality

- The 8am standup metric is queue depth and overnight escalations. The 9am leadership metric is "anything I need to tell the CEO about." Two different audiences, two different slides, same underlying data.
- When MTTD spikes, the CISO doesn't want excuses — they want root cause. Is a data source down? Did a detection rule break? Did the threat get quieter? *I once watched MTTD double overnight because a syslog forwarder silently failed and nobody noticed for two weeks. The metric caught what the monitoring of the monitoring didn't.*
- Never promise leadership a metric will improve next quarter unless you've already done the work that will move it. Promised improvements that don't land cost you credibility, and credibility is the only currency a SOC manager has.
- The board asks one question every time: "are we getting better or worse?" If your metrics can't answer that in one slide, you don't have metrics — you have numbers.
- Regulatory metrics (records affected, time-to-notification) have legal weight. Get those wrong and the org pays fines. The SOC analyst's job is to feed clean numbers up; legal and comms own the external story.

## Related concepts

[[Incident Response Lifecycle]] · [[Executive Summary]] · [[Stakeholder Communication]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Vulnerability Management]] · [[MITRE ATT&CK]] · [[SLA and SLO]] · [[Regulatory Reporting]] · [[GDPR Breach Notification]] · [[SIEM]] · [[Alert Tuning]] · [[Dwell Time]]

*Source: VIRGIL knowledge base — 2026-05-11*