---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 059
source: rewritten
---

# Network Infrastructure Concepts
**Physical isolation through air gaps prevents lateral movement between network segments.**

---

## Overview
Network infrastructure security depends on understanding how to compartmentalize systems to limit an attacker's ability to pivot across your environment. One of the most effective (and simplest) strategies is creating physical separation between network segments—ensuring that even if one area is compromised, attackers cannot reach adjacent systems without explicit connectivity bridges. This concept appears frequently on the Security+ exam because it represents foundational defense-in-depth thinking.

---

## Key Concepts

### Air Gap / Physical Isolation
**Analogy**: Think of an air gap like a moat around a castle—you can have guards (Switch A) and you can have other guards (Switch B), but if there's literally no bridge between them, an enemy who captures one castle cannot simply walk to the other.

**Definition**: An [[air gap]] is the physical and logical separation of network segments or devices, preventing any direct connectivity path between them unless explicitly configured. Devices on isolated [[network switches]] cannot communicate unless connected through an intermediary device like a [[router]] or gateway.

| Scenario | Connectivity | Security Benefit |
|----------|--------------|------------------|
| No air gap | Devices move freely between switches | Lateral movement is easy for attackers |
| Air gap in place | Communication blocked unless bridged | Compromised segment cannot reach others |
| Managed bridge | Controlled connection between segments | Allows business need + security control |

**Related Concept**: [[Defense in Depth]]

---

### Use Cases for Air Gaps

**Scenario 1: Server Segmentation**
Imagine you host web servers in one physical rack and database servers in another. An [[air gap]] prevents web server compromise from automatically exposing your databases—an attacker must find a second vulnerability to pivot.

**Scenario 2: Multi-Tenant Environments**
Managed Service Providers (MSPs) serving multiple customers benefit from physical isolation. Customer A's network sits on one [[switch]], Customer B's on a completely separate switch. Even if Customer A is breached, Customer B remains untouched because no physical path exists between their infrastructure.

**Scenario 3: High-Security Installations**
Government, healthcare, and financial institutions use air gaps to enforce compliance. Sensitive systems operate on isolated [[network segments]] that require explicit authorization and monitored gateways for any cross-segment traffic.

---

## Exam Tips

### Question Type 1: Identifying Air Gap Benefits
- *"A financial institution wants to prevent a compromised workstation from accessing its mainframe. Which approach best implements this?"* → Deploy the mainframe on a physically isolated [[network segment]] with no direct connection, using a monitored gateway for legitimate transactions.
- **Trick**: Students confuse "air gap" with "firewall"—air gaps are *physical separation*, not just rule-based filtering. A firewall can be misconfigured; an air gap is harder to breach accidentally.

### Question Type 2: Implementation Scenarios
- *"You manage an MSP with 15 customers. For maximum isolation, how should you segment the network?"* → Assign each customer to separate [[network switches]] with no inter-switch connectivity unless explicitly needed.
- **Trick**: Watch for answers suggesting "VLANs are sufficient"—while [[VLAN|VLANs]] provide logical isolation, the question may require physical separation.

### Question Type 3: Business vs. Security Trade-offs
- *"Two segments are air-gapped, but business requirements now demand data exchange. What's the best approach?"* → Establish a controlled [[gateway]], [[router]], or monitored connection point rather than removing the air gap entirely.
- **Trick**: Don't eliminate isolation just for convenience; instead, create *monitored bridges*.

---

## Common Mistakes

### Mistake 1: Confusing Air Gaps with Network Segmentation
**Wrong**: "A [[VLAN]] creates an air gap because traffic is separated logically."
**Right**: An air gap is *physical*—devices are on different hardware. A [[VLAN]] is logical and can be misconfigured or bypassed. Both are useful but different.
**Impact on Exam**: You may see a scenario describing logical segmentation and be asked if it's "truly isolated"—the answer depends on whether physical separation exists.

### Mistake 2: Thinking Air Gaps Mean No Communication Ever
**Wrong**: "If we create an air gap, Customer A and Customer B can never communicate."
**Right**: Air gaps *prevent uncontrolled communication*. You can still bridge segments using a monitored [[gateway]], [[router]], or [[firewall]] when business needs require it.
**Impact on Exam**: Questions about "enabling communication across air-gapped segments" require understanding controlled bridging, not removing the isolation.

### Mistake 3: Overlooking Physical Layer Security
**Wrong**: "An air gap is only about network configuration."
**Right**: True air gaps require physical security—separate hardware, separate cable runs, and physical access controls. A misconfigured [[patch panel]] can undermine the isolation.
**Impact on Exam**: Scenarios may test whether you recognize that air gaps extend beyond Layer 3 to the actual physical infrastructure.

### Mistake 4: Assuming One Air Gap Secures Everything
**Wrong**: "We isolated the database segment, so our infrastructure is secure."
**Right**: An air gap is one layer of defense. Attackers inside the isolated segment can still escalate privileges, exploit unpatched systems, or exfiltrate data.
**Impact on Exam**: Look for answers that combine air gaps with other controls like [[intrusion detection]], access logging, and [[encryption]].

---

## Related Topics
- [[Defense in Depth]]
- [[Network Segmentation]]
- [[VLAN]] (Logical vs. Physical Isolation)
- [[Firewall]]
- [[Router]]
- [[Gateway]]
- [[Network Switch]]
- [[Lateral Movement]]
- [[Privileged Access Management]]
- [[Zero Trust Architecture]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*