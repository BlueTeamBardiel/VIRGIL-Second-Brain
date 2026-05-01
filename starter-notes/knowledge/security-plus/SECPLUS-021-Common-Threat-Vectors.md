---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 021
source: rewritten
---

# Common Threat Vectors
**Understanding the pathways attackers use to breach your defenses.**

---

## Overview
A [[threat vector]] represents the specific pathway or channel through which an attacker gains unauthorized access to systems and networks. Security professionals must understand these entry points because adversaries continuously identify, exploit, and create new vectors to compromise infrastructure. For the Security+ exam, recognizing common threat vectors is essential because you'll need to recommend appropriate controls and mitigation strategies.

---

## Key Concepts

### Threat Vector / Attack Vector
**Analogy**: Think of a threat vector like a delivery route for pizza—an attacker chooses a specific road to reach your house, and your job is to block all the common routes and watch for new ones.

**Definition**: A [[threat vector]] (also called an [[attack vector]]) is the specific method, technique, or pathway that an attacker leverages to compromise a target system and gain unauthorized access.

**Related Terms**: [[Attack surface]], [[vulnerability]], [[exploit]]

---

### Messaging-Based Threat Vectors

#### Email Attacks
**Analogy**: Email is like your front door—it's designed to let legitimate mail in, but an attacker can hide malicious packages inside normal-looking envelopes.

**Definition**: [[Email]] remains one of the most prevalent threat vectors because nearly everyone relies on it for communication. Attackers embed [[malicious links]], [[phishing]] pages, or [[malware]]-laden attachments within seemingly legitimate messages.

**Common Attack Methods**:
- [[Phishing]] - Deceptive emails impersonating trusted entities
- [[Spear phishing]] - Targeted emails using personal information
- [[Malware distribution]] - Infected attachments or drive-by downloads
- [[Credential harvesting]] - Fake login pages in email bodies

---

#### SMS/Text Message Attacks
**Analogy**: Text messages feel more personal and immediate than email, making them like a whispered recommendation from someone you trust—which is why attackers exploit this familiarity.

**Definition**: [[SMS]] (Short Message Service) attacks, sometimes called [[smishing]], use text messages to trick users into clicking malicious links or revealing sensitive information. Mobile users often trust text messages more than emails, making this vector highly effective.

---

#### Instant Messaging and Direct Messages
**Analogy**: Direct messaging feels like a private conversation with a friend, so attackers impersonate someone you know or trust to lower your defenses.

**Definition**: [[Instant messaging]] platforms and [[direct message]] systems enable real-time, seemingly personal communication. Attackers exploit this intimacy by impersonating colleagues, friends, or service providers to distribute malicious content or conduct [[social engineering]] attacks.

---

## Comparison Table: Messaging Threat Vectors

| Vector | Reach | Trust Level | Immediacy | Typical Payload |
|--------|-------|-------------|-----------|-----------------|
| [[Email]] | Mass/Targeted | Medium | Delayed | Attachments, links, phishing pages |
| [[SMS]] | Mass/Targeted | High | Immediate | Shortened URLs, credential requests |
| [[Instant Messaging]] | Targeted | High | Real-time | Social engineering, malware links |

---

## Exam Tips

### Question Type 1: Identifying Threat Vectors
- *"A user receives a text message claiming to be from their bank asking them to verify account details. What threat vector is being used?"* → [[SMS]]-based attack / [[Smishing]]
- **Trick**: Don't assume the vector is just "text message"—identify it as [[smishing]], which is the SMS equivalent of [[phishing]].

### Question Type 2: Comparative Scenarios
- *"Which messaging platform allows attackers to establish direct, real-time social engineering conversations?"* → [[Instant messaging]] / [[Direct messages]]
- **Trick**: Remember that [[email]] is asynchronous, while instant messaging enables synchronous manipulation.

### Question Type 3: Mitigation Strategy Questions
- *"How should an organization reduce risk from email-based threat vectors?"* → Implement [[email filtering]], [[threat detection]], [[user training]], and [[MFA|multi-factor authentication]]
- **Trick**: Simply blocking email isn't realistic—focus on layered controls and awareness.

---

## Common Mistakes

### Mistake 1: Conflating Threat Vector with Malware Type
**Wrong**: "The threat vector is ransomware."
**Right**: "Ransomware is the [[payload]]; the threat vector is [[email]] (or [[USB]], [[RDP]], etc.)."
**Impact on Exam**: You'll be asked to distinguish *how* something arrives from *what* it is. A vector is always the delivery method.

### Mistake 2: Underestimating SMS Attacks
**Wrong**: "SMS is secure because it's built into phones—it can't be a major threat vector."
**Right**: [[SMS]] is actually a high-trust channel, making it an excellent vector for [[phishing]], [[credential harvesting]], and [[social engineering]].
**Impact on Exam**: Don't assume older/simpler technologies are less dangerous. Attackers target trust, not complexity.

### Mistake 3: Treating All Messaging Threats Identically
**Wrong**: "[[Email]] and [[SMS]] are both messaging, so they require the same defenses."
**Right**: [[Email]] allows complex attachments and can be filtered; [[SMS]] is shorter and harder to filter. [[Instant messaging]] is real-time and personal. Each requires tailored controls.
**Impact on Exam**: Exam questions test whether you understand *why* controls work for specific vectors.

### Mistake 4: Ignoring Unknown/Zero-Day Vectors
**Wrong**: "As long as I defend against known threat vectors, I'm secure."
**Right**: Attackers are continuously discovering and creating new vectors. Your job is to assume [[unknown threat vectors]] exist and design [[defense in depth]] strategies.
**Impact on Exam**: Security+ emphasizes proactive thinking—expect questions about addressing *emerging* threats, not just known ones.

---

## Defense Strategy Framework

| Threat Vector | Primary Control | Secondary Control | Tertiary Control |
|---------------|-----------------|-------------------|------------------|
| [[Email]] | [[Email filtering]] / [[Gateway security]] | [[User awareness training]] | [[MFA]], [[endpoint detection]] |
| [[SMS]] | [[Device-level filtering]] | [[User education]] | [[MFA]] alternatives to SMS |
| [[Instant Messaging]] | [[Access controls]], [[DLP]] | [[User training]] | [[Activity monitoring]] |

---

## Related Topics
- [[Attack surface]]
- [[Phishing attacks]]
- [[Social engineering]]
- [[Malware distribution]]
- [[Defense in depth]]
- [[User awareness training]]
- [[Email security]]
- [[Endpoint protection]]
- [[Multi-factor authentication]]
- [[Zero-day vulnerabilities]]

---

*Source: CompTIA Security+ SY0-701 | Rewritten Study Material | [[Security+]]*