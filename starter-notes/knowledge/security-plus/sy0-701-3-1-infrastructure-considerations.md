```yaml
---
domain: "3.0 - Security Architecture"
section: "3.1"
tags: [security-plus, sy0-701, domain-3, infrastructure, availability, resilience]
---
```

# 3.1 - Infrastructure Considerations

## Summary

Infrastructure Considerations focuses on the balance between **availability** and **security** within systems and networks. This section covers how organizations maintain system uptime while protecting against threats, and how to design systems that can recover quickly from failures. Understanding these concepts is critical for the Security+ exam because infrastructure decisions directly impact both security posture and business continuity.

---

## Key Concepts

- **Availability** – The principle that authorized users can reliably access data and complete transactions when needed; a foundational pillar of [[CIA Triad|information security]]
  - Requires monitoring, redundancy, and proactive maintenance
  - Often measured as a percentage of total operational time (e.g., 99.9% uptime)
  - Creates a tension with security: more restrictive access controls may reduce availability

- **Resilience** – The ability of a system to withstand disruptions and maintain or quickly restore functionality after an incident
  - Not just "is the system up?" but "how fast can we get it back up?"
  - Incorporates recovery capabilities alongside failure tolerance

- **Mean Time to Repair (MTTR)** – The average duration required to restore a failed system to full operational status
  - Directly tied to resilience metrics and SLA commitments
  - Influenced by root cause analysis, spare parts availability, and redundant infrastructure

- **Root Cause Analysis** – Investigation into why a system failed, enabling faster recovery and prevention of future incidents
  - Essential for understanding what variables affected availability

- **Redundancy** – Duplication of critical system components to ensure continued operation if one fails
  - Can apply to hardware, software, network paths, and data centers
  - Increases cost but directly improves availability and resilience

- **System Monitoring** – Continuous observation of infrastructure health, performance, and security metrics
  - Enables early detection of potential failures before they impact availability
  - Often tied to [[SIEM|Security Information and Event Management]] systems

- **The Availability-Security Balance** – A core tension in security architecture
  - Maximum security (heavily restricted access) can harm availability
  - Maximum availability (open access) can compromise security
  - Proper design finds the equilibrium based on business requirements

---

## How It Works (Feynman Analogy)

Think of infrastructure availability like a restaurant's customer service:

**The Scenario:** A restaurant wants to serve customers quickly (availability) while preventing unauthorized access to the kitchen (security). If security is too strict—only the head chef can access ingredients, all food must go through three approval layers—customers wait forever and the business loses money. If security is too loose—anyone can walk into the kitchen and grab food—customers get sick and the business gets shut down.

**The Balance:** The smart restaurant implements systems that are both secure AND efficient: trained staff access control, quick ingredient checkpoints, and backup cooks trained to step in if someone calls in sick (redundancy). When something breaks—a fryer fails—they have a second fryer ready and know exactly how to swap it out (low MTTR). Managers constantly observe operations (monitoring) to catch problems early.

**The Technical Reality:** Infrastructure availability mirrors this balance. Organizations deploy [[redundant systems]] (backup servers, failover databases), implement [[monitoring]] tools (like [[Wazuh]] or [[Splunk]]), enforce [[access controls]] through [[Active Directory]] or [[LDAP]], and maintain recovery procedures so that when failures occur (and they will), downtime is measured in minutes rather than hours. [[MTTR]] is the key metric proving your infrastructure is resilient.

---

## Exam Tips

- **Availability vs. Resilience Distinction:** The exam distinguishes between systems that *stay up* (availability) and systems that *recover quickly* (resilience). A system with good resilience might go down but comes back fast; a system with good availability rarely goes down at all. Expect scenario questions asking you to identify which metric applies.

- **MTTR is Quantifiable:** Remember that [[Mean Time to Repair]] is measured in concrete time units (hours, minutes, seconds). The exam may ask: "Which infrastructure improvement would reduce MTTR?" Answer: redundancy, spare parts inventory, automated recovery scripts, documentation—anything that speeds repairs.

- **Redundancy Costs Money:** Recognize the economic tradeoff. The exam might present scenarios where you must choose between redundancy (expensive, high availability) and single points of failure (cheap, high risk). Higher criticality systems demand more redundancy; lower-priority systems may not justify the cost.

- **Monitoring Feeds Into Availability:** Don't separate monitoring from availability. [[SIEM]] systems, log aggregation, and alerting are not just security tools—they directly improve availability by detecting failures early. The exam may ask how to improve SLAs; monitoring is always a correct answer.

- **Root Cause Analysis Prevents Recurrence:** When a scenario describes a past outage, the exam expects you to understand that identifying the root cause (not just the symptom) prevents future downtime. Watch for questions asking "what should be done after an outage?"—RCA is the answer.

---

## Common Mistakes

- **Treating Availability as a Binary:** Candidates often think "the system is either up or down," missing that availability is a percentage metric (99%, 99.9%, 99.99% uptime). Expect percentage-based questions and SLA calculations.

- **Confusing Availability with Redundancy:** Not all redundancy improves availability if failover is slow. A system with two servers but manual failover might have poor availability. The exam tests whether you understand that redundancy + automation = better availability.

- **Overlooking MTTR in Recovery Planning:** Candidates focus on prevention ("stop outages from happening") and forget recovery ("minimize impact when they do"). The exam includes questions about [[Incident Response]] and Business Continuity—both require low MTTR thinking.

---

## Real-World Application

For **Morpheus's [YOUR-LAB] homelab**, infrastructure considerations directly apply: the [[Tailscale]] mesh network must remain available to support remote access while filtering traffic securely; [[Wazuh]] monitoring detects failures before they cascade; and redundant nodes in the fleet ensure [[Active Directory]] authentication services stay up during maintenance. When designing lab infrastructure, Morpheus must balance the impulse to add complex security controls (like multi-factor authentication for every service) against user convenience—too restrictive and the lab becomes a barrier to learning; too loose and it's a liability. Real sysadmins face this daily: enterprise firewalls that block legitimate business requests, security patches that break availability, and the constant pressure to "keep things running" while "keeping things secure."

---

## Wiki Links

- [[CIA Triad]] – The foundational security model (Confidentiality, Integrity, Availability)
- [[Availability]] – One of the three pillars of CIA; ensures authorized access when needed
- [[Resilience]] – Recovery capability and failure tolerance
- [[Mean Time to Repair (MTTR)]] – Key metric for recovery speed
- [[Redundancy]] – Duplication for fault tolerance
- [[Monitoring]] – Continuous observation of system health
- [[SIEM]] – Security Information and Event Management for monitoring
- [[Incident Response]] – Procedures for handling security events and outages
- [[Active Directory]] – Identity and access management (critical availability infrastructure)
- [[LDAP]] – Lightweight Directory Access Protocol for authentication
- [[Wazuh]] – Open-source security monitoring platform
- [[Splunk]] – Enterprise security monitoring and analytics
- [[Tailscale]] – VPN/mesh network for secure remote access
- [[Business Continuity]] – Planning for maintaining operations during disruptions
- [[Disaster Recovery]] – Recovering from major infrastructure failures
- [[Service Level Agreement (SLA)]] – Contractual uptime commitments
- [[Automation]] – Scripted recovery to improve MTTR
- [[Failover]] – Automated switch to redundant systems
- [[Root Cause Analysis (RCA)]] – Investigation into failure causes

---

## Tags

`domain-3` `security-plus` `sy0-701` `infrastructure` `availability` `resilience` `mttr` `redundancy`

---
_Ingested: 2026-04-15 23:53 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
