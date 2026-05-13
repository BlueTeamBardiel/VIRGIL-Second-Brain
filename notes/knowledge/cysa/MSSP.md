# MSSP — Managed Security Service Provider

## What it is

In **Civilization VI**, you hit the Modern Era, your empire spans four continents, and you realize you cannot personally micromanage every city's production queue, every trade route, every spy assignment, and every border skirmish. So you sign a defensive pact with a stronger civilization. They don't run your empire — you still pick research, you still build wonders — but if a barbarian raid hits your frontier or Genghis declares surprise war, their units roll in. You pay per turn, you give up some sovereignty, and in exchange you sleep at night. That's exactly what an MSSP is — you outsource the 24/7 grind of security monitoring to someone with more eyes, more scale, and a night shift that already exists.

A **Managed Security Service Provider** is a third-party vendor that delivers security operations — monitoring, detection, alerting, sometimes response — as a contracted service. The customer keeps ownership of their data and their risk; the MSSP runs the SOC functions the customer can't or won't staff internally. Think 24/7 SIEM monitoring, [[EDR]] alert triage, vulnerability management, threat intelligence enrichment, and sometimes full incident response retainer.

The CySA+ angle: MSSPs are the canonical example of **streamlining operations** through outsourcing. CompTIA frames them under Objective 1.5 because they're how mid-market companies achieve coverage and efficiency they can't build in-house — and because the analyst on the other side of that contract is often *you*, working a tenant queue inside a multi-customer SOAR platform.

## Why it matters

You will work for an MSSP, work with an MSSP, or replace an MSSP. There is no fourth option in the career.

The economics are brutal and the math is simple: a 24/7 internal SOC needs minimum 6–8 analysts to cover three shifts with vacation, sick days, and turnover. Burdened cost: $800K–$1.2M/year before tooling. An MSSP contract for the same coverage runs $150K–$400K depending on tenant size and service tier. For companies under ~2,000 endpoints, the math never pencils in favor of building internal. So you outsource the grind and keep a small internal team — usually a security manager, a senior engineer, and an IR lead — who own the relationship and the escalations.

**Exam relevance (CS0-003 Objective 1.5):** CompTIA wants you to recognize MSSPs as part of the efficiency-and-process-improvement story alongside [[SOAR]], automation, and tool integration. Expect questions framing MSSPs as a way to standardize processes, minimize human engagement on routine tasks, and achieve coverage that internal staffing can't.

## Key facts

### What an MSSP actually delivers

| Service tier | What's included | Who buys it |
|---|---|---|
| **Monitoring only** | 24/7 SIEM eyes-on-glass, alert forwarding to customer | Small orgs, compliance-driven |
| **Monitoring + triage** | L1/L2 analysis, false-positive filtering, enriched escalations | Mid-market |
| **MDR (Managed Detection and Response)** | Triage + active containment authority on endpoints | Mid-market to enterprise |
| **Full co-managed SOC** | MSSP runs L1/L2, customer keeps L3/IR, shared SIEM tenant | Enterprise |
| **MSSP + IR retainer** | Above + dedicated incident response hours on-call | Regulated industries |

The line between **MSSP** and **MDR** matters. MSSP traditionally = alert forwarding (here's a ticket, you handle it). MDR = the provider acts on your endpoints directly. CompTIA treats them as adjacent but distinct.

### How MSSPs achieve efficiency — the CS0-003 hit list

This is the Objective 1.5 vocabulary, mapped to how an MSSP actually runs:

- **Standardize processes** — every customer ticket follows the same playbook. The MSSP can't reinvent triage per tenant; they'd go broke. So they build one runbook for "suspicious PowerShell" and apply it across 400 customers with tenant-specific tuning.
- **Identification of tasks suitable for automation** — anything repeatable, deterministic, no judgment required. Hash lookups, IP reputation checks, geolocation, user-context enrichment, ticket creation. If a human's only job is copy-paste into VirusTotal, that's a SOAR play.
- **Repeatable / do not require human interaction** — the criteria for automation. If the analyst makes the same decision 1,000 times with the same inputs, the machine should make it.
- **Team coordination to manage and facilitate automation** — someone owns the playbooks. At an MSSP that's a detection engineer or SOAR engineer, not the L1 floor. The floor consumes automation; engineering builds it.
- **Streamline operations** — the entire pitch.
- **[[SOAR]] (Security Orchestration, Automation, and Response)** — the platform MSSPs run on. Splunk SOAR, Palo Alto Cortex XSOAR, Tines, Torq. Playbooks fire on alert ingest, enrich, decide, escalate or close.
- **Orchestrating threat intelligence data** — MSSP has 400 customers. Customer 47 gets hit with a novel C2 domain. Within minutes, that IOC is in every other tenant's blocklist. This is the killer value prop — herd immunity.
- **Data enrichment** — alert comes in with just an IP. SOAR playbook auto-queries WHOIS, GreyNoise, internal asset database, AD user lookup, recent ticket history. By the time L1 sees it, the alert has context.
- **Threat feed combination** — commercial feeds (Mandiant, Recorded Future), open source ([[OSINT]], abuse.ch), ISAC feeds, internal IOCs from other tenants. All deduplicated, scored, fed into detection.
- **Minimize human engagement** — the goal is that analysts only touch alerts where judgment matters. The 80% of noise gets auto-closed by playbook.

### Technology and tool integration

The plumbing question: how does an MSSP connect to your environment?

- **[[API]] (Application Programming Interface)** — the primary integration method. Customer's EDR (CrowdStrike, SentinelOne, Defender) exposes a REST API. MSSP's SOAR pulls alerts, posts containment actions, queries device state. Two-way, structured, authenticated.
- **Webhooks** — event-driven push. Customer's tool fires an HTTPS POST to the MSSP when something happens. Unlike polling, webhooks are real-time. Slack alerts, GitHub events, payment processors all use this pattern.
- **Plugins** — vendor-built connectors that wrap APIs in a SOAR-friendly interface. XSOAR has 800+ plugins; Tines has connection libraries. The plugin handles auth, rate limiting, and response parsing so playbook authors don't have to.
- **Single pane of glass** — one dashboard showing data from all integrated tools. The customer logs into the MSSP portal and sees endpoint, network, identity, cloud — without bouncing between 12 vendor consoles. The promise is unified visibility; the reality is the pane is only as good as the integrations behind it.

### API vs Webhook — the trap

API is **pull-based** (you ask). Webhook is **push-based** (it tells you). MSSPs use both: webhooks for low-latency alert ingestion, APIs for enrichment queries and response actions. CompTIA likes this distinction.

### CompTIA exam traps

> **CompTIA exam trap:** MSSP vs MSP. An **MSP** (Managed Service Provider) handles IT — patching, helpdesk, infrastructure. An **MSSP** specifically handles security — SOC, monitoring, IR. MSP-delivered security is not an MSSP relationship; it's a side dish. The exam will test the distinction.

> **CompTIA exam trap:** Outsourcing security does not transfer accountability. You can transfer the *work* to an MSSP; you cannot transfer regulatory responsibility, breach notification duty, or executive liability. If the MSSP misses an intrusion, your CISO still answers to the board, and your DPO still files the GDPR 72-hour notice. Risk **transfer** in the contract sense is narrow — usually limited to contractual remedies, not regulatory ones.

> **CompTIA exam trap:** "Minimize human engagement" does not mean "eliminate analysts." CompTIA frames automation as reducing routine work so humans focus on judgment-heavy work. Picking the answer that says "fully automate the SOC" is wrong every time.

> **CompTIA exam trap:** Single pane of glass is a goal, not a product. If a question describes "consolidating data from disparate security tools into a unified interface," the answer is single pane of glass — even though no real deployment ever fully achieves it.

### What MSSPs are bad at

The pitch is great. The reality has friction.

- **Business context** — the MSSP analyst doesn't know that the SQL server flagged for anomalous queries is your CFO's quarterly close tool. They escalate; you de-escalate. Tuning takes 6–12 months.
- **False positive fatigue** — multi-tenant detection rules are tuned to the average customer, not yours. Your unique stack generates noise the playbook doesn't know to suppress.
- **Response authority** — most MSSP contracts allow alerting, not action. By the time the ticket reaches your on-call, the attacker has moved laterally. MDR fixes this; vanilla MSSP doesn't.
- **Lock-in** — the SIEM is theirs. The playbooks are theirs. The detection content is theirs. Switching MSSPs means rebuilding detection logic from scratch.
- **The dashboard is not the truth** — *the single pane of glass shows you what the integrations report; it does not show you what they failed to report. Coverage gaps are invisible until an intrusion finds one.*

### Co-managed model — the modern compromise

The trend in mid-market and enterprise is **co-managed SOC**: the customer owns the SIEM tenant (Splunk, Sentinel, Chronicle), the MSSP provides analysts who work inside it. Customer keeps the data, the detection logic, the institutional knowledge. MSSP provides the eyeballs and the night shift. Best of both — assuming the contract is written well and the customer has at least one internal engineer who owns the relationship.

## SOC reality

- **You will work an MSSP queue.** L1 jobs at MSSPs are the most common entry point into the field. You'll triage 80–150 alerts a shift across 8–20 customer tenants. You'll learn more in 12 months than 3 years at a single-tenant SOC because you see *everyone's* attack surface.
- **The 3am alert from an MSSP looks like this:** an email or PagerDuty page with a tenant ID, severity, IOC summary, and a link to the ticket in their portal. Your job as the customer on-call is to validate scope, decide whether to authorize containment, and loop in IR if needed. You do not promise leadership "we've contained it" until the MSSP confirms endpoint isolation and you've verified in your own console.
- **The CISO's recurring question:** "What is the MSSP catching that we'd miss internally, and what are we catching that they're missing?" Quarterly business review meetings live on this question. Bring metrics: MTTD, alert volume, true-positive rate, tickets closed by automation vs human.
- **The hand-off boundary is the contract.** Read it. The MSSP's SLA might say "15-minute response to critical alerts" — that's response, not resolution. Response means a human acknowledges the ticket. Resolution is your problem until you've paid for a higher tier.
- **The classic MSSP failure mode:** the contract was signed three years ago, the tenant has drifted, half the log sources have stopped forwarding, and nobody noticed because the dashboard still looks green. *An empty SIEM is the quietest SIEM. Verify ingest health monthly, or the silence will eat you.*

## Related concepts

[[SOAR]] · [[SIEM]] · [[EDR]] · [[MDR]] · [[Incident Response]] · [[Threat Intelligence]] · [[API]] · [[Webhooks]] · [[Single Pane of Glass]] · [[Data Enrichment]] · [[Playbooks]] · [[SLA]] · [[OSINT]] · [[MTTD]] · [[Co-managed SOC]]

*Source: VIRGIL knowledge base — 2026-05-11*