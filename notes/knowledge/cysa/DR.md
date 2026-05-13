# DR — Disaster Recovery

## What it is

In **Skyrim**, your character dies to a frost troll on the 7,000 Steps and the screen fades to black. You don't lose the save. You reload from the autosave at High Hrothgar, re-equip, eat a sweetroll, and walk back up the mountain. The save file is the entire point — without it, every death is permadeath and the game ends at the first dragon. **Disaster Recovery** is the autosave system for the enterprise. The business takes a hit — ransomware, datacenter fire, region-wide AWS outage, a backhoe through the fiber — and DR is the documented, tested process of reloading from a known-good state.

Plain English: DR is the plan for getting critical IT systems back online after they've gone down hard. It's a subset of **Business Continuity (BC)**, which is the broader plan for keeping the *business* running (people, processes, facilities) when IT is on fire.

Technical: Disaster Recovery is the **set of policies, procedures, tools, and playbooks** that restore IT infrastructure and data after a disruptive event. It's measured by two numbers — **RTO** (Recovery Time Objective: how long until we're back up) and **RPO** (Recovery Point Objective: how much data we can afford to lose). DR lives in the **Preparation** phase of the IR lifecycle and gets exercised through **tabletop** drills, then activated during **Containment, Eradication, and Recovery** when an incident escalates past the SOC's ability to absorb it locally.

## Why it matters

The CySA+ exam tests DR under Objective 3.3 — preparation and post-incident activity. CompTIA wants you to know that DR is not "the backup admin's problem" — it's part of the IR program. Ransomware in 2026 isn't a malware incident, it's a DR incident. The moment LockBit's successor encrypts the file servers, your SOC ticket becomes a recovery operation, and whether the business survives the week is a function of whether someone tested the backups in the last quarter.

Career relevance: every CySA+ analyst gets pulled into DR. Not because you write the plan, but because you're the one who verifies the IoCs are gone before the restored systems come back online. Restore a clean backup onto a network that still has the threat actor's persistence in it, you just handed them their access back, freshly patched.

## Key facts

### DR lives inside the IR lifecycle

CompTIA's four-phase model (NIST SP 800-61):

| Phase | DR activity |
|---|---|
| **Preparation** | Write the [[Incident response plan]], build DR runbooks, stage backup infrastructure, run [[Tabletop]] exercises, train staff |
| **Detection and Analysis** | Determine if the incident scope triggers DR activation (encrypted file shares? region down?) |
| **Containment, Eradication, Recovery** | DR is the **Recovery** half — restore from backup, fail over to DR site, rebuild from gold images |
| **Post-incident Activity** | [[Root cause analysis]], [[Lessons learned]], update the DR plan with what actually broke |

The exam *will* try to bait you into picking "DR is its own phase." It's not. It's a tool used inside the Recovery step.

### RTO vs RPO — the two numbers leadership cares about

- **RTO (Recovery Time Objective)** — maximum tolerable downtime. "We need email back in 4 hours." Drives the *architecture* (hot site vs warm site vs cold site).
- **RPO (Recovery Point Objective)** — maximum tolerable data loss, measured in time. "We can lose at most 15 minutes of transactions." Drives the *backup frequency* (continuous replication vs nightly snapshots).

A bank has RTO of minutes and RPO near zero — they run synchronous replication to a hot site. A small law firm might have RTO of 48 hours and RPO of 24 — nightly tape, mailed to Iron Mountain.

### DR site types

| Site type | Hardware | Data | Time to activate | Cost |
|---|---|---|---|---|
| **Hot** | Fully provisioned, running | Live replicated | Minutes | $$$$ |
| **Warm** | Provisioned, idle | Recent backups loaded | Hours | $$$ |
| **Cold** | Empty space, power, network | Restore from tape/cloud | Days | $ |
| **Cloud / IaC** | Spin up on demand | Object storage / snapshots | Minutes–hours | Variable |

Cloud-native DR (Terraform plans + S3 snapshots + cross-region replication) has eaten most of the traditional warm-site market. The exam still tests the classic four.

### Backup strategy — the 3-2-1 rule

- **3** copies of the data
- on **2** different media types
- with **1** offsite (and ideally **1 offline / air-gapped / immutable**)

Modern variant: **3-2-1-1-0** adds one immutable copy and zero errors on backup verification. Ransomware crews specifically hunt and delete online backups. If your only "offsite" is a replicated NAS reachable from the production domain, you don't have a backup, you have a second target.

### Playbooks — the DR runbook

A DR playbook is the step-by-step for one specific failure scenario. Not "Disaster Recovery Plan v4.docx, 87 pages" — that document collects dust. The playbook is the operational artifact:

- **Trigger condition** — what event activates this playbook
- **Decision authority** — who calls "we're activating DR" (usually CIO or incident commander, never the L1 analyst)
- **Communication tree** — call list, out-of-band channel (Signal, not Slack — Slack might be encrypted too)
- **Technical steps** — exact commands, in order, with expected output
- **Verification** — how you know recovery worked (not "ping responds" — "test transaction completes end-to-end")
- **Rollback** — what to do if recovery makes it worse

Common playbooks: ransomware recovery, datacenter failover, ransomware recovery (yes twice — encrypted backups is a different playbook than encrypted prod), domain controller rebuild, cloud account compromise.

### Training and tabletops

[[Tabletop]] exercises are the cheap, high-value preparation move. Get the IR team, IT leadership, legal, comms, and a business owner in a room. The facilitator reads an injects: *"It's 2am Sunday. PagerDuty just woke you up — the SOC says every Windows file share in the east datacenter is showing .lockbit3 extensions. What do you do, in order, for the next 6 hours?"*

You're not testing whether systems recover. You're testing whether *people know the plan, know each other's names, and know which decisions belong to whom*. The first time legal and IT meet should never be during the actual incident.

Cadence: tabletops quarterly, full DR failover test annually. Anything less and the plan is fiction.

### Forensic analysis before recovery

This is the trap blue teams keep falling into. The business screams "restore now," and IT restores from the most recent backup — which is from *after* the threat actor established persistence. Now your "clean" environment has the same backdoor, freshly restored.

Order of operations during a security-driven DR event:

1. **Forensic acquisition** — image affected systems, preserve volatile memory, log chain of custody. [[Forensic analysis]] runs in parallel with recovery, not after.
2. **Determine compromise window** — when did the threat actor first get in? Backups from before that date are clean; backups from after are suspect.
3. **Restore from pre-compromise backup** to isolated network
4. **Scan and verify** — IoC sweep, EDR coverage, credential rotation
5. **Cut over** to production

The change board will push back on the time this takes. The CISO needs to back the IR lead, or you're rebuilding the same incident in three weeks.

### Post-incident activity

After the lights come back on, the work isn't done.

- **[[Root cause analysis]]** — not "phishing email" (that's the vector). Why did the phish land? Why did the macro run? Why did the workstation have local admin? Why did that account reach the file server? Five whys until you hit something fixable.
- **[[Lessons learned]] meeting** — within two weeks while memory is fresh, blameless format. What worked, what didn't, what surprised us. Output is a list of action items with owners and due dates.
- **DR plan updates** — every actual incident reveals plan gaps. Update the playbooks. Re-run the tabletop with the new scenario.
- **Metrics** — MTTD, MTTR, MTTRem, actual RTO vs target RTO, actual RPO vs target RPO. Report up.

### CompTIA exam traps

> **CompTIA exam trap:** **BC vs DR** — Business Continuity is the umbrella (people, process, facilities, alternate work locations, supplier contracts). Disaster Recovery is the IT subset (systems, data, infrastructure). If the question is about employees working from home during a hurricane, that's BC. If it's about failing over to the secondary datacenter, that's DR.

> **CompTIA exam trap:** **RTO vs RPO direction** — RTO is *forward in time* (how long until we're back). RPO is *backward in time* (how far back is the last good data). Candidates flip these under pressure. Mnemonic: **R**TO = **R**estore **T**ime, **R**PO = data **P**oint.

> **CompTIA exam trap:** **Hot site does not mean "fast backup"** — it means a fully running duplicate facility with live data replication. A "hot backup" (database term) is a different thing — a backup taken while the DB is online. Read the question carefully.

> **CompTIA exam trap:** **The MOU / SLA inhibitor** — if your DR site is provided by a vendor, the contract dictates how fast they spin you up. Your internal RTO of 4 hours means nothing if the MOU says "best effort within 72 hours." This is a documented CompTIA "inhibitor to remediation."

## SOC reality

- At 3am when the ransomware note hits, the L1 analyst's job is not to fix anything. It's to **confirm scope** (how many hosts, which shares, which segments), **preserve evidence** (don't reboot the patient zero workstation — memory is gold), and **escalate to the IR lead** who decides whether to call DR activation.
- The CISO's first three questions, in order: *"What's the scope? Is the threat actor still in the network? When was the last clean backup?"* Have those answers ready or have the path to get them.
- Never tell leadership "we'll be back up in X hours" during active recovery. Tell them "we're restoring to an isolated environment, validating, and will have a verified ETA in the next status call." False precision early burns credibility you'll need at hour 36.
- The handoff: L1 detects and escalates → L2/L3 scopes and contains → IR lead activates DR → IT operations executes restore → IR validates clean → business owner approves cutover. Six handoffs, and every one of them is in the playbook, by name and number.
- The tabletop you ran last quarter is the only reason any of this works. *The plan you never rehearsed is the plan you don't have.*

## Related concepts

[[Incident response plan]] · [[Tabletop]] · [[Business continuity (BC)]] · [[Root cause analysis]] · [[Lessons learned]] · [[Forensic analysis]] · [[Chain of custody]] · [[MTTD]] · [[MTTR]] · [[Playbooks]] · [[Ransomware]] · [[Backups]] · [[Inhibitors to remediation]]

*Source: VIRGIL knowledge base — 2026-05-11*