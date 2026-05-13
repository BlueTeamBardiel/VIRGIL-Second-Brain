# Sample Incident Report Template

## What it is

In **Assassin's Creed**, every memory Desmond relives ends up logged in the Animus database — target name, location, date, method, witnesses, escape route, anomalies in the genetic memory. Altaïr's bureau leaders don't just want "the Templar is dead." They want the dossier: who, where, when, what tipped them off, what went sideways, what the next assassin needs to know before walking into the same district. The Brotherhood survives because every memory becomes institutional knowledge.

That's exactly what an incident report does — it turns one team's 3am war-room scramble into a document the entire organization can learn from, audit against, and defend in court six months later.

Technically: an **incident report** is the structured artifact produced during and after the Detection & Analysis and Post-Incident phases of the NIST SP 800-61 lifecycle. It captures scope, impact, timeline, evidence chain, root cause, response actions, and recommendations in a format that satisfies internal stakeholders, regulators, legal counsel, and (sometimes) law enforcement. CompTIA tests whether you can recognize the standard sections and understand why each one exists.

## Why it matters

The report is the deliverable. Everything else — the EDR alert, the containment call, the 4am pizza, the forensic image — is invisible to the executives who decide your budget next quarter. They read the report. Auditors read the report. Lawyers read the report. The next analyst who sees the same TTPs reads the report.

For the exam: **Objective 4.2** explicitly calls out incident response reporting and communication. CompTIA will hand you a scenario and ask which section a piece of information belongs in, or which stakeholder gets which version. They will test whether you know the difference between an executive summary and a root cause analysis, and they will absolutely test the regulatory reporting timelines.

For the job: a sloppy report is how you lose the courtroom argument, miss the 72-hour GDPR window, or get the same intrusion two months later because nobody wrote down what the attacker actually did.

## Key facts

### The standard sections of an incident report

| Section | What goes in it | Audience |
|---|---|---|
| **Executive summary** | 1 paragraph. Plain English. Scope, impact, status, business risk. No jargon. | C-suite, board |
| **Incident declaration** | When IR was formally activated, by whom, severity classification (High/Med/Low) | Internal, audit |
| **Scope** | Systems, users, data, business units affected. Quantified. | All |
| **Impact** | Confidentiality / integrity / availability damage. Financial, operational, reputational. | Exec, legal, PR |
| **Timeline** | Chronological event log with timestamps (UTC, always) | IR, forensics, legal |
| **Who, what, when, where, why, how** | The 5W1H narrative | All |
| **Evidence** | Artifacts collected, chain of custody references, hashes | Forensics, legal, law enforcement |
| **Root cause analysis (RCA)** | The actual technical failure that allowed the incident | Engineering, leadership |
| **Response actions** | What containment, eradication, recovery steps were taken | IR, audit |
| **Metrics & KPIs** | MTTD, MTTR, MTTRem, alert volume context | Leadership, SOC manager |
| **Lessons learned** | What worked, what didn't, what changes are coming | All |
| **Recommendations** | Concrete remediation, control gaps, budget asks | Leadership |
| **Communications log** | Who was notified, when, by whom — internal, customer, regulator, media, law enforcement | Legal, PR, compliance |

### The 5W1H — the narrative backbone

Every incident report needs the **Who, What, When, Where, Why, How**. CompTIA loves this phrasing because it's framework-agnostic.

- **Who** — threat actor (named if attribution exists), affected users, affected systems, internal responders
- **What** — what happened in plain English ("attacker exfiltrated 14,000 customer records via SQL injection on the legacy billing portal")
- **When** — first observed activity, detection time, containment time, eradication time, recovery time (all UTC)
- **Where** — which network segments, which assets, which geographies, which data classifications
- **Why** — motive if known (financial, espionage, hacktivism, opportunistic)
- **How** — the technical kill chain: initial access → execution → persistence → lateral movement → exfil

### The timeline — non-negotiable accuracy

The timeline is the section that lawyers and regulators read first. Every entry needs:

- **UTC timestamp** (local time is how you lose a court case across time zones)
- **Source** (which log, which analyst, which tool)
- **Event** (what happened — observed, not inferred)
- **Actor** (system or human who took the action)

Separate **observed events** from **response actions**. The attacker's beacon at 02:14 UTC is an observed event. The SOC isolating the host at 02:47 UTC is a response action. Mixing them is how you lose narrative clarity and credibility.

### Metrics and KPIs — what CompTIA tests

| Metric | Formula | What "good" looks like |
|---|---|---|
| **MTTD** (Mean Time to Detect) | Time from initial compromise to detection | Industry median ~200+ days; mature SOC <24h |
| **MTTR** (Mean Time to Respond) | Time from detection to containment | Hours, not days |
| **MTTRem** (Mean Time to Remediate) | Time from detection to full eradication & recovery | Depends on scope; days to weeks |
| **Alert volume** | Total alerts / triaged / escalated / true positive | Track the funnel; a 0.1% true-positive rate means your tuning is broken |

> **CompTIA exam trap:** MTTR is ambiguous in the wild — some shops use it for "respond," others for "repair," others for "resolve." CompTIA uses **Mean Time to Respond**. **MTTRem** is the separate metric for full remediation. If the question asks about getting the environment back to clean and patched, that's MTTRem, not MTTR.

### Root cause analysis vs. lessons learned

These are different sections and CompTIA will test the distinction.

- **Root cause** is the **technical answer to "why did this happen?"** — an unpatched CVE, a misconfigured S3 bucket, a phished credential with no MFA on the VPN. One sentence, factual, blame-free.
- **Lessons learned** is the **organizational answer to "what do we change?"** — patch cadence, S3 baseline hardening, MFA enforcement on all external services, tabletop exercise for this specific scenario.

RCA feeds engineering. Lessons learned feed the program.

### Stakeholder identification — who gets which version

| Stakeholder | What they get | What they care about |
|---|---|---|
| **Executive leadership** | Executive summary, impact, recommendations | Business risk, dollars, when can we say it's over |
| **Legal** | Full report, evidence chain, communications log | Liability, privilege, litigation hold |
| **PR / Communications** | Approved external messaging only | Reputation, narrative control |
| **Customers** | Sanitized notification, what was exposed, what to do | What happened to *my* data |
| **Regulators** | Formal report per jurisdiction (GDPR, HIPAA, PCI, CIRCIA) | Timeline compliance, breach scope |
| **Law enforcement** | Evidence, timeline, attribution data if available | Criminal investigation, attribution |
| **Media** | PR-approved statement only, never raw report | The story |
| **SOC / engineering** | Full technical detail, RCA, IoCs | Don't let this happen again |

> **CompTIA exam trap:** Never let media, customers, or unaffected employees see the raw incident report. **Customer communication** and **public relations** are downstream products of the report, not copies of it. The exam will give you a scenario where someone leaks the technical report to a journalist — the correct answer is "PR controls external messaging, IR controls the report."

### Regulatory reporting timelines

| Regulation | Window | Trigger |
|---|---|---|
| **GDPR** (EU) | 72 hours | Personal data breach with risk to data subjects |
| **CIRCIA** (US critical infrastructure) | 72 hours for incidents, 24 hours for ransom payments | Covered cyber incidents |
| **HIPAA** | 60 days | Breach of unsecured PHI |
| **PCI DSS** | Immediately to acquiring bank/card brands | Cardholder data compromise |
| **SEC** (US public companies) | 4 business days | Material cybersecurity incidents |

> **CompTIA exam trap:** The 72-hour GDPR clock starts when the organization **becomes aware** of the breach, not when it actually occurred. If your forensics says compromise happened 40 days ago but you detected it Tuesday morning, the clock started Tuesday morning.

### Tracking numbers — the boring detail that matters

Every incident gets a unique ID (INC-2026-0047 or similar). Every piece of evidence gets a chain-of-custody tag. Every external communication gets a log entry. This is auditability. Without tracking IDs, you cannot prove the report describes the same incident as the evidence box in the legal hold locker.

*This is process maturity, not bureaucracy. Bureaucracy is paperwork that doesn't change outcomes. Tracking IDs are the difference between winning and losing the audit.*

## SOC reality

- **The first draft of the report starts during the incident, not after.** You take notes in a shared doc while you're triaging. If you wait until Monday, you've lost the timeline and you're reconstructing from Slack scrollback.
- **The executive summary is the only section most leadership will read.** Write it last, after you actually know what happened. One paragraph. No acronyms. State the business impact in dollars or customers, not in CVE numbers.
- **Legal will redact your report.** Get used to it. Run anything that mentions specific employees, customer names, or unverified attribution past counsel before it goes to a distribution list.
- **Never write "the attacker did X" if your evidence only supports "we observed X."** Inference belongs in the RCA section. The timeline contains only observed events. Mixing them up is how you get torn apart in deposition.
- **The handoff:** L1 documents observations and timestamps. L2/IR lead owns scope, containment narrative, and evidence chain. IR manager owns the executive summary, RCA, and lessons learned. Legal owns external communications. PR owns media. **You do not freelance external comms.**

## Related concepts

[[Incident Response Lifecycle]] · [[Chain of Custody]] · [[Root Cause Analysis]] · [[MTTD MTTR MTTRem]] · [[Executive Summary]] · [[Stakeholder Communication]] · [[Regulatory Reporting]] · [[GDPR Breach Notification]] · [[CIRCIA]] · [[Lessons Learned]] · [[Evidence Preservation]] · [[Forensic Timeline]] · [[Customer Communication]] · [[Public Relations]] · [[Law Enforcement Coordination]]

*Source: VIRGIL knowledge base — 2026-05-11*