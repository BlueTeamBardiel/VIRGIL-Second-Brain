---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# I. Today's Cybersecurity Analyst
**A modern security analyst must master the foundational pillars of data protection, risk evaluation, and network defense to protect organizational assets.**

---

## Overview

The contemporary cybersecurity analyst operates at the intersection of technical expertise, risk management, and compliance frameworks. Understanding core security principles—from the CIA Triad to threat modeling—forms the bedrock of effective threat detection and incident response. A SOC analyst who can't articulate why data confidentiality matters as much as system availability will struggle to prioritize alerts and recommend remediation.

---

## Key Concepts

### The CIA Triad

**Analogy**: Think of protecting a bank vault. Confidentiality is the lock that keeps thieves out, integrity is the security camera proving no one tampered with the contents, and availability is ensuring the bank opens at 9 AM so customers can access their money.

**Definition**: The [[CIA Triad]] represents three pillars of information security:

| Pillar | Purpose | Technical Controls |
|--------|---------|-------------------|
| **Confidentiality** | Prevents unauthorized viewing of sensitive data | [[Encryption]], [[Access Control]], [[Multi-Factor Authentication]] |
| **Integrity** | Ensures data remains accurate and unmodified | [[Hashing]], [[Digital Signatures]], [[File Integrity Monitoring]] |
| **Availability** | Keeps systems accessible to authorized users | [[Redundancy]], [[Load Balancing]], [[DDoS Protection]] |

Each pillar addresses different threats—a data breach attacks confidentiality, a ransomware attack threatens availability, and a logic bomb threatens integrity.

---

### Privacy Versus Security: Complementary, Not Identical

**Analogy**: Security is the fence around your property; privacy is what you tell your neighbors about what's inside.

**Definition**: [[Privacy]] governs *how organizations handle personal information*, while [[Security]] protects *against unauthorized access and threats*. They overlap but serve different masters—privacy answers to regulations and ethics, security answers to operational risk.

[[Personally Identifiable Information (PII)]] includes any data point that identifies an individual: Social Security numbers, biometric markers, home addresses, medical records, or combinations thereof that become identifying when merged.

**GAPP Framework** (Generally Accepted Privacy Principles):
- **Management**: Document privacy policies and enforcement mechanisms
- **Notice**: Inform users upfront about data collection and usage
- **Choice & Consent**: Obtain explicit permission before processing PII
- **Collection**: Gather only data essential to stated purposes
- **Use, Retention & Disposal**: Limit use to disclosed purposes; destroy data securely when obsolete
- **Access**: Grant individuals the right to review and correct their information
- **Disclosure**: Share third-party data only under agreed terms
- **Security**: Implement encryption, access controls, and audit logging for PII
- **Quality**: Maintain accurate, complete records
- **Monitoring & Enforcement**: Conduct audits and remediate violations

---

### Evaluating Security Risk: The Foundation of Prioritization

**Analogy**: Risk is like weather forecasting—a high-probability storm in a remote desert is less urgent than a low-probability hurricane aimed at a city.

**Definition**: [[Risk]] emerges when a [[Threat]] has the potential to exploit a [[Vulnerability]]. The formula drives prioritization:

**Risk = Threat × Vulnerability**

- **[[Vulnerability]]**: A weakness in systems, processes, or configurations (unpatched software, weak passwords, misconfigured firewalls)
- **[[Threat]]**: An external or internal force capable of exploiting that weakness (hackers, malware, disgruntled employees, natural disasters)

**Threat Taxonomy**:
- **[[Adversarial Threats]]**: Deliberate human attacks (nation-states, cybercriminals, script kiddies)
- **[[Accidental Threats]]**: Unintentional human error (misconfigurations, data exfiltration by accident, credential sharing)
- **[[Structural Threats]]**: System failures (hardware degradation, software bugs, design flaws)
- **[[Environmental Threats]]**: Acts beyond organizational control (earthquakes, floods, infrastructure failures)

**Risk Assessment Mechanics**:
- **[[Likelihood]]**: Probability a threat will materialize (low, medium, high)
- **[[Impact]]**: Severity of consequences if risk occurs (financial loss, reputational damage, operational downtime)
- **[[Risk Matrix]]**: A 2D grid combining likelihood and impact to categorize overall risk level

*Example*: A remote code execution vulnerability in a public-facing web server exposed to the internet = high likelihood × critical impact = **critical risk**. A theoretical vulnerability in an air-gapped system = high likelihood × zero impact = **low risk**.

---

### Network Access Control: The First Gate

**Analogy**: NAC is a nightclub bouncer—checking IDs (authentication), verifying you're on the list (authorization), and ensuring you're not carrying weapons (device health).

**Definition**: [[Network Access Control (NAC)]] enforces policies ensuring only compliant, authorized users and devices connect to the network.

**NAC Deployment Models**:
| Model | Mechanism | Pros | Cons |
|-------|-----------|------|------|
| **Agent-Based** | Software installed on endpoints (e.g., [[802.1X]]) | Granular control | Requires client deployment |
| **Agentless** | Browser-based or portal authentication | Easier for BYOD | Less comprehensive visibility |
| **In-Band** | Dedicated appliances intercept all traffic | Central enforcement | Single point of failure risk |
| **Out-of-Band** | Network devices query auth server independently | Resilience | Complex troubleshooting |

**Access Enforcement Criteria**:
- Time-of-day restrictions (users can only VPN 9-5)
- Role-based network segmentation (developers isolated from finance)
- Geolocation enforcement (block connections from high-risk countries)
- Device posture verification (patch level, antivirus status, disk encryption)

---

### Firewalls: The Network Perimeter Sentinel

**Analogy**: A firewall is a border checkpoint—guards inspect every car entering and leaving, allowing through vehicles that match security rules while turning away suspicious ones.

**Definition**: [[Firewalls]] filter network traffic bidirectionally based on rules, protecting internal networks from untrusted external traffic.

**Firewall Architecture**:
- **Placement**: At network perimeter; all inbound/outbound traffic transits the firewall
- **[[Screened Subnet (DMZ)]]**: A demilitarized zone hosting public-facing services (web servers, email gateways) isolated from internal assets by firewalls on both sides
- **[[Access Control Lists (ACL)]]**: Rule sets permitting or denying traffic by source IP, destination IP, protocol, and port

**Firewall Evolution**:
| Generation | Inspection Depth | Awareness | Use Case |
|-----------|------------------|-----------|----------|
| **Packet Filtering** | Header only (IP, port) | None | Basic filtering; obsolete for modern threats |
| **Stateful Inspection** | Tracks connection state | Connection-aware | Prevents spoofed packets; standard baseline |
| **NGFW** | Deep packet inspection | User, application, threat signatures | Blocks malware, enforces application policies |
| **[[Web Application Firewall (WAF)]]** | HTTP/HTTPS layer | Web-attack patterns | Defends against [[SQL Injection]], [[XSS]], [[CSRF]] |

---

### Network Segmentation: Limiting Lateral Movement

**Analogy**: Segmentation is like compartmentalizing a submarine—if one section floods, bulkheads prevent water from reaching the engine room.

**Definition**: [[Network Segmentation]] divides networks into zones of trust, restricting lateral movement and containing breaches.

**Key Segmentation Tools**:
- **[[Triple-Homed Firewall]]**: Single appliance connecting three networks (corporate, datacenter, DMZ), enforcing granular policies between zones
- **[[Jump Box (Bastion Host)]]**: Hardened server serving as the exclusive gateway to sensitive infrastructure; requires [[Multi-Factor Authentication]] and logging all admin access; eliminates direct admin-to-target connections

---

## Analyst Relevance

A SOC analyst receives a spike in failed login attempts targeting a financial database. Using this knowledge:

1. **Risk Assessment**: Is this a threat (attacker) exploiting a vulnerability (weak password policy)? High likelihood × critical impact = escalate immediately.
2. **Privacy Impact**: Identify if PII is at risk; trigger incident response and potential breach notification obligations.
3. **NAC Validation**: Check if the source IP passes device posture checks; non-compliant devices are suspect.
4. **Firewall Rules**: Review if the attacks originated from expected geographies or blocked ports; validate ACL enforcement.
5. **Segmentation**: Confirm the database resides in a segmented zone; assess whether attackers could pivot to other systems.

The analyst transforms theoretical security principles into tactical decisions—escalate or investigate, isolate or monitor, notify or remediate.

---

## Exam Tips

### Question Type 1: CIA Triad Scenario Matching
- *"A ransomware attack encrypts customer databases, preventing access. Which CIA component is compromised?"* → **Availability** (not confidentiality, because data isn't exposed—it's locked)
- **Trick**: Confusing "data locked away" with "confidentiality." Ransomware affects availability; only data exfiltration affects confidentiality.

### Question Type 2: Risk Calculation
- *"A vulnerability has no known exploits (low likelihood) but affects the company's core revenue system (critical impact). What is the risk level?"* → **Medium to High** (impact dominates when systems are critical)
- **Trick**: Assuming low likelihood = low risk. In critical systems, even low-probability threats matter.

### Question Type 3: Control Selection
- *"You need to ensure only patched, compliant devices access the network. Which control is most appropriate?"* → **[[Network Access Control (NAC)]]** with device health checks
- **Trick**: Confusing NAC (device compliance) with [[Identity and Access Management (IAM)]] (user authentication).

### Question Type 4: Segmentation Benefit
- *"After a breach, you want to prevent attackers from moving laterally to critical systems. What do you implement?"* → **Network segmentation with [[Zero Trust]] principles** and jump boxes for admin access
- **Trick**: Assuming firewalls alone prevent lateral movement; segmentation + restricted paths are necessary.

---

## Common Mistakes

### Mistake 1: Treating Privacy and Security as Synonymous
**Wrong**: "If we encrypt all data, we've solved privacy requirements."
**Right**: Privacy requires encryption (security) *plus* consent frameworks, data minimization, and user rights (GAPP principles).
**Impact on Exam**: You'll incorrectly select GDPR/HIPAA controls (privacy) instead of [[Confidentiality]] controls (security), or vice versa.

### Mistake 2: Calculating Risk as Simple Addition
**Wrong**: Likelihood 3 + Impact 5 = Risk 8.
**Right**: Risk is the *product* of likelihood and impact; a vulnerability with zero exploitability = zero risk regardless of impact severity.
**Impact on Exam**: You'll rank low-likelihood, high-impact risks as higher priority than they warrant, wasting resources.

### Mistake 3: Assuming All Vulnerabilities Are Threats
**Wrong**: "We found a vulnerability; it's a security risk."
**Right**: A vulnerability *becomes* a risk only when a threat actor can exploit it. An unconnected, air-gapped system has vulnerabilities but zero risk from external attackers.
**Impact on Exam**: You'll recommend controls for non-existent threats (like patching an isolated system for web exploits).

### Mistake 4: Confusing NAC with Firewalls
**Wrong**: "Deploy a firewall at the perimeter; that's network access control."
**Right**: Firewalls filter traffic by IP/port; NAC validates device compliance and enforces posture policies *before* network access.
**Impact on Exam**: You'll suggest the wrong control for BYOD compliance or infected endpoint isolation.

### Mistake 5: Overlooking the DMZ's Role
**Wrong**: "Place all servers outside the firewall in the DMZ."
**Right**: Only *public-facing* services (web, DNS, email) live in the DMZ; internal databases must remain inside the firewall.
**Impact on Exam**: You'll create security gaps or recommend impractical architectures.

---

## Related