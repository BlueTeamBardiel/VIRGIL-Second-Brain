---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 41
source: rewritten
---

# Zero-Day Attacks
**A freshly discovered security flaw that attackers exploit before defenders even know it exists.**

---

## Overview

Every piece of software running on modern systems—from your operating system to your email client—contains hidden flaws waiting to be discovered. The critical difference between a safe vulnerability and a catastrophic one comes down to *timing*: who finds it first, and what they do with that knowledge? For A+, understanding zero-day attacks matters because they represent the most dangerous class of [[Vulnerability|vulnerabilities]] that no patch can immediately stop, and you need to recognize them as distinct threats from standard exploits.

---

## Key Concepts

### Zero-Day Vulnerability

**Analogy**: Imagine a bank with a secret back door that only the architect knows about. Security researchers spend years searching for it to tell the bank. But what if a criminal finds it first and robs the bank before anyone can seal it? By the time the bank learns about the door, thousands of dollars are already gone—that's a zero-day.

**Definition**: A [[Vulnerability|vulnerability]] in software or hardware that has been discovered but for which no [[Patch|patch]] or fix is publicly available. The term "zero-day" refers to the fact that developers have *zero days* to respond before active exploitation begins.

**Key Distinction**: Unlike known vulnerabilities tracked in [[CVE|CVE databases]], zero-days remain invisible to vendors until attackers use them or security researchers responsibly disclose them.

---

### The Zero-Day Timeline

| Phase | Who Knows | Status | Risk Level |
|-------|-----------|--------|-----------|
| **Day 0** | Attacker only | Vulnerability discovered secretly | 🔴 Critical |
| **Active Exploitation** | Attacker + some targets | Attacks underway, no patch exists | 🔴 Critical |
| **Disclosure** | Public + Vendor | Vulnerability revealed | 🟠 High |
| **Patch Release** | Everyone | Fix is available | 🟡 Medium |
| **Patch Deployment** | Organizations | Most systems protected | 🟢 Low |

---

### CVE (Common Vulnerabilities and Exposures)

**Analogy**: Think of CVE as a shared library catalog for security flaws. Instead of each town keeping their own secret list of book problems, they all contribute to one master list so everyone can learn and protect themselves.

**Definition**: A standardized database (accessible at [[https://www.cve.org|cve.org]]) that tracks all publicly known [[Vulnerability|vulnerabilities]] and [[Exposure|exposures]]. Each vulnerability receives a unique identifier (e.g., CVE-2024-12345) for tracking and reference.

**For Zero-Days**: Zero-day vulnerabilities are *not* in the CVE database until after disclosure. This is what makes them dangerous—no one can look them up to understand the threat.

---

### Attack Vector vs. Exploit

| Term | Definition | Example |
|------|-----------|---------|
| **[[Vulnerability\|Vulnerability]]** | The flaw itself | Unvalidated user input in code |
| **[[Attack Vector\|Attack Vector]]** | The method to reach the vulnerability | Sending a specially crafted email |
| **[[Exploit\|Exploit]]** | The weaponized code that triggers the vulnerability | Malicious attachment that crashes the system |
| **[[Zero-Day Attack\|Zero-Day Attack]]** | When an exploit targets an unknown vulnerability | All three combined with no patch available |

---

### Responsible Disclosure vs. Wild Exploitation

**Responsible Path** (Security Researchers):
1. Discover vulnerability
2. Contact vendor privately
3. Vendor develops patch
4. Coordinated public release

**Malicious Path** (Attackers):
1. Discover vulnerability
2. Keep it secret
3. Create exploit
4. Deploy against targets *before* anyone knows

---

## Exam Tips

### Question Type 1: Vulnerability Identification
- *"A newly discovered flaw in Windows 11 is being exploited in the wild. No patch has been released yet. What is this called?"* → **Zero-day vulnerability**
- **Trick**: Don't confuse this with an *unpatched* vulnerability. An unpatched vulnerability has a known patch available—the admin just hasn't installed it yet. A zero-day has NO patch anywhere.

### Question Type 2: CVE vs. Zero-Day
- *"Which of the following can be found in the CVE database?"* → Known vulnerabilities (NOT zero-days)
- **Trick**: The exam loves mixing these up. Remember: **CVE = Public Knowledge. Zero-Day = Secret**.

### Question Type 3: Timeline Understanding
- *"When is a zero-day most dangerous?"* → **During active exploitation, before patch availability**
- **Trick**: Zero-days are dangerous because of the *time gap*. Once a patch drops, it's no longer a zero-day—it becomes a race to patch.

---

## Common Mistakes

### Mistake 1: "All Unpatched Vulnerabilities Are Zero-Days"
**Wrong**: If my Windows system is two months behind on updates, I have zero-day vulnerabilities.

**Right**: You have *known but unpatched* vulnerabilities. Zero-day specifically means the vulnerability itself is unknown to the vendor or public. A patch exists somewhere—you just haven't applied it.

**Impact on Exam**: You'll likely see a scenario asking you to classify a vulnerability. If a patch exists anywhere (even if you haven't installed it), it's NOT a zero-day.

---

### Mistake 2: "CVE Database Tracks All Threats"
**Wrong**: I can find all current attacks by checking the CVE database.

**Right**: CVE only tracks publicly disclosed vulnerabilities. Active zero-days won't appear there until after someone reports them.

**Impact on Exam**: Questions may ask what you can *use* to find information about threats. CVE is great for known issues, but useless for zero-days. You need [[Threat Intelligence|threat intelligence]] feeds for that.

---

### Mistake 3: "Attackers Always Announce Their Discoveries"
**Wrong**: Once someone finds a vulnerability, they tell everyone or sell it publicly.

**Right**: Attackers profit by keeping vulnerabilities secret. They exploit silently for as long as possible before vulnerability goes public.

**Impact on Exam**: This shapes the entire premise of zero-day danger. The attacker's competitive advantage *is* the secrecy. Recognize questions that hinge on "how long can attackers abuse this?"

---

### Mistake 4: "Patches Fix Zero-Days Instantly"
**Wrong**: Once a patch drops, the zero-day threat disappears.

**Right**: The patch is available, but organizations need time to test and deploy. During this window (sometimes weeks), it's still actively exploited against unpatched systems.

**Impact on Exam**: Look for questions asking about the "most dangerous period." Answer: **Between patch release and widespread deployment**.

---

## Related Topics

- [[Vulnerability|Vulnerability]]
- [[Patch Management|Patch Management]]
- [[CVE|CVE Database]]
- [[Exploit|Exploit]]
- [[Attack Vector|Attack Vector]]
- [[Threat Intelligence|Threat Intelligence]]
- [[Incident Response|Incident Response]]
- [[Responsible Disclosure|Responsible Disclosure]]
- [[Malware|Malware]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*