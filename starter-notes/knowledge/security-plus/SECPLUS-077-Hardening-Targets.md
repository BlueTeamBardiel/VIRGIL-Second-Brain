---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 077
source: rewritten
---

# Hardening Targets
**Factory defaults leave systems vulnerable—you must intentionally strengthen them.**

---

## Overview
Out-of-the-box configurations prioritize ease of installation over security, leaving systems exposed to attack. To secure any device or operating system, you need to understand which settings require modification to meet your organization's security standards. This is foundational knowledge for the Security+ exam because [[hardening]] directly reduces your attack surface and is a core responsibility of security professionals across all environments.

---

## Key Concepts

### Baseline Hardening Philosophy
**Analogy**: A new house has unlocked doors and no security system installed—just like a new OS comes wide open and trusting. You must add locks, alarms, and security measures to make it safe.

**Definition**: The practice of configuring systems to their most restrictive state while maintaining necessary functionality, removing unnecessary services, closing unused ports, and applying secure defaults.

[[Hardening]] is not a one-time action but an ongoing baseline from which all systems should start. Related to [[Defense in Depth]] and [[Principle of Least Privilege]].

---

### Manufacturer Hardening Guides
**Analogy**: A restaurant provides food safety guidelines so each franchise follows the same hygiene practices—vendors provide hardening guides so admins know the security "recipe" for their specific product.

**Definition**: Official documentation from vendors that specifies which settings, configurations, and policies should be applied to their software or hardware to achieve a secure state.

These guides are specific to [[Operating Systems]], [[Applications]], and [[Firmware]] versions. When official guides don't exist, consult [[Community Resources]] and third-party security organizations.

| Source | Authority | Customization |
|--------|-----------|---------------|
| Manufacturer Guide | Highest | Product-specific |
| Third-Party Guide (CIS Benchmarks) | High | Industry standard |
| Community Forums | Medium | Community-validated |
| Generic Best Practices | Low | One-size-fits-all |

---

### Patch Management as Hardening
**Analogy**: Your car needs regular oil changes and tire rotations—patches are the security maintenance that keeps vulnerabilities from causing a breakdown.

**Definition**: The systematic process of releasing, testing, and deploying security updates and bug fixes to close known [[Vulnerabilities]] and prevent exploitation.

[[Patches]] address both functional defects and security flaws. Each patch deployment reduces your exposure window to known threats. Related to [[Vulnerability Management]] and [[Patch Tuesday]].

---

### Mobile Device Segmentation
**Analogy**: A hotel keeps guest rooms separate from staff areas—sensitive work data is kept in a walled-off section of your phone, separated from personal apps and photos.

**Definition**: The logical or physical separation of storage and data partitions on mobile devices to prevent unauthorized access to corporate information if personal space is compromised.

[[Data Segmentation]] on mobile devices typically creates:
- **Corporate partition**: Managed, encrypted, monitored company data
- **Personal partition**: User's private applications and files

| Segmentation Type | Protection | Use Case |
|-------------------|-----------|----------|
| Logical Partition | Software-enforced isolation | BYOD environments |
| Hardware-based | Cryptographic separation | High-security devices |
| Application-level | Per-app sandboxing | Third-party app restriction |

If an attacker gains access to one segment, [[Lateral Movement]] to other partitions is blocked or significantly impeded. This aligns with [[Zero Trust]] principles and [[Containerization]].

---

## Exam Tips

### Question Type 1: Identification of Hardening Methods
- *"Which action BEST reduces vulnerabilities on a newly deployed Windows server?"* → Apply the vendor hardening guide and deploy current patches
- **Trick**: Don't confuse hardening with just installing a [[Firewall]]—hardening is comprehensive configuration

### Question Type 2: Mobile Device Security
- *"A BYOD policy requires company data separation. Which approach accomplishes this?"* → Implement logical device segmentation to isolate corporate and personal data
- **Trick**: Segmentation is NOT the same as full-device encryption; both are needed together

### Question Type 3: Resource Selection
- *"An admin cannot find hardening guidance for a legacy system. What is the BEST next step?"* → Contact the manufacturer's support team, then check CIS Benchmarks or trusted community forums
- **Trick**: Random internet advice is inferior to official vendor documentation

---

## Common Mistakes

### Mistake 1: Assuming Out-of-Box = Secure
**Wrong**: "The OS manufacturer wouldn't ship an insecure system, so default settings must be safe enough."
**Right**: Manufacturers ship with maximum compatibility and user-friendliness, sacrificing security by default. You must explicitly harden.
**Impact on Exam**: You'll miss questions asking what MUST be done after installation; the answer is always "apply hardening standards."

### Mistake 2: Confusing Patching with Hardening
**Wrong**: "Once I patch the system, it's fully hardened."
**Right**: [[Patching]] closes known vulnerabilities, but hardening also disables unnecessary services, enforces [[Authentication]] policies, and implements [[Encryption]].
**Impact on Exam**: Multi-part hardening questions require you to identify multiple complementary controls, not just one.

### Mistake 3: Overlooking Segmentation on Mobile
**Wrong**: "Mobile devices only need antivirus and a passcode."
**Right**: Enterprise mobile security requires [[Data Segmentation]], [[Mobile Device Management]], policy enforcement, and separate storage domains.
**Impact on Exam**: BYOD and mobile security scenarios expect you to recommend segmentation as a primary control.

### Mistake 4: Treating All Hardening Guides as Equal
**Wrong**: "Any hardening guide from the internet will work for my system."
**Right**: Vendor-specific and [[CIS Benchmarks]] are authoritative; generic guides may introduce incompatibilities or miss critical controls.
**Impact on Exam**: Questions reward selecting official or industry-standard guides (like CIS) over random online sources.

---

## Related Topics
- [[Defense in Depth]]
- [[Principle of Least Privilege]]
- [[Patch Management]]
- [[Vulnerability Management]]
- [[Mobile Device Management]]
- [[BYOD Policies]]
- [[CIS Benchmarks]]
- [[Security Baselines]]
- [[Firewall Configuration]]
- [[Access Control Lists]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*