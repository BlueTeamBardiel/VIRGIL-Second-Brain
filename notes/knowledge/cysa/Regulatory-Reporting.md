# Regulatory Reporting

## What it is

In **Minecraft**, if you build a redstone contraption that accidentally wipes your friend's base on a public server, the server has rules. You have a window — usually before the next admin log review — to self-report in the ticket channel with coordinates, timestamp, and what happened. Self-report inside the window and you get a warning and a rollback. Stay quiet and get caught by the audit logs later? Ban, blacklist, your build gets griefed by the mods on the way out. The admins don't care that you're sorry. They care that you told them inside the window.

That's regulatory reporting. When you suffer a qualifying incident, the government and your sector regulators have written down — in actual law — how many hours you have to file the ticket. Miss the window and the fines start. Lie on the ticket and the fines compound.

**Technical definition:** Regulatory reporting is the legally-mandated disclosure of qualifying cyber incidents to government bodies, sector regulators, and in some cases law enforcement, within fixed timelines defined by statute or contract. It is distinct from voluntary information sharing (ISACs, threat intel feeds) and distinct from customer/public-relations communication. It is compliance work with criminal and civil penalties attached.

## Why it matters

The CISO doesn't lose their job over the breach. They lose it over the late filing. Equifax (2017), Uber (2016 — the cover-up cost the CSO a felony conviction), and every GDPR seven-figure fine since 2018 are case studies in the same lesson: **regulators punish silence harder than they punish the incident itself.**

For a CySA+ analyst, regulatory reporting is where the IR clock collides with legal counsel and the executive team. You're not the one filing the form, but you're the one whose timeline, scope, and evidence package determines whether the form is accurate, defensible, and on time. A bad timeline from the SOC becomes a perjured filing from the General Counsel.

**Exam relevance:** Objective **CS0-003 4.2** — incident response reporting and communication. CompTIA tests timeline numbers, who reports to whom, and the distinction between regulatory reporting, law enforcement notification, and customer communication. These are three different audiences with three different rules. Mix them up on the exam and you lose the question.

## Key facts

### The timelines that matter (memorize the numbers)

| Framework / Law | Jurisdiction | Trigger | Clock |
|---|---|---|---|
| **CIRCIA** | US — critical infrastructure | Substantial cyber incident | **72 hours** from reasonable belief |
| **CIRCIA** | US — critical infrastructure | Ransomware payment made | **24 hours** from payment |
| **GDPR Art. 33** | EU — any personal data | Personal data breach | **72 hours** to supervisory authority |
| **GDPR Art. 34** | EU — high risk to data subjects | Same | "Without undue delay" to data subjects |
| **HIPAA Breach Rule** | US — PHI | Breach > 500 individuals | **60 days** to HHS + media |
| **HIPAA Breach Rule** | US — PHI | Breach < 500 individuals | Annual log to HHS |
| **PCI DSS** | Card data (contractual, not law) | Suspected card data compromise | **Immediately** to acquirer / card brands |
| **SEC Cyber Rule (Item 1.05)** | US — public companies | Material cyber incident | **4 business days** after materiality determination |
| **NY DFS Part 500** | NY financial services | Cybersecurity event | **72 hours** |
| **State breach laws (50 states)** | US — PII | Varies by state | Varies — often "without unreasonable delay," some have hard caps |

**The 72-hour number is the one CompTIA loves.** GDPR, CIRCIA, NY DFS — all 72. Memorize 72 first, then learn the exceptions.

### CIRCIA — the one CySA+ candidates miss

**Cyber Incident Reporting for Critical Infrastructure Act of 2022.** Mandates reporting to **CISA** (Cybersecurity and Infrastructure Security Agency). Two clocks:

- **Substantial cyber incident → 72 hours** from when the entity *reasonably believes* the incident occurred. Not from confirmation. Reasonable belief is a lower bar.
- **Ransomware payment → 24 hours** from the payment, regardless of whether the underlying incident is "substantial."

The 24-hour ransomware clock exists because Congress wanted visibility into the ransom economy. You can be a tiny org that paid $40k in Bitcoin and you still owe CISA a filing in 24 hours.

CIRCIA applies to **covered entities in 16 critical infrastructure sectors** — energy, water, healthcare, financial, comms, etc. The implementing rule went through final rulemaking; check what's currently in force on the date of your filing, not the date of your study session.

### The four audiences (do not confuse them)

| Audience | What they want | Who drives it |
|---|---|---|
| **Regulators** (CISA, HHS, SEC, state AGs, EU DPAs) | Compliance filing, factual, narrow scope | Legal + IR |
| **Law enforcement** (FBI, Secret Service, local) | Evidence, chain of custody, IOCs, attribution help | IR + Legal |
| **Customers / data subjects** | Plain-language harm explanation, remediation steps | PR + Legal |
| **Media / public** | Executive summary, narrative control | PR + Executive |

A CySA+ analyst feeds the **timeline and evidence package** to all four. The wording changes; the underlying facts do not. *If your regulatory filing says one timeline and your press release says another, the plaintiffs' attorneys eat for a year.*

### What goes in a regulatory filing (the who/what/when/where/why)

CompTIA's IR reporting objective explicitly lists: **who, what, when, where, why, how, scope, impact, root cause, recommendations.** A regulatory filing is the same skeleton with legal counsel as the editor:

- **Who** — affected entity, who discovered it, who's responding. Not threat actor attribution — never attribute in a regulatory filing unless you're certain, and you're never certain.
- **What** — incident type (ransomware, data exfil, BEC, DDoS). Stay categorical.
- **When** — first detection time, estimated initial compromise time, time of report. **MTTD and dwell time matter here.**
- **Where** — affected systems, business units, geographic scope. Drives multi-jurisdiction filings.
- **Scope** — record count, data classes (PII, PHI, PCI, IP), business systems impacted.
- **Impact** — operational disruption, financial estimate (often "under investigation"), safety implications.
- **Recommendations / remediation** — what you've done, what's next. CISA wants this; SEC wants it for the materiality calculus.

### What you do NOT put in a regulatory filing

- Speculation on attribution
- Internal blame
- Settlement intentions
- Anything not yet verified by IR lead and legal counsel
- Privileged communications (attorney-client work product stays out)

*The regulatory filing is a sworn statement to the government. Treat every word like it'll be read aloud in a deposition, because it will be.*

### Metrics regulators ask about

| Metric | Definition | Why regulators care |
|---|---|---|
| **MTTD** (mean time to detect) | Initial compromise → detection | Dwell time = exposure window |
| **MTTR** (mean time to respond) | Detection → containment action | How fast you stopped the bleed |
| **MTTRem** (mean time to remediate) | Detection → full eradication & recovery | How long the door was open after you knew |

CompTIA distinguishes MTTR (respond) from MTTRem (remediate). Regulators sometimes use them interchangeably in plain-English questions — your job is to know which they mean. *A 4-hour MTTD with a 30-day MTTRem tells regulators you saw it fast and fixed it slow. Both numbers matter.*

### CompTIA exam traps

> **CompTIA exam trap — 72 hours is GDPR, not "all breaches."** US state breach laws are mostly "without unreasonable delay" with state-specific caps. If the question stem says "personal data of EU residents" → 72 hours. If it says "PHI affecting 600 patients" → 60 days HIPAA. Don't reflex to 72.

> **CompTIA exam trap — regulatory reporting ≠ law enforcement notification.** Reporting to CISA is regulatory. Calling the FBI is voluntary law-enforcement engagement. CIRCIA reports are explicitly *not* a substitute for FBI notification and vice versa. Some incidents trigger both, neither, or one — read the stem.

> **CompTIA exam trap — incident declaration starts the clock, not the SOC alert.** The legal clock typically runs from "reasonable belief" or "incident declaration," not from the first SIEM alert. Tuning out a noisy alert at 2am isn't an incident; the IR lead declaring at 9am is. Know who has declaration authority in your runbook — usually IR commander or CISO.

> **CompTIA exam trap — paying ransom triggers its own clock.** Under CIRCIA, ransomware *payment* is a separate 24-hour reporting trigger independent of whether the underlying incident was reportable. Pay quietly and you've created two violations.

### Inhibitors to timely reporting

The reasons orgs blow the window — CompTIA tests this under "inhibitors to remediation" but it applies here too:

- **Scope uncertainty** — "We don't know yet how many records." Regulators accept "scope under investigation" in the initial filing. Silence is not acceptable.
- **Legal review bottleneck** — General Counsel wants 72 hours to review a 72-hour filing. Build the filing in parallel with the investigation, not sequentially.
- **Multi-jurisdiction confusion** — A breach affecting US + EU + Canadian customers triggers GDPR, state laws, and PIPEDA simultaneously, with different clocks. Map your data footprint *before* the incident.
- **Executive denial** — "We're not sure it's material yet." The SEC's 4-business-day clock starts at materiality determination, which creates incentive to delay determination. The SEC noticed and is litigating.

## SOC reality

- The L1 analyst doesn't file the regulatory report. The L1 analyst's **timestamps** are what the report is built from. If your SIEM event time is wrong, your filing is wrong. Verify your time sources — NTP drift has cost organizations real money in regulatory disputes.
- At hour 1 of a declared incident, the IR lead asks the SOC: "Earliest evidence of compromise — what's the timestamp, what's the source log, what's the confidence?" That answer goes straight into the legal team's reporting-clock calculation.
- The CISO will ask twice: "Are we reportable?" and "What's our window?" Never answer "I think so." Answer "Legal is making that call — here's the evidence package and the earliest reasonable-belief timestamp." Reportability is a legal determination, not a SOC determination.
- Never tell leadership "we're outside the reporting window" as comfort. Some clocks start at *discovery*, not at *compromise* — discovering an 18-month-old breach today still starts a 72-hour clock today.
- The handoff is: **SOC → IR lead → Legal → Executive → Filing.** Public relations and customer communication are downstream of the regulatory filing, never upstream. *PR speaking before legal files is how the SEC gets a second look at your disclosures.*

## Related concepts

[[Incident Response Lifecycle]] · [[Incident Declaration]] · [[Stakeholder Identification]] · [[Executive Summary]] · [[Customer Communication]] · [[Law Enforcement Notification]] · [[Chain of Custody]] · [[MTTD]] · [[MTTR]] · [[MTTRem]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[CIRCIA]] · [[GDPR]] · [[HIPAA]] · [[PCI DSS]] · [[SEC Cyber Disclosure Rule]] · [[Inhibitors to Remediation]]

*Source: VIRGIL knowledge base — 2026-05-11*