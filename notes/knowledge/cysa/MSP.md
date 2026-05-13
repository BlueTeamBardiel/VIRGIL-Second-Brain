# MSP — Managed Service Provider

## What it is

In **Tekken**, when Heihachi hires the Tekken Force, he doesn't train every soldier himself. He pays a paramilitary outfit to handle perimeter security at the Mishima Zaibatsu while he focuses on tournament politics and throwing his son off cliffs. The Force has its own command structure, its own SLAs with the Zaibatsu, and when something goes wrong — say, Jin breaches the compound — the Force responds first, but Heihachi is still the one whose tower gets leveled. That's exactly what an **MSP** does — you outsource the day-to-day security work, but the risk stays on your balance sheet.

A **Managed Service Provider** is a third-party vendor contracted to operate some portion of your IT or security stack — patching, monitoring, vulnerability scanning, endpoint management, sometimes the full SOC (in which case it's an MSSP, Managed Security Service Provider). The relationship is governed by an [[SLA]] for performance, an [[MOU]] for scope, and a contract that defines who eats the loss when something gets missed.

The CySA+ angle: MSPs show up in Domain 4.0 because **vulnerability management reporting crosses the customer-vendor boundary**, and that boundary is where remediation goes to die.

## Why it matters

Most mid-market companies don't run their own SOC. They pay an MSP. That means the CySA+ analyst at the customer site is reading reports written by someone else, arguing about SLA breach with someone else's account manager, and trying to get a critical vuln patched on a system the MSP technically owns the change window for. CompTIA objective **CS0-003 4.1** explicitly calls out MOU, SLA, organizational governance, and stakeholder communication as inhibitors to remediation — and the MSP relationship is where all four collide.

The real-world stakes: the 2021 Kaseya VSA incident hit roughly 1,500 downstream customers through a single MSP platform compromise. When the MSP gets popped, every tenant it manages is in scope. You inherit their security posture whether you audited it or not.

## Key facts

### MSP vs MSSP vs MDR

| Provider type | Scope | Typical deliverable |
|---|---|---|
| **MSP** | General IT — patching, backups, helpdesk, infrastructure | Uptime SLA, ticket resolution |
| **MSSP** | Security operations — SIEM monitoring, alert triage, vuln management | 24/7 monitoring, IR support |
| **MDR** (Managed Detection & Response) | Threat hunting + active response on endpoint | Containment actions, threat hunting reports |
| **Co-managed** | Shared duties — MSP does L1, customer SOC does L2/L3 | Hybrid, depends on contract |

CompTIA tends to use **MSP** as a catch-all even when the scenario describes MSSP work. Read the question for what's actually being managed.

### The governance documents

- **[[MOU]] (Memorandum of Understanding)** — non-binding scope agreement. Says *what* the relationship covers. Frequently the first thing missing or out of date when something breaks.
- **[[SLA]] (Service-Level Agreement)** — contractually binding. Defines performance commitments: response times, uptime, patch windows, remediation timelines. Breach has financial consequences.
- **SLO (Service-Level Objective)** — the internal target the MSP measures itself against, usually tighter than the SLA. SLA is the floor; SLO is the goal.
- **MSA (Master Service Agreement)** — the parent contract; individual SOWs (Statements of Work) hang off it.

> **CompTIA exam trap:** MOU vs SLA. The MOU describes the relationship; the SLA defines measurable performance. CompTIA will hand you a scenario where a vendor missed a remediation deadline and ask which document was violated — the answer is **SLA**, not MOU. MOU has no teeth.

### What MSPs do in vulnerability management

- Run authenticated scans against your environment (Nessus, Qualys, Rapid7)
- Deliver **compliance reports** mapped to PCI DSS, HIPAA, SOC 2
- Track [[KPIs]] — MTTD, MTTR, MTTRem, patch latency, scan coverage
- Maintain the **action plan** for [[critical vulnerabilities]] and [[zero-days]]
- Patch [[affected hosts]] on a defined cadence
- Handle [[configuration management]] drift

What they typically *don't* own:
- The risk decision on whether to patch a [[legacy system]]
- The change board approval for [[business process interruption]]
- Custody of [[proprietary systems]] the customer wrote in-house
- Acceptance of residual risk — that always stays with the customer

### Inhibitors to remediation in the MSP context

CompTIA objective 4.1 lists inhibitors explicitly. The MSP relationship amplifies most of them:

| Inhibitor | How the MSP relationship makes it worse |
|---|---|
| **MOU** | Scope ambiguity — "we didn't think that system was in your scope" |
| **SLA** | Hard deadlines clash with customer change-freeze windows |
| **Organizational governance** | Two change boards (yours + theirs) must align |
| **Business process interruption** | MSP wants patch window; customer's ops team says no |
| **[[Legacy systems]]** | MSP refuses liability on EOL hardware; vuln sits forever |
| **[[Proprietary systems]]** | MSP can't patch what they can't access; in-house code is your problem |
| **Degrading functionality** | Patch breaks a workflow; rollback negotiation begins |
| **Changing business requirements** | New acquisition adds 400 hosts; MSP scope hasn't caught up |

### Compensating controls

When the MSP can't patch — legacy system, vendor-locked appliance, proprietary line-of-business app — the play is **compensating controls**. Network segmentation, IDS rules tuned to the known exploit, WAF signatures, application allowlisting, increased monitoring on the affected hosts. The vuln isn't fixed; the blast radius is shrunk. Document it. The auditor will ask.

*A compensating control is a promise to watch the unpatched thing harder, not a fix. The CVSS score doesn't drop just because you wrote a SIEM rule.*

### Stakeholder identification and communication

Vulnerability reports from an MSP land in front of multiple audiences. The CySA+ analyst's job is making sure each one sees what they need:

- **Executives** — risk score trends, top 10 critical vulns, business impact in dollars
- **System owners** — affected hosts, patch availability, remediation steps
- **Compliance / GRC** — mapping to regulatory frameworks, audit evidence
- **IT operations** — patch deployment plans, change windows, rollback procedures
- **Legal** — anything touching PII, breach notification, contractual exposure

The MSP delivers a generic report. The internal analyst translates it for each stakeholder. That translation work is what CompTIA is testing in 4.1.

### Metrics and KPIs the MSP reports

| Metric | What it measures | "Good" looks like |
|---|---|---|
| **MTTD** | Time from compromise to detection | < 24h for critical assets |
| **MTTR** | Time from detection to response (containment) | < 4h for criticals |
| **MTTRem** | Time from detection to full remediation | varies; SLA-driven |
| **Patch latency** | Vuln publication → patch deployed | < 30d for critical, < 90d for high |
| **Scan coverage** | % of assets in authenticated scan scope | > 95% |
| **Recurrence rate** | Same vuln reappearing after "fix" | < 5% — high recurrence = bad config mgmt |
| **Risk score trend** | Aggregate org risk over time | flat or declining |

> **CompTIA exam trap:** **Recurrence** is its own metric. If the same CVE keeps showing up on the same host after patching, your config management is broken — the gold image is rebuilding the vulnerability back in, or someone's rolling back the patch. CompTIA tests this as a configuration management problem, not a patching problem.

### Prioritization in MSP reports

The MSP gives you a stack-ranked list. The risk score is usually CVSS-derived but adjusted for environmental factors (asset criticality, exposure, exploitability). The **top 10** framing is standard — it forces a tractable conversation. Anything ranked 11+ becomes "we'll get to it." That's a feature, not a bug, as long as the top 10 is actually the right 10.

*The top 10 is a focusing constraint. If everything is a P1, nothing is.*

## SOC reality

- The MSP's monthly vuln report is 400 pages. Nobody reads 400 pages. Your job is to surface the 5 things leadership needs to act on this week.
- When the MSP misses a critical-patch SLA, the conversation is never "are we breaking the contract" — it's "do we want to make our vendor angry while we still need them on the phone for the next incident." Diplomacy beats legalism until renewal time.
- The CISO's question is always **scope, impact, evidence**: which hosts, what data, what's preserved. Doesn't matter if it's your team or the MSP — the question is the same.
- Never promise leadership "the MSP has it handled" until you've seen the ticket, the change record, and the verification scan showing the vuln is gone. *MSP "remediated" status is a claim, not proof.*
- Escalation path: L1 (MSP analyst) → L2 (MSP escalation engineer) → MSP account manager → your internal IR lead → your CISO → legal. Every step adds latency. Pre-negotiate the path before the incident, not during.
- The day the MSP itself gets compromised (Kaseya, SolarWinds, ConnectWise), your environment is in scope automatically. Have a playbook for "what if our security vendor is the threat actor's delivery mechanism."

## Related concepts

[[SLA]] · [[MOU]] · [[Vulnerability management]] · [[Compensating controls]] · [[Legacy systems]] · [[Proprietary systems]] · [[KPIs]] · [[MTTD]] · [[MTTR]] · [[Critical vulnerabilities]] · [[Zero-days]] · [[Configuration management]] · [[Patching]] · [[Supply chain attack]] · [[Third-party risk management]] · [[Stakeholder communication]] · [[Compliance reports]]

*Source: VIRGIL knowledge base — 2026-05-11*