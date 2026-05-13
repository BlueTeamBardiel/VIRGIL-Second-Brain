# BIA — Business Impact Analysis

## What it is

In **Far Cry 5**, when you start clearing Hope County, you don't just rush the nearest cult outpost. You look at the map and see what each region actually controls — the silos feeding the militia, the radio towers running propaganda, the airstrip that lets the Seed family move heavy. Hit the wrong outpost first and you take a region with no strategic value while the cult tightens its grip everywhere that matters. Pick the right one and you cripple their supply line for half the county. That triage of *what actually keeps the enemy operational* is exactly what a BIA does — except you're doing it for your own org, before the attacker forces the question for you.

**Plain English:** a Business Impact Analysis is the document that says "if THIS system goes down, here's what we lose, how fast, and what it costs." It ranks every business process by how much pain its absence causes.

**Technical definition (CS0-003):** A Business Impact Analysis is a preparation-phase artifact that identifies critical business functions, the IT systems and dependencies supporting them, the financial and operational impact of disruption over time, and the recovery objectives — **RTO** (Recovery Time Objective), **RPO** (Recovery Point Objective), **MTD** (Maximum Tolerable Downtime), and **WRT** (Work Recovery Time) — that drive incident response prioritization, [[Business Continuity]] planning, and [[Disaster Recovery]] design.

The BIA is the thing you write *before* the incident so that during the incident, "what do we save first?" isn't a question you answer with vibes at 3am.

## Why it matters

Without a BIA, every incident becomes a meeting. The CFO thinks payroll is critical. The marketing director thinks the public website is critical. The plant manager thinks the OT historian is critical. They're all partly right and all completely useless to the L2 analyst who has thirty minutes to decide which segment gets isolated first.

A signed-off BIA collapses that meeting into a document. When ransomware hits and you have one IR team and three encrypted file servers, the BIA tells you which one gets restored first — not because the loudest VP shouted, but because the org already decided, in calm weather, that order processing has a 4-hour MTD and the SharePoint research archive has 30 days.

**Exam relevance — Objective CS0-003 3.3:** the BIA lives in the **Preparation** phase of the incident response lifecycle. CompTIA will ask you to identify it as preparation, not response. They'll also test that BIA outputs (RTO/RPO) drive the **Business Continuity** and **Disaster Recovery** plans, and that lessons learned can feed BIA updates in the post-incident phase.

## Key facts

### What goes into a BIA

A real BIA — not the checkbox version — covers five things:

| Component | What it answers |
|---|---|
| **Critical process inventory** | What does the business actually *do* to make money or fulfill its mission? |
| **Dependency mapping** | Which IT systems, people, vendors, and facilities does each process need? |
| **Impact assessment** | What does an hour, a day, a week of outage cost? Financial, reputational, regulatory, safety. |
| **Recovery objectives** | RTO, RPO, MTD, WRT — the numbers the IR and DR teams have to hit. |
| **Prioritization tier** | Tier 1 (mission critical) through Tier 4 (deferrable). |

### The four numbers the BIA must produce

| Metric | Definition | The question it answers |
|---|---|---|
| **RTO** — Recovery Time Objective | Max time to restore the system after disruption | "How fast must it come back up?" |
| **RPO** — Recovery Point Objective | Max acceptable data loss measured in time | "How far back can our backups be?" |
| **MTD** — Maximum Tolerable Downtime | Longest the business can survive without it | "When does this outage kill us?" |
| **WRT** — Work Recovery Time | Time to revalidate, reconcile, return to normal ops after restore | "After the system is up, how long until it's actually usable?" |

**MTD = RTO + WRT.** CompTIA loves that equation. If RTO is 4 hours and WRT is 2 hours, MTD is 6 hours — and your DR plan has to fit inside it.

### How BIA connects to the rest of preparation

- **[[Incident Response Plan]]** — the IRP uses BIA tiers to define escalation thresholds and notification trees. A Tier 1 system getting hit is auto-Sev1.
- **[[Playbooks]]** — playbook prioritization (which system gets the analyst's attention first when two alerts fire at once) is BIA-driven.
- **[[Business Continuity]] (BC)** — the BC plan keeps the business *running* during disruption (alternate sites, manual processes, vendor failover). BIA tells BC what to keep running.
- **[[Disaster Recovery]] (DR)** — DR restores the technology. RTO/RPO from the BIA are the contractual obligations DR has to meet.
- **[[Tabletop Exercise]]** — you test the BIA assumptions by walking a scenario. "Ransomware hits ERP — what's our RTO? Can we actually hit it?" Almost always: no, not at first.
- **Training** — the L1 analyst needs to know which assets are Tier 1 without thinking. That's a BIA-driven asset criticality tag in the SIEM.

### Where BIA fails in the real world

The BIA document on the shared drive almost always lies. Common rot:

- **Asset drift** — the BIA was written in 2022, the SaaS migration finished in 2024, half the dependencies listed don't exist anymore.
- **Phantom criticality** — every business unit claims Tier 1 because nobody wants their thing labeled "deferrable." If everything is Tier 1, nothing is.
- **No dependency walk** — the BIA lists "Order Processing System: Tier 1" but never mentions it depends on an Active Directory domain controller in a closet nobody remembers.
- **Untested RTOs** — the BIA promises a 4-hour RTO for the ERP. The DR team has never actually restored it in under 18 hours.

*The BIA you didn't validate with a tabletop is fiction with a logo.*

### BIA in the post-incident phase

After the incident, the **lessons learned** review feeds back into the BIA:

- Did the incident reveal a critical dependency the BIA missed? Update the dependency map.
- Did we beat or miss the RTO? Either way, recalibrate.
- Did a "Tier 3" system turn out to be Tier 1 because it fed a regulatory reporting pipeline? Reclassify.
- Did a [[Root Cause Analysis]] reveal that a single vendor failure cascaded across three "independent" processes? The BIA's independence assumption was wrong.

This is the loop CompTIA wants you to see: **Preparation produces BIA → Detection/Containment uses BIA for triage → Post-incident updates BIA.** The artifact is alive, not a binder.

### CompTIA exam traps

> **CompTIA exam trap:** BIA is **preparation**, not detection or response. If the question describes activity happening *during* an incident — triage, containment, forensic acquisition — and asks where the BIA fits, the answer is still preparation. The BIA was *written* in preparation; it's *consulted* during response. CompTIA tests the artifact's home phase.

> **CompTIA exam trap:** RTO vs RPO. RTO is **time to recover** (forward-looking — how long until we're back). RPO is **acceptable data loss** (backward-looking — how much data can we lose). A 1-hour RPO means your backups must run at least hourly. A 1-hour RTO means you must restore service within an hour of the outage. Swapping them is the most-tested confusion in this objective.

> **CompTIA exam trap:** BIA vs Risk Assessment. A risk assessment asks "what threats exist and how likely are they?" A BIA asks "if the worst happens, how bad is it for the business?" BIA is **impact-focused and threat-agnostic** — it doesn't care whether the ERP went down from ransomware, a power outage, or a forklift through the rack. It cares what the outage costs.

> **CompTIA exam trap:** BIA does not produce the BC or DR plan — it produces the **inputs** (RTO, RPO, criticality tiers) that the BC and DR teams use to build their plans. If the question asks what the BIA delivers, the answer is the analysis and the objectives, not the recovery procedures themselves.

### How forensic analysis interacts with BIA

During [[Forensic Analysis]], the BIA tells you which evidence to preserve first. If you've got two encrypted hosts and one forensic acquisition team, the BIA-tagged Tier 1 asset gets the [[Write Blocker]] and the chain-of-custody form first. The Tier 3 asset waits. This is one of the few places the BIA directly shapes a technical workflow during the incident itself.

It also drives the eradication-versus-preservation tradeoff. A Tier 1 revenue-generating system might get a forensic snapshot and then an aggressive re-image to hit RTO. A Tier 4 system might sit untouched for days while the forensic team works carefully — because the MTD allows it.

## SOC reality

- **The alert at 3am:** ransomware on a file server. Your first SIEM query isn't "what's the malware family?" — it's "what's the asset tag, what tier is it, what depends on it?" If the BIA tagging is in the asset inventory, that query takes 30 seconds. If it's in a Word doc on someone's laptop, you're flying blind.
- **What the IR lead asks first:** "Tier? RTO? Who owns the business process?" If you can't answer in under a minute, the BIA failed before the incident started.
- **What the CISO asks at hour two:** "Are we going to miss MTD on anything?" That's a yes-or-no question and you need a real answer, because at MTD the conversation moves from technical to legal/regulatory/board-level.
- **Never promise leadership:** "We'll hit RTO." Until the restore completes and the business owner validates the data, RTO is a goal, not a fact. Say "we're on track" — not "we'll make it."
- **The handoff:** L1 confirms asset and tier from inventory → L2 pulls the BIA dependency map and identifies blast radius → IR lead drives containment priority by tier → BC/DR teams activate based on whether RTO is achievable → post-incident, the lessons learned writer updates the BIA. If any link in that chain doesn't know the BIA exists, the chain breaks.

## Related concepts

[[Incident Response Plan]] · [[Business Continuity]] · [[Disaster Recovery]] · [[Playbooks]] · [[Tabletop Exercise]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Forensic Analysis]] · [[RTO]] · [[RPO]] · [[MTD]] · [[Asset Inventory]] · [[Risk Assessment]]

*Source: VIRGIL knowledge base — 2026-05-11*