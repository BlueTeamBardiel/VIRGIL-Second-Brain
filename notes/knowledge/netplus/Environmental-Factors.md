# Environmental Factors

## What it is

In **Skyrim**, you don't just stack health potions and call yourself prepared. You keep a horse outside Whiterun, a house in Solitude with an enchanting table, a stash chest in Riften, and a save file from before you walked into Helgen. When the dragon shows up — and it always shows up — you don't panic. You fast-travel to the nearest fallback, regear, and ride back to finish the fight. The Dragonborn doesn't survive because they're tough. The Dragonborn survives because they have **backup positions, prepared gear, and a save state**.

That's exactly what disaster recovery does — it's the network's save file, fallback house, and emergency stash, planned before the dragon lands on the data center.

Technically, **disaster recovery (DR)** is the set of policies, procedures, and infrastructure used to restore IT services after a disruptive event — hardware failure, power loss, ransomware, fire, flood, or the HVAC unit deciding July is a good month to die. DR is measured in two numbers: how much data you can lose (**RPO**), and how long you can be down (**RTO**). Everything else — sites, replication, failover — is engineering to hit those two numbers.

## Why it matters

Outages cost money by the minute. A trading firm losing $100k/minute does not have the same DR budget as a dentist's office losing $200/hour, and Net+ wants you to understand that **DR is a business decision before it's a technical one.** The CIO doesn't ask "what's our replication topology?" — they ask "how long until we're back, and how much data did we lose?"

Objective 3.3 expects you to define RPO, RTO, MTTR, MTBF, distinguish cold/warm/hot sites, explain active-active vs active-passive, and know the difference between a tabletop exercise and an actual failover test. CompTIA writes scenario questions where the right site choice depends on a budget line and a tolerance number. Read the question carefully — the answer is in the constraints.

In the field, this is the difference between "we restored from backup overnight" and "the company is gone." Colonial Pipeline. Maersk. The hospital systems that paid ransoms because they had no recovery plan. *DR is not a luxury. DR is the only thing standing between a bad Tuesday and a bankruptcy filing.*

## Key facts

### The four metrics that define DR

| Metric | What it measures | Example |
|---|---|---|
| **RPO** (Recovery Point Objective) | Maximum acceptable **data loss**, measured in time | "We can lose 15 minutes of transactions" → backup every 15 min |
| **RTO** (Recovery Time Objective) | Maximum acceptable **downtime** before recovery completes | "We must be back in 4 hours" → drives site/replication choice |
| **MTBF** (Mean Time Between Failures) | Average uptime between failures of a component | A drive rated 1.2M hours MTBF — statistical, not a guarantee |
| **MTTR** (Mean Time To Repair) | Average time to restore a component after it fails | Swap a hot-spare drive: 5 min. Order a new switch: 48 hr |

**RPO looks backward** from the moment of disaster ("how much did we lose?"). **RTO looks forward** ("how long until we're back?"). Mix these up on the exam and you will lose easy points.

**MTBF is about the component.** MTTR is about the team and the parts shelf. Together they define **availability**:

> Availability = MTBF / (MTBF + MTTR)

A drive that fails rarely but takes a week to replace can have worse availability than one that fails monthly but swaps in five minutes. *Reliability and recoverability are different problems.*

### DR sites — the three flavors

| Site type | What's there | Spin-up time | Cost | Use case |
|---|---|---|---|---|
| **Cold site** | Empty building. Power, cooling, floor space. No gear, no data. | Days to weeks | $ | Low-budget DR, long RTO tolerance |
| **Warm site** | Hardware in place, network ready. Data is **stale** — restored from backup at failover. | Hours to a day | $$ | Mid-tier — most realistic enterprise default |
| **Hot site** | Fully redundant, **live data replication**, ready to take traffic now. | Minutes (or zero) | $$$$ | Finance, healthcare, anything with an RTO under an hour |

**Cold site = empty house in Solitude.** **Warm site = the house is furnished but the chests are empty** — you fast-travel there, then go fetch your gear. **Hot site = a fully stocked clone of your main house, with the cooking pot already bubbling.**

> **CompTIA exam trap:** A "warm site has hardware but data must be restored from backup." A "hot site has hardware AND replicated live data." If a question describes a site with servers racked but no current data, the answer is **warm**, not hot. CompTIA tests this distinction in nearly every DR question.

### High-availability approaches

HA and DR overlap but aren't the same. **HA** keeps services running through individual component failures (a drive, a power supply, a switch). **DR** kicks in when the whole site goes dark.

**Active-active**
- Both nodes/sites serve traffic simultaneously, load balanced
- Failure of one = the other absorbs full load (capacity-plan accordingly)
- Higher throughput, more complex, requires real-time sync
- Example: two data centers both serving the website, GeoDNS routing users to nearest

**Active-passive**
- One node serves traffic. The other is a standby.
- On failure, traffic **fails over** to the standby
- Simpler, cheaper, but the passive node is paid-for capacity sitting idle
- Failover takes seconds to minutes depending on detection and DNS TTL
- Example: a primary firewall with a standby in HA pair sharing a virtual IP

*Active-active scales. Active-passive simplifies. Pick based on whether you need more horsepower or fewer 2am pages.*

### Replication and the RPO floor

RPO is bounded by **how often data is copied** to the recovery site.

| Replication method | Typical RPO |
|---|---|
| Synchronous (every write committed at both sites) | Near zero — latency-bound, typically <100 km |
| Asynchronous (writes queued, flushed continuously) | Seconds to minutes |
| Scheduled snapshots (every 15 min, hourly, etc.) | The snapshot interval |
| Nightly backup | Up to 24 hours |
| Weekly backup tape rotation | Up to 7 days |

**You cannot have a 5-minute RPO with nightly backups.** The math doesn't care about your budget meeting.

### Testing — the part everyone skips

A DR plan that has never been tested **is not a DR plan, it is a fanfic.** CompTIA tests this in plain English: "the company has a documented DR plan but has never executed it" — the correct answer is always *"conduct a test."*

| Test type | What happens | Risk | Realism |
|---|---|---|---|
| **Tabletop exercise** | Team walks through "what would we do if…" verbally. No systems touched. | None | Low — catches plan gaps, not technical issues |
| **Walkthrough** | Same as tabletop but with the runbook in hand, step-by-step | None | Low-medium |
| **Simulation** | Test environment, simulated failure, real procedures against non-prod | Low | Medium |
| **Parallel test** | DR site brought up alongside prod, processes data in parallel. Prod not interrupted. | Low | High |
| **Validation / full failover** | Actually fail over production to the DR site. Verify it works. | High | Highest — the real thing |
| **Failback** | After a failover test, returning to primary. Often where things break. | Medium | The forgotten step |

*The first time you fail over should never be the day of the disaster.* The teams that survive real outages are the ones who tested last quarter and found the firewall rule that blocked replication on weekends.

> **CompTIA exam trap:** A **tabletop exercise** is a *discussion*. No systems are touched. If the scenario says "the team gathered to walk through the response plan and identify gaps," that's a tabletop. A **validation test** or **full failover test** actually executes the failover. CompTIA loves making you distinguish between "discussed" and "executed."

### Backups vs DR — not the same thing

A backup is a copy of data. DR is the **process and infrastructure** to restore service. You can have backups and still have no DR if you have nowhere to restore them to within your RTO. *A backup is a parachute. DR is the whole emergency landing procedure including where the runway is.*

**3-2-1 rule:** 3 copies of data, on 2 different media, with 1 offsite. Modern variant: **3-2-1-1-0** — add 1 immutable/air-gapped copy and 0 errors on verification.

### CompTIA exam traps

> **Trap 1 — RPO vs RTO:** RPO is **data loss** (time before disaster). RTO is **downtime** (time after disaster). Mnemonic: RP**O** = how **O**ld the data is when we recover. RT**O** = how long until we're back **O**nline.

> **Trap 2 — MTBF vs MTTR:** MTBF is **B**etween failures (uptime). MTTR is **T**o **R**epair (downtime). MTBF big number = good. MTTR big number = bad.

> **Trap 3 — Cold/warm/hot is about DATA, not just hardware.** Warm has hardware but stale or no data. Hot has hardware AND live-replicated data ready to serve.

> **Trap 4 — Active-passive is still redundancy.** Active-passive is HA; the passive node is just hot-standby instead of load-sharing.

## Helpdesk reality

- User says: *"The site is down."* Check: is it down for everyone, or just them? Is the primary DC reachable? Has anyone declared an incident? **L1 doesn't trigger DR failover.** That's a management decision tied to declaring a disaster.
- User says: *"How long until we're back?"* Never quote the RTO as a promise. The RTO is the **target**, not a guarantee. Say "the team is working on it, I'll update you as I learn more." Promising a number you can't keep ends careers.
- During an outage, the runbook is your friend. If your team doesn't have a DR runbook, write one **before** the next outage — failover steps, contact tree, DNS TTLs, credentials location, service startup order. *The runbook written during a crisis is the runbook nobody can read at 3am.*
- After any outage — real or test — write the **post-mortem.** What broke, what worked, what surprised the team, what to change. No-blame, root-cause focused.
- If you've never seen a DR test, ask to be in the next one. The diagrams lie. The failover doesn't.

## Related concepts

[[Backups]] · [[High Availability]] · [[Redundancy]] · [[Load Balancing]] · [[Clustering]] · [[Snapshots]] · [[Replication]] · [[NIC Teaming]] · [[Power Redundancy]] · [[UPS]] · [[Generators]] · [[Cooling and HVAC]] · [[Fire Suppression]] · [[Change Management]] · [[Incident Response]] · [[Business Continuity]] · [[Risk Assessment]] · [[SLA]]

*Source: VIRGIL knowledge base — 2026-05-11*