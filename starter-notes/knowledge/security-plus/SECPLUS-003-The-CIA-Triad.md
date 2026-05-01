---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 003
source: rewritten
---

# The CIA Triad
**The three foundational pillars that govern every security decision in information technology.**

---

## Overview
The CIA Triad serves as the conceptual backbone for nearly all [[Security+]] exam questions and real-world security implementations. These three interconnected principles—[[Confidentiality]], [[Integrity]], and [[Availability]]—define what we're protecting and why. Understanding how to balance these three sometimes-competing objectives is critical for passing the SY0-701 exam and building effective security strategies.

---

## Key Concepts

### Confidentiality
**Analogy**: Think of confidentiality like a locked filing cabinet in your office. Only the people you give the key to can open it and read what's inside. Everyone else walks past it, but they have no idea what's in there.

**Definition**: [[Confidentiality]] is the protection of sensitive information from unauthorized disclosure or viewing. It ensures that only authorized individuals can access private data.

**Implementation Methods**:
- [[Encryption]] (converting data into unreadable form without the decryption key)
- [[Access Controls]] (restricting who can see what)
- [[Authentication]] (verifying someone is who they claim to be)

---

### Integrity
**Analogy**: Imagine mailing a letter to a friend. Integrity means that when they receive it, the letter hasn't been secretly opened, read, modified, and resealed by someone in the middle. They get exactly what you sent.

**Definition**: [[Integrity]] guarantees that information hasn't been altered, modified, or corrupted—either intentionally or accidentally—during transmission or storage. It confirms the data remains exactly as the originator created it.

**Implementation Methods**:
- [[Hashing]] (creating a unique fingerprint of data)
- [[Digital Signatures]] (proving who created/approved the data)
- [[Message Authentication Codes]] (MAC) (verifying the data hasn't changed)
- [[Checksums]] (detecting accidental corruption)

---

### Availability
**Analogy**: Availability is like making sure your restaurant is open during business hours. It doesn't matter how good your food is if customers can't access it because you're closed all the time.

**Definition**: [[Availability]] ensures that authorized users can access systems, networks, and data whenever they need them. It means preventing downtime, outages, and denial-of-service conditions.

**Implementation Methods**:
- [[Redundancy]] (backup systems and data)
- [[Load Balancing]] (distributing traffic)
- [[Disaster Recovery]] planning
- [[Business Continuity]] strategies
- [[DDoS Mitigation]] controls

---

## The CIA Triad Triangle

| Component | Protects Against | Primary Threat |
|-----------|------------------|---|
| **Confidentiality** | Unauthorized disclosure | [[Data Breach]], [[Eavesdropping]] |
| **Integrity** | Unauthorized modification | [[Man-in-the-Middle Attack]], [[Data Tampering]] |
| **Availability** | Service disruption | [[Denial of Service]], [[Ransomware]], hardware failure |

---

## The Balancing Act: The Core Challenge

The greatest difficulty in IT security is simultaneously providing access to authorized users while protecting against unauthorized users. This creates natural tension:

- **More Confidentiality** → Harder access (less availability)
- **More Availability** → More people can reach it (harder to maintain confidentiality)
- **Strong Integrity Controls** → May slow down systems (impacts availability)

Every security decision involves choosing which principles matter most for that specific situation.

---

## Exam Tips

### Question Type 1: Identifying Which Principle is Violated
- *"A hacker intercepts an employee's email and modifies it before sending it to the finance department, causing an incorrect wire transfer. Which principle of the CIA Triad was violated?"* → **Integrity** (data was altered)
- *"A database server crashes and employees cannot access customer records for 6 hours. Which principle is affected?"* → **Availability** (system is not accessible)
- *"An unauthorized person gains access to employee salary information. Which principle is violated?"* → **Confidentiality** (information was disclosed)
- **Trick**: Don't confuse "someone got in" (confidentiality) with "someone changed something" (integrity)

### Question Type 2: Selecting the Right Control
- *"A company wants to prevent employees from changing financial records without authorization. Which principle are they protecting?"* → **Integrity** (and the control is likely [[Digital Signatures]] or [[Audit Logs]])
- **Trick**: The question might describe a scenario (like encryption) and ask which principle it addresses

### Question Type 3: Prioritization Scenarios
- *"A hospital must choose between implementing stronger authentication (slowing down emergency room access) or maintaining current speed. What's the security consideration?"* → This is about balancing **Confidentiality** vs. **Availability**
- **Trick**: Real-world security always involves trade-offs; the "right" answer depends on context

---

## Common Mistakes

### Mistake 1: Confusing Confidentiality with Access Control
**Wrong**: "If we have strong access controls, we have confidentiality"
**Right**: Access controls are *one tool* for achieving confidentiality, but confidentiality also requires encryption, proper data classification, and user training
**Impact on Exam**: You might select "access control" when the question is really asking about preventing disclosure during transmission—the answer should be [[Encryption]]

### Mistake 2: Thinking Integrity Means "Data is Accurate"
**Wrong**: "Integrity means the financial records are correct and up-to-date"
**Right**: Integrity specifically means the data hasn't been *tampered with or modified*—it says nothing about whether the data is correct or relevant
**Impact on Exam**: A question about corrupted or altered data always points to integrity, not accuracy or quality

### Mistake 3: Assuming CIA Triad Covers Everything
**Wrong**: Using CIA Triad to analyze a [[Non-Repudiation]] question
**Right**: [[Non-Repudiation]] is a separate security principle (proving someone definitely did something); the triad covers confidentiality, integrity, and availability only
**Impact on Exam**: Watch for questions about "proving who sent a message"—that's non-repudiation, not part of CIA

### Mistake 4: Forgetting That All Three Matter
**Wrong**: Prioritizing only confidentiality because data protection is mentioned
**Right**: Most real scenarios require balancing all three
**Impact on Exam**: Questions often describe situations where you must identify *which principle is most at risk* given the specific threat

---

## Related Topics
- [[Non-Repudiation]] (fourth principle, sometimes called "AAA")
- [[Encryption]] (primary confidentiality tool)
- [[Access Controls]] (supporting confidentiality)
- [[Hashing]] (integrity verification)
- [[Digital Signatures]] (both integrity and non-repudiation)
- [[Disaster Recovery]] (availability protection)
- [[Defense in Depth]] (layering CIA controls)
- [[Risk Management]] (prioritizing CIA controls)
- [[Threat Modeling]] (identifying CIA risks)

---

*Source: CompTIA Security+ SY0-701 Exam Objectives | [[Security+]]*