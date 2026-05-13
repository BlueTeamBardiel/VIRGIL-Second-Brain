# Incident Communications (NIST SP 800-61 Aligned)

## What it is

In **Skyrim**, when a dragon lands on the watchtower outside Whiterun, Irileth doesn't just charge in swinging. She runs the comms. Jarl Balgruuf gets briefed first — the executive. The guards get the operational order — containment. A courier rides to the other holds — regulatory notification. And eventually some bard in the Bannered Mare turns the whole thing into a song — that's public relations, and you'd better hope the bard got the facts right because that song is the one people remember.

That's exactly what incident communications does — it's the structured information flow running alongside the technical response, and it determines whether leadership, customers, regulators, and law enforcement come out of the incident trusting you or firing you.

Technically: **Incident Communications** is the set of NIST SP 800-61–aligned practices for stakeholder identification, internal coordination, external notification (legal, regulatory, customer, media, law enforcement), and post-incident reporting. It runs across all four lifecycle phases and is tested on CS0-003 Objective 4.2 as a discipline equal in weight to the technical response.

## Why it matters

Communication failures hurt more than technical failures. You can rebuild a domain controller in eight hours. You cannot rebuild the trust of a board that learned about your breach from a journalist.

Every major breach post-mortem of the last decade has the same shape: technical containment was fine, communication discipline was a fire. Equifax, Uber, SolarWinds — the ones that hurt worst on reputation weren't the ones with the worst malware. They were the ones where the comms drifted off-plan: delayed disclosure, contradictory statements, executives blindsided by reporters, regulators learning from press releases.

Domain 4.0 is 17% of the exam and Objective 4.2 owns the communication piece directly. CompTIA tests the stakeholder list, the regulatory clocks, and who gets told first.

## Key facts

### The stakeholder map

| Stakeholder | What they need | When they get it |
|---|---|---|
| **Executive leadership** | Scope, impact, business risk, decision points | Immediately on incident declaration |
| **Legal counsel** | Evidence handling, regulatory exposure, contract obligations | Before any external communication |
| **PR / Comms** | Approved talking points, confirmed vs speculation | Before media contact, never reactively |
| **Customers** | Data affected, action needed, remediation offered | Per regulatory clock or contract SLA, whichever is tighter |
| **Regulators** | Formal breach notification per applicable law | GDPR 72h, HIPAA 60d, CIRCIA 72h / 24h for ransom |
| **Law enforcement** | Evidence preservation, threat actor indicators | When criminal activity suspected — coordinate with legal first |
| **Insurance / Cyber carrier** | Incident notification per policy | Often 24–72h or coverage is at risk |
| **Affected third parties** | Their exposure via your incident | Per MOU/MSA terms |

Order matters. Legal before media. Executives before customers. Internal alignment before any external word goes out. The fastest way to make an incident worse is to have your CFO say one thing to Reuters while your CISO says another to a regulator the same afternoon.

### Incident declaration

Declaration is the moment somebody with authority says **"this is now an incident, not an alert."** That declaration starts clocks — regulatory, SLA, insurance, evidence preservation — and activates the communication plan.

It must capture, at minimum:
- **Who** declared it (named person, role, time)
- **What** is suspected (ransomware, data breach, BEC, DoS)
- **When** detection occurred and when declaration occurred (different timestamps)
- **Where** — affected systems, networks, data classes
- **Scope** — known affected assets, unknown blast radius

Declaration is not a guess about root cause. It's recognition that a defined threshold has been crossed. Get the time right. Forensic timelines will be built backward from this moment.

### The executive summary

The exec summary is the one-page document that lets a non-technical leader make a decision:

- **What happened** (plain English, no acronyms)
- **What's the impact** (revenue, data, customers, regulatory)
- **What we're doing** (containment status, ETA to recovery)
- **What we need from you** (decisions, approvals, external engagement)
- **What's next** (next update time, next decision point)

If your executive summary is longer than a page, you've written a technical report and labeled it wrong.

### The full IR report

Built post-incident. Contains:

- **Executive summary** (the one-pager above)
- **Timeline** — every meaningful event with timestamps, sourced to evidence
- **Scope** — systems, accounts, data, networks confirmed affected
- **Impact** — operational, financial, reputational, regulatory
- **Root cause analysis** — underlying technical and process failures, not just the immediate vector
- **Evidence** — chain of custody summary, what's preserved, where
- **Recommendations** — control improvements, remediation, policy changes
- **Lessons learned** — what the organization will do differently
- **Metrics** — MTTD, MTTR, MTTRem, alert volume, dwell time

### Metrics and KPIs

| Metric | Formula | What "good" looks like |
|---|---|---|
| **MTTD** (Mean Time to Detect) | Compromise → detection | Mature SOCs <24h, top-tier <1h |
| **MTTR** (Mean Time to Respond) | Detection → containment | Minutes to hours for known playbooks |
| **MTTRem** (Mean Time to Remediate) | Detection → full remediation incl. root cause | Days to weeks |
| **Alert volume** | Alerts per analyst per shift | Watch the trend. Spike = tuning issue or campaign |
| **Dwell time** | Time attacker was in before detection | Industry median ~10–20 days; lower is better |

> **CompTIA exam trap:** MTTR is ambiguous in the wild — some shops mean "respond," some "repair," some "resolve." On the exam, MTTR = Mean Time to Respond (detection → containment), MTTRem = Mean Time to Remediate (detection → full fix). They are not synonyms.

### Regulatory reporting timelines

| Regulation | Trigger | Clock |
|---|---|---|
| **GDPR** | Personal data breach with risk to data subjects | **72 hours** to supervisory authority |
| **HIPAA Breach Notification** | PHI breach affecting 500+ individuals | **60 days** to HHS, individuals, and media |
| **CIRCIA** | Covered cyber incident at covered entity | **72 hours**; ransom payment **24 hours** |
| **PCI DSS** | Cardholder data breach | Per acquirer / card brand — often immediate |
| **State breach laws** | PII breach affecting state residents | Varies (most 30–90 days) |
| **SEC cyber disclosure** | Material cyber incident at public company | **4 business days** after materiality determined (Form 8-K Item 1.05) |

> **CompTIA exam trap:** GDPR's 72-hour clock starts when you **become aware** of the breach, not when it occurred and not when you finish investigating. CompTIA will write a scenario where the breach happened weeks ago but was just discovered — the 72 hours starts on discovery.

### Customer communication

Tell customers:
- What data of theirs was affected (specific — "email addresses and hashed passwords" beats "some account information")
- What you've done about it
- What they need to do (rotate passwords, watch credit, enable MFA)
- What you're offering (credit monitoring, password reset, support line)

Never speculate. Never say "no evidence of misuse" if you haven't actually checked — that phrase has destroyed careers because it gets re-quoted as "we said we'd checked."

### Media and public relations

Two rules:
1. Only the designated spokesperson talks to media. Everyone else routes inquiries to PR.
2. The first public statement sets the narrative. Get it right or get it controlled.

The first statement does not need root cause. It needs **acknowledgment, action, accountability, next update.** "We're aware, we've engaged response, we're investigating, we'll update by [time]." Speculation in the first statement is how organizations get sued.

### Law enforcement coordination

Coordinate through legal counsel. Engage when there's evidence of criminal activity (ransomware, extortion, nation-state, insider theft). Understand:
- Law enforcement may ask you to delay public disclosure — your regulatory clocks may not pause for this
- Evidence preservation must support potential prosecution (chain of custody is non-negotiable)
- Information sharing is generally one-way until charges are filed

> **CompTIA exam trap:** Law enforcement involvement does **not** override regulatory notification timelines unless the regulation explicitly allows law enforcement deferral. GDPR 72h doesn't pause because the FBI asked you to stay quiet. Legal counsel decides.

### Lessons learned and root cause

Lessons learned is a meeting, a document, and a feedback loop. It happens within two weeks of incident closure while memory is fresh. Root cause goes deeper than the immediate vector — phishing email is the *vector*; the root cause is "no DMARC enforcement, no user reporting button, no email sandbox." Fix root cause or the next incident has the same shape.

## SOC reality

- The IR call at 3am is half technical, half communication. While the L2 is killing C2 beacons, somebody — usually the IR lead — is on a second bridge with legal and the CISO drafting the customer notification timeline.
- The first question the CISO asks is never "did you contain it?" It's **"what's the scope, what's the impact, is evidence preserved?"** Have those three answers ready within an hour.
- Never tell leadership "we've contained it" until you've validated containment with telemetry — no new beacons, no new lateral movement, no new persistence. A premature containment claim that gets walked back in the morning is a career event.
- The communication plan is built in **Preparation phase**, not during the incident. If you're identifying stakeholders at 3am, you've already lost time. The contact tree, the spokesperson, the legal escalation — all of it lives in the playbook.
- L1 acknowledges. L2 triages and escalates. IR lead declares and starts the comms tree. CISO owns external communication. CEO owns the board. Know your lane and don't jump it.

*Communication failures outlive technical failures. The malware gets cleaned. The press release gets quoted forever.*

## Related concepts

[[Incident Response Lifecycle (NIST SP 800-61)]] · [[Root Cause Analysis]] · [[Chain of Custody]] · [[Evidence Acquisition]] · [[Lessons Learned]] · [[MTTD]] · [[MTTR]] · [[Regulatory Compliance — GDPR, HIPAA, PCI DSS]] · [[CIRCIA Reporting Requirements]] · [[SEC Cyber Disclosure Rule]] · [[Executive Summary]] · [[Stakeholder Identification]] · [[Business Impact Analysis]] · [[Incident Declaration]]

*Source: VIRGIL knowledge base — 2026-05-11*