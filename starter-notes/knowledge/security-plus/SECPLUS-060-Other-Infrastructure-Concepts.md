---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 060
source: rewritten
---

# Other Infrastructure Concepts
**Understanding where security lives: on-premises versus cloud deployment models and their security implications.**

---

## Overview
Organizations must decide whether to protect their data and systems using their own physical infrastructure or by leveraging third-party [[cloud computing]] providers. Both approaches offer distinct security advantages and trade-offs that directly impact risk management, operational costs, and compliance requirements—making this a critical topic for Security+ candidates.

---

## Key Concepts

### On-Premises Infrastructure
**Analogy**: Like owning your own home, you control every lock, alarm system, and security measure, but you also pay for all maintenance, repairs, and security staff.

**Definition**: [[On-premises infrastructure]] refers to security systems, data centers, and protective technologies physically located within your organization's facilities that your internal IT team operates and maintains.

**Advantages**:
- Complete control over security decisions and implementations
- Direct oversight of all [[data governance]] and [[access control]] policies
- No reliance on third-party security practices
- Customizable security stack tailored to organizational needs

**Disadvantages**:
- Requires dedicated IT staff with specialized expertise
- Substantial capital expenditures for hardware and [[physical security]]
- Ongoing operational costs (facilities, cooling, power, staffing)
- Internal team responsible for patches, updates, and incident response

---

### Cloud-Based Infrastructure
**Analogy**: Like renting an apartment, the landlord handles maintenance, security, and repairs—you gain convenience and lower upfront costs, but surrender some control.

**Definition**: [[Cloud infrastructure]] security means leveraging a third-party provider's centralized systems, where the provider manages [[authentication]], [[encryption]], updates, and compliance monitoring across shared resources.

**Advantages**:
- Operational cost reduction (no hardware procurement or data center management)
- Centralized security managed by specialized cloud security professionals
- Automatic [[patch management]] and security updates
- Scalability without infrastructure overhaul
- Shared security responsibility model ([[shared responsibility model]])

**Disadvantages**:
- Reduced visibility into security implementation details
- Dependent on provider's security posture and incident response capabilities
- Potential [[vendor lock-in]] complications
- Compliance challenges across jurisdictions and data residency requirements

---

### Comparison Table

| Factor | On-Premises | Cloud-Based |
|--------|-------------|------------|
| **Control** | Complete | Shared/Limited |
| **Upfront Cost** | High (CapEx) | Low (OpEx) |
| **Operational Overhead** | High (staffing, maintenance) | Low (provider-managed) |
| **Expertise Required** | Deep technical knowledge | Provider-dependent knowledge |
| **Customization** | Maximum flexibility | Limited by provider offerings |
| **Incident Response** | Internal ownership | Shared responsibility |
| **Physical Security** | Your responsibility | Provider responsibility |
| **Scalability** | Time-intensive | Rapid and on-demand |

---

## Exam Tips

### Question Type 1: Infrastructure Deployment Models
- *"Your company wants to minimize operational overhead while maintaining compliance with data residency laws. Which infrastructure model is most appropriate?"* → Cloud may reduce overhead, but on-premises better guarantees data residency control.
- *"An organization requires complete control over security decision-making and customization options. What infrastructure approach is recommended?"* → On-premises, despite higher costs.
- **Trick**: Questions often present cost as the primary factor—but don't ignore control and compliance requirements, which may outweigh savings.

### Question Type 2: Security Responsibility Distribution
- *"In a cloud-based security model, who is responsible for [[patch management]] of the underlying hypervisor?"* → The cloud provider (part of [[shared responsibility model]]).
- **Trick**: Confusing what the customer manages versus what the provider manages based on service tier ([[SaaS]] vs [[PaaS]] vs [[IaaS]]).

### Question Type 3: Attack Surface Considerations
- *"Does an attacker's approach differ between on-premises and cloud security?"* → No—attackers work to bypass security regardless of deployment model; the attack vectors may differ, but intent remains constant.
- **Trick**: Don't assume cloud is inherently "safer" or on-premises is inherently "more vulnerable."

---

## Common Mistakes

### Mistake 1: Assuming On-Premises = Automatically More Secure
**Wrong**: "We control everything on-premises, so we're definitely more secure than cloud."
**Right**: Security depends on implementation quality, expertise, and resources—not location alone. A poorly maintained on-premises system can be far less secure than a well-managed cloud platform.
**Impact on Exam**: You'll encounter scenarios where cloud provides superior security through expert management, redundancy, and [[disaster recovery]] capabilities.

### Mistake 2: Overlooking Shared Responsibility Model Boundaries
**Wrong**: "The cloud provider handles ALL security in our cloud environment."
**Right**: You retain responsibility for [[data encryption]], [[access control]], user authentication, and security configuration. The provider secures the infrastructure underneath.
**Impact on Exam**: Security+ questions frequently test where responsibility boundaries lie; misconstruing these is a major trap.

### Mistake 3: Conflating Cost Savings with Security Improvement
**Wrong**: "Cloud is cheaper, therefore it's the better security choice."
**Right**: Cost and security are separate dimensions. Cloud offers cost advantages but may introduce compliance complexity, reduced control, and vendor dependency concerns.
**Impact on Exam**: Expect questions asking you to evaluate trade-offs beyond mere expense.

### Mistake 4: Ignoring Regulatory and Compliance Constraints
**Wrong**: "We'll just move everything to the cloud and save money."
**Right**: [[HIPAA]], [[PCI-DSS]], [[GDPR]], and other frameworks may mandate on-premises storage, data residency, or specific security controls that cloud models cannot satisfy.
**Impact on Exam**: Questions often embed compliance requirements as the deciding factor between deployment models.

---

## Related Topics
- [[Shared Responsibility Model]]
- [[Cloud Computing]] (SaaS, PaaS, IaaS)
- [[Data Governance]]
- [[Disaster Recovery]] and [[Business Continuity]]
- [[Physical Security]]
- [[Patch Management]]
- [[Access Control]]
- [[Vendor Risk Management]]
- [[Compliance Frameworks]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*