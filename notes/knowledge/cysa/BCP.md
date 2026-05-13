# BCP — Business Continuity Plan

## What it is

In **Watch Dogs**, when Aiden Pearce hits the ctOS hack to blackout a city block, the traffic lights don't just go dark — Chicago has backup generators kicking on at hospitals, manual traffic cops getting dispatched, ComEd crews rolling to substations. The grid is down but the city keeps functioning at degraded capacity because somebody, somewhere, wrote down what happens when ctOS eats it. That's exactly what a **BCP** does — it's the written plan that keeps the business running while the primary systems are on fire.

**Plain English:** when something breaks badly enough that normal operations stop, the BCP tells everyone how to keep the critical parts of the business limping along until IT brings the real systems back.

**Technical CS0-003 definition:** the **Business Continuity Plan (BCP)** is the documented strategy and procedures that maintain essential business functions during and after a disruptive incident — ransomware, datacenter outage, regional disaster, supply-chain failure. It sits in the **Preparation** phase of the incident management lifecycle and is invoked during **Containment, Eradication, and Recovery**. BCP is not [[Disaster Recovery (DR)]] — DR restores the IT systems; BCP keeps the business operating *while DR is happening*. The BCP names alternate sites, manual workarounds, communication trees, vendor failovers, and the order in which functions come back online based on [[Business Impact Analysis (BIA)]] priorities.

## Why it matters

CompTIA tests BCP in Objective **3.3** under preparation activities. They will absolutely give you a scenario where ransomware has detonated and ask whether your next move is to invoke BCP, DR, or the IR plan — and the answer depends on what got hit and what the org needs to keep doing for customers.

Career relevance: when you sit in an L2 or IR lead seat, the **first question executives ask after "are we breached?"** is **"can we still take orders / process payments / treat patients?"** That question is answered by the BCP, not by the SOC. If you don't know where your org's BCP lives, who owns it, and what its [[Recovery Time Objective (RTO)]] is for your critical business processes, you cannot answer leadership. You will stand in front of the CEO with nothing.

Real-world stakes: Maersk in 2017 (NotPetya) lost their entire Active Directory globally. The business continuity move was manual shipping operations, paper bills of lading, and WhatsApp coordination — that's BCP working at degraded capacity while DR rebuilt 4,000 servers and 45,000 endpoints in ten days. Without a BCP, Maersk closes for two weeks. With one, they ship cargo on paper.

## Key facts

### BCP vs DR vs IRP — the trap CompTIA loves

| Plan | Scope | Triggers | Owner | Question it answers |
|---|---|---|---|---|
| **IRP** (Incident Response Plan) | Cybersecurity incidents specifically | IoCs, alerts, breach | CISO / IR lead | "What do we do about the attack?" |
| **BCP** (Business Continuity Plan) | Keep critical business functions running during *any* disruption | Major outage, disaster, breach | Business continuity officer / COO | "Can we still operate?" |
| **DRP** (Disaster Recovery Plan) | Restore IT systems and data | Same as BCP, IT-side | IT director / infrastructure lead | "When is the real system back?" |

> **CompTIA exam trap:** BCP is **not** the same as DR. DR is a *subset* of BCP focused on IT systems recovery. BCP is the umbrella that includes DR, communications, alternate facilities, manual procedures, and vendor coordination. If the question is about restoring servers and data, that's DR. If the question is about keeping the call center taking calls while the servers are down, that's BCP.

### Where BCP lives in the incident lifecycle

CompTIA / NIST SP 800-61 four phases:

1. **Preparation** — BCP is *written, tested, maintained* here. This is where tabletops happen, where the [[Business Impact Analysis (BIA)]] gets refreshed, where [[Recovery Point Objective (RPO)]] and RTO numbers get argued with the business.
2. **Detection and Analysis** — BCP is not invoked yet; you're still figuring out scope.
3. **Containment, Eradication, and Recovery** — BCP gets *invoked* when impact is large enough. Executive declares BCP active; failover procedures kick in.
4. **Post-incident Activity** — BCP performance is *reviewed*; gaps go into [[Lessons learned]] and feed the next preparation cycle.

### Core BCP components

- **Business Impact Analysis (BIA)** — ranks processes by criticality. Outputs: RTO (how fast must it come back), RPO (how much data can we lose), MTD (maximum tolerable downtime).
- **Recovery strategies** — alternate sites (hot, warm, cold), manual workarounds, vendor agreements, mutual aid.
- **Plan documentation** — roles, contact trees, decision authorities, invocation criteria.
- **Training and awareness** — staff know their role *before* the lights go out.
- **Testing and exercises** — tabletops, walkthroughs, parallel tests, full interruption tests.
- **Maintenance** — review cycle, usually annual or after major change.

### Site types — memorize the recovery cost/speed tradeoff

| Site | Provisioning | Cost | RTO |
|---|---|---|---|
| **Hot** | Fully equipped, live data replication | $$$$ | Minutes to hours |
| **Warm** | Equipped, partial data, needs cutover | $$$ | Hours to a day |
| **Cold** | Empty space with power/HVAC | $ | Days to weeks |
| **Cloud / DRaaS** | On-demand, varies by config | $$–$$$ | Minutes to hours |

> **CompTIA exam trap:** a **hot site** has live replicated data and can take production load almost immediately. A **warm site** has hardware but needs data restored and configuration tuned. A **cold site** is *just a building with power*. If the scenario emphasizes lowest cost and accepts long downtime, cold. If the scenario emphasizes lowest RTO regardless of cost, hot. CompTIA will hide the answer in the RTO requirement.

### Testing — the four levels CompTIA cares about

1. **Tabletop** — talk through the scenario in a conference room. Cheap, no production impact, surfaces gaps in roles and decisions. The IR equivalent of a strat meeting before the raid.
2. **Walkthrough / structured review** — step through the actual playbook documents with stakeholders.
3. **Simulation / parallel test** — bring up the alternate site alongside production, verify it works, do not cut over.
4. **Full interruption** — actually fail over to the alternate site. Highest fidelity, highest risk. Reserved for mature programs.

> **CompTIA exam trap:** tabletops are **preparation** activity, not post-incident. They validate the plan *before* an incident. Lessons learned after a real incident feed the next tabletop scenario. CompTIA will swap "tabletop exercise" and "after-action review" and ask which phase — tabletops are prep, AARs are post-incident.

### What forensic analysis owes BCP

When IR runs [[Forensic analysis]] and [[Root cause analysis]], the BCP team needs answers to specific questions:

- Was data integrity preserved on the alternate site, or did the attacker reach it too?
- How long was the actual outage vs the RTO promise to the business?
- Did manual workarounds introduce compliance gaps (PCI, HIPAA, SOX)?
- Did the BCP invocation criteria fire at the right time, too early, too late?

These answers feed [[Lessons learned]] which feed next year's BCP revision.

## Feynman anchor — the ctOS blackout

In **Watch Dogs**, the ctOS hacks aren't just visual spectacle. When Aiden triggers a blackout in The Loop, the game models the cascade:

- Traffic lights die → cars pile up → emergency services can't get through
- ATMs go offline → cash flow stops → retail can't transact
- The L train halts → workers can't get home → next shift can't get to work
- Cell towers stay up (different infrastructure) → people can still call

The city has a continuity posture baked into how the systems are *separated*. The L runs on a different grid segment than the financial district. The hospitals have generators. The 911 PSAP has UPS and a diesel that runs for 72 hours.

That's BCP architecture. **You don't build resilience by making one thing bulletproof. You build it by ensuring that when one thing dies, the things that depend on it can run degraded, manually, or on a backup, long enough for IT to restore the primary.**

The blue-team version: when ransomware eats your ERP, the warehouse keeps shipping with paper pick lists. When AD goes down, local admin creds on critical workstations let ops continue. When the SIEM is offline, syslog still writes to a separate collector you can grep later.

*The hard lesson: every BCP I've seen that failed in a real incident failed because the "backup" depended on the same thing that was down. The alternate auth depended on AD. The alternate site's data sync depended on the primary's network. The manual workaround required a printer that needed Active Directory to authenticate. Dependency mapping is the BCP. Everything else is documentation.*

## SOC reality

- The BCP lives in a SharePoint folder nobody can find at 2am when ransomware hits. The first IR action after declaring incident is **someone running to find the printed copy** in the war-room binder. If your org doesn't have a printed copy, that's your first lessons-learned bullet.
- The L1 analyst does not invoke BCP. **An executive does** — usually the COO or CISO with explicit authority documented in the plan. Your job is to give them clean scope and impact data so they can make the call.
- The CISO's question at hour two is always **"what's the impact to revenue-generating operations?"** That answer comes from the BIA inside the BCP, not from your SIEM dashboard. Know where to find it.
- Never promise a recovery time you can't hit. **RTO is a contractual commitment**, not a hope. If the BCP says four hours and you're at hour three with no progress, the next call goes to legal and comms, not to "we'll try harder."
- After the incident, the post-mortem will ask **"did we invoke BCP at the right time?"** Invoking too early burns money on alternate sites you didn't need. Invoking too late means the business bled for hours while IT tried to fix it themselves. The invocation criteria in the plan exist to remove that judgment call from the worst moment to be making it.

## Related concepts

[[Disaster Recovery (DR)]] · [[Business Impact Analysis (BIA)]] · [[Recovery Time Objective (RTO)]] · [[Recovery Point Objective (RPO)]] · [[Incident Response Plan (IRP)]] · [[Tabletop exercise]] · [[Lessons learned]] · [[Root cause analysis]] · [[Forensic analysis]] · [[Playbooks]] · [[Preparation phase]] · [[Post-incident activity]] · [[Mean Time to Recovery (MTTR)]]

*Source: VIRGIL knowledge base — 2026-05-11*