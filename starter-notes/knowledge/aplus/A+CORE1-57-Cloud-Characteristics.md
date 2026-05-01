---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 57
source: rewritten
---

# Cloud Characteristics
**Understanding how organizations choose between owning their own infrastructure versus renting shared cloud resources.**

---

## Overview

Cloud computing fundamentally changed how IT infrastructure works by offering two distinct models: organizations can either build and maintain their own isolated systems, or leverage shared resources managed by third-party providers. For the A+ exam, understanding these deployment models is critical because IT professionals need to recognize the cost implications, security considerations, and resource management differences between these approaches. This concept appears frequently on both 220-1201 and 220-1202 exams.

---

## Key Concepts

### Private Cloud

**Analogy**: Think of a private cloud like owning your own private swimming pool. You buy the pool, maintain it, heat it, clean it, and only you and your invited guests use it. You have complete control, but you also pay all the upfront costs and ongoing maintenance bills.

**Definition**: A [[cloud computing]] environment where an organization purchases, installs, and manages all [[hardware]], [[storage]], and [[infrastructure]] within their own [[data center]]. All resources are dedicated exclusively to that single organization—no other companies share the same physical equipment.

**Also Known As**: 
- [[Internal Cloud]]
- [[On-Premises Cloud]]

**Key Characteristics**:
- Exclusive resource access
- High upfront capital expenditure (CapEx)
- No metered usage costs after initial setup
- Full administrative control
- Dedicated [[bandwidth]] and [[CPU]]

---

### Public Cloud

**Analogy**: A public cloud is like using a community swimming pool. Many families share the same facility, but each family has their own assigned lane. The pool operator handles all maintenance and equipment, you just pay per visit, and everyone's water stays separate even though you're using the same pool.

**Definition**: A [[cloud computing]] model where a third-party cloud provider (such as [[Amazon Web Services|AWS]], [[Microsoft Azure]], [[Google Cloud]], or [[Rackspace]]) owns and manages the [[infrastructure]]. Multiple organizations share the same physical [[servers]], [[storage devices]], and [[network resources]], but their data remains logically isolated and inaccessible to other tenants.

**Key Characteristics**:
- Shared resources across many customers
- Pay-as-you-go pricing (OpEx model)
- Minimal upfront infrastructure investment
- Provider handles all maintenance and updates
- Automatic [[scalability]]
- Multi-tenant architecture with data isolation

---

## Deployment Model Comparison

| Aspect | Private Cloud | Public Cloud |
|--------|---------------|--------------|
| **Hardware Ownership** | Organization owns equipment | Provider owns equipment |
| **Cost Structure** | High CapEx, low ongoing costs | Low CapEx, variable OpEx |
| **Resource Sharing** | Single organization only | Multiple tenants share resources |
| **Data Isolation** | Physical separation | Logical separation |
| **Control Level** | Complete administrative control | Limited to cloud provider settings |
| **Maintenance Burden** | Organization responsible | Provider responsible |
| **Scalability** | Limited by purchased equipment | Unlimited elasticity |
| **Compliance** | Easier to meet strict regulations | Must verify provider compliance |

---

## Exam Tips

### Question Type 1: Cost and Investment Models
- *"A company wants to minimize upfront infrastructure costs and only pay for resources they actually use. Which cloud model best fits this requirement?"* → **Public Cloud** (pay-per-use, low CapEx)
- *"An organization has $500,000 to spend on infrastructure upfront and wants unlimited data access. Which model should they choose?"* → **Private Cloud** (CapEx investment, no metered costs)
- **Trick**: Don't confuse "no additional costs" (private cloud after setup) with "cheaper overall"—public cloud can be cheaper for variable workloads.

### Question Type 2: Resource Sharing and Isolation
- *"In a public cloud environment, can Customer A view Customer B's data?"* → **No**—logical/virtual isolation prevents this despite physical resource sharing.
- *"Why might a company choose private cloud despite higher costs?"* → Security, compliance requirements, or need for complete control.
- **Trick**: The exam may imply that "shared resources" means "shared data"—they don't. Multi-tenancy provides isolation.

### Question Type 3: Maintenance and Administration
- *"Which cloud deployment requires the organization to purchase and install their own servers?"* → **Private Cloud**
- *"Who maintains the physical infrastructure in a public cloud?"* → **The cloud provider**
- **Trick**: Even in private cloud, you can still use [[virtualization]] and [[cloud computing]] principles—ownership ≠ whether it's "cloud-like."

---

## Common Mistakes

### Mistake 1: Confusing "Private Cloud" with "Secure Cloud"
**Wrong**: "Private cloud is always more secure because other people can't access it."
**Right**: Public clouds can be equally or more secure with proper [[encryption]], [[access controls]], and [[identity management]]. Security depends on implementation, not deployment model.
**Impact on Exam**: You may see questions asking whether private cloud automatically meets security requirements—it doesn't; proper security controls matter more.

### Mistake 2: Thinking Public Cloud Has No Costs After Setup
**Wrong**: "Public cloud is cheap—you pay once and that's it."
**Right**: Public cloud operates on [[OpEx]] (operational expenditure)—you're billed continuously based on usage: storage, [[bandwidth]], compute hours, etc.
**Impact on Exam**: Questions testing budget awareness will trap you if you don't understand ongoing metered billing.

### Mistake 3: Believing "Shared Resources" Means "Shared Data"
**Wrong**: "In public cloud, my data could be visible to other companies using the same servers."
**Right**: Multi-tenant [[virtualization]] provides complete logical isolation; other tenants cannot access your data even though they use identical physical hardware.
**Impact on Exam**: Don't automatically choose "private cloud" answers when isolation is mentioned—public cloud provides adequate isolation for most workloads.

### Mistake 4: Overlooking the "No Additional Costs" Advantage of Private Cloud
**Wrong**: "Private cloud is always more expensive."
**Right**: Private cloud requires massive upfront [[CapEx]], but once paid, you can scale usage with zero additional cloud costs. Public cloud charges for every resource increment.
**Impact on Exam**: Recognize scenarios where a company with predictable, high resource usage might benefit from private cloud's flat costs.

---

## Related Topics
- [[Cloud Computing Models]]
- [[Infrastructure as a Service (IaaS)]]
- [[Data Center Architecture]]
- [[Virtualization]]
- [[Network Scalability]]
- [[Cloud Security]]
- [[Operational Expenditure vs Capital Expenditure]]
- [[Multi-Tenancy]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) Cloud Characteristics Lecture | [[A+]]* | [[CompTIA]]