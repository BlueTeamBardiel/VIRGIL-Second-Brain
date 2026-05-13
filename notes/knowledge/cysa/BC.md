# BC — Business Continuity

## What it is

In **Fortnite**, the storm closes and the named POI you were looting just got swallowed. Tilted is gone, your team's loadout cache is sitting under purple damage, and the circle is now centered on a flat field with no cover. You don't quit the match. You rotate. You pre-built a tower on the high ground last circle because you knew this could happen, you've got mats banked, and your squad already called the fallback before the storm even started moving. The fight continues from a worse position, with degraded resources, but you are still in the game.

That's exactly what **Business Continuity** does — it's the plan that keeps the business operating during and after a disruption, even when primary systems, sites, or staff are unavailable.

Technical definition: **Business Continuity (BC)** is the strategic and procedural capability of an organization to maintain delivery of products and services at acceptable predefined levels during and following a disruptive incident. In CS0-003 terms, BC lives in the **Preparation** phase of the incident management lifecycle and is invoked during **Containment, Eradication, and Recovery**. BC is *not* Disaster Recovery. DR is the IT subset — restoring systems, data, and infrastructure. BC is the parent — keeping the business itself running. Payroll still runs. Customers still get answered. Orders still ship. Maybe degraded, maybe manual, but running.

## Why it matters

Ransomware doesn't ask if your BC plan is current. When Conti, LockBit, or whoever the flavor of the quarter is encrypts your file servers, the question leadership asks at hour two is not "do we have backups" — it's **"can we operate?"** If the answer is no, you are bleeding revenue, contractual SLAs, customer trust, and regulatory standing simultaneously. Healthcare orgs hit by ransomware without a BC plan have diverted ambulances. Manufacturers without BC have idled production lines for weeks. The 2021 Colonial Pipeline incident was a BC failure dressed up as a ransomware story — the OT systems were fine, but they couldn't bill, so they shut the pipe.

For the CS0-003 exam, BC shows up in **Objective 3.3** as part of preparation and post-incident artifacts. CompTIA expects you to distinguish BC from DR, know where BC plans get exercised (tabletops), and understand BC as an input to [[Incident Response Plan]] and a topic of [[Lessons Learned]] after the fact.

Career relevance: as a SOC analyst you don't *write* the BC plan, but you absolutely execute against it during an incident. The IR lead will ask "what's the BC posture for this business unit" and if you can't find that document in 90 seconds, the wrong call gets made.

## Key facts

### BC vs DR — the trap CompTIA loves

| Capability | Scope | Owner | Question it answers |
|---|---|---|---|
| **Business Continuity (BC)** | Whole business — people, process, facilities, vendors, IT | Business / executive | "Can we still operate?" |
| **Disaster Recovery (DR)** | IT systems, data, infrastructure | IT / SOC / infra | "Can we restore the systems?" |

DR is a subset of BC. You can have working DR (systems are back) and still fail BC (call center has no staff, no facility, no phones). You can also have working BC (orders processed by hand on paper) while DR is still in flight.

> **CompTIA exam trap:** if the question describes restoring servers, failing over to a hot site, or rehydrating data from backups — that's **DR**. If the question describes the business operating during the outage — alternate workspaces, manual procedures, vendor contracts, call trees — that's **BC**. The word "continuity" means *continuing operations*, not *recovering systems*.

### Core BC artifacts

- **Business Impact Analysis (BIA)** — identifies critical business functions, their dependencies, and the financial/operational cost of downtime. Drives everything else.
- **Recovery Time Objective (RTO)** — maximum tolerable downtime per function. "Payroll must be back in 8 hours."
- **Recovery Point Objective (RPO)** — maximum tolerable data loss. "We can lose at most 1 hour of transactions."
- **Maximum Tolerable Downtime (MTD)** — hard ceiling. Past this, the business doesn't survive.
- **BC Plan (BCP)** — the document. Roles, contacts, fallback procedures, alternate sites, vendor agreements.
- **Crisis communications plan** — who talks to customers, regulators, press, employees. Almost always a sub-plan of BC.

### The continuity strategies (ranked by cost and speed)

| Strategy | Description | Failover time | Cost |
|---|---|---|---|
| **Hot site** | Fully operational duplicate, live data replication | Minutes | $$$$ |
| **Warm site** | Hardware ready, data not current, requires restore | Hours to a day | $$$ |
| **Cold site** | Empty facility with power/network, bring your own everything | Days to weeks | $$ |
| **Cloud / multi-region** | Active-active or active-passive in another region | Seconds to minutes | Variable |
| **Reciprocal agreement** | Partner org loans capacity | Variable, contractually fragile | $ |

### BC's place in the incident management lifecycle

Mapping to NIST SP 800-61 / CompTIA's four phases:

1. **Preparation** — BC plan written, BIA done, RTO/RPO defined, [[Tabletop Exercises]] run, [[Playbooks]] reference the BC plan, staff trained on fallback procedures, vendor contracts signed.
2. **Detection and Analysis** — incident classified. Severity determines whether BC is invoked. Not every incident triggers BC; a phishing click on one user doesn't, ransomware across the file servers does.
3. **Containment, Eradication, and Recovery** — BC is *active*. Alternate sites, manual procedures, customer comms, regulatory notifications all happen in parallel with the technical eradication work the SOC is doing.
4. **Post-incident Activity** — [[Root Cause Analysis]] and [[Lessons Learned]] feed BC plan updates. Forensic analysis output informs whether BC assumptions held.

### Tabletop exercises — where BC gets stress-tested before it matters

A **tabletop** is a discussion-based exercise. The facilitator presents a scenario ("ransomware just encrypted the ERP system, primary datacenter is offline, it's the last business day of the quarter") and the participants — IR team, business unit leads, legal, comms, executives — walk through their response verbally. No systems are touched. The goal is to find the gaps in the plan, the assumptions that don't hold, the contact list with three dead numbers on it.

Compare:

- **Tabletop** — discussion only, low cost, finds plan gaps
- **Walkthrough** — physically walk the procedures, no production impact
- **Simulation** — partial execution against test systems
- **Parallel test** — failover runs alongside production
- **Full interruption** — actually cut over to BC site. Highest risk, highest fidelity.

> **CompTIA exam trap:** the exam will describe a scenario where "the team discussed the response in a conference room" and ask what type of exercise it was. Answer: **tabletop**. Not simulation, not drill. Discussion-based equals tabletop.

### Training and playbooks

BC only works if the people invoking it know it exists and where to find it. Training requirements typically include:

- IR team trained on the BC plan annually
- Business unit owners trained on their specific continuity procedures
- Executives trained on crisis communications and decision authority
- New-hire onboarding includes BC awareness
- [[Playbooks]] for specific incident types (ransomware, datacenter outage, supply chain compromise) explicitly reference BC invocation criteria

### Post-incident — closing the loop

After the incident is contained and recovered, the BC plan gets graded. The **Post-incident Activity** phase produces:

- **Forensic analysis report** — what happened, technically, with evidence (chain of custody preserved by tools like FTK, Autopsy, Volatility)
- **Root Cause Analysis (RCA)** — *why* it happened. Not "the user clicked the link" — that's a symptom. The root cause is more like "no application allowlisting, no macro blocking via GPO, no EDR isolation policy."
- **Lessons learned report** — what worked, what didn't, what changes
- **BC plan updates** — every assumption that broke gets fixed. Every contact that was wrong gets corrected. Every RTO that wasn't met gets re-baselined or re-resourced.

*I learned this the hard way: a BC plan with a 2-year-old vendor contact list is worse than no plan, because it gives leadership false confidence right up to the moment they dial a disconnected number.*

## SOC reality

- At 3am during a ransomware event, the IR lead's first three questions are **scope, impact, BC status.** If you can't tell them which business units are down and whether BC has been invoked, you're not contributing.
- The SOC doesn't *own* BC, but the SOC's containment decisions directly affect it. Isolating a domain controller might stop the spread *and* take down authentication for the manufacturing floor. That's a BC trade-off and it has to be made with the business on the call, not by the L2 analyst alone.
- The CISO's question to the SOC during an incident is rarely "what's the malware family." It's "**what's still working and what isn't.**" That's a BC question dressed up in technical clothes.
- Never tell leadership "we're back" until BC criteria are met. Systems-up is not business-up. *The line is: "technical recovery complete, business operations validation in progress."*
- The handoff escalation during a BC-triggering incident: L1 detects → L2 confirms scope → IR lead engages → executive on-call paged → BC coordinator invokes plan → legal/comms/regulatory parallel tracks open. If any of those hops takes more than 15 minutes, your BC plan has a latency problem and that's a Lessons Learned item.

## Related concepts

[[Disaster Recovery]] · [[Incident Response Plan]] · [[Tabletop Exercises]] · [[Playbooks]] · [[Lessons Learned]] · [[Root Cause Analysis]] · [[Forensic Analysis]] · [[Business Impact Analysis]] · [[RTO and RPO]] · [[Crisis Communications]] · [[Preparation Phase]] · [[Post-incident Activity]]

*Source: VIRGIL knowledge base — 2026-05-11*