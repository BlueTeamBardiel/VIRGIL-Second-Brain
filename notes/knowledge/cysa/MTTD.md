# MTTD — Mean Time to Detect

## What it is

In **Persona 5**, the Phantom Thieves can only steal a Palace's Treasure after they send a calling card. The calling card forces the Treasure to materialize — until then, it's a hazy psychological construct nobody can grab. But here's the catch: the Palace ruler knew something was wrong long before the card arrived. Shadows had been roaming the corridors for weeks. Security level was climbing. The ruler just couldn't articulate the threat until the card made it real. That gap — between "something is off in my Palace" and "the Phantom Thieves are here, now, with a name and a face" — is exactly what MTTD measures.

**Mean Time to Detect** is the average time between when an incident *begins* (initial compromise, first malicious action, T₀) and when your security team *detects* it (alert triaged, incident declared, T_detect). Plain English: how long the attacker is in your environment before you notice. Technical: a SOC performance KPI calculated across all confirmed incidents in a measurement window, expressed in minutes, hours, or days depending on the maturity of the program.

Formula:

> **MTTD = Σ (T_detect − T_compromise) / N incidents**

The ugly truth: T_compromise is rarely known at the time of detection. It gets backfilled during root cause analysis when forensics pins the actual initial access timestamp. So MTTD is almost always a *retrospective* metric — you can't compute it in real time, you compute it after the post-incident write-up.

## Why it matters

CS0-003 Objective 4.2 lists MTTD alongside MTTR and MTTRem as the three core IR metrics CompTIA expects you to define, calculate, and distinguish. They show up in executive summaries, board reports, and the metrics section of every IR after-action report.

Real-world stakes: industry MTTD for sophisticated intrusions is still measured in *months*. The IBM Cost of a Data Breach reports have hovered around 200+ days for years. Every day the attacker is undetected is another day of [[Lateral Movement]], credential harvesting, and staging for [[Exfiltration]]. MTTD is the single best proxy for "how blind are we?" — and the metric the CISO uses to justify EDR budget, SIEM tuning hours, and threat-hunting headcount.

It's also the metric that tells you whether your [[SIEM]] rules are working or whether you're paying for very expensive log storage that nobody queries.

## Key facts

### The detection clock — when does it start and stop?

| Event | What it is | Timestamp |
|---|---|---|
| **T_compromise (T₀)** | Initial access — phishing click, exploited CVE, valid creds used by attacker | Backfilled from forensics |
| **T_alert** | SIEM, EDR, or other tool fires an alert | Wall-clock from tool |
| **T_triage** | L1 analyst opens the ticket and starts investigating | Ticket timestamp |
| **T_detect** | Incident is *declared* — confirmed not false positive | IR system of record |

**MTTD ends at T_detect, not T_alert.** This is a CompTIA-relevant nuance. An alert firing is not detection. A SOC drowning in 50,000 alerts a day with a 5-minute alert latency can still have an MTTD of weeks if nobody triages the right alert. *An alert in the queue is not a detection — it's a lottery ticket waiting to be scratched.*

### MTTD vs MTTR vs MTTRem — the three-metric trap

CompTIA loves to scramble these. Burn them in:

| Metric | Measures | Clock starts | Clock stops |
|---|---|---|---|
| **MTTD — Mean Time to Detect** | Detection latency | T_compromise | T_detect (incident declared) |
| **MTTR — Mean Time to Respond** | IR speed once detected | T_detect | T_contained (active threat neutralized) |
| **MTTRem — Mean Time to Remediate** | Full cleanup | T_detect | T_remediated (root cause fixed, systems restored, lessons learned filed) |

MTTR has a second, ambiguous meaning in IT ops — **Mean Time to Repair** — which is why CompTIA sometimes spells it out as "respond" in question stems. *Read the stem. Don't assume.*

> **CompTIA exam trap:** A question gives you a timeline — compromise on Monday, alert fires Tuesday, analyst confirms incident Wednesday, host contained Thursday, root cause patched and systems restored next Monday. Which window is MTTD? **Monday → Wednesday.** Not Monday → Tuesday (that's alert latency, not detection). Not Monday → Thursday (that's MTTD + MTTR). CompTIA tests the difference between alert-fired and incident-declared.

### What "good" MTTD looks like

There is no universal benchmark — it scales with your stack, threat model, and detection surface. Rough industry shape:

- **Mature SOC, well-tuned EDR/SIEM, threat-hunting program:** hours to a day for commodity threats; days for stealthy [[APT]] activity
- **Average enterprise:** weeks to months for targeted attacks
- **No SOC, log-and-forget posture:** detection happens when the ransomware note appears, the FBI calls, or the data shows up on a leak site — MTTD measured in months or "never"

The honest framing for an executive summary: *"MTTD for commodity malware was 4 hours this quarter. MTTD for the credential-theft incident in March was 47 days. The gap is our detection blind spot, and it's where threat-hunting hours need to go."*

### What drives MTTD down

- **Behavior-based detection** ([[EDR]], [[UEBA]]) catches things signature-based tools miss
- **Log coverage** — you can't detect what you don't ingest. DNS logs, EDR telemetry, identity logs (Entra ID, Okta), cloud audit logs
- **Detection engineering** — purpose-built rules mapped to [[MITRE ATT&CK]] techniques, not vendor defaults
- **Threat hunting** — proactive hypothesis-driven searches that find dwell-time intrusions sitting under the alert threshold
- **Tuning** — every false positive that gets suppressed is bandwidth returned to triaging real signal
- **Threat intelligence integration** — fresh IoCs piped into the SIEM shorten the gap between "this campaign is public" and "we'd see it in our environment"

### What drives MTTD up (the inhibitors)

- Alert fatigue — when [[Alert Volume]] exceeds analyst capacity, real detections sit in queue
- Log gaps — endpoints not on EDR, OT networks not monitored, shadow IT
- Encrypted traffic without TLS inspection
- Living-off-the-land binaries (LOLBins) that look like normal admin activity
- Legacy systems that can't run modern telemetry agents
- Detection rules that haven't been reviewed in 18 months and don't cover current TTPs

### MTTD in the incident report

CompTIA Objective 4.2 specifies what goes in incident response reporting. MTTD lives in the **Metrics and KPIs** section of the report and feeds the **Executive Summary**. The full report structure:

| Section | Contents |
|---|---|
| **Executive Summary** | Who, what, when, where, why, how — in two paragraphs the CFO can read |
| **Timeline** | T_compromise → T_detect → T_contained → T_remediated, with MTTD/MTTR/MTTRem called out |
| **Scope and Impact** | Hosts affected, data exposed, business processes disrupted |
| **Root Cause Analysis** | The actual failure — patch missing, MFA bypass, phished credential |
| **Evidence** | Chain of custody, artifact hashes, where the forensic images live |
| **Metrics and KPIs** | MTTD, MTTR, MTTRem, alert volume, false-positive rate |
| **Lessons Learned** | What detection gap let this dwell; what's changing |
| **Recommendations** | Specific controls, tuning, budget asks |
| **Stakeholder Communications** | Customer notice, regulatory ([[GDPR]] 72hr, [[CIRCIA]]), law enforcement, PR/media |

### Stakeholder context — who cares about MTTD and why

- **CISO / executives:** trending MTTD quarter-over-quarter is board material. Down is good, up is a budget conversation
- **IR team lead:** uses MTTD to argue for detection engineering vs. response tooling spend
- **Legal:** MTTD drives the regulatory clock. [[GDPR]] requires breach notification within 72 hours of *awareness*. A long MTTD means the legal clock never started — once T_detect lands, the 72-hour timer begins
- **PR / customer communications:** "We detected the intrusion within X hours" is a defensible story. "The attacker was in our environment for 6 months" is a press release nobody wants to write
- **Law enforcement / FBI:** when they're the ones telling you about your own incident (third-party notification), your MTTD just became "however long until they called" — and that's the worst version of the metric

> **CompTIA exam trap:** Regulatory reporting timelines start at **awareness/discovery**, not at compromise. A 200-day MTTD doesn't mean you violated GDPR's 72-hour rule retroactively — but it does mean you were blind for 200 days, which regulators will absolutely ask about during the investigation. Don't conflate MTTD with notification compliance.

## SOC reality

- **What the metric actually looks like on the dashboard:** a rolling 90-day MTTD chart split by incident severity. Sev-1 MTTD is usually decent (those alerts get worked fast). Sev-3 MTTD is where the dwell time hides — low-severity alerts that turn out to be the first stage of a real intrusion three weeks later
- **What the L1 analyst does:** nothing directly with MTTD. The L1 works the queue. MTTD is calculated by the SOC manager after the post-incident review, when the timeline gets reconstructed
- **What the CISO asks in the IR debrief:** "When did this actually start? When did we see it? Why didn't we see it sooner? What would we need to see it next time?" The first three questions are MTTD. The fourth is the recommendations section
- **What never to promise leadership:** that MTTD will go down next quarter. It might — but a single sophisticated incident with a 90-day dwell discovered in the measurement window will tank the average. *MTTD is volatile; explain the shape, not just the number*
- **The handoff:** L1 detects and triages → L2 confirms and declares incident (this is T_detect) → IR team contains → forensics backfills T_compromise → SOC manager closes the loop and updates the metric. Every handoff is a clock-stop opportunity if the ticketing system isn't tight

*The hard lesson: a SOC with great alerting and bad triage has the same MTTD as a SOC with no tools at all. The alert that nobody opens didn't happen.*

## Related concepts

[[MTTR]] · [[MTTRem]] · [[Incident Response Lifecycle]] · [[SIEM]] · [[EDR]] · [[Alert Fatigue]] · [[Threat Hunting]] · [[MITRE ATT&CK]] · [[Root Cause Analysis]] · [[Executive Summary]] · [[Chain of Custody]] · [[GDPR]] · [[CIRCIA]] · [[Lessons Learned]] · [[Detection Engineering]] · [[Dwell Time]]

*Source: VIRGIL knowledge base — 2026-05-11*