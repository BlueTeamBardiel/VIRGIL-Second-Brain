---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 43
source: rewritten
---

# Insider Threats
**The most dangerous attacker is already sitting at a desk inside your organization.**

---

## Overview

Organizations invest heavily in perimeter security—[[firewalls]], [[intrusion detection systems]], and boundary defenses—but leave themselves vulnerable to threats originating from authenticated users already on the internal network. An [[insider threat]] occurs when an employee, contractor, or trusted individual with legitimate system access exploits that access to steal data, sabotage infrastructure, or compromise security. This is critical for A+ because IT professionals must understand that **the strongest castle is worthless if the enemy already has the key to the front door.**

---

## Key Concepts

### Insider Threat Definition

**Analogy**: Imagine hiring a tour guide for your bank vault. They learn exactly where the most valuable items sit, how the alarm systems work, which cameras have blind spots, and when guards take breaks. One day, they simply walk out with the goods—and no one outside the building suspected a thing.

**Definition**: An [[insider threat]] is a security risk posed by individuals with legitimate credentials and system access who intentionally or unintentionally compromise organizational security, data integrity, or availability. Unlike external attackers, insiders possess intimate knowledge of systems, security controls, data locations, and operational procedures.

**Related Concepts**: [[authentication]], [[access control]], [[data exfiltration]], [[privilege escalation]]

---

### Types of Insider Threats

| Threat Type | Motivation | Method | Detection Difficulty |
|---|---|---|---|
| **Disgruntled Employee** | Revenge, financial hardship | Direct data theft, sabotage | Medium |
| **Recruited Insider** | Financial incentive, coercion | Targeted access provision, espionage | High |
| **Careless User** | None (unintentional) | Credential exposure, misconfiguration | Low |
| **Third-Party Contractor** | Varies | Lateral movement, backdoor installation | High |
| **Compromised Account** | Attacker controls legitimate credentials | Data exfiltration, malware deployment | Medium |

---

### Knowledge-Based Advantage

**Analogy**: A burglar studying a neighborhood for weeks knows every house layout, which windows don't lock properly, and when residents leave. An insider employee has studied your organization's architecture for months or years.

**Definition**: Malicious insiders possess **institutional knowledge** that external attackers must spend months discovering—data repository locations, [[patch management]] schedules, security tool configurations, incident response procedures, and system vulnerabilities specific to your environment.

**Key Insight**: Insiders can execute attacks with surgical precision because they understand:
- Where sensitive data is stored and how to access it
- Which [[logging]] and [[monitoring]] systems might detect their activity
- How to exfiltrate data without triggering [[intrusion detection systems]]
- When security staff are least attentive

---

### Recruitment and Directed Threats

**Analogy**: A sophisticated heist doesn't target random buildings—criminals identify and recruit someone already working inside the target location, offering them payment or leverage.

**Definition**: **Directed insider threats** occur when external threat actors deliberately recruit, manipulate, or coerce legitimate employees into providing unauthorized access or stealing proprietary information. This represents organized, intentional compromise rather than opportunistic exploitation.

**Real-World Scenarios**:
- Competitors paying employees for source code or trade secrets
- Nation-states recruiting contractors for intelligence gathering
- Criminal syndicates offering payment for system access during ransomware attacks
- Social engineering targeting dissatisfied employees with financial offers

---

### Unintentional Insider Threats

**Analogy**: A well-meaning employee leaving car doors unlocked and engine running in the parking lot isn't trying to facilitate theft—but they've made the thief's job trivial.

**Definition**: [[Unintentional insider threats]] result from negligence, poor security hygiene, or lack of training—not malicious intent. Examples include password written on sticky notes, [[credential sharing]], unencrypted laptops, or falling for [[phishing]] attacks.

**Common Causes**:
- Weak [[password]] practices
- Unpatched software vulnerabilities
- Accidental data exposure (email misconfiguration)
- Clicking malicious links in [[phishing]] emails
- Leaving workstations unlocked

---

## Exam Tips

### Question Type 1: Identifying Insider Threat Vectors
- *"A company discovers that a former employee transferred 50GB of customer data before their account was disabled. Which control would have BEST prevented this?"* 
  - **Answer**: [[Data loss prevention (DLP)]] tools that monitor outbound data transfers in real-time.
  - **Alternatives**: Remote wipe capabilities, continuous access reviews, activity logging (all help, but DLP is most direct).

- *"An attacker recruits an IT support technician to install a backdoor during system maintenance. What is the primary vulnerability being exploited?"*
  - **Answer**: Lack of [[principle of least privilege]] and insufficient [[separation of duties]].
  - **Trick**: Many students answer "weak passwords"—wrong. The issue is **authorized access being abused**, not unauthorized access being gained.

### Question Type 2: Control Implementation
- *"Which of the following BEST detects when an employee accesses files outside their job responsibilities?"*
  - **Answer**: [[User and Entity Behavior Analytics (UEBA)]] or [[file integrity monitoring]] with access logging.
  - **Trick**: [[Firewalls]] protect the perimeter; they don't monitor internal behavior. [[Antivirus]] catches malware, not policy violations.

### Question Type 3: Mitigation Strategies
- *"A company wants to reduce insider threat risk. Which action should be taken FIRST?"*
  - **Answer**: Implement [[principle of least privilege]]—grant only necessary access for job functions.
  - **Why It Matters**: Limits the damage any single compromised or malicious account can cause.

---

## Common Mistakes

### Mistake 1: Assuming Firewalls Prevent Insider Threats
**Wrong**: "We have a strong firewall, so insider threats aren't a problem."
**Right**: [[Firewalls]] protect external perimeter; they don't stop authenticated internal users from exfiltrating data or misusing credentials.
**Impact on Exam**: Questions about insider threat mitigation aren't solved with perimeter security answers. You need internal controls like [[DLP]], [[SIEM]], [[audit logging]], and [[access control lists]].

---

### Mistake 2: Confusing Insider Threats with User Error
**Wrong**: "An insider threat is just a careless employee."
**Right**: Insider threats span a spectrum from **unintentional negligence** (careless user leaving password visible) to **intentional malice** (recruited employee stealing trade secrets). Both are insider threats with different causes and controls.
**Impact on Exam**: You might be asked whether a scenario is "insider threat or user training issue"—answer: it can be both. A security control addressing one might not address the other.

---

### Mistake 3: Believing Insider Threats Are Rare
**Wrong**: "This mostly happens at big tech companies, not normal organizations."
**Right**: Insider threats affect **all organizations**—healthcare (patient data theft), finance (wire fraud), manufacturing (blueprint theft), and education (research data exfiltration). Size and industry don't eliminate risk.
**Impact on Exam**: Don't dismiss insider threat questions as "unrealistic." The CompTIA A+ exam emphasizes real-world security principles.

---

### Mistake 4: Overlooking Third-Party and Contractor Risks
**Wrong**: "Contractors aren't real employees, so they're not insider threats."
**Right**: Contractors, vendors, and temporary staff **are insiders** because they have system access. They may have weaker background checks, less security awareness training, and higher turnover.
**Impact on Exam**: When a question mentions "external consultants" with system access, treat them as insider threat subjects requiring the same access controls and monitoring.

---

## Controls and Defenses

| Control | How It Helps | A+ Relevance |
|---|---|---|
| **[[Principle of Least Privilege]]** | Users get only necessary access; limits damage | Foundation of access control |
| **[[Separation of Duties]]** | No single person controls sensitive processes | Prevents embezzlement, sabotage |
| **[[Audit Logging]] & [[SIEM]]** | Detects abnormal behavior patterns | Identifies exfiltration attempts |
| **[[Data Loss Prevention (DLP)]]** | Blocks unauthorized data transfers | Prevents theft at exit points |
| **[[User Activity Monitoring]]** | Records what employees do on systems | Post-incident forensics |
| **[[Termination Procedures]]** | Immediate credential revocation on departure | Prevents access by former employees |
| **[[Background Checks]]** | Identifies high-risk hires | Pre-employment screening |
| **[[Security Awareness Training]]** | Teaches users to recognize social engineering | Reduces unintentional threats |
| **[[Multifactor Authentication]]** | Prevents account takeover with stolen credentials | Protects high-privilege accounts |

---

## Related Topics
- [[Access Control Models]] ([[RBAC]], [[ABAC]])
- [[Principle of Least Privilege]]
- [[Data Loss Prevention (DLP)]]
- [[Audit Logging and Monitoring]]
- [[User and Entity Behavior Analytics (UEBA)]]
- [[Separation of Duties]]
- [[Credential Management]]
- [[Social Engineering]]
- [[Physical Security]]
- [[Termination Procedures]]

---

*Source: CompTIA A+ Core 2 (220-1202) | Security Awareness and Insider Threats | [[A+]]*