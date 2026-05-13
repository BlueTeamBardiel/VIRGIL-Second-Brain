# SLO — Service-level Objective

## What it is

In **Escape from Tarkov**, when you go down mid-raid and your insurance kicks in, Prapor's contract is brutally specific: items recovered will be returned in **24 to 48 hours of in-game time**, but only if no other player looted them off your corpse first. That window — 24 to 48 hours — is the **objective**. It's not a guarantee that your kitted M4 comes home; it's the measurable target Prapor is willing to commit to, with a clear failure mode (some Scav looted your rig) baked into the contract. That's exactly what a Service-level Objective does — it's a specific, measurable promise about how the security team will perform, with the understanding that misses are tracked and explained, not hidden.

Plain English: an **SLO is a number we promise to hit.** "We will patch critical vulnerabilities within 15 days." "We will triage P1 alerts within 30 minutes." "We will close confirmed incidents within 72 hours." The number is the SLO. Whether we hit the number is measured. Whether we explain when we miss is governance.

Technical CS0-003 definition: an **SLO** is the specific, measurable performance target inside a broader **Service-level Agreement (SLA)** that governs vulnerability response, incident handling, and patch deployment timelines. SLOs translate [[risk management]] policy into operational deadlines that the SOC, IR team, and patch management team are accountable for. In vulnerability management, SLOs are typically expressed as **"time to remediate by severity"** — e.g., Critical = 7 days, High = 30 days, Medium = 90 days, Low = 180 days.

## Why it matters

SLOs are the line between "we have a vulnerability management program" and "we have a spreadsheet of CVEs nobody is fixing." Without an SLO, a CVSS 9.8 sits in the backlog next to a CVSS 4.3 and the change board picks whichever is least disruptive. With an SLO, the CVSS 9.8 has a **deadline with a name attached** — and if it slips, someone owes the steering committee an explanation.

Exam relevance: **Objective 2.5** explicitly calls out "Policies, governance, and service-level objectives (SLOs)" as part of vulnerability response. CompTIA wants you to understand that SLOs are the **managerial control** that drives the **operational and technical work** of patching, mitigating, and accepting risk. They're also the metric your CISO reports to the board, and the metric auditors test against during compliance reviews (PCI DSS 6.3.3 requires critical patches within 30 days — that's an SLO codified by regulation).

Career-wise: every senior SOC role asks "what's your MTTR?" in the interview. MTTR is the measurement; the SLO is the target. Knowing the difference puts you ahead of the candidate who calls them the same thing.

## Key facts

### SLO vs SLA vs KPI vs MTTR

CompTIA loves to test these as a cluster. Don't mix them up.

| Term | What it is | Example |
|------|------------|---------|
| **SLA** | The contract / agreement. Includes penalties for missing. | "Vendor will respond to P1 tickets within 1 hour or pay credit." |
| **SLO** | The specific measurable target inside the SLA. | "P1 ticket response time: 60 minutes." |
| **SLI** (indicator) | The actual measured value. | "This month's P1 response time: 47 minutes." |
| **KPI** | A business-level performance metric, broader than SLO. | "Patch compliance rate across enterprise: 94%." |
| **MTTR** | Mean Time to Remediate / Respond — the historical average SLI for fix time. | "Critical CVE MTTR Q1: 11 days." |

**The relationship:** SLA contains SLOs. SLOs are measured by SLIs. SLIs aggregated over time become KPIs (like MTTR). Miss the SLO enough and you breach the SLA.

### Typical vulnerability response SLOs by severity

These numbers are the industry-common ones CompTIA expects you to recognize. Your shop may differ — but on the exam, these are the canonical targets:

| Severity | CVSS range | Patch SLO (internet-facing) | Patch SLO (internal) |
|----------|------------|------------------------------|----------------------|
| Critical | 9.0–10.0 | 7–15 days | 30 days |
| High | 7.0–8.9 | 30 days | 60 days |
| Medium | 4.0–6.9 | 60–90 days | 90 days |
| Low | 0.1–3.9 | 180 days | 180+ days or accept |

Note: **regulatory SLOs override internal SLOs**. PCI DSS says critical patches in 30 days. CISA Binding Operational Directive 22-01 says known-exploited CVEs in 14–21 days for federal agencies. The strictest deadline wins.

### What SLOs drive operationally

When the SLO clock starts ticking, the [[vulnerability management]] lifecycle has to deliver. The four risk treatment paths from objective 2.5 all live inside the SLO:

- **Mitigate** — apply the patch within the window. Default path. Requires a [[maintenance window]], change approval, sometimes a **rollback** plan if the patch breaks production.
- **Transfer** — push the risk to a third party (cyber insurance, contractual indemnity from the vendor). Doesn't make the CVE go away — the residual risk still owns you.
- **Avoid** — decommission the affected system or feature entirely. Drastic but final.
- **Accept** — formally document that the business is accepting the risk, signed by a risk owner with authority. Requires an **exception** filed against the SLO with an expiration date.

**Compensating controls** buy you time inside the SLO when you can't patch. The 90-day-old Server 2012 box that runs the warehouse ERP isn't getting patched this Tuesday — but a WAF in front of it, network segmentation, and EDR with aggressive blocking can satisfy auditors that the risk is contained while the exception runs.

### Control type mapping

CompTIA categorizes controls along two axes (objective 2.5). SLOs themselves are **managerial / preventative** — they prevent risk accumulation by enforcing deadlines. But hitting an SLO uses every control type:

| Control function | Example in SLO context |
|------------------|-----------------------|
| **Preventative** | Patching before exploit windows close |
| **Detective** | Vuln scanner finds the CVE, SIEM detects exploit attempts |
| **Corrective** | The patch itself; rollback procedure if it breaks |
| **Responsive** | IR playbook fires when SLO miss correlates with active exploitation |
| **Managerial** | The SLO policy document, exception process, risk register |
| **Operational** | Patch Tuesday cadence, change board, maintenance windows |
| **Technical** | WSUS, Tanium, Ansible, vulnerability scanner integration |

### Inhibitors to remediation (CompTIA tests this hard)

The SLO is the deadline. These are the reasons the deadline slips — and CompTIA expects you to name them by exam vocabulary:

- **MOU** (Memorandum of Understanding) — the partner agreement says you can't restart their system without 5 days notice.
- **SLA** (with the vendor) — the vendor SLA says they have 30 days to ship the patch, eating into yours.
- **Organizational governance** — change board only meets Thursdays.
- **Legacy systems** — Windows Server 2008 can't take the patch. Compensating control or accept.
- **Proprietary systems** — vendor won't allow third-party patching. SCADA / OT is the worst offender.
- **Business process interruption (BPI)** — patching the payment system during Black Friday is a fireable offense, even if the CVSS is 10.

Each inhibitor is a legitimate reason to file an **exception** against the SLO. Each exception needs an owner, an expiration date, and a compensating control. No exception is permanent. The phrase "we've been running with that exception for three years" is the smell of a program that has surrendered.

### CompTIA exam traps

> **CompTIA exam trap:** SLA vs SLO. The SLA is the **agreement / contract**. The SLO is the **measurable target inside it**. If the question asks "what is the specific metric we commit to?" — that's the SLO. If the question asks "what is the document governing the relationship?" — that's the SLA. They are not synonyms.

> **CompTIA exam trap:** MTTR is not an SLO. MTTR is the **measured historical average** (an SLI aggregated over time). The SLO is the **target** MTTR is being compared against. A team can have an SLO of "30 days" and an MTTR of "47 days" — that's a program in breach, not a definition problem.

> **CompTIA exam trap:** Accepting risk does not delete the SLO. An accepted risk requires a **documented exception** with an owner and an expiration. CompTIA will give you a scenario where someone says "we accepted the risk" with no paperwork — that's not acceptance, that's negligence.

> **CompTIA exam trap:** Compensating controls don't stop the SLO clock — they justify the exception. If a system can't be patched in 15 days, you don't get to claim the SLO was met. You met it with a compensating control documented under an exception. The distinction matters for auditors.

## SOC reality

- **The Monday-morning vuln review:** L2 analyst pulls the Tenable / Qualys / Rapid7 report, sorts by "days until SLO breach." Anything in the red zone gets escalated to the patch team or the risk register that morning. The ones already past breach get a name attached and a calendar invite to the change board.
- **The 3am call doesn't ask about SLOs.** When the exploit hits the unpatched box, the IR lead doesn't ask "was this within SLO?" — they ask "is it contained?" SLO accountability happens at the post-incident review, where the question "why was this 47 days old?" gets asked in front of the CISO.
- **What the CISO actually asks:** "What's our critical-vuln SLO compliance rate this quarter, and which business units are dragging us down?" The answer needs to be a single number with three names attached. If you don't have it, you're not running a program.
- **Never promise leadership a number you can't hit.** *I learned the hard way that committing to "all criticals in 7 days" sounds great in the boardroom and ruins your quarter when the OT team can't take downtime. The SLO must reflect what operations can actually deliver, not what the deck looks pretty saying.*
- **The handoff:** Vuln scanner → vuln management team (triage, severity, asset criticality) → patch management or IR (depending on whether it's known-exploited) → change board → ops team executes during maintenance window → scanner re-validates closure. Every step is timestamped. The timestamps are your SLO evidence.

## Related concepts

[[SLA]] · [[KPI]] · [[MTTR]] · [[MTTD]] · [[CVSS]] · [[Vulnerability management]] · [[Patch management]] · [[Compensating control]] · [[Risk acceptance]] · [[Exceptions]] · [[Maintenance windows]] · [[Change management]] · [[Inhibitors to remediation]] · [[Rollback]] · [[PCI DSS]] · [[CISA BOD 22-01]]

*Source: VIRGIL knowledge base — 2026-05-11*