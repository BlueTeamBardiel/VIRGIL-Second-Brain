# Technical Change Management

## What it is

In Sekiro, you don't just walk up to Genichiro on the Ashina Castle rooftop and start swinging. You learn his deflect timings, you grind Mibu Village for skill points, you stock pellets and divine confetti, and you make sure you have a backup Prosthetic Tool slotted before the fight begins. Skip the prep, get the Shinobi Death Counter. That's exactly what **Technical Change Management** does — it forces you to plan, test, and prepare before touching production, so a failed deployment doesn't kill the business.

Technical Change Management is the formalized process of evaluating, approving, scheduling, implementing, and documenting modifications to IT systems in a way that minimizes risk to confidentiality, integrity, and availability.

## Why it matters

Unmanaged change is the leading cause of self-inflicted outages — patches break dependencies, firewall edits orphan services, and undocumented "quick fixes" become next year's incident. Without change control, you also lose audit trail, which torpedoes [[SOC 2]], [[PCI DSS]], and [[HIPAA]] compliance.

**Exam angle:** Objective 1.3 lists the technical implications explicitly — *allow lists/deny lists, restricted activities, downtime, service/application restarts, legacy applications, dependencies* — plus *documentation* (updating diagrams, policies/procedures, version control) and *backout plans*. CompTIA's favorite trap: giving you a scenario where a change "succeeded" but broke a downstream system, and asking what was missing. The answer is almost always **dependency analysis** or **backout plan**, not "more testing."

## Key facts

### The lifecycle (memorize the order)

1. **Request** — submitted via [[Change Request]] (RFC) ticket
2. **Review** — technical and security analysis, [[Impact Analysis]]
3. **Approval** — [[Change Advisory Board]] (CAB) decision
4. **Test** — in staging/sandbox before production
5. **Implement** — within approved [[Maintenance Window]]
6. **Verify** — confirm success and monitor
7. **Document** — update diagrams, baselines, configs

### Change types

| Type | Description | Approval path |
|------|-------------|---------------|
| **Standard** | Pre-approved, low-risk, repeatable (e.g., password reset) | Auto-approved |
| **Normal** | Routine but needs review | Full [[CAB]] review |
| **Emergency** | Required to fix outage or critical vuln | [[ECAB]] expedited approval |

### Technical implications (Objective 1.3 verbatim)

- **[[Allow Lists]] / [[Deny Lists]]** — modifying these without coordination breaks legitimate traffic or admits malicious traffic
- **Restricted Activities** — some changes require freeze windows (year-end financial close, retail blackout periods)
- **[[Downtime]]** — planned vs. unplanned; SLAs dictate tolerance
- **Service / Application Restarts** — required to apply config; impacts dependent services
- **[[Legacy Applications]]** — fragile, often undocumented, frequent breakage on dependency updates
- **Dependencies** — Service A relies on Service B; restart B without warning A and you cascade

### Documentation requirements

- **Updated [[Network Diagrams]]** — physical and logical topology
- **Updated [[Policies and Procedures]]** — if process changes
- **[[Version Control]]** — for code, configs, infrastructure-as-code (Git, Ansible, Terraform state)
- **[[Configuration Baseline]]** — the "known good" snapshot

### Backout plan

The non-negotiable. Every change ticket must answer: *"If this fails at 2 AM, how do we revert in under X minutes?"* Includes:
- **Snapshots / VM rollback**
- **Config backups** (running-config, startup-config)
- **Database point-in-time restore**
- **Reverse change script**

No backout plan, no approval. CompTIA loves this question.

### Why changes fail (the human cost)

- **Stakeholder communication gap** — ops fixed it, but didn't tell the help desk, who then escalate phantom tickets
- **Insufficient testing** — staging didn't mirror prod
- **Missing dependency map** — restarted the auth service during business hours
- **Skipped CAB** — "it was just a small change" — famous last words

## Related concepts

[[Configuration Management]] · [[Change Advisory Board]] · [[Backout Plan]] · [[Maintenance Window]] · [[Impact Analysis]] · [[Version Control]] · [[Configuration Baseline]] · [[Patch Management]] · [[ITIL]] · [[Standard Operating Procedure]]

---
*Source: VIRGIL knowledge base — 2026-05-08*