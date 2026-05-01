---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 029
source: rewritten
---

# Zero Trust
**A security philosophy that treats every user, device, and application as potentially hostile until proven trustworthy.**

---

## Overview
For decades, network security relied on a "castle and moat" model—fortify the perimeter and trust everything inside. Zero Trust flips this completely: assume breach and verify everything, everywhere. On the Network+ exam, you'll encounter Zero Trust as a fundamental shift from traditional [[perimeter security]] to continuous verification, and understanding its implementation matters for real-world scenarios involving [[access control]], [[encryption]], and [[network segmentation]].

---

## Key Concepts

### Zero Trust Architecture
**Analogy**: Instead of a nightclub that checks your ID at the door and then lets you roam freely, Zero Trust is like a museum where every exhibit requires you to re-verify your credentials and prove your reason for being there—every single time.

**Definition**: A [[security framework]] requiring continuous [[authentication]], [[authorization]], and [[encryption]] for all users, devices, and traffic, regardless of location or previous trust status.

| Traditional Perimeter Security | Zero Trust Security |
|---|---|
| Trust internal traffic by default | Verify all traffic, always |
| Firewall at network edge | Firewalls at every access point |
| Username/password sufficient | Multi-factor authentication required |
| Limited internal monitoring | Continuous monitoring and logging |
| Static access policies | Dynamic, context-aware policies |

---

### Authentication & Verification
**Analogy**: Think of traditional authentication as showing your driver's license once at airport check-in. Zero Trust authentication is like being asked for your ID again at security, at the gate, and before boarding—proving your identity repeatedly based on context.

**Definition**: The process of confirming user identity before granting access, enhanced by continuous verification and [[multi-factor authentication (MFA)]].

Key authentication mechanisms include:
- Username and password (baseline)
- [[MFA|Multi-factor authentication]] (SMS, TOTP, biometrics)
- [[Single Sign-On (SSO)]]
- [[Certificate-based authentication]]

---

### Adaptive Identity
**Analogy**: A bank teller treats a regular customer withdrawing $100 differently than a stranger trying to wire $50,000 internationally. Adaptive identity adjusts trust levels based on who you are and what you're doing.

**Definition**: An [[authentication]] approach that dynamically evaluates trust based on user identity, device posture, location, and behavior patterns.

**Context factors evaluated:**
- Employee tenure and role
- Geographic location of login
- Device health and patch status
- Time of access
- Resource sensitivity
- Historical behavior patterns

---

### Policy-Based Access Control
**Analogy**: Instead of "everyone in the building can access the kitchen," policies state "only employees with catering badge, during business hours, from known devices, can access the kitchen."

**Definition**: Rules-driven [[access control]] that grants or denies permissions based on organizational policies, device compliance, and user context—not just group membership.

```
POLICY EXAMPLE:
IF user == "employee" 
   AND device_compliant == true 
   AND location == "corporate_network" OR "VPN"
   AND time >= 08:00 AND time <= 18:00
   AND mfa_verified == true
THEN grant_access(resource)
ELSE deny_access()
```

---

### Encryption & Data Protection
**Analogy**: Zero Trust doesn't just lock the front door—it locks every document in a safe, even though they're all inside the building.

**Definition**: End-to-end [[encryption]] applied to all data in transit and at rest, preventing unauthorized access even if network compromise occurs.

**Implementation methods:**
- [[TLS/SSL]] for data in transit
- [[AES]] encryption for data at rest
- [[VPN]] or [[zero trust network access (ZTNA)]]
- Application-level encryption

---

### Continuous Monitoring & Logging
**Analogy**: Instead of checking who entered once at the door, you have cameras watching every hallway, recording every action, and flagging unusual behavior in real-time.

**Definition**: Real-time observation of all network traffic, user actions, and device behavior with automated [[threat detection]] and incident response.

**Key monitoring elements:**
- [[User and Entity Behavior Analytics (UEBA)]]
- [[Security Information and Event Management (SIEM)]]
- [[Intrusion Detection System (IDS)]]
- Device telemetry and logging

---

### Microsegmentation
**Analogy**: Instead of one large building where people move freely, create small rooms where each room requires separate verification—employees can't move between rooms without re-authentication.

**Definition**: Division of the network into small, isolated zones requiring individual [[authentication]] and [[authorization]] before access—preventing lateral movement.

| Traditional Network | Microsegmented Network |
|---|---|
| One large trusted zone | Multiple trust zones |
| Lateral movement unrestricted | Restricted inter-zone traffic |
| Breach spreads easily | Breach contained to segment |
| Few [[firewall]] rules | Granular [[firewall]] rules per segment |

---

## Exam Tips

### Question Type 1: Zero Trust Philosophy
- *"Your organization wants to implement a security model where all traffic is encrypted, all users are authenticated continuously, and every device must prove compliance. Which approach best describes this?"* → **Zero Trust Architecture**
- **Trick**: Don't confuse Zero Trust with simply "adding firewalls"—it's about verification and continuous trust evaluation, not just barriers.

### Question Type 2: Adaptive Identity Components
- *"A Zero Trust system denies an employee's access attempt from an unknown geographic location at 2 AM on an unpatched device. Which concept is being applied?"* → **Adaptive Identity with policy-based access**
- **Trick**: Adaptive identity isn't just location-based—it weighs multiple factors simultaneously.

### Question Type 3: Implementation Technologies
- *"Which of the following technologies would NOT be part of a Zero Trust implementation: A) [[VPN]], B) [[MFA]], C) Perimeter firewall only, D) [[UEBA]]?"* → **C) Perimeter firewall only**
- **Trick**: Zero Trust requires defense-in-depth, not just edge protection. Internal monitoring and segmentation are critical.

### Question Type 4: Microsegmentation
- *"After a breach, you want to prevent attackers from moving laterally through your network. What Zero Trust component should you implement?"* → **Microsegmentation**
- **Trick**: Microsegmentation works alongside [[VLANs]] and [[firewalls]], but goes deeper with per-application access control.

---

## Common Mistakes

### Mistake 1: Confusing Zero Trust with VPN-Only Access
**Wrong**: "We implemented Zero Trust because all employees use VPN."
**Right**: VPN is one layer. Zero Trust requires VPN + [[MFA]] + device compliance checks + continuous monitoring + microsegmentation + encryption.
**Impact on Exam**: You'll see questions asking "what's missing from this Zero Trust deployment?"—VPN alone isn't enough.

### Mistake 2: Believing Trust Increases Over Time
**Wrong**: "Once a user authenticates once, they're trusted for the session."
**Right**: Zero Trust performs continuous verification. A user's trust level can change mid-session if behavior becomes suspicious or device compliance fails.
**Impact on Exam**: Expect questions about re-authentication and continuous verification, not one-time access grants.

### Mistake 3: Overlooking Device Posture
**Wrong**: "Zero Trust is just about user authentication."
**Right**: Device health, patch levels, antivirus status, and encryption are mandatory components of Zero Trust access decisions.
**Impact on Exam**: Questions may ask about denying access from a compliant user on a non-compliant device.

### Mistake 4: Thinking Zero Trust Eliminates All Firewalls
**Wrong**: "Zero Trust means we remove our perimeter firewall."
**Right**: Zero Trust layers firewalls at every boundary—perimeter + internal + application-level.
**Impact on Exam**: Don't fall for "Zero Trust replaces firewalls"—it actually increases firewall density.

### Mistake 5: Assuming Microsegmentation Only Needs Network Rules
**Wrong**: "We microsegmented using [[VLANs]], so we have Zero Trust."
**Right**: VLANs are layer 2; Zero Trust microsegmentation requires layer 7 policies, application-aware controls, and identity-based access.
**Impact on Exam**: Distinguish between network segmentation and Zero Trust microsegmentation.

---

## Related Topics
- [[Perimeter Security]]
- [[Multi-Factor Authentication (MFA)]]
- [[Encryption (TLS/SSL, AES)]]
- [[Access Control Lists (ACLs)]]
- [[Firewalls & Firewall Rules]]
- [[VPN & Zero Trust Network Access (ZTNA)]]
- [[Security Information and Event Management (SIEM)]]
- [[Intrusion Detection System (IDS)]]
- [[User and Entity Behavior Analytics (UEBA)]]
- [[Network Segmentation & VLANs]]
- [[Identity and Access Management (IAM)]]
- [[Device Compliance & Mobile Device Management (MDM)]]
- [[Least Privilege Principle]]

---

*Source: CompTIA Network+ N10-009 Study Material | [[Network+]] | [[Security Framework]]*