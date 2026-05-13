# Reporting

## What it is

In **Escape from Tarkov**, you finish a raid and the game drops you into the post-raid screen: status (survived, killed in action, MIA, run-through), extraction point used, time in raid, kills with timestamps, every piece of loot in your gamma container, XP breakdown by skill, and the full kill feed showing who shot whom with what round through what armor. If you died, you can watch the replay and see the angle the PMC held, the audio cue you missed, the moment you peeked the window one second too long. Then you take that data and decide what to bring next raid — different armor, different route, different extract.

That's exactly what a forensic incident report is — the post-raid screen for a security incident, written so leadership, legal, and the next analyst can read what happened, why, what it cost, and what changes next.

Technical definition: a **forensic incident report** is the formal written deliverable of the incident response process. It documents the scope, timeline, evidence, root cause, impact, and remediation actions of a security incident in a manner that is **factual, defensible, and reproducible**. It is the artifact that survives the incident — the playbook update, the legal exhibit, the audit evidence, the lessons-learned input.

## Why it matters

The incident ends. The report doesn't. Six months later, when regulators ask what happened, when the insurer asks why they should pay the claim, when legal asks who had access to the compromised mailbox between 02:14 and 04:47 UTC, when the new SOC manager asks why this control was implemented — the report is the only thing that answers. If it wasn't written down, it didn't happen.

CySA+ Objective **3.2** lists reporting as part of incident response activities, and Objective **4.2** covers incident response reporting and communication explicitly. CompTIA tests this because in the real world, the analyst who can triage but can't write loses career velocity fast. The L2 who writes the report that closes the audit finding gets promoted. The L2 who triaged brilliantly but left no paper trail gets asked to "support the IR lead" on the next one.

Reports are also the legal record. If the incident becomes litigation, every claim in your report becomes a deposition question. *"You wrote on page 4 that the attacker exfiltrated 14GB. How do you know it was 14GB and not 140GB?"* If the answer isn't in the evidence section, the report is worthless.

## Key facts

### The mandatory components

CompTIA expects you to know what goes in the report. Memorize this list:

| Section | What it answers |
|---|---|
| **Executive summary** | What happened, in plain English, in 150 words. The CEO reads this. |
| **Scope** | Which systems, accounts, data, business units were involved |
| **Timeline** | Every event with UTC timestamps — first compromise, detection, containment, eradication, recovery |
| **Detection and analysis** | How we found it, what IoCs fired, what tools surfaced what |
| **Evidence summary** | Every artifact collected — disk images, memory dumps, log exports, network captures — with hashes |
| **Chain of custody** | Who touched what evidence, when, why, and where it's stored |
| **Root cause analysis** | The actual technical failure — not "phishing" but "unpatched Exchange CVE-2023-XXXXX exposed to internet, no WAF, no EDR on the server" |
| **Impact assessment** | Records affected, downtime, financial cost, regulatory exposure, reputational |
| **Containment, eradication, recovery actions** | What we did, in order, with timestamps |
| **Compensating controls** | What we put in place to cover the gap while permanent fix is pending |
| **Remediation recommendations** | What needs to change permanently — with owners and due dates |
| **Lessons learned** | What the IR process itself got wrong; what to fix in the playbook |

### The phases mapped to the report

The CompTIA / NIST SP 800-61 incident response lifecycle maps directly into report sections:

- **Preparation** — referenced in lessons learned ("playbook X did/didn't work")
- **Detection and analysis** — its own section; covers IoCs, log analysis, data analysis, validation
- **Containment, eradication, recovery** — its own section; covers isolation, re-imaging, compensating controls
- **Post-incident activity** — the report itself, plus lessons learned and remediation tracking

### Evidence and chain of custody — the legal spine

Every piece of evidence cited in the report needs three things:

- **Acquisition method documented** — write blocker used, command run, tool version. *"FTK Imager 4.7.1, write-blocked via Tableau T8u, full E01 acquisition"* — not *"copied the disk."*
- **Integrity validation** — cryptographic hash (SHA-256 minimum) of the evidence at acquisition, compared against hash at every handoff. If the hash changes, the evidence is tainted.
- **Chain of custody log** — every transfer, with timestamp, from-person, to-person, reason, and storage location. One missing link breaks the entire chain in court.

If the evidence is under **legal hold**, the report notes it explicitly. Legal hold suspends normal retention/destruction schedules — the relevant data sits frozen until counsel releases it. Reporting that an asset was re-imaged when it was under legal hold is how the CISO ends up in a deposition.

### Scope and impact — the two questions leadership actually asks

Every executive who reads the report asks two questions: **how big is it (scope)** and **how bad is it (impact)**. Everything else is detail.

- **Scope** is technical — endpoints, accounts, mailboxes, databases, network segments touched. Concrete. Countable.
- **Impact** is business — records breached, dollars lost, hours of downtime, customers notified, regulatory clocks started (GDPR 72h, HIPAA 60d, PCI per the contract, CIRCIA per the rule).

Conflating these is a rookie move. *"Scope: 14 endpoints, 3 service accounts, 1 file share. Impact: 47,000 PII records potentially accessed, GDPR Article 33 notification filed at T+62h, estimated $2.1M in notification and credit monitoring costs."* That's how you write it.

### Data and log analysis — show your work

The analysis section is where the report earns its credibility. It's not enough to write *"the attacker moved laterally to FILESRV-03."* You have to show the SIEM query, the timestamp, the source IP, the authentication event ID, the process tree. Reviewable. Reproducible. If a second analyst can't follow your logs to your conclusion, the conclusion isn't defensible.

### Remediation and compensating controls — different things

CompTIA tests this distinction.

- **Remediation** is the permanent fix. Patch the CVE. Rotate the credentials. Re-image the host. Redesign the segmentation.
- **Compensating controls** are temporary measures that reduce risk while the permanent fix is pending. Can't patch the legacy SCADA box until the maintenance window in 6 weeks? Compensating control: isolate it on its own VLAN with explicit firewall rules and enhanced monitoring. The report names both — what we did right now, and what we still owe the business.

### CompTIA exam traps

> **CompTIA exam trap:** Reporting is *post-incident activity* in the NIST four-phase lifecycle, but evidence collection that *supports* the report happens during *detection and analysis* and *containment*. CompTIA will ask when chain of custody starts — the answer is **at the moment of evidence acquisition**, not when the report is written.

> **CompTIA exam trap:** Re-imaging a host destroys volatile and disk evidence. If the system is under **legal hold** or part of an active investigation, you image first, *then* re-image. The wrong order is unrecoverable. CompTIA likes to bury this in a scenario question where the analyst "quickly restored service" — that's the wrong answer when evidence preservation is in scope.

> **CompTIA exam trap:** "Root cause" is not the IoC. The IoC is `powershell.exe -enc <base64>` on the endpoint. The root cause is *"phishing email bypassed mail filter because DMARC was monitor-only, user clicked link because no security awareness training in 18 months, payload executed because EDR exception was overly broad."* CompTIA wants the systemic answer.

> **CompTIA exam trap:** Validating data integrity in a forensic context means **cryptographic hashing** (MD5/SHA-1/SHA-256) of evidence at acquisition and at every transfer. It does not mean "checking that the logs look right." If the question asks how you prove the disk image wasn't tampered with — the answer is *hash comparison*.

### Audience-specific framing

One incident, multiple reports — or one report with multiple sections written for different readers:

- **Executive / board** — executive summary, business impact, dollars, regulatory status, action items they need to approve
- **Legal / compliance** — chain of custody, evidence inventory, notification timelines, legal hold status
- **Technical / engineering** — root cause, log analysis, IoCs, remediation steps with owners
- **Regulators / external** — only what the law requires, reviewed by counsel before submission, no speculation

Never speculate in writing. *"The attacker may have been a nation-state"* in an executive summary becomes a headline. If you don't have evidence, don't write it.

## SOC reality

- The IR lead writes the first draft 48 hours after recovery, while the timeline is still fresh. Wait a week and half the detail is gone. *Write while the smell of smoke is still in the room.*
- The CISO will ask three questions on the first read: *scope, impact, are we done?* If the executive summary doesn't answer those in the first paragraph, you rewrite it.
- Every claim in the report needs an evidence reference. *"Attacker accessed mailbox at 03:14 UTC (Evidence Item 7, M365 UAL export, hash: a3f4...).”* No floating assertions.
- Legal reads the report before anyone outside the company sees a sentence of it. Build that into your timeline. The report you wrote at T+72h is not the report that ships at T+96h — counsel will edit.
- The lessons-learned section is the only part the SOC actually re-reads. Make it actionable. "Detection gap: no alerting on impossible-travel events for service accounts. Owner: Detection Engineering. Due: 30 days." Not *"improve monitoring."*
- Never write *"the incident is fully contained"* in the report until you have monitoring in place to confirm it stays contained. *"Confirmed contained as of [date], with continuous monitoring controls X, Y, Z."* That's the defensible phrasing.

## Related concepts

[[Chain of Custody]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Root Cause Analysis]] · [[Incident Response Lifecycle]] · [[Lessons Learned]] · [[Compensating Controls]] · [[Data Integrity Validation]] · [[Scope and Impact Assessment]] · [[Re-imaging]] · [[Communication and Reporting]] · [[Regulatory Notification Timelines]]

*Source: VIRGIL knowledge base — 2026-05-11*