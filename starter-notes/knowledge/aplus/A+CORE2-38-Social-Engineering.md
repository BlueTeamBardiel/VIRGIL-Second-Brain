---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 38
source: rewritten
---

# Social Engineering
**Human manipulation tactics designed to trick people into bypassing security controls and revealing confidential information.**

---

## Overview

Social engineering represents one of the most persistent threats in IT security because it exploits human psychology rather than software vulnerabilities. For the A+ exam, you need to recognize that attackers use psychological manipulation—often combined with technical tactics—to compromise organizational security. Understanding these attack vectors is critical because no firewall can stop someone who willingly gives away their password.

---

## Key Concepts

### Pretexting

**Analogy**: Imagine a con artist calling a restaurant pretending to be a health inspector to gain access to restricted areas. They're fabricating an entire false scenario to seem legitimate.

**Definition**: Creating a fabricated scenario or false identity to manipulate someone into divulging sensitive information or granting unauthorized access.

| Element | Purpose |
|---------|---------|
| False Identity | Establish credibility |
| Manufactured Urgency | Bypass critical thinking |
| Authority Appeal | Reduce resistance |

---

### Phishing

**Analogy**: Think of phishing like a fisherman casting bait into water—they're throwing out seemingly legitimate-looking messages hoping someone will "bite" and click a malicious link.

**Definition**: Mass-distributed fraudulent communications (typically email) designed to trick recipients into visiting fake websites, downloading [[malware]], or surrendering credentials.

**Related Tactics**:
- [[Spear Phishing]]: Targeted attacks against specific individuals using personal information
- [[Whaling]]: High-level phishing targeting executives and decision-makers
- [[Smishing]]: Phishing conducted via SMS text messages
- [[Vishing]]: Voice-based phishing using phone calls

---

### Tailgating (Piggybacking)

**Analogy**: Following someone through a secured door without using your own access card—you're using their legitimate entry as cover for unauthorized access.

**Definition**: Gaining physical access to restricted areas by following an authorized person through secure entry points without using proper credentials yourself.

---

### Baiting

**Analogy**: A fisherman leaves bait unattended on a dock knowing someone will take it. Attackers leave infected USB drives or devices in parking lots hoping curiosity drives someone to plug them in.

**Definition**: Leaving attractive but malicious items (infected USB drives, external hard drives, or downloads) in public places, counting on human curiosity to execute the attack.

---

### Impersonation & Authority Abuse

**Analogy**: A scammer wearing a fake security uniform convincing someone they need to "verify" their access credentials. The uniform creates false authority.

**Definition**: Pretending to be someone with legitimate authority (IT support, management, law enforcement) to pressure victims into compliance without proper verification.

---

### Manipulation Through Current Events

**Analogy**: A con artist reads the local news, then calls someone claiming to help with the disaster they just heard about—using real events to seem credible.

**Definition**: Weaponizing recent news, company announcements, or tragic events (deaths, disasters, scandals) in social engineering attacks to bypass normal skepticism.

| Attack Trigger | Example |
|---|---|
| Death notification | Fake sympathy email with malicious link |
| Natural disaster | "HR needs updated banking for relief fund" |
| Company merger | Impersonating new leadership requesting access |
| Security breach (real) | Fake password reset email during actual incident |

---

### Quid Pro Quo

**Analogy**: Someone offering to fix your car in exchange for use of your garage key—they're exchanging something valuable for access you'd normally protect.

**Definition**: Offering something desirable (prize, assistance, discount) in exchange for information or access that the victim normally wouldn't grant.

---

## Exam Tips

### Question Type 1: Attack Identification
- *"An employee receives an email claiming their bank account was compromised and asks them to click a link to 'verify their identity.' What type of attack is this?"* → **Phishing** (possibly [[spear phishing]] if targeted)
- **Trick**: Don't confuse phishing with [[spam]] — phishing always involves social engineering intent, spam is bulk unwanted mail

### Question Type 2: Prevention Strategy
- *"Which is the BEST defense against social engineering attacks?"* → **User awareness training and verification procedures** (not just technical controls)
- **Trick**: A+ tests whether you understand that technology alone won't stop social engineering—humans are the security layer

### Question Type 3: Real-World Scenario
- *"A caller claiming to be from IT support asks an employee for their password to 'update the system.' What should the employee do?"* → **Hang up and call IT directly using a known, trusted number**
- **Trick**: The question tests judgment, not just knowledge—right answer involves verification, not compliance

### Question Type 4: Attack Combination
- *"An attacker sends a targeted email impersonating HR about a bonus with a link to a fake portal. This combines which two attack types?"* → **Phishing + Impersonation** (or **Spear Phishing** as the broader category)
- **Trick**: Real attacks often blend multiple tactics; A+ expects you to identify the components

---

## Common Mistakes

### Mistake 1: Confusing Phishing with Malware
**Wrong**: "Phishing is a type of malware that automatically infects your computer."
**Right**: Phishing is a **social engineering tactic** that tricks users into performing actions; the malware comes second (if at all) as a delivery mechanism.
**Impact on Exam**: You might choose wrong answers about phishing "spreading" or "replicating"—phishing requires user action to succeed.

---

### Mistake 2: Thinking Technology Solves Social Engineering
**Wrong**: "We installed an email filter, so we're protected from social engineering."
**Right**: Email filters catch *some* phishing, but social engineering succeeds through **human psychology**—no filter stops a determined attacker who can manipulate people directly.
**Impact on Exam**: A+ questions test whether you understand that user training is equally or more important than technical controls.

---

### Mistake 3: Assuming Social Engineering Always Involves Malware
**Wrong**: "If there's no virus or malicious code, it wasn't social engineering."
**Right**: Social engineering often achieves its goal (credential theft, data access) **without any malware**—it's purely psychological manipulation.
**Impact on Exam**: A scenario where someone tricks an employee into resetting a password is pure social engineering, no malware involved.

---

### Mistake 4: Overlooking the "Human" Element in BYOD & Remote Work
**Wrong**: "Social engineering is an office-only problem since everyone's remote now."
**Right**: Remote and BYOD environments **increase** social engineering risk—no security desk to verify visitors, easier to impersonate authority, harder to spot pretexting.
**Impact on Exam**: Modern A+ questions emphasize that distributed workforces need stronger social engineering defenses, not weaker ones.

---

### Mistake 5: Thinking One Training Session Prevents All Attacks
**Wrong**: "We did security training once a year, so employees know to avoid phishing."
**Right**: Social engineering tactics **constantly evolve**; effective defense requires **ongoing, regular awareness training** with realistic simulations.
**Impact on Exam**: A+ may ask what's missing from a company's defense strategy—the answer is often "continuous training" rather than "install software X."

---

## Defense Strategies

### Technical Controls
- [[Email filtering]] and [[spam detection]]
- [[Multi-factor authentication]] (defeats credential harvesting)
- [[Endpoint protection]] against malware payloads
- [[URL filtering]] to block suspicious domains

### Human Controls (Primary Defense)
- Regular security awareness training
- Simulated phishing exercises to test employee response
- Clear incident reporting procedures
- Verification protocols for all access requests

---

## Related Topics
- [[Phishing]]
- [[Spear Phishing]]
- [[Malware]] (often delivered via social engineering)
- [[Authentication]] and [[Password Security]]
- [[Email Security]]
- [[Physical Security]] (tailgating prevention)
- [[Incident Response]] (handling successful social engineering)
- [[User Training and Awareness]]

---

*Source: CompTIA A+ Core 2 (220-1202) — Security and Troubleshooting | [[A+]]*