---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 105
source: rewritten
---

# Security Policies
**The foundational rulebook that transforms abstract security goals into concrete organizational directives.**

---

## Overview
Security policies serve as the documented expectations and guidelines that guide how an organization protects its assets and responds to threats. Without policies, security becomes reactive and inconsistent—you're fighting fires instead of preventing them. For Security+, understanding the relationship between policy frameworks and their technical implementations is essential, as exam questions test whether you know *what should happen* versus *how to make it happen*.

---

## Key Concepts

### The CIA Triad as Policy Foundation
**Analogy**: Think of CIA like a three-legged stool—remove any leg and the whole thing collapses. Every security policy ultimately serves one of these three purposes.

**Definition**: The [[CIA Triad]] represents the three pillars that all security policies must protect: [[Confidentiality]] (keeping secrets secret), [[Integrity]] (ensuring data hasn't been tampered with), and [[Availability]] (making sure systems work when needed).

| Pillar | Policy Example | Risk if Ignored |
|--------|---|---|
| **Confidentiality** | Data classification standards | Competitive secrets leak |
| **Integrity** | Change management procedures | Undetected data corruption |
| **Availability** | Backup and recovery policies | Business continuity failure |

---

### Broad vs. Granular Policies

**Analogy**: A broad policy is like "drive safely" while granular policies are the actual traffic laws—speed limits, stop signs, right-of-way rules.

**Definition**: Organizations maintain a spectrum of [[Security Policies]], ranging from high-level strategic guidelines (e.g., "all data at rest must be encrypted") to specific technical standards (e.g., "Wi-Fi networks must use WPA3 with AES-256").

**Examples of Broad Policies**:
- [[Data Storage Requirements]]
- [[Incident Response Procedures]]
- [[Business Continuity Standards]]

**Examples of Granular Policies**:
- [[Remote Access Requirements]] (VPN protocols, MFA mandates)
- [[Wireless Network Usage]] (frequency bands, authentication methods)
- [[Device Management Standards]] (patch windows, MDM enrollment)

---

### Information Security Policy Framework

**Analogy**: An ISP is like a master blueprint—it references every room in a building, while individual policies are the room-by-room construction specs.

**Definition**: The [[Information Security Policy]] (ISP) is the comprehensive, master-level documentation that catalogs all security policies an organization maintains. It serves as the single source of truth for "what should be done and why."

**Purpose in Organizations**:
- Answers incident response questions ("What do we do if malware is detected?")
- Defines access control standards ("Who can connect to the VPN?")
- Establishes compliance obligations ("Which regulations apply to this data?")
- Provides audit trails ("Did we follow our own rules?")

---

### Policy as Mandate vs. Recommendation

**Analogy**: A recommendation is a suggestion; a mandate is the law. Organizations choose how binding their policies are.

**Definition**: [[Policy Enforcement Level]] determines whether adherence to a policy is optional guidance or a required condition of employment/operation.

| Level | Binding? | Consequence of Violation | Use Case |
|-------|----------|---|---|
| **Recommendation** | No | None (best practice guidance) | Emerging security practices |
| **Mandate** | Yes | Disciplinary action or access revocation | Critical controls (encryption, MFA) |

---

## Exam Tips

### Question Type 1: Policy Purpose and Intent
- *"Your organization discovers a workstation infected with ransomware. Which document should the IT team reference FIRST to determine response procedures?"* → [[Information Security Policy]] framework
- **Trick**: Don't confuse the policy (the rule) with the [[Technical Security Controls]] (the tools that enforce it). A policy says "encrypt data"; a control is the encryption software.

### Question Type 2: CIA Triad Alignment
- *"A backup policy that requires daily snapshots primarily protects which CIA principle?"* → [[Availability]] (recovery depends on having backups) and [[Integrity]] (verifying backups haven't been corrupted)
- **Trick**: Many policies protect multiple CIA principles—identify the PRIMARY intent.

### Question Type 3: Policy Hierarchy
- *"An employee disputes a security policy enforcement, claiming it contradicts company culture. What takes precedence?"* → The documented [[Information Security Policy]] mandate, regardless of cultural preference
- **Trick**: Policies supersede informal practices; expect questions testing this authority.

---

## Common Mistakes

### Mistake 1: Confusing Policy with Implementation
**Wrong**: "Our security policy is to install Windows Defender on all endpoints."
**Right**: "Our policy is to maintain endpoint protection; Windows Defender is ONE technical control that implements this policy."
**Impact on Exam**: You'll see questions asking whether a specific tool/technology meets policy requirements—knowing the distinction prevents answer traps.

### Mistake 2: Assuming Broad Policies Are Sufficient
**Wrong**: "We have a 'secure all data' policy, so we're covered."
**Right**: Effective policies cascade from strategic (broad CIA goals) → operational (specific technical requirements like "TLS 1.2 minimum") → tactical (implementation details).
**Impact on Exam**: Look for questions asking "what's MISSING from this policy?" The answer is usually a needed level of specificity.

### Mistake 3: Treating Policies as Static Documents
**Wrong**: "We wrote our information security policy in 2015 and haven't changed it."
**Right**: Policies must evolve with threats, regulations, and technology changes. [[Policy Review Cycles]] are standard practice.
**Impact on Exam**: Questions may ask about policy maintenance, version control, or when policies should be updated (answer: at least annually, or when major threats/regulations emerge).

### Mistake 4: Overlooking the "Why"
**Wrong**: Memorizing that "VPN access requires MFA" without understanding the threat model.
**Right**: Understanding that remote access = increased attack surface, so MFA mitigates credential compromise risk.
**Impact on Exam**: Higher-level questions ask you to justify policies or identify which policy best addresses a scenario—you need the reasoning, not just the rules.

---

## Related Topics
- [[CIA Triad]]
- [[Technical Security Controls]]
- [[Incident Response Procedures]]
- [[Access Control Policies]]
- [[Data Classification Standards]]
- [[Compliance and Regulations]]
- [[Risk Management Framework]]
- [[Security Governance]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*