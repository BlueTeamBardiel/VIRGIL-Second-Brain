---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# VIIII. Building an Incident Response Program
**A structured playbook for detecting, containing, and learning from security breaches.**

---

## Overview

Think of an incident response program like a fire department—you need trained personnel, pre-positioned equipment, clear communication channels, and a playbook *before* the fire starts, not after. [[Incident Response]] is the organizational capability to systematically identify, investigate, contain, remove, and restore systems compromised by attackers. Security analysts need to understand this because incidents happen constantly in modern networks, and the difference between a 10-minute containment and a 10-day breach often comes down to having a mature IR program in place.

---

## Key Concepts

### Security Events vs. Security Incidents

**Analogy**: A security event is like seeing a car door slightly ajar in a parking lot—it *might* mean something, but it could also mean nothing. A security incident is like finding the car actually missing—a clear violation of what *should* be happening.

**Definition**: A [[security event]] is any detectable activity on a system or network (failed login, firewall block, malware signature match). A [[security incident]] is one or more events that actually *violate* or *threaten to violate* your organization's security policy (confirmed malware infection, verified data theft, unauthorized system access).

| Aspect | Event | Incident |
|--------|-------|----------|
| **Scope** | Single occurrence | One or more events combined |
| **Threat Level** | May or may not be malicious | Confirmed policy violation |
| **Examples** | Port scan, failed auth, alert fire | Ransomware execution, data exfil, breach |
| **Action Required** | Investigation | Full IR activation |

**Key Exam Rule**: Every [[incident]] contains multiple [[events]], but not every [[event]] becomes an [[incident]].

---

### The Incident Response Lifecycle (NIST SP 800-61)

**Analogy**: Like a medical trauma protocol—preparation prevents poor performance, immediate diagnosis guides treatment, controlled containment stops bleeding, follow-up prevents infection, and debrief prevents future injuries.

#### **Phase 1: Preparation**

**Definition**: Building the foundational systems, people, and processes *before* an attack happens.

- [[IR policies]], [[playbooks]], and [[procedures]] documented and approved
- [[CSIRT]] (Computer Security [[Incident Response]] Team) recruited, trained, and on-call
- [[Logging]], [[monitoring]], and [[NTP]] (time sync) configured across infrastructure
- [[Legal]], [[HR]], [[PR]], and [[law enforcement]] coordination plans pre-negotiated
- [[Detection rules]], [[SIEM]] correlations, and [[threat intelligence]] feeds active

**Reality**: Organizations that skip preparation don't fail faster—they fail *catastrophically*.

#### **Phase 2: Detection and Analysis**

**Definition**: Identifying that something malicious happened and gathering evidence about what, where, and when.

Data sources feeding analysis:
- [[SIEM]] alerts and correlation rules
- [[IDS]]/[[IPS]] triggered signatures
- [[EDR]] (Endpoint Detection and Response) behavioral alerts
- Antivirus quarantine logs
- OS event logs, application logs, network device logs
- Third-party managed detection services

Key discipline: **Confirm before reacting.** False positives can trigger unnecessary isolation that harms business. Analysts validate alerts using multiple data sources to reduce noise.

#### **Phase 3: Containment, Eradication, and Recovery**

**Definition**: Stop the attack, remove the attacker, and restore normal operations.

- **[[Containment]]** (Immediate): Isolate compromised systems to stop lateral movement and data theft. Short-term actions (disable account, pull network cable, block IP). Long-term actions (network segmentation, patching, credential rotation).
- **[[Eradication]]** (Complete Removal): Hunt down and destroy all malware, backdoors, shells, and attacker-created accounts. Incomplete eradication = re-infection.
- **[[Recovery]]** (Restoration): Rebuild or restore systems from clean backups. Monitor heavily for signs the attacker returns.

**Critical Balance**: Speed limits damage, but destroying evidence or acting without forensic preservation ruins investigations and legal cases.

#### **Phase 4: Post-Incident Activities**

**Definition**: Learning and improving so the same attack doesn't work twice.

- Conduct [[lessons learned]] session (what happened, how did we miss it, what stops it next time?)
- Perform [[root cause analysis]]—don't just fix the symptom
- Retain [[evidence]] per legal holds and policy (often 3-7 years)
- Update [[detection rules]], [[SIEM]] queries, [[playbooks]], and [[threat intelligence]]
- Patch systems, implement new segmentation, strengthen access controls

---

### CSIRT (Computer Security Incident Response Team)

**Analogy**: Like a hospital emergency department—you need surgeons, nurses, administrators, and staff trained to work together under stress.

**Definition**: A designated team with clear authority and accountability for managing security incidents.

| Role | Examples | Responsibility |
|------|----------|-----------------|
| **Core Technical** | Incident handlers, forensic analysts, threat hunters | Triage, analysis, containment |
| **Extended** | IT operations, system admins | System restoration, evidence collection |
| **Non-Technical** | Legal, HR, PR, C-suite | Compliance, communication, liability |
| **External** | Law enforcement, threat intelligence partners | Investigation support, attribution |

Success factors:
- Pre-defined escalation authority (who can isolate what without approval chains that slow response?)
- Executive sponsorship (IR decisions sometimes break business processes—needs C-level backing)
- Clear contact trees and availability (on-call rotation, not single points of failure)

---

### Incident Classification and Severity

**Analogy**: Like hospital triage—a scraped knee is different from a gunshot wound, but both need categorized response.

#### **Classification by Attack Vector**

- [[External attack]] or [[removable media]] (USB drops, physical theft)
- [[Attrition attack]] ([[DDoS]], resource exhaustion)
- [[Web attack]] (injection, XSS, web shell)
- [[Email attack]] (phishing, malicious attachment)
- [[Impersonation]] (social engineering, credential abuse)
- [[Improper usage]] (insider abuse, policy violation)
- [[Loss or theft of equipment]] (laptop stolen, unencrypted drive missing)

---

#### **Severity Scoring (Multi-Dimensional)**

Severity isn't one number—it's a combination of impact factors:

| Dimension | Examples | Impact |
|-----------|----------|--------|
| **Functional Impact** | Service unavailable vs. degraded vs. none | How crippled is the business? |
| **Economic Impact** | Revenue loss, recovery costs, fines, lawsuits | Dollar amount of damage |
| **Recoverability Effort** | Hours vs. days vs. weeks to restore | Resource drain and downtime cost |
| **Information Impact** | Public data vs. internal vs. regulated (PII/PHI/PCI) | Regulatory fines, reputation |

**Exam Tip**: An attack stealing 10,000 credit card numbers = *critical* (regulatory impact). An attack disrupting internal email for 2 hours = *medium* (functional impact only, recoverable quickly).

---

### Attack Modeling Frameworks

#### **Diamond Model of Intrusion Analysis**

**Analogy**: Like investigating a crime—who did it, what tools did they use, where were they operating from, and who was the target?

**Definition**: A four-node model mapping the core elements of a cyber attack.

```
        Adversary
           / \
          /   \
    Capability - Infrastructure
         \   /
          \ /
         Victim
```

- **[[Adversary]]**: Nation-state, criminal group, hacktivist, insider
- **[[Capability]]**: Tools (malware, exploits, frameworks like Cobalt Strike)
- **[[Infrastructure]]**: C2 servers, proxies, hosting providers, botnets
- **[[Victim]]**: Organization, individual, or system targeted

Use cases: Correlate seemingly unrelated incidents (same infrastructure = same campaign), predict adversary behavior, attribute attacks.

---

#### **Lockheed Martin Cyber Kill Chain**

**Analogy**: A military battle plan—reconnaissance, weapon assembly, delivery, strike, entrenchment, command structure, objective. Defenders win by interrupting *any* stage.

**Definition**: A seven-stage progression model showing how attackers move from reconnaissance to achieving their goal.

| Stage | Definition | Defender Break Point |
|-------|-----------|----------------------|
| **1. Reconnaissance** | Target research, OSINT, scanning, network enumeration | Egress filtering, OSINT hardening |
| **2. Weaponization** | Malware creation, exploit development, payload assembly | Code signing enforcement, AV detection |
| **3. Delivery** | Phishing email, watering hole, USB drop, direct deployment | Email filtering, URL blocking, physical security |
| **4. Exploitation** | Vulnerability triggered, exploit executed, code runs | Patching, EDR behavior detection |
| **5. Installation** | Persistence mechanism deployed (backdoor, registry key, cron job) | File integrity monitoring, [[EDR]] |
| **6. Command & Control** | Attacker establishes remote communication channel | [[network segmentation]], DNS sinkholing, IDS/IPS |
| **7. Actions on Objectives** | Data theft, lateral movement, system destruction, ransom | [[DLP]], [[logging]], [[incident response]] |

**Limitations**: Assumes external attacker (poor at insider threats), emphasizes perimeter defense (weak on internal detection), doesn't address post-breach persistence well.

---

#### **MITRE ATT&CK Framework**

**Analogy**: Instead of a linear chain, this is a *matrix* showing all the techniques attackers actually use—like a playbook of every offensive move ever documented.

**Definition**: A behavior-based adversary model mapping [[tactics]] (what attackers *try* to do), [[techniques]] (how they do it), and [[procedures]] (the specific tools and sequences).

**Structure**:
- [[Tactic]]: Objective (e.g., "Initial Access," "Persistence," "Exfiltration")
- [[Technique]]: Method under that tactic (e.g., "Phishing" under Initial Access)
- [[Sub-technique]]: Specific variant (e.g., "Spearphishing Link" or "Spearphishing Attachment")

**Analyst Use**:
- Detection engineering (map SIEM rules to ATT&CK techniques)
- [[Threat hunting]] (search for known techniques in your logs)
- Threat intelligence (correlate detected techniques to known campaigns)

**Exam Focus**: CompTIA expects you to recognize ATT&CK tactics/techniques in scenarios and map them correctly.

---

#### **Unified Kill Chain**

**Analogy**: Takes both the military chain-of-command model and the full playbook approach, blending linear progression with tactical depth.

**Definition**: A hybrid framework combining the Cyber Kill Chain's *progression* with ATT&CK's *comprehensive technique coverage*.

Strengths:
- Covers *external* attacks (traditional Kill Chain)
- Covers *internal* attacks and lateral movement (ATT&CK depth)
- Addresses defender stages: Detect, Deny, Disrupt, Degrade, Deceive, Defend

---

## Analyst Relevance

A [[SOC]] analyst working for a financial services firm receives a SIEM alert: "Unusual PowerShell execution from accounting workstation."

**Without an IR program**: Analyst is confused about whether to escalate, unsure where to look for context, can't isolate the system without breaking the bank's reconciliation process, has no playbook, and wastes 2 hours emailing around asking "is this bad?"

**With an IR program**: 
1. Analyst immediately executes the "Suspicious PowerShell" [[playbook]]
2. Playbook tells her to: check EDR, pull process memory, check for C2 callbacks, review account activity
3. She confirms it's actual malware, not a false positive
4. Escalation path is pre-defined—she notifies the incident commander
5. IC coordinates with network ops to isolate the workstation *during a scheduled maintenance window* (pre-planned)
6. Forensics team has evidence collection procedures ready
7. Post-incident, her team updates the playbook to catch this specific malware faster next time

**Real outcome**: 15-minute containment instead of