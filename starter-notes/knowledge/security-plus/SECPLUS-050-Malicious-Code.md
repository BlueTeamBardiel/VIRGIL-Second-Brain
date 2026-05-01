---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 050
source: rewritten
---

# Malicious Code
**Weaponized software and scripts designed to circumvent security controls and establish unauthorized system access.**

---

## Overview
Throughout your information security career, you'll encounter attackers employing multiple attack vectors to breach systems. While some adversaries exploit human psychology through [[social engineering]] or leverage careless administrative practices like unchanged [[default credentials]] and [[misconfigurations]], others deploy purpose-built malicious code to achieve their objectives. Understanding how malicious code operates—rather than relying on people to simply "not fall for tricks"—is essential for the Security+ exam because it represents the technical sophistication layer of attack methodology.

---

## Key Concepts

### Malicious Code (General Category)
**Analogy**: Think of malicious code like a lockpick—while some attackers simply try doors left unlocked (default passwords), others craft specialized tools to bypass the lock itself (exploit vulnerable code).

**Definition**: Any software, script, executable, or programmatic instruction deliberately engineered to compromise system confidentiality, integrity, or availability without authorization.

**Related contexts**:
- Contrasts with [[social engineering]] (manipulation-based) and [[misconfiguration]] exploits (human error-based)
- Requires technical sophistication from attacker
- Often delivered through [[vectors of attack]]

### Delivery Mechanisms
**Analogy**: Malicious code is like contraband; it can arrive in a suitcase, hidden in a letter, or smuggled through a cargo container—same harmful contents, different packaging methods.

**Definition**: The various formats through which malicious code reaches a target system.

| Delivery Method | Characteristics | Example |
|---|---|---|
| **Executable Files** | Standalone binary programs | .exe, .com, .bin files |
| **Scripts** | Interpreted code running on target | PowerShell, VBScript, JavaScript |
| **Macro Viruses** | Code embedded in documents | Word/Excel macro payloads |
| **Trojan Horses** | Legitimate-appearing software hiding malicious intent | Fake utility programs |

### Malicious Code Types
**Analogy**: Just as a master chef uses different kitchen tools for different tasks, attackers deploy specialized malicious code variants for different objectives.

**Definition**: Categorized classifications of malicious software based on propagation method and behavioral characteristics.

**Key distinctions**:
- [[Virus]]: requires host file to propagate
- [[Worm]]: self-replicating network propagation
- [[Trojan]]: deception-based delivery
- [[Rootkit]]: privilege escalation focus
- [[Ransomware]]: extortion methodology
- [[Spyware]]: surveillance and data exfiltration
- [[Adware]]: advertising injection

---

## Exam Tips

### Question Type 1: Identification by Delivery Mechanism
- *"A user receives an Excel spreadsheet from a trusted vendor. When opened, malicious code executes automatically. What is the most likely attack vector?"* → [[Macro virus]]
- **Trick**: Don't confuse "malicious code" as the TYPE of threat—it's the category. The specific type (virus, worm, Trojan) determines the mechanism.

### Question Type 2: Defense Implications
- *"Your organization needs to defend against multiple forms of malicious code simultaneously. Which single control provides the broadest protection?"* → [[antivirus software]], [[endpoint detection and response (EDR)]], or [[application whitelisting]]
- **Trick**: No single control blocks everything—layered defense is required.

### Question Type 3: Contrast with Non-Code Attacks
- *"An attacker gains network access by convincing an admin to share credentials. Is this a malicious code attack?"* → No, this is [[social engineering]].
- **Trick**: Security+ tests your ability to distinguish between human-factor and technical-factor attacks.

---

## Common Mistakes

### Mistake 1: Conflating "Malicious Code" with Specific Malware Types
**Wrong**: "Malicious code is the same as a virus."
**Right**: Malicious code is the umbrella category; viruses, worms, and Trojans are specific types within that category.
**Impact on Exam**: You'll miss questions asking you to differentiate between propagation methods (self-replicating vs. file-dependent vs. deception-based).

### Mistake 2: Assuming Malicious Code Always Arrives as an Executable
**Wrong**: "Malicious code must be a .exe file."
**Right**: Malicious code can be packaged as macros, scripts, interpreted code, or embedded in documents.
**Impact on Exam**: You'll incorrectly answer questions about Office document attacks or PowerShell exploitation.

### Mistake 3: Overlooking the Contrast with Administrative Weaknesses
**Wrong**: "Default credentials and malicious code are the same attack category."
**Right**: Default credentials exploit human negligence; malicious code exploits technical vulnerabilities or social engineering delivery.
**Impact on Exam**: Questions specifically test whether you understand that malicious code represents a *different* sophistication level and defense requirement.

### Mistake 4: Ignoring Delivery Context
**Wrong**: "The malicious code is the only thing that matters."
**Right**: How the code is delivered (macro-enabled document, email attachment, USB drive, watering hole website) determines which defensive controls apply.
**Impact on Exam**: You'll miss questions about preventing specific delivery vectors (e.g., disabling macros, email filtering, application control).

---

## Related Topics
- [[Social Engineering]] — human-factor attack method (contrast)
- [[Misconfigurations]] — administrative oversight exploitation (contrast)
- [[Default Credentials]] — basic access exploitation (contrast)
- [[Antivirus Software]] — detection and removal control
- [[Endpoint Detection and Response (EDR)]] — advanced malicious code defense
- [[Application Whitelisting]] — execution control
- [[Sandboxing]] — isolated execution environment
- [[Vectors of Attack]] — delivery mechanisms for threats
- [[Defense in Depth]] — layered response to malicious code

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*