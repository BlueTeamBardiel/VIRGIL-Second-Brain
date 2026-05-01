---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 121
source: rewritten
---

# User Training
**Building a security-conscious workforce through structured education and awareness programs.**

---

## Overview
User training forms the foundation of any organizational [[Security Program]], serving as a critical control that transforms employees into active defenders against threats. For Security+ purposes, understanding how to design, implement, and measure user education initiatives is essential—because even the strongest technical controls fail when people lack security awareness and judgment.

---

## Key Concepts

### Onboarding Security Training
**Analogy**: Think of security training like driver's education—you wouldn't hand someone keys before they understand traffic laws and defensive driving techniques. Similarly, users shouldn't access network resources before learning organizational security expectations.

**Definition**: Mandatory [[Security Awareness Training]] delivered to new employees *before* their first connection to corporate systems, establishing baseline knowledge of policies, acceptable use standards, and threat recognition.

Key timing elements:
| Timing | Purpose |
|--------|---------|
| **Pre-access** | Establishes foundational knowledge before risk exposure |
| **During onboarding** | Integrates security into organizational culture from day one |
| **Documented completion** | Creates accountability and compliance records |

---

### Role-Based Security Training
**Analogy**: A surgeon and a receptionist need different medical training—they face different risks and responsibilities. Security training works the same way.

**Definition**: Customized [[Security Training]] tailored to departmental functions and data access levels. An [[Accounting Department]] faces different threats (financial fraud, data theft) than [[Shipping and Receiving]] (physical security, social engineering at loading docks).

| Department | Primary Threat | Training Focus |
|------------|----------------|-----------------|
| **Accounting** | Financial fraud, unauthorized transfers | Payment verification, suspicious requests |
| **Shipping/Receiving** | Physical security breaches, credential theft | Package handling, visitor verification |
| **IT/Security** | Advanced persistent threats, zero-days | Incident response, threat intelligence |
| **HR** | Credential stuffing, impersonation attacks | Verification procedures, social engineering |

---

### Third-Party and Contractor Training
**Analogy**: Guests entering your home need to understand your house rules, even if they don't live there permanently.

**Definition**: [[Security Training]] extended to external stakeholders including [[Contractors]], [[Business Partners]], [[Suppliers]], and temporary service providers who access organizational networks or systems. This creates a security perimeter beyond employee boundaries.

Critical considerations:
- [[Vendor Management]] requirements
- Temporary access protocols
- Liability and contractual obligations
- [[Non-Disclosure Agreements (NDAs)]] enforcement

---

### Training Completion Tracking
**Analogy**: A restaurant health inspection isn't just about cooking—inspectors verify *documentation* proves safe practices occurred consistently.

**Definition**: Systematic [[Documentation]] and audit trails recording which personnel have completed required [[Security Training]], establishing organizational compliance posture and identifying gaps.

Why this matters:
- Regulatory compliance requirements ([[HIPAA]], [[PCI-DSS]], [[SOX]])
- [[Risk Assessment]] baseline verification
- Accountability during security incidents
- Insurance and audit defense

---

### Security Policy Documentation
**Analogy**: Imagine playing a sport with unwritten rules—players would interpret them differently and conflict would result. Written policies eliminate ambiguity.

**Definition**: Comprehensive, accessible [[Security Policies]] covering acceptable use, password standards, data handling, and incident reporting, distributed through multiple channels and integrated into employee handbooks.

Distribution methods:
- Online policy portals (always-available reference)
- Employee handbook inclusion (contractual acknowledgment)
- [[Learning Management Systems (LMS)]] with tracked completion
- Department-specific supplements

---

### Situational Awareness and Threat Recognition
**Analogy**: A security guard doesn't just watch cameras during specific hours—they maintain constant vigilance, noticing anything unusual. Users need the same mindset.

**Definition**: Ongoing employee capability to identify and report suspicious activity across all work contexts, moving beyond passive compliance to active threat detection.

Critical threat categories users must recognize:

| Threat Type | Recognition Indicators | User Response |
|------------|------------------------|----------------|
| **[[Phishing]] Emails** | Unusual sender addresses, urgent language, request for credentials | Report to security team, do not click |
| **[[Smishing]]** | Text messages requesting verification, clicking links | Verify through official channels only |
| **Malicious URLs** | Shortened links, domains mimicking legitimate services | Hover to verify, do not click blind |
| **[[Physical Security Breaches]]** | Tailgating, unsecured USB devices, impersonation | Challenge unknown persons, verify identity |
| **Pretexting** | Callers claiming authority, requesting sensitive data | Never confirm identity over phone, verify separately |
| **Malware-Carrying Devices** | USB drives left in parking lots, suspicious flash media | Never connect unknown devices, report immediately |

---

## Exam Tips

### Question Type 1: Training Program Implementation
- *"An organization wants to ensure all new hires understand security requirements before accessing company systems. Which approach best addresses this?"* → **Pre-employment or onboarding security training** before network access is granted.
- **Trick**: Don't confuse "ongoing awareness" with "initial onboarding"—Security+ distinguishes between foundational training (happens once) and continuous awareness (happens repeatedly).

### Question Type 2: Third-Party Risk Management
- *"A company contracts with external consultants who need temporary system access. What should be included in their security training?"* → [[Role-Based Access]] requirements specific to their contracted scope, not full employee-level training.
- **Trick**: Contractors don't need the same depth of organizational training as employees, but they *do* need access-specific guidelines and [[NDAs]].

### Question Type 3: Compliance and Documentation
- *"Which of the following best ensures an organization can prove security training occurred?"* → **Documented completion records** with timestamps, signatures, and assessment scores.
- **Trick**: The policy existing isn't enough—Security+ focuses on *verification* that training actually happened.

### Question Type 4: Threat Recognition
- *"An employee receives an email appearing to come from the CFO requesting an urgent wire transfer. The employee should..."* → **Report to security team and verify through alternate communication channel** before taking action.
- **Trick**: These scenarios test [[Situational Awareness]]—right action is *always* to verify suspicious requests independently, not to assume authenticity.

---

## Common Mistakes

### Mistake 1: Treating All Training Identically
**Wrong**: Delivering the same generic security training to accounting staff, developers, and warehouse workers.
**Right**: Customizing training content to reflect departmental threats, data access levels, and role-specific risks ([[Risk-Based Training]]).
**Impact on Exam**: Questions may present a scenario requiring "appropriate training for role X"—generic answers will be marked incorrect. Security+ expects you to recognize that threat profiles vary by position.

---

### Mistake 2: Forgetting Documentation Matters
**Wrong**: Conducting excellent training but failing to track attendance, scores, or completion dates.
**Right**: Maintaining formal records proving *when* training occurred, *who* attended, and *what assessment scores* they achieved.
**Impact on Exam**: Compliance questions hinge on documentation—a perfectly trained workforce with no records is a compliance liability. Questions may ask "how would you prove training compliance during an audit?"

---

### Mistake 3: One-Time Training Sufficiency
**Wrong**: Assuming employees trained once during onboarding remain security-aware indefinitely.
**Right**: Implementing [[Security Awareness Training]] as ongoing/recurring requirement, with refreshers when threats evolve or after security incidents.
**Impact on Exam**: Don't confuse "initial onboarding" with "continuous awareness." Questions about maintaining organizational security posture emphasize *recurring* training and updates to address emerging threats.

---

### Mistake 4: Underestimating Physical Security Training
**Wrong**: Focusing training exclusively on digital threats (phishing, malware) while ignoring physical attack vectors.
**Right**: Including guidance on [[Dumpster Diving]] prevention, USB device handling, tailgating detection, and social engineering via pretext calls.
**Impact on Exam**: Security+ treats physical and digital threats equally—questions may present a scenario where the threat vector is a mysterious USB device or tailgating attempt. Users trained only on email attacks will miss these.

---

### Mistake 5: Not Addressing Third-Party Training Separately
**Wrong**: Assuming contractors and vendors understand organizational policies automatically or require no training.
**Right**: Providing role-specific training covering systems they'll access, acceptable use boundaries, and incident reporting procedures.
**Impact on Exam**: Third-party risk management is a major Security+ domain—questions test whether you'd extend training programs to vendors/contractors accessing sensitive resources.

---

## Related Topics
- [[Security Awareness Training]]
- [[Phishing Simulation and Testing]]
- [[Policy Development and Distribution]]
- [[Role-Based Access Control (RBAC)]]
- [[Third-Party Risk Management]]
- [[Compliance and Regulatory Standards]]
- [[Security Culture]]
- [[Incident Response Training]]
- [[Data Classification Training]]
- [[Acceptable Use Policy (AUP)]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]] | [[User Education and Training Domain]]*