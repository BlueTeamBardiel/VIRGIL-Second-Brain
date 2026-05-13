# File Systems

## What it is

The file system is the warehouse's filing cabinet — the storage is the warehouse itself, but the file system is the index card system that tells the OS where every box lives, who owns it, and who's allowed to open it. Without it, you have a hard drive full of magnetic noise.

In plain English: a file system is how the operating system organizes bits on a storage device into files and folders, tracks where each file's data physically lives, and enforces permissions on who can read or write it.

Technically: a file system is the on-disk data structure (metadata tables, allocation maps, journals) plus the kernel-level driver that translates "open `C:\Users\bob\resume.docx`" into specific block addresses on the underlying storage device.

> **Wait — this topic says "File Systems" but the objective bullets are about documentation, asset management, and ticketing?** That's the topic title mismatch from the syllabus. The real subject of objective 4.1 is **support systems information management** — ticketing, asset management, SOPs, KB articles. We're covering that. The "File Systems" label is a syllabus quirk.

## Why it matters

Every IT job lives or dies on documentation. The technician who writes good tickets, keeps the CMDB clean, and contributes to the KB gets promoted. The one who fixes things silently and leaves no trail gets stuck at tier 1 forever, because nobody knows what they did or how to repeat it.

CompTIA tests this hard on 220-1202 objective 4.1 because the field has watched too many sysadmins quit, taking the only knowledge of how the payroll server actually works with them. Documentation is the institutional memory that survives turnover.

For your first helpdesk job, three documents will define your week: the ticket you're working, the KB article you're searching, and the CMDB entry that tells you which laptop the user actually has.

## At home, at work

**Beat 1 — what documentation actually consists of.** Four pillars hold up the operations house. **Ticketing systems** (ServiceNow, Jira Service Management, Freshservice, Zendesk) — every user request gets a ticket with a unique ID, category, severity, assigned tech, description, progress notes, and resolution. **Asset management / CMDB** (Configuration Management Database) — every device, license, and configuration item, tagged with an asset ID, assigned user, warranty status, and current state. **Documents** — SOPs, KB articles, incident reports, onboarding/offboarding checklists, SLAs. **Policies** — acceptable use, password, BYOD.

Severity is usually P1–P4: P1 is "production is on fire," P4 is "user wants a second monitor when convenient." SLAs tie severity to response time: P1 = 15-minute response, 4-hour resolution; P4 = next business day. Internal SLAs are between IT and the business; external/third-party SLAs are between you and a vendor (Microsoft, your ISP, your MSP).

**Beat 2 — at home, you already do this badly.** You document your gaming rig in a way that would horrify any auditor, and you know it.

**The build sheet:** Notion page, Google Doc, or sticky note with your part list — CPU, mobo, RAM kit with timings, GPU, PSU, NVMe. *That's your CMDB entry for one asset.*

**The BIOS notes:** Somewhere you've written down "XMP profile 1, RAM at 6000 CL30, Curve Optimizer -25 all-core, fan curve custom." *That's a configuration management record.* When you re-flash the BIOS and lose all settings, that note is the only thing between you and an hour of re-tuning.

**The "what broke and how I fixed it" doc:** The time your PC wouldn't POST and you found the front-panel USB header shorting against the case. If you wrote it down, you fixed it in 10 minutes the second time. If you didn't, you spent another hour rediscovering it. *That's a KB article.*

**The receipt folder:** Newegg confirmations, Amazon invoices, the GPU warranty registration email. *The day your 4090 dies in month 23 of a 36-month warranty, that folder is worth the GPU.*

**Beat 3 — bridge to the enterprise.** Same four pillars, but with structure, audit trails, and the assumption that you will leave the company someday.

At home: one build sheet, you're the only user, you remember most of it. At the enterprise: 8,000 endpoints in a CMDB. Every laptop has an asset tag (the silver sticker on the bottom), an asset ID in ServiceNow, assigned user, department, cost center, warranty end date, OS version, last-check-in timestamp. When Karen in Accounting calls and says "my laptop is broken," you pull up her name, see she has a Dell Latitude 5540, asset tag ACME-04521, warranty active until 2027-08-12, on Windows 11 23H2, last seen on the network 47 minutes ago. You knew all that before you said hello.

At home, your "ticketing system" is the mental note "fix the audio thing this weekend." At the enterprise, every interaction is a ticket with a clear issue description, category, severity, assigned tech, timestamped progress notes, and a resolution. When the same issue hits five more users, the second tech searches the queue, finds yours, copies the fix. Multiply across a 50-person IT department and documentation discipline is the difference between a functional shop and chaos.

**Beat 4 — the point.** Same fundamental question at home and at work: *if I got hit by a bus tomorrow, could someone else pick up where I left off?* At home, your PC sits unused. At work, the answer determines whether the business keeps running. Documentation is the institutional memory that survives turnover, vacation, and the day you finally take that better job offer. Get this habit into your bones in your first 90 days.

## Key facts

### Ticketing system anatomy

| Field | Purpose | Example |
|---|---|---|
| Ticket ID | Unique reference | INC0042871 |
| Category | Routing and reporting | Hardware > Laptop > Display |
| Severity / Priority | Drives SLA timer | P2 — High |
| Issue description | Clear, concise summary | "External monitor not detected after dock firmware update" |
| Requester / Assigned tech | Who reported it / who owns it | jdoe@acme.com / You |
| Progress notes | Timestamped log of every step | "10:14 — verified cable, swapped DP port, no signal" |
| Resolution | What ultimately fixed it | "Rolled back dock firmware to 1.4.2" |
| Status | Workflow state | Open / In Progress / Resolved / Closed |

**Escalation:** Tier 1 (helpdesk, password resets, basic troubleshooting) → Tier 2 (deeper hardware/software, imaging, AD changes) → Tier 3 (sysadmin, network, security) → Vendor (Microsoft, Dell ProSupport, Cisco TAC). Escalating outside your scope wastes the next tier's time; escalating too late misses your SLA.

### Asset management and the CMDB

The CMDB tracks **configuration items (CIs)** — anything the business owns that has a configuration worth tracking.

| Field | What it tracks |
|---|---|
| Asset tag / ID | Physical sticker + database key (ACME-04521) |
| Device information | Make, model, serial, MAC, hostname |
| Assigned user | Current owner — pulled from AD/Entra |
| User information | Department, manager, cost center, location |
| Procurement lifecycle | Ordered → received → deployed → in-service → retired → disposed |
| Warranty and licensing | End date, support level, attached software licenses |
| Inventory lists | In stock vs. deployed |

**Procurement lifecycle** is cradle-to-grave: procure (PO issued), receive (asset tagged, added to CMDB), deploy (assigned via onboarding), maintain (patches, warranty claims), retire (device EOL), dispose (wiped per data-destruction policy, recycled per e-waste policy). Skip the disposal documentation and you'll fail a compliance audit the day a regulator asks where SN# ABC123 went.

### Types of documents

| Document type | Purpose |
|---|---|
| **SOP** | Step-by-step for routine tasks — "How to image a new Latitude" |
| **Custom software install procedure** | Vendor-specific install + config — "Deploying the SAP GUI client" |
| **KB article** | Searchable issue-resolution doc — "Outlook crashes on send after KB5034441" |
| **Incident report** | Post-mortem for P1/P2 events — what happened, root cause, prevention |
| **Onboarding checklist** | AD account, email, MFA, hardware, software, security training |
| **Offboarding checklist** | Disable account, forward email, recover laptop, revoke licenses |
| **SLA** | Response/resolution times — internal (IT to business) or external (vendor to you) |
| **Acceptable use policy** | What users can/can't do on company gear |

A good KB article has: clear title (the symptom the next tech will search for), affected systems, symptoms, root cause, step-by-step resolution, and prevention.

### CompTIA exam traps

> **Exam trap:** **CMDB vs. asset management** — Asset management is the broader discipline (procurement, inventory, warranty, lifecycle); the CMDB is the database that holds configuration items and their relationships. The CMDB is *part of* asset management, not a synonym.

> **Exam trap:** **Internal vs. external SLA** — Internal SLA = IT's commitment to other departments (helpdesk responds in 15 min to P1). External / third-party SLA = a vendor's commitment to you (Dell ProSupport, 4-hour onsite). The exam loves this distinction.

> **Exam trap:** **Onboarding vs. offboarding** — Onboarding *creates and grants*; offboarding *disables and recovers*. The most common offboarding miss is leaving the AD account active "just in case" — that's how dormant accounts become attacker footholds.

> **Exam trap:** **Incident report vs. KB article** — Incident report is the post-mortem of a specific event. KB article is the reusable solution doc for a recurring problem. Same fix may appear in both, but they serve different audiences.

## Helpdesk reality

- **"Can you just fix it real quick, no need for a ticket."** No. Every interaction gets a ticket — for your protection, for SLA tracking, for the next tech who hits the same issue. "If it's not in the ticket, it didn't happen." Politely create the ticket while you fix it.
- **"I don't know my asset tag."** Fine — look up the user in the CMDB, you'll find their assigned device. If they have multiple, ask which one. Never start troubleshooting without knowing which physical machine you're touching.
- **Use approved AI to stitch your notes into clean ticket updates.** During a fast call with a developer about a niche app, take rough fragment notes. After, paste them into Microsoft Copilot or ServiceNow Now Assist and ask for a formatted progress note. Never paste credentials, PII, or sensitive screenshots into unapproved tools.
- **Write the KB article the same day you solve the novel problem.** Wait a week and you'll forget the exact registry key or command. The article you write tired on Friday saves your team eight hours next month.
- **The CMDB is only as good as the people who update it.** If you swap a user's laptop and don't update the assignment, the next tech will troubleshoot the wrong machine. Update it before you close the ticket, not "later."

## Related concepts

[[Ticketing Systems]] · [[Change Management]] · [[Knowledge Base Articles]] · [[Asset Tags and CMDB]] · [[SLAs and Escalation]] · [[Onboarding and Offboarding]] · [[Incident Response]] · [[Acceptable Use Policy]]

*Source: VIRGIL knowledge base — 2026-05-10*