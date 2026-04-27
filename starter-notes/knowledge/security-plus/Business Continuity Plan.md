---
domain: "Governance, Risk, and Compliance"
tags: [business-continuity, disaster-recovery, resilience, incident-response, risk-management, grc]
---
# Business Continuity Plan

A **Business Continuity Plan (BCP)** is a documented framework that defines how an organization will continue operating critical functions during and after a disruptive event such as a cyberattack, natural disaster, or infrastructure failure. It encompasses people, processes, and technology, and is closely related to but broader than a [[Disaster Recovery Plan]], which focuses specifically on restoring IT systems. The BCP is a core governance artifact required by frameworks such as [[ISO 27001]], [[NIST SP 800-34]], and [[HIPAA Security Rule]].

---

## Overview

A Business Continuity Plan exists because organizations face an ever-present risk of disruption from events ranging from ransomware attacks and power outages to pandemics and supply chain failures. Without a BCP, an organization's response to such events is improvised, slow, and inconsistent — leading to financial losses, reputational damage, regulatory penalties, and in critical sectors like healthcare, potential loss of life. The BCP provides pre-approved decision trees, resource lists, communication templates, and recovery procedures so that staff can act decisively under pressure.

The BCP encompasses the full lifecycle of a disruption: prevention (reducing the likelihood of an event), preparedness (training and documentation), response (immediate actions during an incident), and recovery (restoring normal operations). This lifecycle is sometimes called the **PPRR model**. Unlike an [[Incident Response Plan]], which is reactive and security-specific, the BCP is proactive and operationally broad — it considers not just cyberattacks but any event that could interrupt business services.

Foundational to any BCP is a **Business Impact Analysis (BIA)**, which identifies critical business functions and quantifies the consequences of their disruption. The BIA produces two key metrics: the **Recovery Time Objective (RTO)** — the maximum tolerable downtime for a function — and the **Recovery Point Objective (RPO)** — the maximum acceptable data loss measured in time. These metrics drive technology and process decisions throughout the plan.

Organizations in regulated industries are typically legally required to maintain a BCP. The **Gramm-Leach-Bliley Act (GLBA)** requires financial institutions to have continuity plans. **HIPAA** requires covered entities to maintain contingency plans under 45 CFR §164.308(a)(7). **DORA (Digital Operational Resilience Act)** in the EU imposes rigorous BCM (Business Continuity Management) requirements on financial entities. Even without regulation, cyber insurance carriers increasingly require evidence of a tested BCP before issuing policies.

The BCP must be a living document. Plans that are written once and filed away fail catastrophically in real incidents because environments change — new systems are added, staff turn over, and threat landscapes evolve. Industry best practice calls for reviewing and testing the BCP at least annually, after any major infrastructure change, and after any actual incident that activates the plan.

---

## How It Works

### Phase 1: Initiation and Scope Definition

Before writing a single procedure, the organization must define the **scope** of the BCP — which business units, locations, systems, and processes are covered. This is formalized in a **BCP Policy Statement**, signed by executive leadership, that authorizes the program and assigns a **BCP Owner** (often a CISO, CRO, or dedicated BCM Manager).

```
BCP Scope Example:
- In scope: All revenue-generating business units, customer-facing web applications,
  financial systems, HR payroll systems, and all Tier-1 data centers.
- Out of scope: Development/test environments, internal marketing tools.
```

### Phase 2: Business Impact Analysis (BIA)

The BIA is the analytical engine of the BCP. It is conducted via structured interviews, surveys, and system dependency mapping. For each identified critical function:

1. **Identify the function** — e.g., "Process customer payment transactions"
2. **Map dependencies** — applications, servers, vendors, staff, facilities
3. **Quantify impact** — financial loss per hour of downtime, regulatory exposure, reputational impact
4. **Assign RTO and RPO** — based on impact severity

```
BIA Output Example:

| Business Function         | Max Tolerable Downtime | RTO    | RPO     | Priority |
|---------------------------|------------------------|--------|---------|----------|
| Payment Processing        | 4 hours                | 2 hrs  | 15 min  | Critical |
| Customer Support Portal   | 24 hours               | 8 hrs  | 1 hr    | High     |
| Internal HR System        | 72 hours               | 24 hrs | 4 hrs   | Medium   |
| Marketing Analytics       | 2 weeks                | 1 week | 24 hrs  | Low      |
```

### Phase 3: Risk Assessment

Building on the BIA, the **Risk Assessment** identifies specific threats to continuity and evaluates their likelihood and impact. Common threats include:

- **Ransomware** — encrypts systems, preventing access to data
- **DDoS attacks** — overwhelm network infrastructure
- **Third-party vendor failure** — SaaS provider outage
- **Physical facility loss** — fire, flood, building access restriction
- **Key person dependency** — single staff member holds critical knowledge

Each risk is scored (e.g., using a 5×5 likelihood/impact matrix) and mapped to specific BCP controls.

### Phase 4: Strategy Development

For each critical function and identified risk, the BCP defines a **continuity strategy**:

```
Continuity Strategies by Category:

DATA:
  - Hot standby database replication (e.g., MySQL GTID-based replication)
  - Offsite cloud backups (AWS S3 with versioning and MFA delete enabled)
  - Immutable backup storage (Veeam hardened repository)

SYSTEMS:
  - VMware vSphere HA clusters with automatic VM failover
  - Cloud burst capacity via AWS EC2 Auto Scaling
  - Pre-provisioned DR site at geographically separate facility

NETWORK:
  - Dual ISP connections with BGP failover
  - SD-WAN with automatic path switching
  - Out-of-band management network (separate from production)

STAFF:
  - Cross-training matrix documenting backup personnel for each critical role
  - Emergency contact tree with primary, secondary, tertiary contacts
  - Remote work capability pre-tested and documented

FACILITIES:
  - Alternate work site agreements (hot site, warm site, or cold site)
  - Work-from-home policy with VPN and endpoint requirements
```

### Phase 5: Plan Documentation

The BCP document itself typically includes:

1. **Executive Summary and Policy** — Authorizing statement, scope, objectives
2. **BIA Results** — Criticality rankings, RTOs, RPOs
3. **Risk Assessment Summary** — Threat register, risk scores, controls
4. **Emergency Response Procedures** — Immediate actions during an incident
5. **Crisis Communications Plan** — Templates for notifying employees, customers, regulators, and media
6. **IT Continuity Procedures** (often the DRP as an annex)
7. **Recovery Procedures by Scenario** — Step-by-step runbooks per threat type
8. **Vendor/Supplier Contacts** — Emergency contact lists for all critical third parties
9. **Plan Activation Criteria** — Explicit thresholds that trigger BCP activation

### Phase 6: Testing and Maintenance

Testing validates that the plan works before a real incident occurs. There are five standard test types in order of rigor:

```
BCP Test Types:

1. TABLETOP EXERCISE
   - Discussion-based walkthrough with key stakeholders
   - Scenario: "Our primary data center loses power for 48 hours — what do we do?"
   - Effort: Low | Disruption: None

2. WALKTHROUGH / STRUCTURED WALK-THROUGH TEST
   - Each team leader explains their role line-by-line through the plan
   - Identifies gaps and misunderstandings in procedures
   - Effort: Low | Disruption: None

3. SIMULATION TEST
   - Realistic scenario exercise; teams respond as if the event were real
   - IT teams may set up failover systems without cutting over production
   - Effort: Medium | Disruption: Minimal

4. PARALLEL TEST
   - Failover systems are activated and tested simultaneously with production
   - Both primary and DR systems run in parallel
   - Effort: High | Disruption: Low (production untouched)

5. FULL INTERRUPTION / CUTOVER TEST
   - Primary systems are actually taken offline; DR systems handle live traffic
   - Highest confidence; highest risk
   - Effort: Very High | Disruption: Significant
```

---

## Key Concepts

- **Recovery Time Objective (RTO):** The maximum duration an organization can tolerate for a system or process to be unavailable. An RTO of 4 hours means that if systems are not restored within 4 hours, the business consequences become unacceptable. RTO drives decisions about failover automation, hot/warm/cold site design, and staffing.

- **Recovery Point Objective (RPO):** The maximum age of data that must be recoverable after a disaster. An RPO of 15 minutes means backups or replication must be frequent enough that no more than 15 minutes of transactions can be lost. RPO drives decisions about backup frequency, replication technology, and storage architecture.

- **Business Impact Analysis (BIA):** A structured analytical process that identifies critical business functions, their dependencies, and the financial and operational consequences of disruption. The BIA is the foundational input to all BCP strategy decisions and is conducted before strategies or procedures are written.

- **Maximum Tolerable Downtime (MTD) / Maximum Tolerable Period of Disruption (MTPD):** The absolute longest an organization can survive without a particular function before the consequences become catastrophic or unrecoverable (e.g., regulatory license revocation, permanent customer loss). MTD is broader than RTO; if RTO is not met, the organization is operating in dangerous territory until MTD is reached.

- **Hot Site / Warm Site / Cold Site:** Three categories of alternate processing facilities. A **hot site** is a fully equipped, staffed, and mirrored environment that can assume production load within minutes to hours; it is the most expensive. A **warm site** has hardware and connectivity but requires data restoration and configuration; recovery takes hours to days. A **cold site** is an empty facility with power and connectivity where equipment must be procured and configured from scratch; recovery takes days to weeks.

- **Single Point of Failure (SPOF):** Any component whose failure would halt an entire system or process. BCP risk assessments systematically identify SPOFs — a single ISP connection, a single server without HA, a single employee with unique knowledge — and establish controls to eliminate them.

- **Mean Time to Recovery (MTTR):** The average time required to restore a failed component or system to full operation. MTTR is an operational metric used to validate whether technical capabilities can actually meet RTO commitments. Measured through testing and real incident data.

---

## Exam Relevance

The Security+ SY0-701 exam tests BCP concepts under **Domain 5.0: Security Program Management and Oversight**, with particular focus on the relationships between BCP, DRP, and key metrics.

**High-frequency exam topics:**
- **RTO vs. RPO distinction** — Questions frequently present scenarios and ask which metric is being described. Remember: RTO = *time to restore*, RPO = *data age/loss tolerance*.
- **BIA as a prerequisite** — The exam expects you to know that BIA must be completed *before* strategies are developed. Questions may ask about the correct order of BCP activities.
- **Hot/Warm/Cold site definitions** — Know that "hot" = most expensive and fastest, "cold" = cheapest and slowest. A common distractor presents a "cloud-based failover" scenario and asks which site type it most resembles (typically warm or hot).
- **MTD vs. RTO** — MTD is the ceiling; RTO must always be less than MTD. A question may ask: "If MTD is 8 hours, and the RTO is 10 hours, what is the problem?" Answer: RTO exceeds MTD, meaning the plan is inadequate.
- **Tabletop exercise** — Frequently appears in scenario questions. Know that it is discussion-based and does NOT involve system activation.

**Common gotchas:**
- Do not confuse **BCP** (operational continuity of the business) with **DRP** (IT/technical system restoration). The DRP is a *subset* of the BCP.
- **MTTR** is not the same as RTO. MTTR describes historical performance; RTO is a target/requirement.
- **Geographic redundancy** alone does not satisfy BCP requirements — plans, training, and testing are equally required.
- The exam distinguishes between **succession planning** (who fills leadership roles) and **cross-training** (backup personnel for technical roles) — both are BCP components.

---

## Security Implications

### BCP Documents as Attack Targets

The BCP and BIA are among the most sensitive documents an organization possesses. They contain an exhaustive inventory of critical systems, their dependencies, backup locations, vendor contacts, and recovery procedures. An attacker who gains access to these documents effectively has a **blueprint for causing maximum damage** — knowing exactly which systems are highest priority, which have thin recovery capabilities, and what the RPOs are helps adversaries time and target attacks for maximum effect.

**Real-World Incident — Conti Ransomware Playbook Leak (2021):**
When the Conti ransomware group's internal communications were leaked, they revealed that operators specifically sought out backup system documentation and disaster recovery procedures in compromised networks *before* deploying ransomware. By destroying backups first and understanding RTOs, they maximized pressure during ransom negotiations. Organizations with poorly protected BCP documents and backup infrastructure suffered significantly longer recovery times.

### Backup Infrastructure as Attack Surface

If BCP depends on backups and the backups are compromised, the BCP fails. The **Veeam CVE-2023-27532** vulnerability (CVSS 7.5) allowed unauthenticated attackers to access backup infrastructure credentials, directly attacking the recovery capability. Similarly, **CVE-2022-36537** affected ConnectWise ScreenConnect used in many MSP-managed DR environments.

Ransomware groups now routinely target:
- **Veeam and Commvault servers** — attempting to delete or encrypt backup repositories
- **Shadow Volume Copies** — using `vssadmin delete shadows /all /quiet` to eliminate Windows VSS snapshots
- **Cloud backup portals** — credential stuffing against AWS/Azure consoles to delete S3 versioned objects or Azure Blob snapshots

### Insider Threats to BCP Activation

An insider threat actor with knowledge of BCP activation thresholds could deliberately cause conditions that trigger the BCP, forcing the organization into a degraded state with elevated access controls and emergency procedures — conditions that may be more exploitable. Similarly, a disgruntled employee could modify BCP documentation, corrupting procedures at the moment they are most needed.

### Third-Party/Supply Chain Risk

Many BCPs assume vendor availability that may not hold during widespread events. The **2021 Kaseya VSA supply chain attack** disrupted managed service providers (MSPs) that many organizations relied on for their IT continuity operations — the very entities contracted to *execute* the DRP were themselves compromised.

---

## Defensive Measures

**Protect BCP Documentation:**
- Store BCP documents in a **privileged access-controlled repository** (e.g., SharePoint with conditional access, or an offline encrypted vault)
- Apply **classification labels** (e.g., Confidential/Restricted) to all BCP/BIA documents
- Audit access logs to BCP storage locations; alert on anomalous access
- Maintain a **printed or air-gapped copy** of critical BCP procedures — ransomware cannot encrypt paper

**Protect Backup Infrastructure:**
```bash
# Veeam Hardened Repository (Linux) - Enable immutability
# In Veeam console: Backup Infrastructure > Backup Repositories
# > Add Repository > Linux > Enable "Make recent backups immutable for X days"

# Verify immutability flag on Linux repo
lsattr /backups/veeam/ | grep -i immutable

# AWS S3 - Enable MFA Delete and Object Lock
aws s3api put-bucket-versioning \
  --bucket my-backup-bucket \
  --versioning-configuration Status=Enabled,MFADelete=Enabled \
  --mfa "arn:aws:iam::123456789:mfa/admin 123456"

aws s3api put-object-lock-configuration \
  --bucket my-backup-bucket \
  --object-lock-configuration \
    '{"ObjectLockEnabled":"Enabled","Rule":{"DefaultRetention":{"Mode":"COMPLIANCE","Days":30}}