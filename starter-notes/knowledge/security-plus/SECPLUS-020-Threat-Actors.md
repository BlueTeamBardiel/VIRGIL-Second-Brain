---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 020
source: rewritten
---

# Threat Actors
**Understanding who attacks your systems and why they're doing it matters more than you think.**

---

## Overview
A [[threat actor]] is any individual, group, or organization that deliberately initiates harmful actions targeting the [[security]] of systems, networks, or data belonging to others. For Security+ purposes, identifying threat actors helps you understand attack motivations, predict attack patterns, and design appropriate defensive responses. The key insight: different threat actors have different goals, resources, and capabilities—and your defense strategy must adapt accordingly.

---

## Key Concepts

### Threat Actor Definition
**Analogy**: Think of a threat actor like different types of criminals—a shoplifter has different motivations, resources, and methods than a organized crime ring planning a bank heist. Both are criminals, but their scale and sophistication differ dramatically.

**Definition**: A [[threat actor]] is an entity (person, group, or nation-state) capable of executing malicious actions that compromise [[confidentiality]], [[integrity]], or [[availability]] of information systems.

---

### Threat Actor Locations

**Analogy**: Imagine security at a concert—threats can come from ticket holders already inside (internal) or from crowds outside trying to sneak in (external).

**Definition**: [[Threat actor]] origin determines attack surface:

| Location | Characteristics | Example Attack |
|----------|-----------------|-----------------|
| **Internal** ([[Insider Threat]]) | Already has system access; knowledge of network topology | Employee stealing customer data |
| **External** | Must gain initial access; relies on public information | Phishing campaign targeting organization |

---

### Resource Availability

**Analogy**: A street mugger operates very differently than a drug cartel with millions in funding—budget determines sophistication and scale of operations.

**Definition**: The [[funding]] and [[resources]] available to a threat actor directly correlates with attack complexity and persistence.

| Resource Level | Capabilities | Examples |
|---|---|---|
| **Low Resources** | Basic tools, limited persistence, script-based attacks | Script kiddies, opportunistic attackers |
| **Moderate Resources** | Custom tooling, sustained campaigns, organized structure | Cybercriminal groups, hacktivists |
| **High Resources** | Advanced persistent threat (APT) infrastructure, zero-day exploits, nation-state backing | [[Nation-State Actors]], major [[APT]] groups |

---

### Threat Actor Sophistication

**Analogy**: Imagine the difference between someone randomly trying keys on a lock versus a professional locksmith with specialized equipment versus a master craftsman who designs better locks—each operates at a completely different level.

**Definition**: [[Sophistication]] measures an attacker's technical skill, tool development capability, and understanding of security concepts:

| Sophistication Level | Characteristics |
|---|---|
| **Unsophisticated** | Uses public exploits blindly; doesn't understand code; relies entirely on existing tools |
| **Intermediate** | Understands basic networking/systems; can modify existing tools; may develop custom scripts |
| **Highly Sophisticated** | Creates novel exploits; develops custom malware; understands defensive systems deeply; maintains operational security |

---

## Exam Tips

### Question Type 1: Identifying Threat Actor Characteristics
- *"A threat actor with significant funding, custom-built malware, and ability to maintain access for months most likely represents which category?"* → [[Nation-State Actor]] or well-funded [[APT]] group
- **Trick**: Don't assume all well-funded actors are nations—wealthy criminal organizations also have substantial resources and sophistication.

### Question Type 2: Location-Based Threats
- *"An employee installing unauthorized software on their workstation to steal intellectual property best represents which threat vector?"* → [[Insider Threat]] (internal location)
- **Trick**: Internal threats often get underestimated on exams—candidates focus too heavily on external attacks.

### Question Type 3: Resource Assessment
- *"A attacker using publicly available exploit code with no modifications most likely has which resource profile?"* → Low resources, unsophisticated
- **Trick**: Limited resources doesn't mean "not dangerous"—opportunistic attackers cause significant damage through volume.

---

## Common Mistakes

### Mistake 1: Assuming All Threats Come from Outside
**Wrong**: "We only need to worry about external attackers; our employees are trusted."
**Right**: [[Insider Threat|Internal threats]] represent significant risk from employees, contractors, and third-party vendors with legitimate access.
**Impact on Exam**: You'll see scenario questions testing whether you recognize insider threats. Missing this loses points on [[threat assessment]] questions.

### Mistake 2: Confusing Resources with Sophistication
**Wrong**: "A well-funded threat actor always uses advanced exploits."
**Right**: A well-funded actor *can* use advanced exploits, but may choose not to if simpler methods work. Conversely, a sophisticated attacker might have limited funding.
**Impact on Exam**: Questions often present scenarios where funding and sophistication don't match expectations—this tests real-world understanding.

### Mistake 3: Overlooking Motivation in Threat Analysis
**Wrong**: Treating all attackers the same way defensively.
**Right**: Understanding [[motivation]] (profit, espionage, hacktivism, disruption) helps predict attack methods and persistence levels.
**Impact on Exam**: Context-dependent questions require you to infer threat actor type from motivational clues in the scenario.

### Mistake 4: Forgetting That "Threat Actor" Includes Non-Malicious Actors
**Wrong**: Assuming all threat actors have intentionally malicious goals.
**Right**: [[Threat Actor|Threat actors]] can include negligent employees, script kiddies testing systems without permission, or competitors gathering intelligence—not always criminal intent.
**Impact on Exam**: Scenario-based questions may describe threats that don't fit "criminal" stereotypes; you must classify based on impact, not intent.

---

## Related Topics
- [[Insider Threat]]
- [[Nation-State Actors]]
- [[APT (Advanced Persistent Threat)]]
- [[Motivation and Intent]]
- [[Threat Intelligence]]
- [[Attack Surface]]
- [[Risk Assessment]]
- [[Threat Modeling]]

---

*Source: CompTIA Security+ SY0-701 | [[Security+]]*