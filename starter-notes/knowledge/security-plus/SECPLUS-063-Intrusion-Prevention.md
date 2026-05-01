---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 063
source: rewritten
---

# Intrusion Prevention
**Active threat blocking that stops malicious traffic before it enters your network.**

---

## Overview
An [[Intrusion Prevention System (IPS)]] operates as a gatekeeping mechanism that inspects all network traffic flowing through it in real-time, identifying and immediately blocking any suspicious or malicious patterns. This is crucial for Security+ because understanding the difference between passive detection and active prevention is fundamental to building effective network defenses.

---

## Key Concepts

### Intrusion Prevention System (IPS)
**Analogy**: Think of an IPS like a security guard at an airport who doesn't just scan your bag and radio for help—they actively confiscate dangerous items before you board the plane.

**Definition**: An [[IPS]] is an inline security device that monitors network traffic in real-time and automatically blocks packets matching malicious signatures, [[exploits]], or attack patterns before they reach internal systems.

| Characteristic | Details |
|---|---|
| **Placement** | Inline (in the direct path of traffic) |
| **Response Time** | Immediate blocking (real-time) |
| **Attack Types Blocked** | Known [[vulnerabilities]], [[buffer overflows]], [[SQL injection]], zero-days (pattern-based) |
| **False Positive Impact** | Can disrupt legitimate traffic if misconfigured |

---

### Intrusion Detection System (IDS)
**Analogy**: An [[IDS]] is like a silent alarm system that alerts security when someone tries to enter through a window—but it doesn't lock the window or stop them.

**Definition**: An [[IDS]] monitors network traffic and generates alerts when suspicious activity is detected, but takes no blocking action. It operates in "listen-only" mode.

| Feature | IDS | IPS |
|---|---|---|
| **Action on Threat** | Alert only | Block immediately |
| **Deployment** | Can be inline or passive | Must be inline |
| **Network Impact** | None (non-disruptive) | Can affect legitimate users |
| **Detection Delay** | Reaction is manual/delayed | Automatic and instant |

---

### Fail-Open vs. Fail-Close Configuration
**Analogy**: Fail-open is like a fire escape door that swings open when power fails—everyone gets out safely but security is compromised. Fail-close is a security gate that locks down the entire building if the system fails.

**Definition**: These are two opposing design philosophies for how an [[IPS]] behaves when it experiences a hardware failure, power loss, or software crash.

| Failure Mode | Behavior | Advantages | Disadvantages |
|---|---|---|---|
| **Fail-Open** | Traffic continues flowing unfiltered | Network availability maintained | No security monitoring active |
| **Fail-Close** | All traffic is blocked until device recovers | Prevents bypass attacks | Network outage/denial of service |

**Why this matters**: Most organizations choose fail-open to prioritize [[availability]] over temporary loss of [[confidentiality]] and [[integrity]] protections.

---

## Exam Tips

### Question Type 1: IPS vs. IDS Distinction
- *"Your organization needs to actively prevent known exploits from reaching production servers. Which device should you deploy?"* → **IPS** (blocking capability required)
- *"Management wants alerts on suspicious activity but is concerned about disrupting legitimate business traffic. What solution minimizes false positive impact?"* → **IDS** (passive monitoring)
- **Trick**: Questions may ask "which detects threats?" (both do), but "which stops threats?" is IPS-only

### Question Type 2: Failure Scenarios
- *"An IPS fails unexpectedly. Network traffic continues flowing, but security monitoring stops. How was this device configured?"* → **Fail-open**
- *"Your IPS crashed at 2 AM and brought down all internet connectivity until the team manually rebooted it. What configuration caused this?"* → **Fail-close**
- **Trick**: Don't confuse "security failure" with "network failure"—fail-close is more secure but less available

### Question Type 3: Attack Detection Capabilities
- *"Which of the following can an IPS block without prior signature updates?"* → Pattern-based attacks like [[buffer overflow]] or [[SQL injection]] (behavioral signatures)
- **Trick**: Zero-day exploits may be blocked if they match generic attack patterns, but not if they're entirely novel

---

## Common Mistakes

### Mistake 1: Believing IDS and IPS Are Interchangeable
**Wrong**: "We deployed an IDS, so we're protected from network attacks"
**Right**: An [[IDS]] provides visibility and alerting; an [[IPS]] provides actual threat prevention
**Impact on Exam**: You'll lose points on scenario questions asking which device "stops" vs. "detects" threats. Read action verbs carefully: *prevent/block* = IPS; *detect/alert* = IDS

### Mistake 2: Assuming Fail-Close Always Means "More Secure"
**Wrong**: "We should configure everything fail-close because security is more important than uptime"
**Right**: Fail-close can enable [[denial of service]] attacks; fail-open maintains [[availability]] while sacrificing temporary filtering
**Impact on Exam**: Multi-answer questions about resilience and [[availability]] require understanding this trade-off. Fail-close can actually make your network *less* secure if attackers intentionally crash the IPS

### Mistake 3: Confusing IPS Placement with IDS Placement
**Wrong**: "We installed an IDS inline to block attacks"
**Right**: An [[IPS]] MUST be inline to block; an [[IDS]] can be placed on a [[SPAN port]] or [[network tap]] to passively monitor without impacting traffic
**Impact on Exam**: Deployment architecture questions will test whether you understand inline requirements for active blocking

### Mistake 4: Thinking All Threats Require Signatures
**Wrong**: "Our IPS is useless because it only blocks known attacks"
**Right**: [[IPS]] systems detect both signature-based threats AND behavioral anomalies ([[buffer overflow]], [[SQL injection]] patterns)
**Impact on Exam**: Questions about unknown attack detection should not immediately conclude "IPS can't help"—behavioral analysis matters

---

## Related Topics
- [[Intrusion Detection System (IDS)]]
- [[Network Segmentation]]
- [[Firewall]] (different layer, different purpose)
- [[Signature-Based Detection]]
- [[Anomaly Detection]]
- [[Buffer Overflow]]
- [[SQL Injection]]
- [[Availability]] vs. [[Confidentiality]] Trade-offs
- [[Network Tap]]
- [[SPAN Port]]
- [[Denial of Service (DoS)]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*