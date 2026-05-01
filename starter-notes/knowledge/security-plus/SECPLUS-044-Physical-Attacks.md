---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 044
source: rewritten
---

# Physical Attacks
**Tangible threats that bypass digital defenses by targeting the hardware itself.**

---

## Overview
While most security discussions center on [[Vulnerability|vulnerabilities]] in [[Operating System|operating systems]] and software exploits, physical attacks represent an entirely separate threat vector that requires equally rigorous defensive strategies. Understanding physical security is critical for Security+ because an attacker with hands-on access to infrastructure can completely circumvent all digital protections—locks only delay the honest; determined adversaries will find ways through.

---

## Key Concepts

### Physical Access as Root Compromise
**Analogy**: If your digital security is a bank vault's time-lock, physical access is the bank robber who simply demolishes the walls around it. No matter how strong the vault is internally, removing the entire building renders it useless.

**Definition**: [[Physical Access]] to computing equipment grants an attacker the ability to directly manipulate, extract, or control hardware, effectively bypassing all [[Operating System|OS]]-level protections, authentication systems, and encryption at the software level.

**Why it matters**: [[Authentication]] and [[Authorization]] controls exist only within the digital layer—they assume the hardware itself is trustworthy. Once an attacker physically touches equipment, they own it.

---

### Brute Force Physical Attacks
**Analogy**: Imagine trying every key on your keyring against a door—eventually one works, or you bash the door down. Physical brute force works the same way but with locks, barriers, and access points instead of passwords.

**Definition**: [[Brute Force]] physical attacks involve repeated attempts to force entry through doors, windows, locks, or perimeter barriers using direct physical effort, tools, or sustained pressure rather than exploiting digital weaknesses.

**Related concept**: [[Brute Force Attack]] (password cracking) uses the same methodical exhaustion principle in the physical realm.

#### Brute Force Risk Assessment
| Location | Difficulty | Time to Breach | Attacker Access |
|----------|-----------|-----------------|-----------------|
| Unsecured window | Low | Minutes | Building interior |
| Standard lock door | Medium | 5-30 minutes | Restricted zone |
| Reinforced perimeter | High | 30+ minutes | Data center floor |
| Multi-factor locks | Very High | 60+ minutes | Secure cabinet |

---

### Perimeter Security Vulnerabilities
**Analogy**: A castle with towering walls but a moat with stepping stones is still easily crossed—your defenses are only as strong as their weakest point.

**Definition**: [[Perimeter Security]] failures occur when the physical boundary protecting critical infrastructure (data centers, server rooms, networking closets) can be breached through doors, windows, or access points that lack adequate [[Physical Security Controls|controls]].

**Assessment approach**: Conduct walk-throughs of your facility identifying every potential entry vector—evaluating how long brute force attacks would realistically take at each point.

---

### Infrastructure Exposure Through Physical Compromise
**Analogy**: Stealing blueprints from an architect's desk reveals the building's design—physical access to infrastructure reveals everything about your entire security posture.

**Definition**: Once an attacker achieves physical breach of critical infrastructure zones, they gain direct access to [[Network Devices|networking equipment]], [[Server|servers]], [[Storage|storage systems]], and backup media, providing complete organizational compromise.

---

## Exam Tips

### Question Type 1: Physical Attack Recognition
- *"A security analyst discovers forced entry marks on a data center window. What type of attack occurred?"* → [[Brute Force]] physical attack
- **Trick**: Don't overthink it—the question is testing whether you recognize physical attacks as a distinct category separate from digital exploits.

### Question Type 2: Risk Prioritization
- *"Which represents the greatest physical security risk to a server room?"* → Unsecured external doors → Lack of [[Access Control|access controls]] → Unmonitored perimeter
- **Trick**: Questions may present multiple physical threats; identify which provides the most direct path to critical assets.

### Question Type 3: Control Identification
- *"Which control would best mitigate brute force physical attacks on facility doors?"* → [[Physical Security Controls]] such as reinforced locks, time-delay mechanisms, or [[Bollard|bollards]]
- **Trick**: The answer isn't technology—it's structural/physical reinforcement.

---

## Common Mistakes

### Mistake 1: Assuming Digital Security Alone is Sufficient
**Wrong**: "We have strong [[Firewall|firewalls]], [[Encryption|encryption]], and [[Intrusion Detection|IDS]] systems—our infrastructure is secure."

**Right**: Digital security controls are ineffective if an attacker can physically access the hardware running them. A compromised server defeats all software-based defenses.

**Impact on Exam**: You'll encounter scenario questions where candidates must recognize that digital protections fail after physical breach. Missing this relationship costs points on scenario-based questions.

---

### Mistake 2: Conflating Brute Force with Only Password Attacks
**Wrong**: "Brute force only applies to password cracking and login attempts."

**Right**: [[Brute Force]] is a methodology applicable to any security mechanism—including forcing doors, bypassing locks, or defeating [[Physical Barrier|barriers]].

**Impact on Exam**: A question about facility security breaches using brute force methods tests whether you understand the term's broader scope beyond digital password attacks.

---

### Mistake 3: Overlooking Perimeter Assessment in Security Plans
**Wrong**: Focusing exclusively on firewall rules and access control lists while ignoring data center entry points.

**Right**: Comprehensive [[Security Architecture|security architecture]] requires evaluating physical perimeter strength as a foundational layer—entry points are your first defense line.

**Impact on Exam**: Security+ heavily emphasizes defense-in-depth and layered controls. Questions often test whether candidates understand that physical security is Layer 1 of a complete security posture.

---

## Related Topics
- [[Physical Security Controls]]
- [[Access Control]] (badging, mantrap)
- [[Data Center]] security design
- [[Defense in Depth]]
- [[Vulnerability Assessment]]
- [[Risk Assessment]] methodology
- [[Perimeter Security]]
- [[Environmental Controls]]
- [[CCTV and Surveillance]]
- [[Lock Types and Mechanisms]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*