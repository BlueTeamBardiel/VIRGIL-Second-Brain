# MOU — Memorandum of Understanding

## What it is

In **Grand Theft Auto V**, the Trevor-Michael-Franklin heist crew doesn't sign a contract before knocking over the Union Depository. There's no notarized document, no breach-of-contract clause, no SLA on getaway driver punctuality. There's a verbal agreement on the rooftop: *here's the plan, here's the split, here's who's doing what.* When Trevor decides to go loud instead of stealth, nobody can sue him. The "agreement" only works because everybody shows up wanting the same outcome.

That's exactly what an **MOU** does — it's a handshake on paper. Two parties write down what they intend to do together, but nobody's going to court if it falls apart.

Technical definition: a **Memorandum of Understanding** is a non-binding written agreement between two or more parties documenting mutual intent, roles, and expectations. It's not a contract. It does not create legally enforceable obligations the way an [[SLA]] or a master services agreement does. It says *"we plan to cooperate like this"* — not *"we will, or you sue us."*

For CySA+ purposes, MOUs show up in two places: as a **stakeholder communication artifact** when coordinating with partners, vendors, or internal business units, and — critically — as an **inhibitor to remediation** when the MOU restricts what you can patch, scan, or take offline.

## Why it matters

Objective 4.1 calls out MOU explicitly under inhibitors to remediation, alongside [[MOA]], [[SLA]], organizational governance, business process interruption, [[Legacy systems]], and proprietary systems. CompTIA isn't testing whether you know what the letters stand for. They're testing whether you understand why the vuln management team can't just push a patch on Tuesday at 2pm because *an MOU with a partner says they get 30-day advance notice of any change to the shared system.*

Real-world stakes: you find a critical RCE on a server that's part of a research partnership with a university, or a shared payment gateway with a third-party processor, or an integration point with a regulator's data feed. The CVSS is 9.8. Your scanner is screaming. And there's an MOU sitting in legal's SharePoint that says you can't touch the box without coordinated maintenance windows and written approval from the counterparty.

The MOU isn't the enemy. It's the reality the analyst writes around in their action plan.

## Key facts

### MOU vs. the other paperwork

CompTIA loves to test the distinctions. Memorize the table.

| Document | Binding? | Purpose | Enforcement |
|---|---|---|---|
| **MOU** (Memorandum of Understanding) | No | Documents mutual intent and roles | Goodwill only |
| **MOA** (Memorandum of Agreement) | Sometimes | More formal than MOU, may include obligations | Varies by jurisdiction and language |
| **SLA** (Service Level Agreement) | Yes | Defines measurable service levels (uptime, response time) | Financial penalties, contract termination |
| **MSA** (Master Services Agreement) | Yes | Umbrella contract governing the overall relationship | Full contract law |
| **NDA** (Non-Disclosure Agreement) | Yes | Restricts information sharing | Civil litigation, injunctions |
| **ISA** (Interconnection Security Agreement) | Yes | Governs technical connection between two networks | Both parties must enforce |
| **BPA** (Business Partnership Agreement) | Yes | Defines partnership terms, profit split, exit | Full contract law |

The exam trap is mostly **MOU vs. SLA**. MOU = intent, non-binding. SLA = measurable, enforceable, penalties on the table.

### What's actually in an MOU

A typical MOU covers:

- **Parties** — who's signing, on behalf of which org
- **Purpose** — what the cooperation is for (data sharing, joint research, shared infrastructure)
- **Roles and responsibilities** — who does what, who owns which system
- **Resources committed** — staff time, infrastructure, data feeds
- **Duration and termination** — when it starts, when it ends, how to walk away
- **Points of contact** — the named human you call when things break
- **Confidentiality expectations** — often references a separate [[NDA]]
- **Change management language** — how either party gives notice before modifying the shared environment

That last bullet is where vuln management gets pinned.

### MOU as an inhibitor to remediation

The CompTIA objective lists inhibitors to remediation. MOU is one. Here's how it actually inhibits:

- **Change notification clauses** — the MOU says you give the partner 14 or 30 days' notice before patching a shared system. Your emergency patch window just became a month.
- **Coordinated maintenance windows** — the partner gets to dictate when the system goes down. Their finance close is the second Tuesday. Your patch waits until the third.
- **Pre-approval requirements** — any configuration change needs written sign-off from the counterparty's security team. Their security team is two people and one of them is on PTO.
- **Scope restrictions on scanning** — the MOU may prohibit active vulnerability scanning of the shared segment without coordination. Your [[Vulnerability scanning|credentialed scan]] just became a phone call.
- **Data handling restrictions** — you can't pull a forensic image of a shared database during IR without invoking the MOU's incident clause, which may require notifying the partner first.

The analyst's job isn't to break the MOU. It's to document that the MOU exists, log it as the blocker in the vuln management ticket, and escalate the risk acceptance up the chain.

### MOU in the vuln management report

When you write the monthly vuln management report (Objective 4.1 territory — metrics, KPIs, trends, top 10, [[Affected hosts]]), MOUs show up as **inhibitors** in the remediation tracking section:

> CVE-2026-XXXX (CVSS 9.1) — affected host: prod-shared-db-01. Remediation blocked: MOU with [Partner] requires 30-day change notice. Compensating control deployed: WAF rule + IDS signature. Target patch date: 2026-06-15.

That's the language. State the blocker, state the [[Compensating controls|compensating control]], state the new date. Leadership reads that and knows the [[Risk score]] isn't going down this cycle and why.

### MOU vs. legacy and proprietary systems as inhibitors

These three travel together on the exam:

- **MOU** — external agreement blocks the change
- **[[Legacy systems]]** — vendor doesn't ship patches anymore, or the patch breaks the app
- **Proprietary systems** — closed-source, vendor controls the patch cycle, you can't recompile

All three result in the same operational answer: **document, deploy compensating controls, accept residual risk, get the risk owner to sign.** Different reasons, same remediation playbook.

### CompTIA exam traps

> **CompTIA exam trap:** MOU vs. SLA. An MOU is **non-binding** — it documents intent. An SLA is **binding and measurable** — uptime percentages, response times, financial penalties. If the question asks which document defines "99.9% availability with $10K credit per hour of downtime," it's an SLA, not an MOU. If it asks which document describes "the parties intend to share threat intelligence quarterly," it's an MOU.

> **CompTIA exam trap:** MOU as an *inhibitor to remediation*. CompTIA will give you a scenario with a critical vuln on a partner-connected system and ask why the patch is delayed. The answer is the MOU's notification or coordination clause — not "the system is legacy" and not "the vendor won't help." Read the scenario for the contractual artifact, not the technical one.

> **CompTIA exam trap:** MOU vs. ISA. An [[ISA]] (Interconnection Security Agreement) is the **technical** counterpart — it covers the specific security controls on the network connection (encryption, authentication, monitoring). An MOU covers the **business intent**. Big organizations have both: MOU at the top, ISA underneath for the technical layer.

> **CompTIA exam trap:** MOU is not automatically a regulatory artifact. It's not a [[Compliance reports|compliance document]] by default. GDPR, HIPAA, PCI DSS care about [[BAAs]], DPAs, and contractual safeguards — not MOUs. Don't pick "MOU" as the answer to "which document satisfies HIPAA business associate requirements." That's a BAA.

### Where MOU touches the vuln management lifecycle

- **Stakeholder identification** — the MOU names the points of contact. That's your call list when something on the shared system lights up.
- **Action plans** — every vuln on a shared system gets an MOU-aware action plan. Patch date, notification date, compensating control, sign-off.
- **Prioritization** — a CVSS 9.8 on an MOU-bound system may sit longer than a CVSS 7.5 on a system you own outright. [[Risk score]] adjusts for the inhibitor.
- **Trends** — if MOU-blocked patches are climbing quarter over quarter, that's a leadership conversation. Either renegotiate the MOU language or accept that some vulns will age past SLO.
- **Recurrence** — if the same vuln class keeps surfacing on the MOU-bound system because the partner's [[Configuration management]] is loose, that goes in the report too.

## SOC reality

- **The 3am alert on the partner-connected box.** Endpoint telemetry says lateral movement attempt against `shared-integration-prod`. L1's first move isn't *contain the host* — it's *check the runbook for the MOU partner notification clause.* You may be contractually required to notify the counterparty within hours of detecting an incident on the shared system. The IR call and the legal call happen in parallel.
- **The CISO's first three questions.** "What's the scope, what's the impact, who do we have to call externally?" That third question is the MOU question. Have the partner contact list pinned in the IR channel before the incident, not during.
- **Never tell leadership the patch is "in progress" when it's actually blocked by an MOU clause.** Say it plainly: *"MOU requires 14-day notice. Patch scheduled for the 22nd. Compensating control in place."* Vague status reports are how a 30-day delay turns into a 90-day audit finding. *Honesty about a blocker is faster than optimism about a fix.*
- **The L1 → L2 → legal handoff.** Anything involving a contractual artifact escalates out of the SOC and into legal/risk. The analyst's job is to flag the MOU exists, attach it to the ticket, and not negotiate it themselves. *You are not the lawyer. Tag the lawyer.*
- **Tabletop the MOU scenarios.** The IR tabletop exercise should include "the affected system is governed by an MOU with [Partner]." Half the time the playbook doesn't cover it and the room figures out the gap in twenty minutes of awkward silence. Better there than at 3am.

## Related concepts

[[SLA]] · [[MOA]] · [[ISA]] · [[NDA]] · [[BPA]] · [[Vulnerability scanning]] · [[Compensating controls]] · [[Legacy systems]] · [[Risk score]] · [[CVSS]] · [[Affected hosts]] · [[Compliance reports]] · [[Stakeholder identification]] · [[Action plans]] · [[Inhibitors to remediation]] · [[Configuration management]] · [[Patching]] · [[Organizational governance]] · [[Business process interruption]]

*Source: VIRGIL knowledge base — 2026-05-11*