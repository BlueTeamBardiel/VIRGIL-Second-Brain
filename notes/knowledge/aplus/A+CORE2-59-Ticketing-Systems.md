# Ticketing Systems

## What it is

The ticket queue is the helpdesk's nervous system. Every "my screen is black," every "I can't print" enters as a ticket, gets a number, gets routed, gets worked, gets closed. No ticket, no work. No work, no proof you did anything.

In plain English: a ticketing system is a shared database for tracking IT problems and requests from the moment a user reports them to the moment they're resolved. The kanban board for the entire IT department — except the cards are user pain, and the column they're stuck in is your performance review.

Technically: a ticketing system (also called an ITSM platform — IT Service Management) is web-based software that captures, categorizes, prioritizes, assigns, tracks, and documents service requests and incidents. Common platforms include ServiceNow, Jira Service Management, Freshservice, and Zendesk. They integrate with the CMDB (Configuration Management Database), asset management, knowledge base, and SLA tracking. CompTIA tests this under objective 220-1202 4.1.

## Why it matters

Your first IT job will live inside a ticket queue. Eight hours a day. The queue is how your manager measures you, how the business measures IT, and how auditors prove you did the thing you said you did. A closed ticket with good documentation protects you. An undocumented "I fixed it over the phone" does not — when the user says you broke their machine three weeks later, the ticket is the only thing that exists.

This is also where compliance lives. HIPAA, PCI-DSS, SOX — auditors will pull random tickets and check that the right approvals, notes, and closure codes are present. Sloppy ticket hygiene becomes a finding.

## At home, at work

**The technical depth.** A ticket has structure: ticket ID, requester, assigned tech, category, severity (1–4 or critical/high/medium/low), description, progress notes, attachments, resolution, closure code, time-to-resolve. Tickets link to assets (the user's laptop, pulled from the CMDB) and to users (pulled from Active Directory). SLAs run a timer on every ticket — a P1 might have a 1-hour response and 4-hour resolution target; a P4 might have 3 business days.

**Familiar territory.** You've used a ticket system without calling it one. Filing a Steam support claim for a refund. Opening a Discord report on a moderator. Submit issue, get an ID, watch a status field change from `Open` to `Investigating` to `Resolved`. *Same workflow, lower stakes.* The Reddit modmail queue your gaming server runs is a ticketing system with the serial numbers filed off. *You already know the shape of the work.*

**Unfamiliar territory.** ServiceNow is what happens when that modmail grows up, gets a compliance department, and starts billing customers. User submits via portal, email, phone, or chat. The ticket lands in a queue. You pick it up, set status to `In Progress`, write timestamped progress notes as you work, escalate if you're stuck, resolve, set a closure code, document the fix in the KB if it's reusable. Every keystroke is logged. Your manager sees your average time-to-close, your reopen rate, your CSAT scores.

**The point.** Same fundamental loop — receive complaint, work it, document it, close it. The enterprise version adds SLAs, audit trails, asset linkage, and a manager who reads the queue. *Get comfortable inside the ticket. It is the job.*

## Key facts

### Ticket lifecycle (memorize this)

| Stage | What happens |
|---|---|
| **Intake** | User submits via portal, email, phone, chat. System assigns ticket ID. |
| **Categorize** | Hardware / software / network / access / request. Drives routing. |
| **Prioritize** | Severity assigned per impact + urgency matrix. |
| **Assign** | Auto-routed to queue (Tier 1, Tier 2, Network, Security) or grabbed by tech. |
| **Work** | Progress notes timestamped at every step. |
| **Escalate** | If out of scope or SLA threatened, push to Tier 2/3 with full context. |
| **Resolve** | Apply fix. Verify with user. Document what you did. |
| **Close** | Closure code, KB article if novel, link the asset and change record. |

### Ticket field essentials

- **Issue description** — user's own words first, then your translation. "Computer is slow" → "Outlook hangs 30+ seconds opening calendar; CPU pinned at 100% by `searchindexer.exe`."
- **Progress notes** — written for the *next* tech. Timestamp every entry. Never write anything you wouldn't want shown in a deposition.
- **Severity** — driven by impact (one person vs. department vs. company) and urgency (workaround exists vs. work stopped).
- **Assigned user** — the affected user, not the requester (a manager often opens tickets for employees).
- **Categories** — controlled list. "Other" is a smell.

### SLA basics

Service-Level Agreements define what IT promises. Two numbers matter: **response time** (how long until a human acknowledges) and **resolution time** (how long until the issue is fixed). Miss an SLA, reports turn red on your manager's dashboard.

### Asset management and the CMDB

The **CMDB (Configuration Management Database)** is the source of truth for every device, license, and configuration. Asset tags, serial numbers, assigned users, warranty status, software inventory — all live here. A good ticket links to the asset: who it's assigned to, warranty expiration, licensed software, last patch level. *The CMDB is how IT remembers things humans forget.*

### Document types you'll touch

- **SOPs** — step-by-step for routine work: new user setup, software install, password reset.
- **New-user onboarding checklist** — AD account, email, group memberships, hardware, badge, licenses. Miss a line and the user can't work day one.
- **Off-boarding checklist** — disable account, revoke MFA, recover hardware, transfer mailbox, remove from DLs. Miss a line and you have a security incident.
- **Knowledge base (KB) articles** — issue + resolution, written so the next tech can self-serve.
- **Incident reports** — for security events, outages, data exposure. Often legally required.
- **Procurement lifecycle docs** — purchase request, approval, PO, receipt, asset tag, deployment, end-of-life, disposal.

### CompTIA exam traps

> **CompTIA exam trap:** Severity vs. priority. Severity = how bad the impact is. Priority = the order you work it. A P3 ticket from the CEO often gets worked before a P2 ticket from an intern — politics, not the matrix. CompTIA tests the textbook definitions, not the politics.

> **CompTIA exam trap:** KB articles document **resolutions for reuse**. Incident reports document **what happened during a security or outage event**. The KB is the recipe book; the incident report is the autopsy.

## AI tools as tickets and triage helpers

Two legitimate uses for company-approved AI tools (Microsoft Copilot, ServiceNow Now Assist, internally-deployed models — never a random consumer chatbot):

- **Stitching listening-notes into ticket form.** A finance SME is talking fast about a hyper-specific ERP error. You scribble keywords — "GL posting, batch 4471, error 1305, only after Tuesday patch." After the call, paste those fragments into the approved AI and ask it to draft a structured progress note. You edit, verify, submit. *AI does the typing. You do the thinking.*
- **Triaging screenshots of unfamiliar software.** User sends a screenshot of an error in a line-of-business app you've never seen. Drop it into the approved AI: "what does this error mean and what's the likely cause?" AI does the recognition assist. You make the troubleshooting decision.

**Hard rule:** never paste user data, credentials, PII, or sensitive screenshots into a tool your security team hasn't approved. CompTIA's 220-1202 syllabus tests this under privacy and licensing. *Tool, not crutch.*

## Helpdesk reality

Honest truth about your first IT job: a lot of it is helping older or non-technical users operate computers. Sometimes you'll teach. Sometimes you'll just do the task for them over remote control because the queue is full and resolution is the goal. The ticket gets closed either way.

- **"It's broken, fix it."** — open a ticket anyway. No ticket, no work. Get the description in writing, even if you type it yourself while they talk.
- **"Can you just fix it real quick without a ticket?"** — no. Every "quick favor" is unpaid work you can't prove you did. Open the ticket first, then fix.
- **"Why does Word look different now?"** — Microsoft is migrating Office to browser-based Microsoft 365. You'll have this conversation weekly. KB article it once, link it forever.
- **"This is urgent, it's a P1."** — severity is set by impact and urgency, not by the user's volume.
- **Never promise a fix time you don't control.** "I'll get back to you by end of day with an update" is honest. "I'll have this fixed in an hour" is a lie waiting to happen.

## Related concepts

[[Change Management]] · [[Knowledge Base Articles]] · [[Asset Management and CMDB]] · [[SLAs and Service Management]] · [[Incident Response Documentation]] · [[Professional Communication]]

*Source: VIRGIL knowledge base — 2026-05-11*