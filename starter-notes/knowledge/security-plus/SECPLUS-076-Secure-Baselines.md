---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 076
source: rewritten
---

# Secure Baselines
**A standardized security configuration template ensures every deployed application maintains consistent protective measures across all infrastructure layers.**

---

## Overview
When you launch a new application into production, you're not just installing software—you're introducing a system that depends on hundreds of security decisions across firewalls, operating systems, patch levels, and application settings. A [[Secure Baseline]] is your documented minimum security standard that must be present every single time that application goes live. For the Security+ exam, understanding baselines is critical because they form the foundation of how organizations prevent configuration drift and maintain security posture at scale.

---

## Key Concepts

### Secure Baseline
**Analogy**: Think of a secure baseline like a restaurant's health inspection checklist. Every location must pass the same food safety requirements before opening, and inspectors verify those standards remain in place over time—not just once.

**Definition**: A [[Secure Baseline]] is a documented, standardized configuration that defines the minimum required security settings for systems, applications, networks, and devices. It establishes which [[Firewall Rules]], [[Patch Levels]], [[Access Controls]], and [[Configuration Settings]] must exist in every deployment.

**Related Implementation Elements**:
- [[Operating System Hardening]]
- [[Application Configuration]]
- [[File System Permissions]]
- [[Network Device Settings]]

---

## Baseline Sources & Customization

| Source | Characteristics | Best For |
|--------|-----------------|----------|
| **Vendor-Provided** | Created by software/OS manufacturer; already tested | Starting point; reducing development time |
| **Industry Standards** | Published by organizations like CIS or NIST | Compliance requirements; best practices |
| **Custom-Built** | Organization-specific; tailored to unique needs | Sensitive environments; specialized requirements |

### Creating Your Baseline
**Process Flow**:
1. Obtain vendor baseline (application developer or OS manufacturer provides foundation)
2. Customize for organizational needs
3. Document all required [[Permissions]], [[Configuration Settings]], and [[Security Controls]]
4. Test thoroughly before deployment
5. Establish as organizational standard

---

## Baseline Validation & Maintenance

### Continuous Compliance Checking
**Analogy**: Like a pilot running pre-flight checklists before every takeoff, you verify baselines remain intact after deployment.

**Definition**: [[Baseline Validation]] is the ongoing process of scanning and auditing systems to confirm they still match the documented secure baseline standard.

### Drift Correction
If validation discovers deviations from baseline, you must:
- Document what changed
- Prioritize correction based on security impact
- Implement fixes as quickly as possible
- Re-validate to confirm restoration

---

## Exam Tips

### Question Type 1: Baseline Implementation Scenarios
- *"Your organization deploys a new CRM application across 200 workstations. What's the FIRST action before deployment?"* → Establish and document a secure baseline for that CRM's required [[File Permissions]], [[Firewall Rules]], and [[Patch Requirements]]
- **Trick**: Exam may ask about baseline creation vs. baseline validation—creation happens *before* deployment; validation happens *after*

### Question Type 2: Baseline Sources
- *"Where should you obtain initial baseline configuration guidance?"* → The application vendor/manufacturer or relevant [[CIS Benchmarks]] for operating systems
- **Trick**: Don't assume every baseline must be completely custom—vendors provide tested starting points

### Question Type 3: Compliance & Drift
- *"During a security audit, you discover servers running outdated [[Patch Levels]] not specified in the baseline. What's this called?"* → [[Configuration Drift]]
- **Trick**: The baseline itself doesn't *prevent* drift—continuous monitoring and remediation do

---

## Common Mistakes

### Mistake 1: Confusing Baseline Creation with Ongoing Enforcement
**Wrong**: "We created a baseline document last year, so we're secure."
**Right**: Baselines must be *actively maintained and validated* through continuous monitoring; they're not fire-and-forget.
**Impact on Exam**: Questions testing whether you understand baselines are *static documentation* vs. *active security practices*

### Mistake 2: Assuming All Baselines Are Identical
**Wrong**: "Every company should use the same baseline configuration."
**Right**: Baselines are *customized per organization* based on business requirements, risk tolerance, and regulatory obligations.
**Impact on Exam**: Scenario questions will test whether you know when to start with vendor baselines vs. building custom ones

### Mistake 3: Creating Baselines After Deployment
**Wrong**: "We'll establish our baseline once systems are running."
**Right**: Baselines are *defined before deployment* so every instance launches with consistent security.
**Impact on Exam**: Timeline questions test understanding that baselines are *planning documents*, not post-incident corrective actions

### Mistake 4: Overlooking Operating System Baselines
**Wrong**: "We only need to baseline the application settings."
**Right**: The [[Operating System]] underlying the application *must also be part of the baseline* — its [[Patch Level]], [[User Permissions]], and [[Service Settings]] are equally critical.
**Impact on Exam**: Multi-layer questions test knowledge that baselines span OS, network, and application tiers

---

## Related Topics
- [[Configuration Management]]
- [[Patch Management]]
- [[Hardening]]
- [[Access Control Lists]]
- [[Firewall Rules]]
- [[CIS Benchmarks]]
- [[NIST Guidelines]]
- [[Compliance Scanning]]
- [[Configuration Drift]]
- [[Change Management]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*