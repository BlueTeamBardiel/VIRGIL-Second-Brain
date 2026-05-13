# Security Best Practices

Wait. The topic slug says "Security Best Practices" but the objective is 4.1 — documentation and support systems information management. That's the ticketing/asset/documentation note. Writing to the objective, not the mislabeled slug.

## What it is

The first time you built a PC, you knew where every part came from. Receipts in a folder, serial numbers in your head, "the 3600X is in the gaming rig, the 5700X is in the Plex box." One brain, three machines, no problem.

Now imagine 4,000 machines. 600 employees. Forty-seven different software licenses. A help desk that takes 200 tickets a day. The brain doesn't scale. Documentation does.

In plain English: when an org gets big enough that nobody can hold the whole picture in their head, the picture has to live in systems — ticketing for "what's broken right now," asset management for "what do we own and where is it," and documentation for "how do we do the thing." That trio is the nervous system of an IT department.

Technical definition: **support systems information management** is the practice of capturing, organizing, and retrieving operational knowledge across three pillars: a **ticketing system** (work queue), an **asset/configuration management database** (inventory and relationships), and a **document library** (procedures, KBs, reports). CompTIA tests whether you can name the artifacts and use them correctly.

## Why it matters

Your first IT job lives inside these systems. You will not write code on day one. You will not configure a firewall on day one. You will open a ticket, look up a user's assigned asset, read the KB article for the symptom, follow the SOP, document what you did, and close the ticket. Repeat 30 times a day.

The techs who get promoted are the ones whose tickets read like detective reports — clear symptom, clear theory, clear test, clear fix, clear verification. The techs who get stuck at tier 1 are the ones who close tickets with "fixed it."

CompTIA 220-1202 objective 4.1 tests artifact names (SOP vs KB vs incident report), asset lifecycle stages, SLA mechanics, and the difference between a ticket and a CMDB record. This shows up as scenario questions: "a user reports X — which document do you create/consult?"

## At home, at work

**Beat 1 — what these systems actually contain.**

A **ticket** has: issue description (user's words), categories (hardware/software/network/access), severity (P1 outage → P4 request), assigned user (the affected employee), assigned tech (you), device information (which laptop), progress notes (every action timestamped), and resolution. SLAs attach to severity — P1 might be "respond in 15 minutes, resolve in 4 hours."

A **CMDB** (configuration management database) holds device records: asset tag, serial, model, purchase date, warranty expiration, assigned user, installed software, license keys, location, and relationships ("this VM runs on that host, which sits in that rack"). Asset management is the lifecycle layer on top — procurement → deployment → maintenance → retirement → disposal.

**Documents** come in flavors: **SOPs** (how to do a repeatable task — "how to image a laptop"), **knowledge base articles** (symptom → resolution, written for fast lookup), **incident reports** (what happened during an outage or security event, written for after-action), **onboarding/offboarding checklists** (every step from "create AD account" to "ship the laptop"), and **external/third-party docs** (vendor manuals, contracts, license agreements).

**Beat 2 — Feynman via your homelab.**

You run a homelab. Three machines: gaming rig, Plex server, pfSense box. Pretend you're its only sysadmin and walk the layers.

**Ticket equivalent:** Plex stops transcoding at 9pm. You open a note in Obsidian: *"9:02pm — Plex buffering on living room TV. Other clients fine. CPU at 100%."* That's an issue description with a timestamp. *Without the timestamp and the symptom in writing, you'll forget what you saw by tomorrow.*

**CMDB equivalent:** A spreadsheet — three rows, columns for hostname, IP, OS version, CPU, RAM, drives, warranty (lol), "what runs on it." When the Plex box dies in 18 months, that row tells you what to rebuild. *The spreadsheet you didn't make is the one you'll regret at 2am.*

**SOP equivalent:** You wrote "How I reinstall pfSense" after the second time you did it from memory and forgot the VLAN config. Now it's a checklist. *You write the SOP the third time you do the thing — never the first.*

**KB equivalent:** A note titled "Plex transcoding 100% CPU — fix: force direct play in client settings." Six months later when it happens again, you search "transcoding" and find the answer in 4 seconds. *The KB is a letter to your future self.*

**Beat 3 — bridge to enterprise.**

Same artifacts, different scale and rigor.

The Obsidian note becomes **ServiceNow** or **Freshservice** or **Jira Service Management** — a queue your manager watches, with SLA timers ticking. The issue description is written by the user (badly), and your first job is restating it clearly in the progress notes.

The spreadsheet becomes a **CMDB** with thousands of CIs (configuration items), automated discovery scanning the network, integration with Active Directory pulling assigned users, and warranty data piped in from Dell's API. Asset tags are physical barcodes stuck on every laptop. When a laptop walks out the door, the offboarding checklist hits the CMDB and flags the asset for recovery.

The SOP folder becomes a **Confluence** or **SharePoint** library with version control, approval workflows, and review dates. The KB is searchable by every tier-1 tech, with article hit-counts telling you which problems are recurring (a hint that you should fix the root cause instead of documenting the workaround forever).

Incident reports become formal post-mortems with a template: timeline, impact, root cause, remediation, lessons learned. Compliance auditors read them.

**Beat 4 — the point.**

The artifacts are the same from your homelab to a 50,000-seat enterprise. *What scales is the discipline of writing things down before you forget them.* Get this habit into your bones now — in your homelab, with your three machines — and you will be the tech who gets promoted. The ones who try to hold it all in their head get buried by month three.

## Key facts

### Ticketing system anatomy

| Field | What goes here | Why it matters |
|---|---|---|
| Issue description | User's reported symptom, in clear language | Drives the entire diagnostic path |
| Categories | Hardware / software / network / access / facilities | Routes to the right team, drives metrics |
| Severity | P1 (outage) → P4 (request) | Drives SLA timer and escalation |
| Assigned users | The affected employee(s) | Who you call/email |
| Device information | Asset tag, hostname, model | Links ticket to CMDB |
| Progress notes | Timestamped log of every action | Audit trail, handoff record |
| Escalation level | Tier 1 / 2 / 3 / vendor | Who owns it now |
| Resolution | What fixed it, in plain English | Feeds the KB |

### Severity and SLA tiers (typical internal SLA)

| Severity | Definition | Response | Resolution |
|---|---|---|---|
| P1 / Critical | Business-stopping outage, multiple users | 15 min | 4 hours |
| P2 / High | Major function broken, single user blocked | 1 hour | 8 hours |
| P3 / Medium | Workaround exists, productivity impacted | 4 hours | 2 business days |
| P4 / Low | Request, question, cosmetic | 1 business day | 5 business days |

Internal SLAs are between IT and the rest of the business. External SLAs are between your company and a vendor (your cloud provider owes you 99.9% uptime). Know which one you're talking about.

### Asset management lifecycle

1. **Procurement** — purchase request, PO, vendor delivery, receiving
2. **Onboarding/setup** — asset tag applied, CMDB record created, image deployed, software installed, assigned to user
3. **Active use** — patches, maintenance, ticket history accumulates against the asset
4. **Warranty and licensing tracking** — when does Dell's NBD warranty expire, when does the Adobe license renew
5. **Reassignment** — employee leaves, asset wiped, reissued to new user, CMDB updated
6. **Retirement/disposal** — secure wipe (NIST 800-88), certificate of destruction for drives, e-waste vendor pickup, CMDB record archived

### CMDB record minimum fields

- Asset tag and serial number
- Make, model, specifications
- Purchase date and warranty expiration
- Assigned user and location
- Installed OS and version
- Installed software and license keys
- Relationships (this VM → that host → that cluster)
- Lifecycle state (active / spare / retired / disposed)

### Document types — what goes where

| Document | Purpose | Audience | Format |
|---|---|---|---|
| **SOP** | Repeatable procedure ("how to image a laptop") | Internal techs | Numbered steps, screenshots, owner, review date |
| **KB article** | Symptom → resolution, fast lookup | Techs and sometimes users | Problem statement, environment, solution, related articles |
| **Incident report** | After-action for outages or security events | Management, compliance | Timeline, impact, root cause, remediation, lessons |
| **New user onboarding checklist** | Every step to provision a new hire | HR + IT | AD account, email, MFA enrollment, hardware issue, software, building access |
| **Offboarding checklist** | Every step to deprovision | HR + IT + Security | Disable accounts, revoke MFA, collect hardware, wipe device, archive mailbox |
| **External/third-party docs** | Vendor manuals, contracts, EULAs | Reference | Stored alongside related assets |

### Writing rules

- **Clear, concise written communication.** No jargon the next tech won't recognize. No "fixed it." Write what you saw, what you tested, what you changed, what you verified.
- **Timestamp everything.** Progress notes without timestamps are worthless during a post-mortem.
- **Past tense, third person.** "User reported X. Tech verified Y. Issue resolved by Z." Not "I think it was probably..."
- **Link the artifacts.** Ticket references the CMDB asset. KB article references the SOP. Incident report references the tickets it spawned.

### CompTIA exam traps

> **CompTIA exam trap:** SOP vs KB article. SOPs are **procedures** ("how to do task X") written for the tech who's about to do the task. KB articles are **symptom-to-resolution** entries written for the tech triaging a complaint. Same library, different purpose. CompTIA will give you a scenario and ask which artifact applies.

> **CompTIA exam trap:** CMDB vs asset management. The **CMDB** is the database of configuration items and their relationships. **Asset management** is the lifecycle process (procure → deploy → maintain → retire) that operates on those records. CMDB is the noun; asset management is the verb.

> **CompTIA exam trap:** Internal SLA vs external SLA. Internal = IT-to-business commitment (we'll resolve P1s in 4 hours). External = vendor-to-company commitment (AWS owes us 99.99%). Scenario questions will mix the two — read carefully.

> **CompTIA exam trap:** Incident report ≠ ticket. A ticket is the unit of work. An incident report is the after-action document summarizing a significant event, often spanning many tickets. Security incidents specifically may have legal/regulatory reporting requirements.

## Helpdesk reality

- *"Just fix it, don't write a novel."* — Write the novel anyway. The next tech (or future you, at 2am) needs the progress notes. Two sentences with timestamps beat zero sentences every time.
- *"It's the same problem as last week."* — Search the KB before you start troubleshooting. If the article exists, follow it and add a note if anything changed. If it doesn't, write it after you resolve the ticket.
- *"Why does onboarding take a week?"* — Because the checklist has 30 items across HR, IT, security, and facilities. Show the user the checklist; they stop asking.
- *"I lost my laptop."* — That's a CMDB update, a security ticket (was it encrypted? remote wipe), an asset write-off, and possibly an incident report. One sentence from the user, four artifacts from you.
- Never paste user PII, credentials, or sensitive screenshots into an AI tool that isn't on your company's approved list. Use approved tools (Microsoft Copilot, ServiceNow Now Assist) to **stitch your rough notes into clean ticket prose** — not to think for you.

## Related concepts

[[Ticketing Systems]] · [[Change Management]] · [[Asset Disposal and Data Destruction]] · [[Incident Response]] · [[Knowledge Base Management]] · [[Onboarding and Offboarding]] · [[Service Level Agreements]] · [[Configuration Management]]

*Source: VIRGIL knowledge base — 2026-05-11*