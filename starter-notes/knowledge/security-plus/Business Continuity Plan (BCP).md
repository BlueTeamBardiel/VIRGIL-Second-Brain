---
domain: "Governance, Risk, and Compliance"
tags: [business-continuity, resilience, disaster-recovery, risk-management, governance, incident-response]
---
# Business Continuity Plan (BCP)

A **Business Continuity Plan (BCP)** is a documented, proactive strategy that defines how an organization will maintain or rapidly resume **mission-critical functions** during and after a significant disruption, whether caused by natural disaster, cyberattack, hardware failure, or other adverse event. The BCP encompasses people, processes, technology, and facilities, and sits within the broader [[Risk Management Framework]] alongside the [[Disaster Recovery Plan (DRP)]]. Unlike the DRP, which focuses narrowly on restoring IT systems, the BCP addresses the entire operational continuity of the organization.

---

## Overview

Business continuity planning emerged as a formal discipline in the 1970s and 1980s, initially driven by financial institutions that recognized catastrophic data loss or operational downtime could be existential. Regulatory pressure from bodies such as NIST, ISO (ISO 22301), and industry-specific regulators (FFIEC for banking, HIPAA for healthcare) has since made BCPs a compliance requirement across many sectors. The BCP is not a single document but a program — a collection of plans, procedures, contracts, and trained personnel.

The BCP lifecycle begins with a **Business Impact Analysis (BIA)**, which identifies critical business functions, the resources they depend upon, and the financial and operational consequences of their disruption over time. The BIA produces two key metrics that drive all downstream planning: the **Recovery Time Objective (RTO)**, which defines the maximum tolerable downtime for a function, and the **Recovery Point Objective (RPO)**, which defines the maximum acceptable data loss measured in time. These metrics directly translate into infrastructure requirements — a four-hour RTO on an email system demands very different investment than a 72-hour RTO.

Once critical functions and their tolerances are understood, the BCP team identifies risks through a formal [[Risk Assessment]], evaluates existing controls, and develops strategies for each threat scenario. Strategies may include geographic redundancy, hot/warm/cold site arrangements, manual workaround procedures, vendor diversification, and cross-training of personnel. The BCP must address not just IT recovery but also workforce continuity (remote work policies, succession planning), supply chain continuity, and communication plans for employees, customers, and regulators.

A BCP that exists only as a PDF on a shared drive is nearly worthless. Effective BCPs require a **testing and exercise program** that validates procedures, exposes gaps, and maintains organizational muscle memory. Common exercise types range from tabletop discussions to full interruption tests where systems are actually failed over to backup infrastructure. After every test and every real incident, the plan must be reviewed and updated — a process called **plan maintenance**. Plans also require defined ownership, typically a Business Continuity Manager or a dedicated BCP committee with executive sponsorship.

Modern BCPs must explicitly address cyber incidents, particularly ransomware, which has become the dominant cause of declared business continuity events in the past decade. The 2021 Colonial Pipeline attack forced the company to halt pipeline operations not because OT systems were compromised but because their billing and business systems were — illustrating that a cyber-focused BCP must account for cascading impacts even when the initial breach is in IT, not OT.

---

## How It Works

### Phase 1: Initiation and Scope Definition

The BCP process begins with executive mandate and scope definition. Leadership identifies which business units, geographic locations, and functions fall within the BCP's scope. A BCP steering committee is formed with representatives from IT, operations, legal, HR, finance, and communications.

```
BCP Scope Statement Example:
- In scope: All revenue-generating operations, customer-facing systems,
  regulatory reporting functions, payroll processing
- Out of scope: Internal knowledge base, non-critical internal tooling
- Geographic scope: Primary site (Chicago IL), Secondary site (Phoenix AZ)
```

### Phase 2: Business Impact Analysis (BIA)

The BIA is the analytical core of the BCP. Each business function is interviewed and assessed:

| Function | RTO | RPO | MTPD | Priority |
|---|---|---|---|---|
| Online payment processing | 1 hour | 15 minutes | 4 hours | Critical |
| Customer support portal | 4 hours | 1 hour | 24 hours | High |
| Internal HR system | 48 hours | 24 hours | 7 days | Medium |
| Marketing website | 8 hours | 4 hours | 48 hours | High |

**Key BIA metrics defined:**
- **RTO (Recovery Time Objective):** Maximum time a function can be offline
- **RPO (Recovery Point Objective):** Maximum data loss tolerance in time
- **MTPD (Maximum Tolerable Period of Disruption):** Absolute outer limit before business viability is threatened
- **WRT (Work Recovery Time):** Time needed to restore data integrity after systems are back online
- **RTO = MTD - WRT** (RTO must be less than MTPD minus Work Recovery Time)

### Phase 3: Risk Assessment and Strategy Selection

Using a risk register format, threats are mapped to critical functions:

```
Risk Register Entry:
Risk ID: RISK-042
Threat: Ransomware attack on primary datacenter
Likelihood: High (based on sector threat intelligence)
Impact: Critical — affects payment processing (RTO: 1hr)
Current Controls: Daily backups (offsite), EDR on endpoints
Residual Risk: Medium
BCP Strategy: Warm standby site with 2-hour failover capability
```

### Phase 4: Recovery Strategy Implementation

**Site Recovery Tiers:**

```
HOT SITE
- Fully operational mirror of production
- Real-time or near-real-time data replication
- Failover time: Minutes to 1-2 hours
- Cost: Very High (~2x infrastructure budget)
- Use for: RTO < 4 hours

WARM SITE
- Pre-provisioned hardware and connectivity
- Data restored from recent backups (hours-old)
- Failover time: 4-24 hours
- Cost: Moderate
- Use for: RTO 4-24 hours

COLD SITE
- Physical space with power and network, no systems
- Equipment must be sourced and configured
- Failover time: Days to weeks
- Cost: Low
- Use for: RTO > 72 hours

CLOUD-BASED RECOVERY (DRaaS)
- Vendor: AWS Elastic Disaster Recovery, Azure Site Recovery, Zerto
- Failover time: Minutes to hours depending on tier
- Pricing model: Pay-per-use with reserved capacity options
```

### Phase 5: Plan Documentation

BCP documentation structure:
```
BCP Master Document
├── 1. Purpose, Scope, and Objectives
├── 2. BIA Summary and Critical Function Registry
├── 3. Risk Assessment Results
├── 4. Recovery Strategies by Function
├── 5. Activation Procedures
│   ├── 5.1 Notification Tree
│   ├── 5.2 Damage Assessment Checklist
│   └── 5.3 Declaration Criteria
├── 6. Recovery Procedures (per system/function)
├── 7. Communication Plan (internal/external/regulatory)
├── 8. Vendor and Supplier Contacts
├── 9. Testing and Exercise Schedule
└── 10. Plan Maintenance Procedures
```

### Phase 6: Testing and Exercises

```
Exercise Types (ascending complexity and disruption):
1. CHECKLIST REVIEW — Verify contact info, document currency
2. TABLETOP EXERCISE — Discussion-based scenario walkthrough (no systems affected)
3. WALKTHROUGH DRILL — Participants physically walk through procedures
4. SIMULATION — Inject realistic scenario; no actual failover
5. PARALLEL TEST — Run recovery site in parallel with production
6. FULL INTERRUPTION TEST — Actually cut over to recovery site
```

**Sample tabletop scenario injection:**
```
Scenario: At 2:14 AM Tuesday, your primary datacenter in Chicago reports
a complete power failure. The UPS sustains systems for 45 minutes.
The generator fails to start. Estimated restoration time: 6-8 hours.

Discussion questions:
- Who has authority to declare a BCP event?
- What is the notification order and timeline?
- Which functions exceed their RTO within this window?
- What manual workarounds exist for payment processing?
- How do you communicate with customers?
```

### Phase 7: Maintenance

```
Maintenance Triggers:
- Annual scheduled review (minimum)
- Post-incident review (mandatory)
- Post-exercise review (mandatory)
- Major infrastructure changes (datacenter migration, cloud adoption)
- Organizational changes (M&A, new product lines)
- New regulatory requirements
- Significant threat landscape changes
```

---

## Key Concepts

- **Business Impact Analysis (BIA):** The structured process of identifying critical business functions, mapping their resource dependencies, and quantifying the financial and operational impact of their disruption over time. The BIA is the foundational input to all BCP strategy decisions.

- **Recovery Time Objective (RTO):** The maximum acceptable length of time a business process or system can be offline following a disruption. Exceeding the RTO results in unacceptable business impact. RTOs directly determine whether hot, warm, or cold site strategies are appropriate.

- **Recovery Point Objective (RPO):** The maximum tolerable amount of data loss measured in time — effectively, how old can the most recent recovered data be? An RPO of one hour means the organization must be able to restore data to a state no older than one hour before the disruption.

- **Maximum Tolerable Downtime (MTD) / MTPD:** The absolute outer boundary beyond which a business function's failure becomes existential to the organization. MTD is the ceiling that RTO must fit under, leaving room for Work Recovery Time.

- **Succession Planning:** The BCP component that ensures critical roles have designated backups with documented authority to act. This prevents single points of failure in human capital — if the CISO is unreachable during an incident, a designated successor must have both the authority and the knowledge to act.

- **Alternate Processing Site:** A pre-designated location (hot, warm, or cold) to which operations can be transferred when the primary site is unavailable. Modern BCPs often designate cloud environments as alternate processing sites via Infrastructure-as-Code templates that can be instantiated rapidly.

- **Crisis Communications Plan:** The BCP sub-plan governing how the organization communicates during a disruption — including internal employee notifications, customer-facing status communications, media relations, and mandatory regulatory notifications (e.g., SEC 8-K filings for material cybersecurity incidents, HIPAA breach notifications).

- **Vital Records Management:** The identification, protection, and recovery procedures for documents and data critical to business operations and legal compliance — contracts, financial records, customer data, regulatory filings. Vital records must be backed up and accessible from alternate locations.

---

## Exam Relevance

**SY0-701 Domain Mapping:** BCP concepts appear in Domain 5.0 — Security Program Management and Oversight, which carries approximately 20% of exam weight.

**Critical distinctions the exam tests:**

| Concept | Distinction |
|---|---|
| BCP vs. DRP | BCP = entire organization continuity; DRP = IT/technology recovery specifically |
| RTO vs. RPO | RTO = time (how long can you be down); RPO = data (how much data loss is acceptable) |
| Hot vs. Warm vs. Cold | Hot = immediate failover; Warm = hours; Cold = days/weeks |
| BIA vs. Risk Assessment | BIA identifies impact of disruption; Risk Assessment identifies probability and threat sources |
| MTD vs. RTO | MTD is the ceiling; RTO must be shorter than MTD |

**Common question patterns:**
- Scenario: "A bank's online portal must be restored within 2 hours and can lose no more than 30 minutes of transactions. What are the RTO and RPO?" → RTO = 2 hours, RPO = 30 minutes
- "Which document identifies which business functions are most critical?" → BIA
- "A company needs instant failover with zero data loss. Which site type is most appropriate?" → Hot site
- "After a DR test, what is the MOST important next step?" → Document lessons learned and update the plan

**Gotchas:**
- The exam frequently tries to conflate BCP and DRP — remember BCP is the umbrella, DRP lives under it
- "Tabletop exercise" does NOT involve any actual system failover — it's discussion only; if systems are involved, it's at minimum a parallel or full interruption test
- MTPD and MTD are used interchangeably in most contexts but some questions use the ISO 22301 term (MTPD)
- A BIA is conducted BEFORE risk assessment in the proper BCP methodology sequence

---

## Security Implications

**BCP Documents as Attack Targets**

The BCP itself is a high-value intelligence target. A threat actor with access to your BCP knows exactly which systems you consider most critical, where your backup sites are located, who the key decision-makers are, what your failover timelines are, and where your gaps exist. In 2020, the ransomware group behind the Maze attacks began exfiltrating business continuity and disaster recovery documentation before encrypting systems specifically to inform ransom negotiation — they knew exactly how much downtime would cost the victim.

**Single Points of Failure in BCP Execution**

BCPs frequently identify technology solutions but miss human dependencies. If the BCP requires a specific administrator to initiate failover and that person is unavailable (hospital, unreachable, part of the incident itself), the plan fails. Social engineering attacks targeting on-call personnel during declared incidents are documented — attackers impersonate vendors or leadership during chaotic recovery scenarios.

**Backup Infrastructure as Attack Surface**

Backup systems and alternate sites are frequently less hardened than production systems. Ransomware operators specifically hunt for and encrypt backup repositories before triggering the primary attack — Veeam backup servers, NAS devices with SMB shares, and tape library management systems are common targets. The Conti ransomware group's leaked playbooks explicitly included instructions for finding and destroying VSS shadow copies and backup software agents.

**Relevant Incidents:**

- **2021 Colonial Pipeline (DarkSide ransomware):** $4.4M ransom paid; the operational shutdown was a business decision due to billing system compromise, not OT system failure — illustrating BCP gaps between IT and OT continuity planning
- **2019 Norsk Hydro (LockerGoga):** Company executed manual operations for weeks; their BCP included manual procedure documentation that proved critical; full IT restoration took months
- **2020 Garmin (WastedLocker):** $10M ransom reportedly paid; aviation database and customer sync services offline for days despite being a technology company — BCP/DRP failures at a tech-savvy organization

---

## Defensive Measures

**1. Protect BCP Documentation**
```
- Store BCP in access-controlled repository (not on general SharePoint)
- Classify BCP as Confidential or higher
- Limit distribution to need-to-know basis
- Maintain printed copies in secure offsite location (USB-isolated)
- Never store BCP on the systems it describes recovering
```

**2. Harden Backup Infrastructure**
```bash
# Veeam: Ensure backup repositories use immutable storage
# AWS S3 Object Lock (Compliance Mode) — prevents deletion for defined period
aws s3api put-object-lock-configuration \
  --bucket bcdr-backups-prod \
  --object-lock-configuration \
  '{"ObjectLockEnabled":"Enabled","Rule":{"DefaultRetention":{"Mode":"COMPLIANCE","Days":30}}}'

# Linux: Enable append-only on backup directories
chattr +a /mnt/backup-share/

# Windows VSS: Verify shadow copies are protected
vssadmin list shadows
# Restrict VSS deletion to SYSTEM only via GPO
```

**3. Network Segmentation for Backup Systems**
```
# Backup server should be on isolated VLAN
# No inbound connections from production servers to backup server
# Backup server initiates all connections (pull model)
# Example pfSense firewall rule concept:
# Allow: backup-vlan → production-vlan:445 (SMB pull)
# Block: production-vlan → backup-vlan (all)
```

**4. Implement 3-2-1-1-0 Backup Rule**
```
3 copies of data
2 different storage media types
1 copy offsite
1 copy offline/air-gapped or immutable
0 errors verified by regular restore testing
```

**5. BCP Testing Cadence**
```yaml
# BCP Exercise Schedule
annual:
  - type: Full BCP Review and Update
  - type: Tabletop Exercise (executive level)
  - type: Parallel Test (IT systems)
semi_annual:
  - type: Communication Tree