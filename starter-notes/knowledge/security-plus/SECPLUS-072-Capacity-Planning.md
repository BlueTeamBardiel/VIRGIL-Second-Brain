---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 072
source: rewritten
---

# Capacity Planning
**Strategic alignment of system resources with organizational demand to prevent service degradation and wasteful spending.**

---

## Overview
[[Capacity Planning]] is the process of determining and provisioning the appropriate level of resources—infrastructure, technology, and personnel—to meet current and projected user demand. For Security+, understanding capacity planning matters because resource constraints directly impact system availability, performance, and your organization's ability to maintain [[Confidentiality, Integrity, and Availability (CIA Triad)]]. Poor capacity decisions create security vulnerabilities through bottlenecks, forced workarounds, and burnout-driven human error.

---

## Key Concepts

### Resource Supply vs. Demand
**Analogy**: Think of a restaurant's seating capacity during dinner rush—too few tables and customers leave angry (demand exceeds supply); too many empty tables and you've wasted rent money (supply exceeds demand). The goal is the "Goldilocks" zone.

**Definition**: The fundamental tension in [[Capacity Planning]] exists between the amount of resources available (supply) and the amount of user requests, transactions, or workload hitting your systems (demand).

| Scenario | Supply | Demand | Result | Business Impact |
|----------|--------|--------|--------|-----------------|
| Balanced | Adequate | Normal | Optimal performance | Cost-effective operations |
| Undersupply | Insufficient | High | [[Application Slowdown]] and [[Outage]] | Lost revenue, SLA breaches, security incidents |
| Oversupply | Excessive | Normal | Wasted infrastructure | Unnecessary [[Capital Expenditure (CapEx)]] |

---

### Infrastructure Capacity
**Analogy**: Your server room is like a highway—add more lanes (servers, storage, bandwidth) to handle rush hour traffic, but don't build a 12-lane highway for a small town.

**Definition**: The hardware, network bandwidth, storage systems, and processing power required to handle peak user load. This includes [[Servers]], [[Storage Devices]], [[Network Bandwidth]], and [[Redundancy]] mechanisms.

---

### Personnel Capacity
**Analogy**: Hiring is like assembling a sports team—you can't field players instantly, training takes time, and cutting too many players mid-season cripples your team's performance.

**Definition**: The human workforce needed to operate, monitor, and maintain systems. Personnel capacity is uniquely difficult because [[Staffing]] cannot scale quickly. Hiring requires recruitment, onboarding, and training (time-intensive and expensive). Layoffs damage morale and institutional knowledge.

| Personnel Scenario | Challenge | Timeline | Cost Impact |
|-------------------|-----------|----------|-------------|
| Understaffed | Burnout, errors, security gaps | Months to hire & train | Revenue loss from incidents |
| Optimally staffed | Smooth operations | N/A | Balanced budget |
| Overstaffed | High payroll burden | Weeks to reassign/separate | Unnecessary overhead |

---

### Technology Fit
**Analogy**: Using a Ferrari for grocery delivery is overkill; using a bicycle to haul construction materials is inadequate. You need the right tool for the job.

**Definition**: Selecting appropriate technology that matches the organization's actual demand patterns, not aspirational or excessive requirements. [[Technology Planning]] ensures [[Cost-Effectiveness]] and [[Performance]] alignment.

---

## Exam Tips

### Question Type 1: Identifying Capacity Planning Problems
- *"Your company experiences daily 2 PM slowdowns when the sales team uploads reports to the server. Backups also run at 2 PM. What is the PRIMARY capacity issue?"* → **Insufficient network bandwidth or disk I/O during peak demand; you've undersupplied resources.**
- **Trick**: Don't confuse "slow application performance" with "bad code." Capacity problems manifest as slowdowns under load, not always bugs.

### Question Type 2: Personnel & Operational Capacity
- *"After a security incident, your team realizes they lack expertise in [[Log Analysis]]. The BEST long-term solution is:"* → **Budget for hiring and training new staff or external consulting**, not a quick Band-Aid fix.
- **Trick**: The exam may try to present expensive solutions (buying new tools) as "capacity planning" when the real gap is **human expertise and [[Staffing]]**.

### Question Type 3: Cost-Benefit Trade-offs
- *"Your infrastructure supports 1000 concurrent users. Projections show demand will grow to 1200 in 2 years. Should you upgrade now or wait?"* → **Depends on upgrade timeline and [[Risk Tolerance]]. Waiting risks undersupply; upgrading now risks wasted CapEx.**
- **Trick**: There's often no "perfect" answer—the exam tests whether you understand the trade-offs between [[Availability]], [[Cost]], and [[Risk]].

---

## Common Mistakes

### Mistake 1: Confusing Capacity with Performance Optimization
**Wrong**: "The database is slow, so we have a capacity problem."
**Right**: A slow database might be a [[Query Optimization]] issue, not insufficient [[Server Resources]]. Always diagnose before scaling.
**Impact on Exam**: You'll select "buy more servers" when the answer is "optimize queries" or "upgrade RAM to the existing server."

---

### Mistake 2: Ignoring the Human Side of Capacity
**Wrong**: "We solved our capacity problem by deploying a new virtualization platform."
**Right**: Technology alone doesn't solve capacity issues if your [[Security Operations Center (SOC)]] staff is already stretched thin monitoring the old system. Humans remain the bottleneck.
**Impact on Exam**: Expect questions that test whether you consider **staff training, hiring timelines, and burnout** as capacity constraints, not just hardware.

---

### Mistake 3: Over-Provisioning as a "Security" Solution
**Wrong**: "To ensure uptime and security, we'll triple our server capacity and triple our staff."
**Right**: Over-provisioning is wasteful and doesn't address actual threats. [[Capacity Planning]] is about matching supply to **realistic, data-driven** demand forecasts.
**Impact on Exam**: The exam may present over-provisioning as "redundancy for [[Availability]]." Distinguish between necessary [[Redundancy]] (active-active failover) and wasteful excess.

---

### Mistake 4: Static Capacity Planning
**Wrong**: "We sized our infrastructure for 5,000 users in 2023 and never revisited it."
**Right**: [[Capacity Planning]] is **ongoing and cyclical**. You must monitor usage trends, forecast growth, and adjust quarterly or annually.
**Impact on Exam**: Look for answers mentioning **regular reviews, [[Monitoring]]**, and **trend analysis**, not one-time planning.

---

## Related Topics
- [[Availability]]
- [[Redundancy]]
- [[Performance Metrics]]
- [[Cost-Benefit Analysis]]
- [[Risk Management Framework]]
- [[Incident Response]] (capacity failures trigger incidents)
- [[Business Continuity Planning]]
- [[Scalability]]
- [[Baseline]] (establishing normal capacity levels)

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*