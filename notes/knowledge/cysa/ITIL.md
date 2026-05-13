# ITIL — Information Technology Infrastructure Library

## What it is

In **Mass Effect**, the Normandy doesn't run on Shepard's vibes. Joker flies, Adams keeps the drive core from melting, Chakwas patches up the squad, Pressly routes the requisitions, and the Council sets the rules of engagement for Spectres. Every system has an owner, every change goes through a process, and when the Reapers show up, nobody is improvising who fixes the eezo core. That's exactly what **ITIL** does — it's the rulebook that says who owns what, how change gets approved, and what "service" actually means inside an IT organization.

**ITIL (Information Technology Infrastructure Library)** is a framework of best practices for **IT Service Management (ITSM)** — owned by AXELOS, currently at ITIL 4. It defines how IT delivers value through structured practices: incident management, problem management, change enablement, release management, configuration management, service-level management. For CySA+, ITIL is the **managerial control** layer behind vulnerability response — the reason your critical patch waits two weeks for the next maintenance window, and the reason that's sometimes the right answer.

## Why it matters

ITIL sits in CySA+ Objective 2.5 under **policies, governance, and service-level objectives**. CompTIA wants you to know vulnerability management doesn't happen in a vacuum — there's a Change Advisory Board (CAB), an SLA, and an SLO that dictate when and how you're allowed to act.

In the real SOC, ITIL is what the change board uses to tell you "no, you can't push that emergency patch to the payment processor on a Friday afternoon." It's also what gives you the *exception process* when CVSS 9.8 hits a system the CAB won't let you touch. Pass the exam, then survive your first change-board meeting.

## Key facts

### ITIL 4 practices that matter for CySA+

| Practice | What it does | CySA+ relevance |
|---|---|---|
| **Incident management** | Restore service ASAP | IR phase: Containment & Recovery |
| **Problem management** | Find root cause of recurring incidents | Post-incident / lessons learned |
| **Change enablement** | Approve, schedule, roll back changes | Patching, maintenance windows |
| **Release management** | Deploy approved changes | Patch deployment, SDLC handoff |
| **Configuration management** | Track CIs in the CMDB | Asset inventory, attack surface |
| **Service level management** | Define and measure SLAs/SLOs/SLIs | Remediation deadlines, MTTR |
| **Information security management** | The security practice itself | Your job, formally |

### Incident vs problem — CompTIA loves this distinction

- **Incident** = unplanned interruption in service. *The web server is down.*
- **Problem** = the underlying cause. *The load balancer has a memory leak that triggers every 72 hours.*

Restore service first (incident management), then dig for root cause (problem management). SOC equivalent: contain the breach, then run the post-incident review to find out why your EDR missed it three times.

### Change types — the CAB will quiz you

| Type | Definition | Example |
|---|---|---|
| **Standard** | Pre-approved, low-risk, repeatable | Routine OS patches in maintenance window |
| **Normal** | Goes through CAB review and scheduling | Firewall rule change, new app deploy |
| **Emergency** | Bypasses normal scheduling, expedited CAB | Zero-day patch, active incident response |

**Emergency Change Advisory Board (ECAB)** is the smaller, faster subset that approves emergency changes outside business hours — the people you wake up when CISA drops an advisory at 11pm.

### SLA vs SLO vs SLI

- **SLA (Service Level Agreement)** — contractual, between provider and customer. *"99.9% uptime or you get a credit."*
- **SLO (Service Level Objective)** — internal target the team commits to. *"Critical vulns patched within 7 days."*
- **SLI (Service Level Indicator)** — the actual measurement. *"Last quarter we patched 92% of criticals within 7 days."*

For vulnerability management, the SLO dictates your patch deadlines. CVSS 9.0+ might be 7 days; 7.0–8.9 might be 30 days; lower might be 90. Miss the SLO, you owe an explanation.

### Risk treatment — the four options

| Treatment | What it means | Vuln management example |
|---|---|---|
| **Mitigate** | Apply controls to reduce risk | Patch the CVE |
| **Transfer** | Shift risk to another party | Cyber insurance, third-party SaaS contract |
| **Avoid** | Stop doing the risky activity | Decommission the vulnerable legacy app |
| **Accept** | Acknowledge and live with it | Document the exception, monitor, move on |

**Transfer doesn't make risk disappear.** Insurance pays the bill; it does not unbreach you. Residual risk still owns you.

### Compensating controls and exceptions

When you can't patch — vendor hasn't released a fix, system is too brittle, CAB said no — you do not get to ignore the risk.

- **Compensating control** — alternative measure that achieves the same security objective. Can't patch the vulnerable web app? Put a WAF in front with virtual patching rules. Can't disable SMBv1? Segment it to a VLAN only one application can reach.
- **Exception** — formal documentation of risk, approver, compensating control, review date, owner. Exceptions have **expiration dates**. Not "accept and forget."

### Control types — the CySA+ matrix

| By function | By nature |
|---|---|
| **Preventative** — stop the event (firewall, MFA) | **Managerial** — policies, ITIL itself |
| **Detective** — find the event (SIEM, IDS) | **Operational** — executed by people (training, IR procedures) |
| **Corrective** — fix after the event (patching, restore) | **Technical** — implemented by tech (EDR, encryption, WAF) |
| **Responsive** — act during the event (containment) | |

ITIL change enablement is a **managerial** control. Patching is **corrective** and **technical**. The maintenance window is **operational**.

### Patching lifecycle under ITIL

1. **Vulnerability identified** (scan, threat intel, bug bounty)
2. **Risk-rated** against the SLO
3. **Change request filed** (standard, normal, or emergency)
4. **CAB review** (skipped for standard, expedited for emergency)
5. **Test in lower environment**
6. **Deployed in maintenance window**
7. **Validated in production**
8. **Rollback plan ready** — every change request must specify the rollback before approval

*If you don't have a rollback plan, you don't have a change — you have a hope.*

### Prioritization and escalation

- **Functional escalation** — kicks the ticket up a tier (L1 → L2 → L3 → IR team)
- **Hierarchical escalation** — kicks it up the management chain (analyst → SOC manager → CISO → CIO)

CySA+ prioritization combines **CVSS score, asset criticality, exploitability, and exposure**. ITIL ensures there's a documented path so it doesn't depend on who's on Slack.

### CompTIA exam traps

> **CompTIA exam trap:** An **incident** is the disruption; a **problem** is the cause. CompTIA will give you a scenario where service is restored but the cause is unknown — that's where problem management takes over.

> **CompTIA exam trap:** **Transfer** is not **avoid**. Cyber insurance is transfer (risk still happens, someone else pays). Decommissioning the vulnerable system is avoid (the risky activity stops entirely).

> **CompTIA exam trap:** A **compensating control** is not a replacement for the original requirement — it's an alternative that achieves the same control objective when the original isn't feasible. Often paired with a time-limited **exception**.

> **CompTIA exam trap:** **SLA vs SLO** — SLA is the external contract with penalties. SLO is the internal target. The remediation deadline is the **SLO** unless the contract bakes it in.

> **CompTIA exam trap:** **Standard change** is pre-approved and does not go to the CAB each time. CompTIA will offer "submit to CAB" as the answer for a routine OS patch — wrong if it's already classified as standard.

## SOC reality

- The alert fires at 2am for a critical CVE on the customer-facing payment app. You can't push the patch — there's a change freeze for quarterly close. You file an **emergency change**, page the ECAB, and put a **WAF virtual patch** in place as the compensating control while waiting on approval.
- Your SOC manager doesn't ask "did you patch it?" They ask **"what's the SLO, where are we against it, and what's the compensating control?"** That's ITIL-speak. Learn to answer in that language.
- The change board will reject your patch. Not because they're wrong — because the last time IT pushed an unscheduled patch, billing went down for six hours. **Their job is to remember that. Your job is to bring a tested rollback plan.**
- Never tell leadership "we're patched" until **validation** is complete — scan re-run, exploit attempt fails, monitoring clean. "Deployed" is not "remediated."
- Exceptions accumulate. Every quarter, pull the exception register, check expirations, force a re-review. *The exception filed two years ago for "temporary" RDP exposure is how the ransomware got in.*

## Related concepts

[[Change management]] · [[CAB — Change Advisory Board]] · [[SLA]] · [[SLO]] · [[SLI]] · [[CMDB]] · [[Risk treatment options]] · [[Compensating controls]] · [[Exceptions]] · [[Maintenance windows]] · [[Rollback procedures]] · [[Patching cadence]] · [[Incident management]] · [[Problem management]] · [[NIST SP 800-61]] · [[CVSS]] · [[Attack surface management]] · [[Secure SDLC]] · [[Control types]]

*Source: VIRGIL knowledge base — 2026-05-11*