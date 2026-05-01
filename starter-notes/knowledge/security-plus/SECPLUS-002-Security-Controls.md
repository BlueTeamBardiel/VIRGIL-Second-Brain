---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 002
source: rewritten
---

# Security Controls
**Layered defensive mechanisms that work together to stop threats, reduce damage, and limit organizational risk.**

---

## Overview
Organizations face constant threats from attackers seeking unauthorized system access. Rather than relying on a single defense, security professionals deploy multiple control types across technical systems, policies, and operational procedures. Understanding control categories is critical for Security+ because exam questions frequently ask you to identify which control type addresses specific security scenarios or business requirements.

---

## Key Concepts

### Technical Controls
**Analogy**: Think of technical controls as the electronic locks, security cameras, and alarm systems protecting a bank building—they're automated, software or hardware-based solutions that enforce security rules without human intervention.

**Definition**: Computer-based mechanisms that automatically enforce security policies through [[Operating System|operating systems]], [[Network Security|network devices]], and application settings. These execute rules regardless of user intent.

**Examples**:
- [[Access Control Lists]] (ACLs) restricting file permissions
- [[Firewall|Firewalls]] blocking unauthorized traffic
- [[Antivirus]] software scanning for malware
- [[Encryption]] protecting data in transit and at rest
- [[Multi-factor Authentication]] requiring multiple verification methods

| Control Type | Implementation | Enforcement |
|---|---|---|
| Technical | Hardware/Software | Automatic |
| Managerial | Documentation/Process | Human Review |
| Operational | Daily Procedures | Staff Action |

---

### Managerial Controls
**Analogy**: Managerial controls are like an employee handbook—they guide human behavior through documented standards, but they only work if people actually read and follow them.

**Definition**: Policy-based security frameworks that establish organizational standards, procedures, and governance structures. These require human interpretation and adherence to be effective.

**Examples**:
- [[Security Policy|Information security policies]]
- [[Acceptable Use Policy|Acceptable Use Policies (AUP)]]
- Risk assessment frameworks
- Incident response procedures
- Employee security awareness training documentation

---

### Operational Controls
**Analogy**: Operational controls resemble a restaurant's daily food safety checklist—they're concrete actions employees perform every shift to maintain security hygiene.

**Definition**: Day-to-day security activities and procedures that staff execute to maintain secure operations. They bridge technical enforcement and policy intent.

**Examples**:
- [[Patch Management]] schedules
- User account provisioning/deprovisioning processes
- [[Security Awareness Training]] delivery
- Backup execution and verification
- Physical access badge management

---

## Control Purpose Categories (Additional Framework)

### Preventive Controls
**Definition**: Systems designed to stop unauthorized actions before they occur.
- [[Network Segmentation]] preventing lateral movement
- Firewall rules blocking malicious traffic

### Detective Controls
**Definition**: Mechanisms that identify security incidents after they happen.
- [[Security Information and Event Management|SIEM]] tools detecting intrusions
- [[Audit Logging]] revealing unauthorized access attempts

### Corrective Controls
**Definition**: Actions taken to restore systems after a security event.
- [[Disaster Recovery]] procedures
- [[Incident Response]] playbooks

### Compensating Controls
**Definition**: Alternative safeguards when primary controls aren't feasible.
- Manual verification when automated systems fail
- Increased monitoring when [[Patching]] delays occur

---

## Exam Tips

### Question Type 1: Identifying Control Categories
- *"A company implements password policies requiring 12+ characters and quarterly changes. This is an example of which control type?"* → **Managerial** (policy-based, requires human adherence)
- *"An administrator configures a firewall rule blocking port 23. Which control type is this?"* → **Technical** (automatic enforcement)
- **Trick**: Don't confuse "preventive/detective" (purpose) with "technical/managerial/operational" (implementation method). A single control can be both technical AND preventive.

### Question Type 2: Control Effectiveness Scenarios
- *"Which control would BEST reduce the impact of a ransomware attack that got past defenses?"* → **Corrective control** like off-site backups (after infection, restore from backup)
- **Trick**: Preventive controls stop attacks; corrective controls minimize damage. Exam often asks which you need when first line of defense fails.

### Question Type 3: Control Selection for Requirements
- *"An organization needs to ensure employees understand data classification rules. Which approach is appropriate?"* → **Managerial control** via security training and [[Data Classification]] policy documentation
- **Trick**: Technical controls can't teach behavior—only policy and training can.

---

## Common Mistakes

### Mistake 1: Confusing Control Type with Control Purpose
**Wrong**: "A firewall is a detective control because it detects attacks."
**Right**: "A firewall is a technical control with a preventive purpose—it stops attacks before entry, not after detection."
**Impact on Exam**: You'll select wrong answers on scenario questions asking you to match controls to organizational needs. Understand that "technical/managerial/operational" describes HOW controls work, while "preventive/detective/corrective" describes WHAT they accomplish.

### Mistake 2: Assuming Managerial Controls Are Less Important
**Wrong**: "We don't need policy documentation if we have firewalls."
**Right**: Technical controls enforce rules within defined parameters, but policies define what those parameters should be and why they matter organizationally.
**Impact on Exam**: Questions testing governance frameworks, compliance requirements, or incident response will expect you to recognize policies as foundational controls. Ignoring them costs points.

### Mistake 3: Overlooking Operational Controls as Real Security
**Wrong**: "Only technical controls actually secure systems."
**Right**: Operational controls like patch management and access provisioning directly prevent vulnerabilities and unauthorized access—they're essential daily execution of policy intent.
**Impact on Exam**: Scenario questions about "what the security team should do this week" are testing operational control understanding. These appear frequently in real exams.

### Mistake 4: Missing Compensating Control Scenarios
**Wrong**: "The organization must upgrade to the latest firewall version immediately."
**Right**: "While waiting for the approved budget, implement compensating controls like increased network monitoring and traffic analysis."
**Impact on Exam**: Security+ values practical decision-making. Questions may ask "what can you do RIGHT NOW with existing resources?"—testing compensating control thinking.

---

## Related Topics
- [[Risk Management]]
- [[Access Control]]
- [[Network Security]]
- [[Cryptography]]
- [[Incident Response]]
- [[Security Governance]]
- [[Threat Management]]
- [[Vulnerability Management]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*