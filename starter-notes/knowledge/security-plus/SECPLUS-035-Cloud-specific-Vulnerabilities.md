---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 035
source: rewritten
---

# Cloud-specific Vulnerabilities
**Modern organizations rapidly shifted workloads to public clouds, creating a new attack surface that many haven't adequately secured.**

---

## Overview
The migration to [[cloud computing]] happened faster than security matured to protect it. Today, nearly every organization relies on [[public cloud]] services to host critical applications and sensitive data, yet many lack fundamental defensive controls. Understanding cloud-specific vulnerabilities is essential for Security+ because exam questions frequently test your ability to identify threats unique to cloud environments and defend against them.

---

## Key Concepts

### Inadequate Multi-Factor Authentication Implementation
**Analogy**: Imagine a bank that installed a fancy vault but left the front door accessible with only a single key—having a strong backend doesn't matter if the entry point is weak.

**Definition**: Many organizations fail to enforce [[multi-factor authentication (MFA)]] on [[cloud management consoles]] and administrative portals, leaving accounts vulnerable to credential compromise despite strong infrastructure elsewhere. Industry data suggests approximately 76% of organizations don't implement MFA for cloud console access.

**Related Risks**: [[credential stuffing]], [[brute force attacks]], [[account takeover]]

---

### Unpatched Code and Vulnerabilities
**Analogy**: Like leaving windows open in a house while installing a new security system—new infrastructure is meaningless if underlying applications have known holes.

**Definition**: Approximately 63% of applications deployed in [[public cloud]] environments operate with unpatched security flaws, sometimes carrying [[CVSS scores]] of 7 or higher (on a 0-10 scale). These aren't cosmetic updates but critical security gaps that actively threaten confidentiality and integrity.

| Status | Percentage | Risk Level | CVSS Impact |
|--------|-----------|-----------|------------|
| Patched | 37% | Low | <7.0 |
| Unpatched | 63% | High | ≥7.0 |

**Related Concepts**: [[vulnerability management]], [[patch management]], [[CVSS scoring]], [[software supply chain security]]

---

### Distributed Denial of Service (DDoS) Exposure
**Analogy**: A restaurant open to the public can serve legitimate customers, but it also invites protesters to block the entrance—accessibility creates risk.

**Definition**: [[Public cloud]] applications are globally accessible by design, meaning anyone with internet connectivity can attempt [[Denial of Service (DoS)]] or [[Distributed Denial of Service (DDoS)]] attacks simultaneously from multiple locations worldwide. This internet-facing nature is a feature, not a bug—but it exposes systems to volumetric attacks.

**Attack Patterns**:
- Single-source [[DoS]] (less common, easier to block)
- [[DDoS]] from botnet (global distribution, harder to mitigate)
- Application-layer attacks (targeting specific vulnerabilities)

**Related Defenses**: [[rate limiting]], [[WAF (Web Application Firewall)]], [[DDoS mitigation services]]

---

### Weak or Misconfigured Authentication
**Analogy**: Like writing your password on a sticky note next to your computer—authentication mechanisms exist, but poor implementation nullifies them.

**Definition**: Cloud applications may use authentication protocols that are outdated, improperly configured, or inadequately integrated with [[identity management]] systems. This includes hardcoded credentials, overly permissive [[API authentication]], or misconfigured [[OAuth]] / [[SAML]] implementations.

**Common Misconfigurations**:
- Default credentials never changed
- Overly broad [[role-based access control (RBAC)]] permissions
- Missing authentication on sensitive [[APIs]]
- Insecure credential storage

**Related Topics**: [[authentication]], [[authorization]], [[API security]], [[identity and access management (IAM)]]

---

## Exam Tips

### Question Type 1: Identifying Cloud-Specific Vulnerabilities
- *"A company migrates their authentication system to a public cloud without implementing multi-factor authentication on the administrative console. Which vulnerability is this organization primarily exposed to?"* → [[Account takeover]] / [[credential compromise]]
- **Trick**: Don't confuse "cloud-specific" with "general security risks"—the question wants threats *amplified by* cloud characteristics (global accessibility, shared responsibility).

### Question Type 2: Remediation Strategy
- *"Which control best reduces the risk of DDoS against a public cloud application?"* → [[DDoS mitigation service]], [[rate limiting]], [[WAF]], or [[anycast network routing]]
- **Trick**: The "best" answer depends on whether you're preventing attacks (detection/filtering) or absorbing them (capacity/distribution). Read carefully.

### Question Type 3: Shared Responsibility Model
- *"Your organization runs unpatched code in AWS. Who is responsible for applying patches?"* → Your organization (the customer)—AWS secures infrastructure; you secure applications.
- **Trick**: Cloud providers secure "up to the hypervisor"; you own everything above that layer.

---

## Common Mistakes

### Mistake 1: Confusing Cloud Vulnerabilities with Cloud Features
**Wrong**: "Public cloud accessibility is a vulnerability that should be eliminated."
**Right**: "Public cloud accessibility is a feature that must be *defended*, not removed."
**Impact on Exam**: You'll choose remediation answers that make the system unusable rather than secure.

### Mistake 2: Assuming the Cloud Provider Handles Application Security
**Wrong**: "AWS will patch my applications, so I only need to worry about infrastructure."
**Right**: Under [[shared responsibility model]], the customer patches application code; the provider secures underlying infrastructure.
**Impact on Exam**: You'll incorrectly attribute patching responsibility to the cloud provider instead of the organization.

### Mistake 3: Treating Cloud Vulnerabilities as Unique Rather Than Amplified
**Wrong**: "Cloud vulnerabilities are completely different from on-premises vulnerabilities."
**Right**: "Cloud vulnerabilities are traditional risks (weak authentication, unpatched code) amplified by global accessibility and ease of deployment."
**Impact on Exam**: Questions test whether you recognize that fundamentals still apply; cloud just expands the attack surface.

### Mistake 4: Overlooking Configuration as a Root Cause
**Wrong**: "Our cloud security problem is the vendor's fault."
**Right**: "Our cloud security problem stems from misconfigured [[IAM]], missing [[MFA]], and overly permissive access policies."
**Impact on Exam**: Security+ emphasizes that most breaches involve *known* vulnerabilities or misconfigurations—not zero-days. You must prioritize configuration hygiene.

---

## Related Topics
- [[Public Cloud]]
- [[Shared Responsibility Model]]
- [[Multi-Factor Authentication (MFA)]]
- [[Denial of Service (DoS)]]
- [[Distributed Denial of Service (DDoS)]]
- [[Vulnerability Management]]
- [[Patch Management]]
- [[Identity and Access Management (IAM)]]
- [[Web Application Firewall (WAF)]]
- [[API Security]]
- [[CVSS Scoring]]
- [[Cloud Security Best Practices]]
- [[Role-Based Access Control (RBAC)]]

---

*Source: CompTIA Security+ SY0-701 Exam Objectives | [[Security+]]*