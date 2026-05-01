---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 007
source: rewritten
---

# Zero Trust
**A security model that assumes no entity—user, device, or process—is inherently trustworthy and requires continuous verification for every access request.**

---

## Overview
Traditional networks operate under a "trust the perimeter" model: once traffic passes the [[firewall]], internal systems remain relatively unsecured, allowing both legitimate and malicious actors to move freely. [[Zero Trust Architecture]] flips this assumption entirely—every access attempt, regardless of origin, must pass security verification before granting resource access. For Security+ certification, understanding Zero Trust is critical because it represents the industry shift away from legacy network segmentation toward continuous [[authentication]] and [[authorization]].

---

## Key Concepts

### Implicit Trust vs. Zero Trust
**Analogy**: Imagine a nightclub with one bouncer at the door. Once you're inside, you can wander anywhere—VIP sections, storage rooms, the bar. A zero-trust nightclub would station a bouncer at *every* room, checking your credentials each time, regardless of where you've already been.

**Definition**: [[Implicit Trust]] assumes that traffic inside the network boundary is safe; [[Zero Trust]] assumes nothing is safe and validates *every* connection, *every* time.

| Aspect | Implicit Trust | Zero Trust |
|--------|---|---|
| Perimeter focus | Yes (firewall-centric) | No (distributed verification) |
| Internal movement | Minimal checks | Continuous authentication |
| Lateral movement risk | High | Low |
| User/device trust assumption | Trusted after entry | Never trusted |
| [[MFA]] requirement | Rare internally | Always required |

---

### Verification at Every Layer
**Analogy**: Think of a multi-checkpoint airport security line. You don't show your ID once at the entrance and then walk freely to the plane—you verify at gates, at the boarding area, everywhere.

**Definition**: [[Zero Trust]] requires [[authentication]] and [[authorization]] checks at:
- User login ([[Multi-Factor Authentication]])
- Device access (device compliance validation)
- Network traversal (micro-segmentation checks)
- Application access (resource-level [[access control]])
- Data movement (encryption and inspection)

Every [[user]], [[process]], and [[device]] must prove legitimacy regardless of previous verification.

---

### Control Planes in Zero Trust Architecture
**Analogy**: A security system isn't one giant wall—it's separated into distinct teams: intelligence gathering (monitoring), decision-making (policy), and enforcement (execution). Each team works independently but in coordination.

**Definition**: [[Zero Trust]] implementations use [[Control Planes]] to compartmentalize security functions:

| Control Plane | Function | Example |
|---|---|---|
| [[Data Plane]] | Enforces access decisions | [[Firewall]] rules, [[encryption]] |
| [[Control Plane]] | Makes policy decisions | Identity verification, resource mapping |
| [[Management Plane]] | Monitors & audits activity | [[SIEM]] logging, threat detection |
| [[Observation Plane]] | Gathers intelligence | [[Network monitoring]], behavior analysis |

This modular approach allows organizations to apply zero-trust principles across [[physical devices]], [[virtual machines]], and [[cloud]] environments uniformly.

---

### Implementation Components
**Analogy**: Building a zero-trust network is like upgrading from a single lock on your front door to having locks on every room, window, and cabinet—plus security cameras everywhere and guards verifying everyone.

**Definition**: Zero Trust requires layering multiple technologies:

- [[Multi-Factor Authentication (MFA)]]—Verify user identity beyond passwords
- [[Encryption at Rest and in Transit]]—Protect data whether stored or moving
- [[Micro-Segmentation]]—Create isolated network zones requiring re-verification
- [[Least Privilege Access]]—Grant minimum necessary permissions
- [[Continuous Monitoring]]—Real-time threat detection and response
- [[Network Access Control (NAC)]]—Device compliance validation before connection
- [[Zero Trust Gateways]]—Advanced [[firewall]] enforcement at access points

---

## Exam Tips

### Question Type 1: Identifying Zero Trust Principles
- *"Which of the following best describes zero trust architecture?"* → "A security model that requires verification of every user, device, and request regardless of network location."
- **Trick**: Don't confuse [[VPN]] access or [[DMZ]] segmentation with true zero trust—those still assume some internal trust.

### Question Type 2: Implementation Scenarios
- *"A company wants to implement zero trust. Which control should be prioritized first?"* → [[MFA]] and [[identity verification]], as they're foundational to all other zero-trust controls.
- **Trick**: Questions may present "single firewall upgrades" as solutions—zero trust is *layered*, not single-point.

### Question Type 3: Component Recognition
- *"Which of the following is NOT part of zero trust architecture?"* → Watch for answers mentioning "trusted internal networks" or "perimeter-only security."
- **Trick**: [[Network segmentation]] alone ≠ zero trust; zero trust requires *verification* inside segments.

### Question Type 4: Breach Scenario Analysis
- *"An attacker gains valid credentials for one user. Under zero trust, what prevents lateral movement?"* → [[Micro-segmentation]], [[continuous authentication]], and [[least privilege access]].
- **Trick**: Don't select answers about "strong perimeter defenses"—zero trust assumes the perimeter is already breached.

---

## Common Mistakes

### Mistake 1: Confusing Zero Trust with Network Segmentation
**Wrong**: "We use [[VLANs]] and [[DMZs]], so we have zero trust."
**Right**: Segmentation is *part* of zero trust, but zero trust also requires active verification at every segment boundary, encryption, [[MFA]], and continuous monitoring.
**Impact on Exam**: You may see questions asking which security control "best complements" zero trust—segmentation alone is incomplete.

### Mistake 2: Thinking Zero Trust Only Applies to Users
**Wrong**: "Zero trust means we authenticate users at login and then they can access anything."
**Right**: Zero trust validates *every* request—users, devices, processes, and data flows all require continuous verification.
**Impact on Exam**: Questions will test whether you understand that [[service-to-service authentication]] and [[device trust]] are equally important as user authentication.

### Mistake 3: Assuming Zero Trust Eliminates Firewalls
**Wrong**: "Zero trust means we don't need firewalls anymore."
**Right**: Firewalls become *more important* in zero trust but operate differently—as [[micro-segmentation]] enforcement points rather than perimeter guardians.
**Impact on Exam**: Don't select answers that suggest zero trust removes traditional security appliances; it redistributes and enhances them.

### Mistake 4: Overlooking the "Continuous" Aspect
**Wrong**: "We verify once per session, and the user is trusted for that session."
**Right**: Zero trust implies *ongoing* verification—re-authentication, behavior analysis, and compliance checks continue throughout the session.
**Impact on Exam**: Questions testing zero trust principles will emphasize "continuous," "ongoing," and "every request"—not just initial access.

### Mistake 5: Underestimating Encryption's Role
**Wrong**: "Zero trust is mainly about authentication; encryption is secondary."
**Right**: [[Encryption at rest and in transit]] is a foundational zero-trust control that prevents data exposure even if credentials are compromised.
**Impact on Exam**: Expect questions pairing zero trust implementation with encryption requirements.

---

## Related Topics
- [[Multi-Factor Authentication (MFA)]]
- [[Micro-Segmentation]]
- [[Least Privilege Access (LPA)]]
- [[Network Access Control (NAC)]]
- [[Identity and Access Management (IAM)]]
- [[Encryption]]
- [[Continuous Monitoring]]
- [[Defense in Depth]]
- [[Firewall Architecture]]
- [[Cloud Security]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*