# Disaster Recovery

## What it is

In **Among Us**, the lights go out on Electrical and Comms gets sabotaged at the same time. The reactor is counting down. Two crewmates run to fix Reactor, one starts Lights, one calls an emergency meeting, and someone is already venting toward O2. The crew that survives isn't the one with the best players — it's the one that already knows who handles which sabotage, in what order, and how long they have before the ship blows. The crew that dies is the one arguing in chat about whether Red is sus while the reactor melts.

That's exactly what disaster recovery does — it's the pre-agreed plan for who fixes what, in what order, and how fast, when the infrastructure is actively on fire.

**Disaster recovery (DR)** is the set of policies, procedures, metrics, and standby infrastructure that restore IT services after a disruptive event — hardware failure, ransomware, flood, fiber cut, datacenter fire. It is distinct from **business continuity** (keeping the business running during the disruption) and **high availability** (preventing the disruption from being user-visible in the first place). DR is what you invoke when HA has already failed.

## Why it matters

Outages cost money per minute. A retail site down on Black Friday burns six figures an hour. A hospital with no EHR access can't admit patients. A factory with no SCADA stops the line. The question on the exam — and on the job — is never "will something break" but "how fast can we restore service and how much data are we allowed to lose."

N10-009 Objective 3.3 tests DR vocabulary cold: RPO vs RTO, MTBF vs MTTR, hot/warm/cold sites, active-active vs active-passive, tabletop vs validation testing. CompTIA loves to flip RPO and RTO in the answer choices and watch candidates pick the wrong one. Get the metrics straight and half the domain is free.

In the field, DR is the difference between "we restored from last night's backup in two hours" and "we no longer have a company." Ransomware made this real for every business since 2019. *If your backups aren't tested, you don't have backups — you have hope.*

## Key facts

### The four DR metrics (memorize these)

| Metric | What it measures | Example |
|---|---|---|
| **RPO — Recovery Point Objective** | How much **data** you can afford to lose, measured in time | RPO = 1 hour → backups every hour |
| **RTO — Recovery Time Objective** | How long the service can be **down** before the business is hurt | RTO = 4 hours → must be back online in 4 hours |
| **MTBF — Mean Time Between Failures** | Average uptime between failures of a component (reliability) | A drive rated 1.2M hours MTBF |
| **MTTR — Mean Time To Repair** | Average time to restore a failed component to service | Swap a hot-spare drive: MTTR = 15 minutes |

The trick: **RPO looks backward** (how far back in time do we restore from?), **RTO looks forward** (how long until we're up again?). MTBF is a property of the **hardware**; MTTR is a property of the **process and the team**.

> **CompTIA exam trap:** RPO and RTO get swapped in answer choices constantly. RPO = **data loss tolerance** (Point in time). RTO = **downtime tolerance** (Time to recover). If the question says "the business can lose at most 15 minutes of transactions," that's RPO. If it says "the business must be back online within 2 hours," that's RTO.

### DR sites — hot, warm, cold

A DR site is a secondary facility you fail over to when the primary is dead. Three flavors, three price points, three recovery speeds.

| Site type | Hardware | Data | Staff | RTO | Cost |
|---|---|---|---|---|---|
| **Cold** | Empty space, power, cooling, network drops | None — bring your own backups | None on-site | Days to weeks | Cheapest |
| **Warm** | Hardware racked, OS installed, network configured | Backups restored on a delay (hours to a day old) | Skeleton or on-call | Hours to a day | Middle |
| **Hot** | Fully provisioned, running, mirrored | Live replication, near-zero data lag | Staffed or fully automated failover | Minutes | Most expensive |

The decision tree is purely economic: **how much downtime can the business eat, and what's the budget?** A hot site for a five-person law firm is malpractice in the other direction — overspending on resilience nobody needed. A cold site for a hospital ICU system is also malpractice. Match the site to the RTO the business actually committed to.

*The cold site you've never tested is functionally a parking lot with a power outlet. The hot site you've never failed over to is just an expensive monitoring dashboard.*

### High-availability approaches — active-active vs active-passive

HA is the thing that keeps DR from being invoked in the first place. Two main patterns:

**Active-active** — both nodes (or all nodes) are processing live traffic simultaneously. A [[load balancer]] distributes requests across them. If one dies, the others absorb the load with no failover delay.
- Pro: full hardware utilization, instant failover, scales horizontally
- Con: more complex (session sync, split-brain risk), every node must handle peak load minus one
- Example: two web servers behind an F5, each serving 50% of users

**Active-passive** — one node serves all traffic, the other sits idle (or in standby) watching the primary's heartbeat. When the primary fails, the passive promotes itself.
- Pro: simpler, no session-sync headaches, well-understood
- Con: half the hardware is doing nothing 99% of the time, brief failover gap (seconds to minutes)
- Example: a primary firewall with a standby firewall in [[HSRP]] / [[VRRP]] / cluster mode

> **CompTIA exam trap:** Active-passive is sometimes called "hot standby" — don't confuse the **standby node** being "hot" with a **hot site**. A hot standby node is a server. A hot site is a whole datacenter.

### DR testing — the part everyone skips

A DR plan that's never been tested is a fiction. CompTIA tests the testing hierarchy:

1. **Tabletop exercise** — the team sits around a table (or a Zoom), the DR coordinator reads a scenario ("ransomware on the file servers, 3 AM Saturday"), and everyone talks through what they'd do. No systems are touched. Cheapest, easiest, catches gaps in the runbook and the call tree. Do this quarterly.

2. **Walkthrough / structured review** — step through the actual documented procedures in order, verifying each step is current. Still no real failover. Catches drift in documentation.

3. **Simulation** — invoke parts of the plan in a sandbox. Restore a backup to an isolated VM. Verify it boots. Verify the data is intact.

4. **Validation test (parallel test)** — bring up the DR site fully, run it in parallel with production, verify it can handle real load. Production stays live as a safety net.

5. **Full failover (cutover test)** — actually cut production over to the DR site. The most realistic, the most dangerous, the most expensive. Do it on a planned maintenance window with a rollback plan.

*The first time you test your DR plan should not be during a real disaster. The first time anyone touches the runbook should not be the night the SAN catches fire.*

### How the metrics interact with the sites

The metrics drive the site choice:

- **RTO of 15 minutes** → hot site, active-active, automated failover. Anything less and you'll miss the window.
- **RTO of 4 hours** → warm site, active-passive with documented manual cutover.
- **RTO of 3 days** → cold site is fine. You have time to ship hardware and restore tapes.
- **RPO of 5 seconds** → synchronous replication, hot site, expensive WAN link.
- **RPO of 24 hours** → nightly backup is sufficient.

The business sets the RPO and RTO. IT designs the infrastructure to meet them. If the business demands RPO=0 and RTO=0, the business is asking for infinite money — push back and make them pick a number they'll actually fund.

### CompTIA exam traps (more)

> **CompTIA exam trap:** MTBF is **between** failures (reliability — how long it lasts). MTTR is **to repair** (recoverability — how fast you fix it). High MTBF good. Low MTTR good. CompTIA will give you a scenario with both numbers and ask which one improves with a hot-spare drive in a RAID array — answer: MTTR (the repair is faster because the spare auto-rebuilds; the underlying drive reliability didn't change).

> **CompTIA exam trap:** A "warm site" is sometimes described as "hardware in place, data restored from backup on activation." The distinguishing feature vs hot is **data freshness and automation**, not whether the lights are on. Read carefully.

> **CompTIA exam trap:** Tabletop exercises **do not** touch production systems. If an answer choice says "the team tabletops the failover by cutting traffic to the DR site," that's wrong — that's a cutover test.

## Helpdesk reality

- User says: *"The site is down, when will it be back?"* You do not know. You never promise a time. You say "we're working on it, I'll update you in 30 minutes." Then you actually update them in 30 minutes.
- The DR runbook lives in a binder, a wiki, and a printed copy in the NOC. If it only lives in the wiki and the wiki is hosted on the same infrastructure that just died, you have no runbook. *Print it. Yes, really.*
- Backups that aren't tested aren't backups. A surprising percentage of "we have nightly backups" environments have been silently failing for months. Restore test, monthly, minimum.
- Tier 1 doesn't invoke DR. Tier 1's job during an outage is to log the tickets, communicate the status page, and not panic the users. DR invocation is a manager/director call, often requiring sign-off because the failover itself can break things further.
- If you've ruled out client-side and the outage is enterprise-wide, your job is **information capture**, not heroics — collect the symptoms, the timestamps, the affected user count, and route to the incident commander. The cowboy who tries to "just restart the SAN" during an active incident is the cowboy who turns a 2-hour outage into a 2-day one.

## Related concepts

[[Business Continuity]] · [[Backups]] · [[High Availability]] · [[Load Balancing]] · [[VRRP]] · [[HSRP]] · [[RAID]] · [[Change Management]] · [[Incident Response]] · [[SLA]] · [[Snapshots]] · [[Replication]]

*Source: VIRGIL knowledge base — 2026-05-11*