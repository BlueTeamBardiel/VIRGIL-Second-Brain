---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 083
source: rewritten
---

# Threat Intelligence
**Strategic knowledge about adversaries, their methods, and attack patterns that informs defensive decision-making.**

---

## Overview
[[Threat Intelligence]] is the collection, analysis, and application of information about current and emerging threats targeting your organization. For Security+ professionals, understanding how to gather, interpret, and act on threat data is essential—it transforms raw security observations into actionable insights that drive tool selection, training priorities, and defensive strategies across the entire enterprise.

---

## Key Concepts

### Threat Intelligence
**Analogy**: Think of threat intelligence like a hospital epidemiologist studying disease patterns—they don't just identify that a patient is sick, they research which viruses are circulating, how they spread, and who's most vulnerable. This shapes treatment decisions organization-wide.
**Definition**: Processed information about [[threat actors]], their [[tactics and techniques]], capabilities, and intentions that organizations use to make informed security decisions.
- Informs [[risk assessment]] and [[vulnerability management]]
- Drives procurement of [[security tools]] and controls
- Shapes [[security awareness training]] priorities
- Supports [[incident response]] and [[threat hunting]]

---

### Open Source Intelligence (OSINT)
**Analogy**: OSINT is like detective work using only publicly available clues—newspaper articles, public records, social media posts—that anyone can access if they know where to look.
**Definition**: [[Threat Intelligence]] gathered from publicly available sources that requires no special access or classified networks.

| Source Type | Examples | Use Case |
|---|---|---|
| **Discussion Forums** | Hacker forums, threat actor communities, dark web boards | Understanding attack planning and tool development |
| **Social Media** | Twitter, LinkedIn, Reddit posts by researchers | Real-time threat notifications and emerging vulnerabilities |
| **Government Resources** | CISA advisories, NSA publications, FBI threat reports | Official vulnerability data and APT attribution |
| **Academic Research** | Security conference papers, whitepapers, university studies | Deep technical analysis of attack methods |

---

### Threat Actors
**Analogy**: Threat actors are like different criminal profiles—a bank robber operates differently than a pickpocket. Understanding their motivation and methods tells you where to focus your defenses.
**Definition**: Individuals, groups, or nation-states conducting malicious cyber activities with varying motivations, resources, and targeting patterns.
- [[Cybercriminals]] (financial motivation)
- [[Nation-state APTs]] (geopolitical objectives)
- [[Hacktivists]] (ideological goals)
- [[Insiders]] (personal grievance or financial gain)

---

### Intelligence Sharing and Application
**Analogy**: Like a neighborhood watch program sharing crime patterns, threat intelligence across departments ensures everyone makes better security decisions.
**Definition**: Distribution of threat findings to relevant stakeholders who can take action.

**Who Uses Threat Intelligence:**
- [[Security Operations Center (SOC)]] teams → Detection tuning and incident response
- [[Risk Management]] professionals → Prioritizing vulnerabilities for remediation
- Executive leadership → Budget justification for security investments
- [[Security awareness]] trainers → Customizing content around active threats
- Procurement teams → Specifying required tool capabilities

---

## Exam Tips

### Question Type 1: Intelligence Sources
- *"Which of the following is an example of OSINT?"* → Any publicly available source (forums, social media, government advisories, published CVEs)
- **Trick**: Don't confuse OSINT with paid threat feeds or [[classified intelligence]]—OSINT is free and public

### Question Type 2: Threat Actor Attribution
- *"A security team discovers an attack using a specific malware variant. Which resource would best help identify the likely threat actor?"* → Threat intelligence reports analyzing [[tactics, techniques, and procedures (TTPs)]] and malware signatures
- **Trick**: Attribution requires correlation of multiple data points—single tools rarely provide complete answers

### Question Type 3: Intelligence Application
- *"After gathering threat intelligence about a new vulnerability, which team should implement mitigations first?"* → [[Patch management]] or [[vulnerability management]] teams (depends on context whether it's confirmed active exploitation)
- **Trick**: Intelligence without action is worthless—the exam expects you to link findings to specific defensive responses

---

## Common Mistakes

### Mistake 1: Confusing Intelligence with Raw Data
**Wrong**: "We collected 500 alerts from our firewall, so we have threat intelligence."
**Right**: Threat intelligence is *analyzed and contextualized* information about adversaries and threats, not just log files or alerts.
**Impact on Exam**: Security+ questions require you to understand that intelligence involves interpretation and application—collection alone doesn't count.

### Mistake 2: Assuming All OSINT Requires Hacking
**Wrong**: "We need to access the dark web illegally to get real threat intelligence."
**Right**: OSINT includes government advisories, public forums, academic papers, and legitimate news sources—no illegal access required for most valuable intelligence.
**Impact on Exam**: Questions about intelligence gathering often test whether you understand legal vs. illegal collection; OSINT is lawful.

### Mistake 3: Treating Threat Intelligence as Static
**Wrong**: "We read one report about APT29 last year, so we understand that threat actor."
**Right**: Threat actor tactics, tools, and targets evolve constantly; intelligence requires continuous monitoring and updating.
**Impact on Exam**: Security+ emphasizes [[continuous monitoring]] and staying current—intelligence gathering isn't a one-time event.

### Mistake 4: Isolating Intelligence to the Security Team
**Wrong**: "Only the SOC cares about threat intelligence."
**Right**: Effective organizations share relevant intelligence with procurement (for tool selection), HR (for insider threat awareness), and leadership (for risk decisions).
**Impact on Exam**: Questions often test organizational impact—expect questions about who else uses threat intelligence beyond security operations.

---

## Related Topics
- [[Threat Hunting]]
- [[Indicators of Compromise (IoCs)]]
- [[Tactics, Techniques, and Procedures (TTPs)]]
- [[MITRE ATT&CK Framework]]
- [[Incident Response]]
- [[Risk Assessment]]
- [[Vulnerability Management]]
- [[Security Awareness Training]]
- [[CISA]] (Cybersecurity and Infrastructure Security Agency)
- [[Cyber Kill Chain]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*