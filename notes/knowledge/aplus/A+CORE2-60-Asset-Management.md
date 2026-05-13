# Asset Management

## What it is

Every gaming PC you've ever built came with a pile of receipts, serial numbers, warranty cards, and license keys. Most people throw them in a drawer. Then the GPU dies in month 14, and you spend an hour digging through email trying to find the order confirmation to file an RMA. You had the data. You just didn't track it.

Asset management is that drawer, but disciplined. It's the practice of knowing what hardware and software you own, where it is, who's using it, when it was bought, when the warranty expires, and when it's supposed to die. Plain English: a list of every machine, peripheral, and license, with enough context to make decisions about them. Technical: a structured inventory — usually a database — that tracks the full lifecycle of every IT asset from procurement to disposal, often joined to a **CMDB** (Configuration Management Database) that records how those assets are configured and how they relate to each other.

The asset list answers *what do we own*. The CMDB answers *how is it set up and what does it depend on*. Mature shops run both, linked.

## Why it matters

You cannot secure, patch, or budget for what you don't know exists. Asset management is the foundation under every other IT discipline — vulnerability management, license compliance, incident response, capital planning. When a CVE drops for a specific Dell BIOS revision, the first question is "how many of those do we have and where?" If you can't answer in under five minutes, you don't have asset management. You have a drawer.

Tested on **220-1202 Objective 4.1** alongside ticketing systems and documentation types. CompTIA folds CMDB, asset tags, procurement lifecycle, warranty tracking, and onboarding/offboarding checklists under this single umbrella because in the field they all live in the same tool.

## In your build, in the enterprise

**Beat 1 — what's actually tracked.** An asset record is more than "Dell laptop, serial XYZ." Real records carry: asset tag (the sticker), serial number, make/model, assigned user, location, purchase date, purchase order, vendor, warranty expiration, license keys tied to it, current OS and patch level, MAC address, and lifecycle state (in stock / deployed / in repair / retired). The CMDB extends that with configuration items (CIs) and relationships — "this VM runs on that host, which sits in that rack, which feeds that app, which the finance team depends on." Asset tags are usually barcoded or QR-coded stickers with an internal ID; the ID is the join key across every other system.

**Beat 2 — your homelab, your drawer of receipts.** You built a gaming rig and a homelab. Track them like an adult.

**The spreadsheet:** One row per device. Hostname, MAC, IP reservation, CPU, RAM, storage, GPU, PSU wattage, motherboard, purchase dates per component, warranty end dates. *When the 7800X3D throws WHEA errors in month 10, you know it's still under AMD warranty without digging through Gmail.*

**The license vault:** Windows keys, game launcher tokens, Plex Pass, Proxmox subscription, domain registrations, the Office license your cousin gave you. Bitwarden or a password manager with a "licenses" folder works. *The day you reinstall Windows on a fresh NVMe at 11pm, you'll thank yourself.*

**The config notes:** Per-VM notes in Proxmox or a markdown file. What this VM does, what depends on it, what its static IP is, what ports it exposes. *That's a baby CMDB. You already think this way; the enterprise just scales it.*

**The kicker:** Three months in, you'll skip an update to the spreadsheet. Six months in, it's stale. *Asset management isn't a project, it's a habit. Tooling that makes updates automatic beats discipline every time.*

**Beat 3 — bridge to the enterprise.** Same question — *what do I own and how is it set up?* — different scale. Your homelab has 6 devices. A mid-size company has 4,000 endpoints, 200 servers, 800 SaaS licenses, and a rack of network gear in three sites. The spreadsheet doesn't survive contact with that. Enterprises run dedicated platforms — **ServiceNow**, **Lansweeper**, **Snipe-IT**, **Jamf** for Mac fleets, **Intune/SCCM** for Windows — that auto-discover devices on the network, pull config data via agents, and write everything into a CMDB. Procurement flows through purchase orders that auto-create asset records on receipt. Onboarding tickets pull a laptop from "in stock" and assign it to a user. Offboarding tickets flip it to "returned, awaiting wipe." Warranty data syncs from the vendor (Dell, HP, Lenovo all offer warranty APIs). Software licenses are reconciled against installed software by the agent, and finance gets a quarterly report on what's overprovisioned.

**Beat 4 — the point.** Same fundamental question, vastly different tooling. Get this into your bones: every asset has a lifecycle (procure → deploy → maintain → retire → dispose), every asset has an owner, every asset has a cost. You'll work tickets for the rest of your career that begin and end in the asset database. *Master the asset record and you've mastered half of operations.*

## Key facts

### The procurement lifecycle

Six stages CompTIA expects you to recognize:

| Stage | What happens |
|---|---|
| **Request** | User or manager submits a ticket for new hardware/software |
| **Approval** | Manager and finance sign off; budget allocated |
| **Procurement** | Purchase order issued to vendor; asset ordered |
| **Receipt & tagging** | Asset arrives, gets an asset tag, record created in the asset DB |
| **Deployment** | Imaged, configured, assigned to user, joined to domain/MDM |
| **Retirement/disposal** | End of life — wiped, recycled, or destroyed per policy; record marked retired |

### Asset tags and IDs

A physical sticker (usually barcoded) with a unique internal ID. Slapped on the chassis in a consistent location — top of the laptop palm rest, back of the monitor, side of the desktop tower. The ID is the canonical reference across the asset DB, the ticketing system, and the CMDB. Serial numbers are the manufacturer's ID; asset tags are yours. Both get tracked. *If you walk into a server room and the racks don't have asset tags, that shop has problems you haven't found yet.*

### CMDB (Configuration Management Database)

A database of **configuration items (CIs)** and their **relationships**. A CI can be a server, a VM, an application, a database, a network switch, even a business service. Relationships capture dependencies: "Payroll app depends on SQL server PAY-DB-01, which runs on host ESX-04, which connects to switch CORE-SW-02." When CORE-SW-02 needs a firmware update, the change window is calculated from the downstream impact. The CMDB is what makes change management possible at scale.

### Onboarding and offboarding checklists

Standard operating procedures (SOPs) for the most common ticket types in IT.

**New user / onboarding checklist:**
- AD/Entra account created, group memberships assigned
- Laptop pulled from stock, imaged, asset record assigned to user
- Email mailbox provisioned, MFA enrolled
- Software licenses assigned (Office, line-of-business apps)
- Phone/softphone provisioned
- Day-one welcome ticket with credentials delivered securely

**User offboarding checklist:**
- Account disabled (not deleted — legal hold)
- Mailbox converted to shared or forwarded to manager
- Laptop returned, wiped, asset flipped to "in stock"
- Licenses reclaimed
- Building access revoked, badge collected
- Manager confirms data handoff

These checklists exist because skipping a step is how a fired employee still has VPN access three months later.

### Warranty and licensing

Warranty data lives on the asset record. Two reasons: RMA eligibility, and replacement planning. If 200 laptops fall out of warranty in Q3, finance needs to know in Q1. Licensing tracks per-seat software entitlements — Microsoft 365, Adobe, AutoCAD, security tools — against actual installed count. Overprovisioning wastes money; underprovisioning is a compliance and audit problem. **License true-ups** happen annually with most vendors.

### SLAs (Service-Level Agreements)

Internal SLAs define how fast tickets must be resolved by severity. They tie into asset management because **severity is often driven by asset criticality** — a CEO laptop is a higher-severity ticket than an intern's monitor. The CMDB tags assets with criticality so the ticketing system can auto-prioritize.

| Severity | Typical response / resolution |
|---|---|
| **Sev 1 — Critical** | 15 min response / 4 hr resolution. Production down, multiple users impacted. |
| **Sev 2 — High** | 1 hr / 8 hr. Single critical user or degraded service. |
| **Sev 3 — Medium** | 4 hr / 2 business days. Standard request, single user. |
| **Sev 4 — Low** | Next business day / 5 days. Cosmetic or scheduled work. |

### Types of documents you'll write

| Document | Purpose |
|---|---|
| **SOP (Standard Operating Procedure)** | Step-by-step for a repeated task: image a laptop, onboard a user, install a software package. Anyone on the team can execute it. |
| **KB article (Knowledge Base)** | Issue + resolution. Internal-facing for techs, or external-facing for users. The currency of L1 support. |
| **Incident report** | Post-incident: what happened, timeline, root cause, remediation, lessons. For outages and security events. |
| **Software install procedure** | Custom package deployment steps, used by automation tools (Intune, SCCM, Jamf). |
| **External / third-party documentation** | Vendor docs, integration guides, contracts. Referenced, not authored. |
| **Progress notes** | Running updates inside a ticket — what you tried, what worked, what didn't. The next tech reads these. |

### CompTIA exam traps

> **CompTIA exam trap:** Asset management vs. CMDB. Asset management tracks *what you own and its lifecycle* (financial, procurement, warranty). CMDB tracks *how it's configured and what it depends on* (technical, relational). They overlap and are often in the same platform, but CompTIA can test them as distinct concepts.

> **CompTIA exam trap:** Asset tag vs. serial number. Asset tag is internal (you assign it). Serial number is from the manufacturer. Both are tracked; they are not the same field.

> **CompTIA exam trap:** Onboarding/offboarding checklists are SOPs, not KB articles. SOPs are for repeated internal procedures. KB articles are for resolving specific issues. Easy to confuse on a question.

## Helpdesk reality

- **"Can you just get me a new laptop?"** — Pulling stock means a procurement ticket, asset assignment, image, and AD work. Set the expectation: same day if stock exists, 5–10 business days if it has to be ordered. Never promise "tomorrow" without checking stock.
- **"I lost my laptop."** — Pull up the asset record. Note the loss in the ticket. Trigger remote wipe via MDM. File the incident report. Notify security. The asset record goes to "lost," not "retired" — those are different states with different financial implications.
- **"My old coworker's account still works."** — Offboarding checklist was skipped. Disable the account immediately, escalate to your lead, and someone needs to audit recent offboardings. This is how breaches start.
- **"I need Photoshop."** — Check the license pool before installing. If no seat is available, it's a procurement request, not a software install. Document the approval chain in the ticket.
- **Never promise a warranty replacement without checking the asset record first.** Out-of-warranty hardware is a budget conversation, not a help desk decision.

## Related concepts

[[Ticketing Systems]] · [[Change Management]] · [[Knowledge Base Articles]] · [[Standard Operating Procedures]] · [[Incident Response]] · [[Procurement Lifecycle]] · [[Software Licensing]] · [[MDM and Intune]]

*Source: VIRGIL knowledge base — 2026-05-11*