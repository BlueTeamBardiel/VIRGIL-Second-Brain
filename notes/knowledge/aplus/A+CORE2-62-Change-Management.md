# Change Management

## What it is

Friday afternoon, 4:55 PM. Someone in networking decides to "just quickly" push a firewall rule change. By 5:15 PM the VPN is down, half the company can't get home email, and the on-call engineer's weekend is cooked. The change worked fine in their head. They didn't tell anyone, didn't test it, didn't have a rollback. There's no record of what they changed, so now troubleshooting starts from zero.

Change management is the immune system that prevents this. It's a formal process: every change to a production system gets documented, reviewed, approved, scheduled, tested, and recorded — before anyone touches anything. Not because IT loves paperwork. Because the alternative is the Friday afternoon story, on repeat, forever.

Technical definition: change management is the structured workflow for proposing, evaluating, approving, implementing, and documenting modifications to production infrastructure, applications, and configurations. Governed by ITIL-derived frameworks in most enterprises, enforced through ticketing platforms (ServiceNow, Jira Service Management, Freshservice), and audited for compliance (SOX, HIPAA, PCI-DSS).

## Why it matters

CompTIA 220-1202 objective 4.2 tests this hard. It's also the single biggest cultural shock for new techs coming from homelab life. At home you reboot the router whenever. At work, rebooting the router requires a ticket, an approval, a maintenance window, and a Slack announcement to 800 people.

Your first IT job will introduce you to the change advisory board (CAB) within your first month. You will either learn to work within it, or you will become the person everyone blames when production breaks. There is no third option.

## At home, at work

**Beat 1 — The vocabulary.** Three change types you must know cold:

| Type | What it is | Approval path |
|---|---|---|
| **Standard** | Pre-approved, low-risk, repeatable (password reset, swapping a known-good NIC, deploying a patched workstation image) | Documented backup plan, no CAB needed |
| **Normal** | New or non-routine, moderate risk (firewall rule change, app version upgrade, new VLAN) | CAB review, sandbox testing required |
| **Emergency** | Production is on fire or about to be (critical CVE patch, expired cert, active outage workaround) | Expedited CAB or emergency approver, named responsible staff |

**Beat 2 — Homelab vs. enterprise.** In your homelab you decide to upgrade Proxmox. You snapshot the VMs, take a backup, run the upgrade, fix what breaks, move on. Total accountability: you. *That's the entire process when nobody else depends on the system.*

Now picture the same upgrade at work, on the hypervisor running 40 production VMs. You file a request form documenting:

- **Purpose of the change** — why we're doing this, what business problem it solves
- **Scope of the change** — exactly which hosts, which VMs, which downstream services
- **Affected systems / impact** — who feels it, for how long, what breaks if it goes wrong
- **Risk analysis** — likelihood × severity, with mitigations
- **Backup plan** — snapshots, config exports, full system backup verified before kickoff
- **Rollback plan** — concrete steps to undo within the maintenance window if it goes sideways
- **Sandbox testing** — proof it worked in a non-prod environment first
- **Date and time of change** — inside an approved maintenance window
- **Responsible staff members** — primary engineer, backup engineer, approver
- **Peer review** — another engineer signs off on the plan before CAB sees it
- **End-user acceptance** — post-change validation that stakeholders confirm the system works

*Same upgrade. Different universe of accountability.*

**Beat 3 — Maintenance windows and change freezes.** Production changes happen inside scheduled maintenance windows — typically late nights, weekends, or quarterly outage windows announced weeks in advance. Outside that window, you don't touch production unless it's an emergency change.

**Change freezes** are blackout periods where no changes are allowed at all. Retail freezes the entire stack from Black Friday through January. Financial firms freeze around quarter-end close. Healthcare freezes around open enrollment. If your ticket lands during a freeze, it waits — unless it's an emergency with executive approval.

**Beat 4 — The point.** Same fundamental question across every environment: *who breaks if this goes wrong, and what's the plan when it does?* In the homelab, the answer is "me, and I'll figure it out." In the enterprise, the answer is documented, reviewed, approved, and signed before you log into the production box. Get this question into your bones — you'll ask it for the rest of your career.

## Key facts

### The CAB (Change Advisory Board)

A standing committee that reviews normal changes weekly (sometimes daily). Members: senior engineers from each infrastructure team, security, application owners, sometimes business stakeholders. They evaluate risk, check for conflicts with other planned changes, and approve or reject. **A change without CAB approval is an unauthorized change**, and unauthorized changes are how techs get fired.

### Required artifacts on every request form

- Purpose, scope, impact
- Risk level and risk analysis
- Implementation steps (numbered, specific, copy-pasteable commands where applicable)
- Backup plan (what was backed up, where, verified by whom)
- Rollback plan (concrete undo procedure with time estimate)
- Test plan and sandbox results
- Maintenance window
- Responsible staff and approver names
- Post-change validation / end-user acceptance criteria

### CompTIA exam traps

> **CompTIA exam trap:** confusing "backup plan" with "rollback plan." Backup plan = the data/config snapshot you take *before* the change. Rollback plan = the *procedure* to revert *if* the change fails. CompTIA tests these as separate concepts.

> **CompTIA exam trap:** emergency change does not mean "skip change management." It means expedited approval with named responsible staff and post-implementation documentation. The paperwork still happens — just on a compressed timeline, often after the fact.

> **CompTIA exam trap:** standard change ≠ no documentation. Standard means pre-approved because the change type is repeatable and low-risk. The backup plan and procedure are documented once and reused. Every individual execution still gets a ticket.

## AI tools as tickets and triage helpers

Change request forms are repetitive prose. You'll write hundreds of them. Company-approved AI tools (Microsoft Copilot, ServiceNow Now Assist, internally-deployed models cleared by your security team) are legitimate accelerators here:

- **Stitching call notes into a request form.** You're on a Teams call with the app owner explaining what they need changed. Type fragments — keywords, version numbers, system names. After the call, paste the notes into the approved AI and ask it to draft purpose, scope, and impact sections in your company's format. You review, edit, file.
- **Drafting rollback procedures.** Describe what the change does; ask the AI to draft a reverse-order rollback procedure. You verify every step against actual system behavior before submitting.

**Hard rule:** never paste production hostnames, IPs, credentials, customer data, or internal architecture diagrams into a tool that hasn't been approved by your company's security team. Change request data often contains sensitive infrastructure detail — exactly the stuff that becomes a breach disclosure if it leaks. CompTIA 220-1202 objective 4.6 (privacy, licensing, policies) tests this directly.

**Tool, not crutch:** AI drafts the prose; you own the technical accuracy and the consequences.

## Helpdesk reality

- "Can you just do it real quick?" — No. Even a password reset on a service account is a change. File the ticket.
- "It's only a small change." — Small changes cause big outages because nobody tested them. *The size of the change is not the size of the blast radius.*
- "Production is down, do I still need a ticket?" — Yes. It's an emergency change. Fix the fire, then document everything within 24 hours. The ticket exists so the post-mortem has a paper trail.
- "We're in a change freeze but my manager said it's fine." — Get it in writing. A Slack screenshot is not "in writing." An email or a CAB exception ticket is.
- "I'll just SSH in and tweak it." — That's how you become the cautionary tale at the next team onboarding. *Unauthorized changes are career-limiting events.*

## Related concepts

[[Ticketing Systems]] · [[Documentation and SOPs]] · [[Incident Response]] · [[Backups and Recovery]] · [[Patch Management]] · [[Maintenance Windows]] · [[Risk Management]]

*Source: VIRGIL knowledge base — 2026-05-11*