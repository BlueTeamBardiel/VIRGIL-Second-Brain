# Security Procedures

## What it is

In Breath of the Wild, before Link enters a Divine Beast, there's a ritual: stock elixirs, equip cold-resistant gear, save the game, talk to the Sheikah at the tower, then ride the elevator up. Skip a step and you're freezing to death on Vah Medoh's wing with no fairies left. That's exactly what **security procedures** are — written, repeatable steps that humans follow so the predictable parts of security don't fail because someone forgot the cold-resistant doublet.

A **security procedure** is a documented, step-by-step sequence of actions that operationalizes a security policy into specific, repeatable tasks for a defined scenario.

## Why it matters

Procedures are where governance meets reality. A policy says "we onboard users securely"; a procedure says "Step 4: ticket assigns role from RBAC matrix; Step 5: MFA enrolled before first login." Without procedures, every analyst improvises, evidence chains break, breaches go unreported within regulatory windows (GDPR's 72 hours, for instance), and audits fail.

**Exam angle:** SY0-701 Objective 5.1 explicitly lists **change management**, **onboarding/offboarding**, and **playbooks** as procedures the candidate must distinguish from policies, standards, and guidelines. CompTIA's favorite trap: presenting a scenario and asking whether the missing artifact is a *policy* (the "what/why"), a *procedure* (the "how, step-by-step"), a *standard* (mandatory specifications), or a *guideline* (recommendations). Procedure = ordered steps. Memorize that.

## Key facts

### The governance hierarchy

| Layer | Purpose | Example |
|---|---|---|
| [[Policy]] | High-level intent, mandatory | "All access must be authenticated and authorized" |
| [[Standard]] | Specific mandatory requirements | "Passwords ≥ 14 chars, MFA via TOTP or FIDO2" |
| [[Procedure]] | Step-by-step how-to | "1. Submit ticket. 2. Manager approves. 3. IAM provisions..." |
| [[Guideline]] | Recommended best practice | "Consider using a password manager" |

### Core procedures on the SY0-701 blueprint

- **[[Change Management]]** — Formal process for modifying production systems. Components: **request**, **impact analysis**, **[[CAB|Change Advisory Board]]** approval, **scheduled maintenance window**, **[[backout plan]]**, **post-implementation review**. Tracks **stakeholders**, **ownership**, **test results**, **dependencies**, **standard operating procedures (SOPs)**, and **technical implications** (downtime, restarts, legacy systems, allow/deny lists). Trap: CompTIA loves "what document lets you undo a failed change?" → **backout plan**.
- **[[Onboarding]]** — NDA signing, background check verification, account provisioning via [[RBAC]], asset issuance, security awareness training, MFA enrollment.
- **[[Offboarding]]** — Account disablement (not deletion — preserve for forensics/legal hold), credential revocation, [[asset return]], knowledge transfer, exit interview, [[NDA]] reminder.
- **[[Playbook]]** — Procedural runbook for a specific scenario, especially [[incident response]] (ransomware playbook, phishing playbook, DDoS playbook). Often automated via [[SOAR]].
- **[[Incident Response Plan]]** — Procedural arm of IR: Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned.

### Change management: what CompTIA wants you to know

| Element | What it does |
|---|---|
| **Approval process** | Authorization gate; usually CAB |
| **Ownership** | Who is accountable for the change |
| **Stakeholders** | Who needs to be informed |
| **Impact analysis** | What this breaks if it goes wrong |
| **Test results** | Proof it works in non-prod |
| **Backout plan** | The "Ctrl-Z" if production melts |
| **Maintenance window** | When the change happens |
| **SOP** | The repeatable script for routine changes |

### Technical implications of changes

**Allow/deny lists**, **restricted activities**, **downtime**, **service/application restarts**, **legacy applications**, **dependencies**, and **documentation updates** (diagrams, policies, version control). Forgetting to update the network diagram after a firewall change is exactly the kind of thing that fails an audit two years later.

### Procedures vs. ad-hoc response

Without procedures: tribal knowledge, inconsistent execution, single-points-of-human-failure, audit findings, regulatory penalties. With procedures: repeatability, evidence trails, faster MTTR, training material for new hires, defensibility in court.

## Related concepts

[[Change Management]] · [[Playbook]] · [[Incident Response]] · [[Onboarding]] · [[Offboarding]] · [[CAB]] · [[Backout Plan]] · [[Standard Operating Procedure]] · [[SOAR]] · [[Governance]] · [[Policy]] · [[Standard]] · [[Guideline]] · [[RBAC]] · [[Separation of Duties]]

---
*Source: VIRGIL knowledge base — 2026-05-08*