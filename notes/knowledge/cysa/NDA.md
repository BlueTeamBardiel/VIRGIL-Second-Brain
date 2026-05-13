# NDA — Non-disclosure Agreement

## What it is

In **Sekiro**, when Lord Kuro gives you the Mortal Blade quest, he doesn't post a town crier. He pulls you into a private chamber, lowers his voice, and binds you by oath — *the Iron Code, but inverted toward him.* The Divine Heir's existence, the Dragon's Heritage, the immortality severing ritual — none of it leaves that room. Every shinobi in service to a lord operates under the same unwritten contract: what you see in the lord's quarters dies with you. Break it and you're not just dishonored; you're hunted.

That's exactly what an NDA does in incident response — it's the legal Iron Code binding everyone who touches a breach to silence outside the authorized circle.

**Non-disclosure Agreement (NDA):** a legally enforceable contract that prohibits signatories from disclosing specified confidential information to unauthorized third parties. In IR context, NDAs scope who can hear about the incident, what they can say, and what the penalties are for leaking — covering employees, contractors, IR retainers, forensic vendors, legal counsel, and sometimes the victim's customers.

## Why it matters

An incident is two parallel events: the technical breach and the information war about the breach. NDAs are how you control the second one. If your forensic vendor tweets "engaged on a fun ransomware case 🍿" before your CISO has briefed the board, you have a second incident on top of the first. If a contractor with cleared access to the war-room Slack DMs a journalist, the SEC, your competitor, or LinkedIn — you're now in regulatory and litigation territory before you've even contained the host.

The exam relevance is **Objective 3.3** — Preparation and Post-incident phases of the IR lifecycle. NDAs live in Preparation (you sign them *before* the incident, with everyone who might touch one) and they govern behavior through Detection, Containment, and Post-incident Activity. CompTIA tests NDA awareness as part of the broader [[stakeholder communication]] and [[legal hold]] discipline — not as a standalone document but as a control that determines who gets to speak.

Career-wise: the first time you join an IR retainer call as an L2 analyst, someone will ask if you've signed the engagement NDA. If you haven't, you don't get the briefing. *Signed paperwork is the price of admission to the room where the work happens.*

## Key facts

### Types of NDAs you'll see in IR

| Type | Who signs | What it covers |
|---|---|---|
| **Employee NDA** | Every employee at hire | All company confidential info — broad, ongoing, survives termination |
| **Contractor / vendor NDA** | Third-party IR firms, MSSPs, forensic vendors, pen testers | Engagement-specific; scoped to data they touch |
| **Mutual / bilateral NDA** | Two parties sharing info both ways | Common when sharing IoCs with peer orgs or ISACs |
| **Unilateral NDA** | One party discloses, other receives | Common when retaining outside counsel or forensic vendors |
| **Engagement-specific NDA** | Per-incident, layered on top of master agreement | Scopes confidentiality to the specific breach |

### What an IR NDA actually restricts

- **Existence of the incident** — sometimes you can't even confirm there *is* an investigation
- **Technical details** — IoCs, TTPs, affected systems, dwell time
- **Business impact** — financial loss estimates, customer counts, data volumes
- **Attribution** — naming the threat actor publicly before law enforcement or counsel clears it
- **Internal communications** — Slack channels, war-room notes, draft executive briefings
- **Post-incident reports** — root cause analysis, lessons learned, forensic findings
- **The other party's confidential info** — vendor methods, tools, proprietary signatures

### Where NDAs fit in the IR lifecycle

**Preparation phase** — this is where NDAs actually get signed. Master service agreements with your IR retainer firm, your forensic vendor, your outside breach counsel, your PR firm. The [[incident response plan]] should list every external party and confirm their NDAs are current. Sign these in peacetime. *You do not negotiate paperwork at 3am while the domain controller is on fire.*

**Detection and Analysis** — NDAs gate the war-room invite list. New L1 analyst rotated into the bridge? Confirm their employee NDA covers IR work. Cyber insurance carrier joins the call? They have one; outside counsel verifies before sharing artifacts.

**Containment, Eradication, Recovery** — NDAs constrain what gets said to system owners and business unit leads. "Your server is being isolated for an active investigation" is allowed; "ransomware actor X used credential Y stolen from user Z" is not, until cleared.

**Post-incident Activity** — the [[lessons learned]] meeting and [[root cause analysis]] document are highly sensitive. NDA terms determine who reads the full RCA versus the sanitized exec summary. [[Tabletop]] exercises that replay real incidents must scrub identifying details or be conducted under NDA.

### NDA + privilege — the combo that actually protects you

NDAs alone are contracts; breach them and you sue. **Attorney-client privilege** is stronger — it can keep documents out of discovery entirely. Mature IR programs structure forensic engagements so the forensic vendor is hired *by outside counsel*, not directly by the company. The NDA covers the vendor's behavior; the privilege (when properly maintained) protects the resulting work product from being subpoenaed.

This is the *Kekkai* layered defense — NDA is one ward; privilege is another. Stack them.

### Common NDA clauses to know

- **Definition of confidential information** — broad vs narrowly scoped
- **Permitted disclosures** — to law enforcement, regulators, under subpoena (with notice)
- **Duration** — 2 years, 5 years, perpetual for trade secrets
- **Return or destruction of materials** — post-engagement evidence handling
- **Carve-outs** — publicly known info, independently developed info, info already known to receiver
- **Remedies** — injunctive relief, liquidated damages, attorneys' fees

### CompTIA exam traps

> **CompTIA exam trap:** NDA vs MOU vs SLA. An NDA controls *confidentiality*. A [[Memorandum of Understanding|MOU]] documents *intent to cooperate* between parties (often non-binding). An [[SLA]] defines *performance metrics and consequences* (uptime, response time). CompTIA loves to give you a scenario — "the IR retainer firm must keep details quiet" — and offer MOU as a tempting wrong answer. Confidentiality = NDA.

> **CompTIA exam trap:** NDAs are part of **Preparation**, not Containment. Signing paperwork during an active incident is a sign your prep failed. If the exam asks where NDAs live in the lifecycle, the answer is Preparation — even though their *effects* govern every later phase.

> **CompTIA exam trap:** An NDA does not override regulatory disclosure obligations. GDPR's 72-hour breach notification, SEC 8-K filings, state breach notification laws, HIPAA breach rule — these are *legal mandates*. An NDA cannot contract around them. If a question pits "NDA confidentiality" against "GDPR notification," the regulation wins.

### NDA failure modes

- **Stale agreements** — vendor NDA signed in 2019, scope no longer covers cloud forensics work in 2026
- **Missing parties** — the new MSSP analyst onboarded last week without paperwork, now reading your war-room
- **Over-broad disclosure inside the org** — "confidential" Slack channel with 80 people in it, half don't need to know
- **Verbal leaks** — engineer brags at a conference about "this crazy ransomware case" — technically a breach
- **Social media** — LinkedIn updates that telegraph an active incident ("interesting week at $COMPANY 👀")
- **AI tooling** — analyst pastes incident details into a public LLM for analysis. The NDA was with the vendor, not OpenAI. *I have seen this kill an engagement.*

## SOC reality

- **The 3am war-room bridge** opens and the IR commander asks "who's on this call, and is everyone covered?" If you can't answer yes for your seat, you get dropped. Have your paperwork status known before you dial in.
- **Your L1 instinct to share IoCs** with the broader infosec community via Twitter/Mastodon/ISAC — pause. Engagement NDA likely restricts attribution and timing. Sanitized IoCs through your threat intel team's approved channel, not your personal account.
- **The CISO will ask** "who knows, and are they all bound?" before authorizing any external communication. Your job is to be able to produce that list — war-room attendees, log access grants, ticket viewers, the works.
- **Never tell the affected business unit lead** more than counsel has cleared. "We're investigating an issue on your systems" is fine. "We think it's APT29 and they've been in for 60 days" is a leak waiting to happen — the BU lead will tell their team, who will tell their friends.
- **Post-incident**, the sanitized [[lessons learned]] deck that goes to all-hands is different from the privileged RCA that goes to legal and the board. Know which document you're handed. Don't forward the privileged one. *That mistake ends careers.*

## Related concepts

[[Incident Response Plan]] · [[Preparation Phase]] · [[Lessons Learned]] · [[Root Cause Analysis]] · [[Tabletop Exercise]] · [[Stakeholder Communication]] · [[Legal Hold]] · [[Chain of Custody]] · [[MOU]] · [[SLA]] · [[Attorney-Client Privilege]] · [[Breach Notification]] · [[GDPR]] · [[Forensic Analysis]] · [[Post-incident Activity]]

*Source: VIRGIL knowledge base — 2026-05-11*