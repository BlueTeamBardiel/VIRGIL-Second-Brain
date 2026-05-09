# Business Impact Analysis

## What it is

In *Fallout: New Vegas*, when you walk into the Lucky 38 and start managing the Strip, you eventually use the **Courier's Stash / faction reputation system** to weigh which power broker to back — the NCR, Caesar's Legion, Mr. House, or Yes Man. Every choice ripples: lose the NCR and you lose the Hoover Dam supply lines; lose Mr. House and the Strip's surveillance and securitron army go dark; lose Yes Man and you lose the option to seize independence. Before you commit, a smart Courier mentally maps **which functions die when which faction dies, how long until the Mojave starves without them, and which losses are tolerable versus catastrophic**. That mental map — that "if X collapses, here is what breaks, how fast, and how badly" — is exactly what a Business Impact Analysis is.

In plain English: a [[Business Impact Analysis]] (BIA) is the homework you do *before* disaster hits, where you list every business process, figure out which ones the company can't live without, calculate how long you can survive without them, and estimate the financial and operational damage if they go down.

**Technical definition:** A Business Impact Analysis is a structured assessment that identifies critical business functions, quantifies the impact of their disruption (financial, operational, regulatory, reputational), and produces the recovery metrics — [[RTO]], [[RPO]], [[MTTR]], [[MTBF]] — that drive [[disaster recovery]] planning, [[business continuity]] strategy, and [[risk management]] decisions. The BIA is foundational input to the [[Disaster Recovery Plan]] (DRP) and [[Business Continuity Plan]] (BCP).

## Why it matters

Without a BIA, you are guessing. You spend $2 million hardening a payroll system that runs once every two weeks, while the e-commerce platform that generates $50,000 an hour sits on a single unreplicated database. After the [[ransomware]] attack hits at 3 a.m., the CISO is in the boardroom being asked, "How long can we be down?" — and "I don't know" is a career-ending answer.

**Real attack/defense scenario:** A regional hospital is hit with [[ransomware]]. Their BIA, completed eighteen months prior, identified the EHR (Electronic Health Record) system as Tier-1 critical with an RTO of 4 hours and an RPO of 15 minutes. Because the BIA forced that conversation, the hospital had funded synchronous replication to a warm site and offline immutable backups. Recovery took 3.5 hours. The hospital across town, with no BIA, took eleven days and faced HIPAA fines because they could not prove which records were lost.

**Exam relevance:** Domain 5.2 of SY0-701 explicitly lists "Business impact analysis" with the sub-bullets *Recovery Time Objective (RTO), Recovery Point Objective (RPO), Mean Time to Repair (MTTR), Mean Time Between Failures (MTBF)*. CompTIA loves to test whether you can distinguish RTO from RPO, calculate MTBF from failure data, and identify which metric drives which recovery decision. Expect at least one performance-based or scenario question forcing you to apply these.

## Key facts

### The four core BIA metrics

| Metric | Question it answers | Drives | Measured in |
|---|---|---|---|
| **RTO** (Recovery Time Objective) | How fast must we be back online? | DR strategy, hot/warm/cold site choice | Time (hours, days) |
| **RPO** (Recovery Point Objective) | How much data can we afford to lose? | Backup frequency, replication tier | Time (minutes, hours) |
| **MTTR** (Mean Time To Repair) | On average, how long does a fix take? | Staffing, parts inventory, SLAs | Time (hours) |
| **MTBF** (Mean Time Between Failures) | How reliable is this asset? | Replacement cycles, redundancy planning | Time (hours, often thousands) |

### RTO — Recovery Time Objective

The maximum tolerable time a business function can be offline before unacceptable consequences occur. RTO is **forward-looking** from the moment of outage to the moment of restoration.

- A retail e-commerce platform might have an RTO of 1 hour.
- A monthly batch reporting tool might have an RTO of 72 hours.
- RTO directly determines DR site type: short RTO → [[hot site]]; medium → [[warm site]]; long → [[cold site]].

> **CompTIA exam trap:** RTO is *not* how long recovery actually took — that's MTTR. RTO is the *target* you committed to in the BIA. A question that says "the system was down for six hours but the agreement allowed eight" is testing RTO (the eight) versus actual downtime.

### RPO — Recovery Point Objective

The maximum tolerable amount of data loss, expressed as a time window. RPO is **backward-looking** from the moment of outage to the last known-good backup or replication point.

- An RPO of 0 means zero data loss tolerated → requires synchronous replication.
- An RPO of 24 hours means daily backups are acceptable.
- An RPO of 15 minutes typically requires log shipping or near-CDP (continuous data protection).

**Memory aid:**
- **RTO = Time** to be back **O**nline
- **RPO = Point** to which data is **O**K to lose

### MTTR — Mean Time To Repair

The average time required to restore a failed component to operational status, calculated from historical incident data.

**Formula:** `MTTR = Total downtime / Number of incidents`

**Example:** Five incidents over the past year produced 20 hours of total downtime. MTTR = 20 / 5 = **4 hours**.

MTTR feeds into RTO planning: if your MTTR for a database server is 6 hours but your RTO commitment is 2 hours, you have a gap and need either redundancy ([[high availability]] cluster) or a faster recovery mechanism.

### MTBF — Mean Time Between Failures

The average operational time between failures of a repairable system. A reliability metric.

**Formula:** `MTBF = Total operational time / Number of failures`

**Example:** A server runs 8,760 hours in a year and fails twice. MTBF = 8,760 / 2 = **4,380 hours**.

> **CompTIA exam trap:** MTBF applies to **repairable** systems. **MTTF** (Mean Time To Failure) applies to **non-repairable** components like a single hard drive that you throw out and replace. SY0-701 mentions MTBF specifically, but distractor answers may include MTTF — read carefully.

### The BIA process — five phases

1. **Identify critical business functions.** Interview department heads, map workflows, list every process the business runs.
2. **Identify dependencies.** What does each function rely on? Servers, applications, vendors, personnel, network links, third-party APIs, [[supply chain]] partners.
3. **Assess impact of disruption.** Quantify financial loss per hour, regulatory penalties, reputational damage, safety implications.
4. **Determine recovery requirements.** Set RTO and RPO for each function based on impact tolerance.
5. **Document and prioritize.** Produce a tiered recovery plan: Tier-1 (critical, restore first), Tier-2 (important), Tier-3 (deferrable).

### Impact categories

A thorough BIA evaluates impact across multiple dimensions, not just dollars:

| Category | Examples |
|---|---|
| **Financial** | Lost revenue per hour, contractual penalties, recovery costs |
| **Operational** | Inability to ship products, process orders, serve customers |
| **Regulatory / Legal** | [[GDPR]], [[HIPAA]], PCI-DSS, SOX violations and fines |
| **Reputational** | Customer churn, brand damage, social media fallout |
| **Safety / Life** | Hospital systems, industrial control systems, [[SCADA]] outages |

### Single Point of Failure (SPOF) identification

A BIA must surface every [[single point of failure]] — a component whose failure halts a critical function with no fallback.

Common SPOFs:
- One internet circuit from one ISP
- One identity provider with no break-glass account
- One DBA who knows the legacy system
- One air-handler cooling the data center
- One vendor providing a critical SaaS dependency

The BIA's job is not to fix SPOFs but to **identify** them so risk owners can decide whether to accept, mitigate (redundancy), transfer (insurance), or avoid the risk.

### Mission Essential Functions (MEF)

Government and many regulated industries require explicit identification of **Mission Essential Functions** — the small set of functions that absolutely must continue during a disruption. MEFs typically have the most aggressive RTO/RPO and drive the highest tier of [[continuity of operations]] (COOP) investment.

### Connecting BIA to other risk artifacts

The BIA is not a standalone document — it feeds and is fed by several others:

- **[[Risk assessment]]:** Identifies threats and vulnerabilities; BIA quantifies the impact half of risk = likelihood × impact.
- **[[Disaster Recovery Plan]] (DRP):** Operationalizes the technical recovery of systems based on BIA RTO/RPO.
- **[[Business Continuity Plan]] (BCP):** Addresses the broader continuation of business operations (people, processes, alternate sites).
- **[[Incident Response Plan]]:** Uses BIA to prioritize which systems to triage first during an incident.
- **[[Tabletop exercise]] / [[disaster recovery]] testing:** Validates that BIA-derived RTO and RPO are actually achievable.

### Worked example — putting it together

A SaaS company runs an HR platform. Their BIA produces:

| Function | RTO | RPO | MTTR (current) | MTBF | Tier |
|---|---|---|---|---|---|
| Login / SSO | 30 min | 0 | 45 min | 2,200 hr | 1 |
| Payroll processing | 4 hr | 1 hr | 6 hr | 4,500 hr | 1 |
| Reporting dashboard | 24 hr | 4 hr | 8 hr | 3,000 hr | 2 |
| Internal wiki | 72 hr | 24 hr | 12 hr | 5,000 hr | 3 |

**Reading the table:**
- Login MTTR (45 min) **exceeds** RTO (30 min) → gap. Solution: deploy [[high availability]] / [[load balancing]] across regions, or move to active-active.
- Payroll RPO is 1 hour → requires hourly transaction log backups or replication.
- Internal wiki Tier 3 → can be on a [[cold site]] with daily backups; no investment in synchronous replication.

This single table justifies budget. The CFO can see exactly why the SSO upgrade costs $400K and why the wiki gets a $5K backup tier.

### Common BIA mistakes (and exam-relevant pitfalls)

- **Confusing RTO with MTTR.** RTO is a *target*; MTTR is a *measured average*. They should be compared, not conflated.
- **Setting RPO = 0 for everything.** Synchronous replication for non-critical systems wastes money; the BIA exists to make that tradeoff explicit.
- **Ignoring third-party dependencies.** Your RTO is meaningless if your payment processor's RTO is 24 hours. [[Vendor risk management]] and [[third-party risk]] feed into BIA.
- **Treating BIA as one-and-done.** It must be reviewed annually and after major changes — new applications, mergers, regulatory changes, or significant infrastructure shifts.
- **Quantitative obsession.** Not every impact maps to dollars cleanly — reputational, regulatory, and life-safety impacts may warrant qualitative ratings (low/medium/high) instead of forced numbers.
- **Skipping interview validation.** A BIA built only from technical documentation misses how the business actually runs. Talk to process owners, not just system owners.

### CompTIA exam traps

- **RTO ≠ RPO.** RTO is *time to restore*; RPO is *acceptable data loss*. Don't confuse them.
- **MTTR vs MTBF.** MTTR = how long it takes to fix when broken; MTBF = average time between failures. Both are reliability metrics — not recovery targets.
- **BIA precedes BCP/DRP.** You cannot write a sensible recovery plan without first knowing what's critical and how long it can be down. The BIA is the input, not the output.
- **Single Loss Expectancy / Annualized Loss Expectancy** are quantitative risk math (`SLE = Asset Value × Exposure Factor`, `ALE = SLE × ARO`). The exam loves these formulas.
- **Critical findings drive tier assignment**, which drives investment. Tier 1 systems get the most expensive controls; Tier 3 gets the cheapest.

## Related concepts

[[Risk Assessment]] · [[Risk Management]] · [[Business Continuity Plan]] · [[Disaster Recovery Plan]] · [[Incident Response Plan]] · [[Continuity of Operations]] · [[High Availability]] · [[Load Balancing]] · [[Hot Site]] · [[Warm Site]] · [[Cold Site]] · [[Tabletop Exercise]] · [[Vendor Risk Management]] · [[Third-Party Risk]] · [[Single Point of Failure]] · [[SLE and ALE]] · [[Mission Essential Functions]] · [[Backup Strategies]] · [[Replication]] · [[Failover]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
