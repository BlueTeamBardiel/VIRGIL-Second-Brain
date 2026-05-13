# LOI — Letter of Intent

## What it is

In **Call of Duty: Modern Warfare**, before the squad breaches the building in *Clean House*, Captain Price tells the team exactly what's happening: we're going in, this floor first, weapons free on confirmed hostiles, we don't shoot the civilians, we exfil out the back. Nobody signs a contract. Nobody calls a lawyer. But every operator knows the plan, the rules of engagement, and what "mission accomplished" looks like before the door blows. That's a Letter of Intent — a non-binding statement that says *here's what we're going to do together, here's the shape of it, the paperwork follows.*

In plain English: an LOI is a written "we agree on the plan, contract pending." It's the handshake before the marriage. It's not legally binding for the work itself, but it usually has a few clauses that *are* binding — confidentiality, exclusivity, no-shop windows.

**Technical definition (CS0-003):** A **Letter of Intent (LOI)** is a preliminary, generally non-binding document that outlines the proposed terms of an agreement between two parties before a formal contract is executed. In incident response preparation, LOIs are used to **pre-stage relationships** with external partners — IR retainers, forensic firms, legal counsel, threat intel providers, cyber insurers, MSSPs — so that when an incident fires, the analyst isn't cold-calling vendors at 3am trying to negotiate rates while the threat actor is exfiltrating.

## Why it matters

Career-wise: most CySA+ candidates think "preparation phase" means writing playbooks and running tabletops. It also means the paperwork — the MOUs, NDAs, SLAs, and LOIs that make the playbook actually executable. The first time you watch an IR team get stuck for six hours because the forensic vendor's contract is still in legal review, you understand why preparation is 80% of incident response and the alert is the other 20%.

Stakes-wise: an LOI in the IR context is usually the **fastest way to get an external firm engaged** when a retainer doesn't already exist. Full contracts take weeks. LOIs take hours to days. During an active breach, that delta is the difference between containment Tuesday and disclosure Friday.

**Exam relevance:** CompTIA Objective **CS0-003 3.3** covers the preparation phase of the incident management life cycle. LOI is on the official acronym list — it shows up in the same conceptual bucket as **[[MOU]]**, **[[NDA]]**, **[[SLA]]**, and **[[MOA]]**, and CompTIA loves to test whether you can distinguish them.

## Key facts

### What an LOI actually contains

| Section | What it says | Binding? |
|---|---|---|
| Parties | Who's involved | N/A |
| Purpose / intent | What we plan to do together | No |
| Proposed scope | Shape of the engagement (IR support, forensic acquisition, etc.) | No |
| Proposed pricing | Rough rates, retainer fee, hourly post-retainer | No |
| Timeline | When we expect to formalize | No |
| **Confidentiality** | Nothing said during negotiation leaks | **Yes** |
| **Exclusivity / no-shop** | Won't shop the deal to competitors during window | **Yes** |
| **Expense reimbursement** | Who pays if the deal dies | **Yes** |
| Termination | How either party walks away | Sometimes |
| Governing law | Whose courts decide disputes | Yes |

The mixed binding/non-binding nature is the trap. **The work is not contractually obligated. The conduct during negotiation is.**

### LOI vs the other acronyms CompTIA tests in this cluster

| Document | Binding? | Purpose | Typical IR use |
|---|---|---|---|
| **LOI** (Letter of Intent) | Mostly **non-binding** | Signal intent to enter a future contract | Pre-staging IR firm engagement |
| **MOU** (Memorandum of Understanding) | Generally **non-binding** | Mutual understanding of cooperation between parties | Inter-agency info sharing, ISAC participation |
| **MOA** (Memorandum of Agreement) | Generally **binding** | Specific obligations between parties | Detailed cooperation terms |
| **NDA** (Non-Disclosure Agreement) | **Binding** | Protect confidential information | Vendor access to incident data |
| **SLA** (Service Level Agreement) | **Binding** | Performance commitments (uptime, response time) | MSSP detection/response times |
| **MSA** (Master Service Agreement) | **Binding** | Overarching terms for ongoing work | The contract the LOI eventually becomes |

Memorize the binding column. CompTIA stem language like "non-binding statement of intent to formalize a contract" is pointing at LOI. "Non-binding mutual understanding of cooperation" is pointing at MOU.

### Where LOIs fit in the preparation phase

The IR preparation phase isn't just **[[playbooks]]** and **[[tabletop exercises]]**. CompTIA Objective 3.3 explicitly lists preparation activities — the LOI sits in the **external relationship pre-staging** bucket alongside:

- **Retainer agreements** with IR firms (Mandiant, CrowdStrike Services, Unit 42, Kroll, etc.)
- **Forensic vendor agreements** for chain-of-custody-preserving evidence acquisition
- **Cyber insurance** policies and the breach hotline number they require you to call first
- **Legal counsel** retention — outside breach counsel, not just in-house
- **PR / crisis communications** firms for disclosure messaging
- **Law enforcement** liaison contacts (FBI field office, Secret Service for financial)
- **Regulatory** reporting templates (GDPR 72h, CIRCIA, state breach notification laws)

The LOI is the lightweight, fast-moving instrument when you need a relationship documented *now* and the lawyers can finalize the MSA later.

### When you use an LOI vs a full retainer

- **Use a retainer (MSA + SOW)** when you have budget, time, and know which firm you want for the long haul. This is the gold standard — pre-paid hours, guaranteed SLA response, known incident commander.
- **Use an LOI** when the incident is mid-flight and you didn't have a retainer, or when you're moving fast on a new vendor relationship and need the binding confidentiality and exclusivity terms locked in while the full contract gets drafted.
- **Use neither** when the vendor will quote and sign a one-shot SOW in a day — sometimes faster than fighting through an LOI.

### CompTIA exam traps

> **CompTIA exam trap:** LOI vs MOU. Both are typically non-binding. The distinction CompTIA tests: **LOI signals intent to enter a future contract** (forward-looking, "we will sign"), while **MOU documents an existing understanding of cooperation** (lateral, "we agree to work together"). LOI → contract is coming. MOU → cooperation without a contract.

> **CompTIA exam trap:** "Non-binding" is misleading. LOIs almost always have **binding clauses inside the non-binding shell** — confidentiality, exclusivity, expense reimbursement, governing law. If a stem says "fully non-binding document," that's wrong even for LOI. The correct framing is "generally non-binding with specific binding provisions."

> **CompTIA exam trap:** LOI is preparation, not response. If the question describes signing paperwork **during** containment or eradication, the answer isn't LOI — that's the **inhibitor to remediation** territory (organizational governance slowing the response). LOIs are pre-staged. The whole point.

### Inhibitors connection

CompTIA tests **inhibitors to remediation** in the same domain. The absence of pre-staged LOIs/retainers is itself an inhibitor — when the playbook says "engage forensic vendor" and the next step is "draft an LOI," you've just added 48 hours to your **[[MTTRem]]**. Pre-staging removes the inhibitor. That's the exam framing.

## Feynman anchor — the squad briefing before the breach

In a Call of Duty multiplayer match, the lobby phase isn't dead time. It's where you check loadouts, confirm the killstreak chain, agree on who's pushing B and who's holding A. Nobody signs anything. But everyone knows the plan. The match starts and the team moves like one organism because the intent was established before contact.

An LOI is the same beat at the enterprise scale. The IR firm, the forensic team, the breach counsel — they're your squad. The LOI is the lobby briefing. It says: when the bomb plants, here's who pushes, here's who plants smoke, here's who calls the rotate. The full contract is the post-match scoreboard — formalized, audited, signed. But the operational alignment happens *before* the match starts.

Now flip it. You're the IR lead. The SIEM lights up at 2:47am. Ransomware notes on twelve servers. You call the IR firm. They ask: *"Do we have a retainer? An LOI? Anything signed?"* You say no. They say: *"Our intake team will call you back in business hours to scope the engagement and route to legal."* You hang up and stare at the ceiling.

*The preparation phase isn't paperwork for paperwork's sake. It's the lobby briefing that lets the squad move at the speed of the threat.*

Anti-cheat systems work the same way — Easy Anti-Cheat and BattlEye don't get deployed at the moment a cheater joins the lobby. They're integrated months before, with vendor contracts and detection-share agreements signed long in advance. By the time the wallhacker connects, the response is automatic. **That's a pre-staged relationship doing the work the contract enabled.**

## SOC reality

- **L1 analysts rarely touch LOIs.** This is IR lead / CISO / legal territory. But you should know whether your org has retainers in place — when you escalate a confirmed incident, the first thing IR leadership asks is "who's our external firm and what's the contact?"
- **The 3am alert moment:** if your runbook says "engage external IR firm" and the next line isn't a phone number with a 24/7 hotline, somebody didn't do the preparation work. Flag it in the post-incident review.
- **What the CISO actually asks during a breach:** "Do we have a retainer? What's the response SLA? Who's our breach counsel?" If those answers don't exist in 30 seconds, the IR clock is already bleeding.
- **Never promise leadership** that "the IR firm is on it" until someone with signature authority has actually executed the LOI or SOW. Vendors don't bill against intent — they bill against signed paper.
- **Handoff point:** when an incident escalates past internal capability (deep forensics, nation-state TTPs, multi-jurisdiction legal exposure), the LOI/retainer is what unlocks the next-tier response. The L2 analyst's job is to surface that escalation cleanly. Legal and the CISO sign the paper.
- **Post-incident lessons learned** almost always contains a line about preparation paperwork. After every real incident, somebody asks: *"Why did it take six hours to get the forensic team imaging the SAN?"* The answer is usually contract velocity. LOIs fix that — or at least make the post-mortem less embarrassing.

## Related concepts

[[MOU]] · [[MOA]] · [[NDA]] · [[SLA]] · [[MSA]] · [[Incident Response Plan]] · [[Playbooks]] · [[Tabletop Exercise]] · [[Retainer Agreement]] · [[Inhibitors to Remediation]] · [[Business Continuity]] · [[Disaster Recovery]] · [[Lessons Learned]] · [[Chain of Custody]] · [[Forensic Analysis]] · [[Root Cause Analysis]] · [[MTTRem]] · [[Cyber Insurance]] · [[Breach Counsel]] · [[CIRCIA]] · [[GDPR Breach Notification]]

*Source: VIRGIL knowledge base — 2026-05-11*