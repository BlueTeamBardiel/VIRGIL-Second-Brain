---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# IV. Threat Intelligence
**The art of turning raw threat data into actionable defense strategies.**

---

## Overview

Threat intelligence is basically intel briefings for your security team—real evidence about who's attacking, what tools they use, and how they operate. Security analysts need this because you can't defend against threats you don't understand. It transforms abstract risk into concrete defensive actions that prevent breaches, speed up incident response, and help you hunt threats proactively instead of waiting to be attacked.

---

## Key Concepts

### [[Threat Intelligence]] Fundamentals

**Analogy**: Think of threat intelligence like a detective's case file. A detective doesn't just know "someone committed a crime"—they know the suspect's identity, their methods, their patterns, what they target, and why. That's exactly what threat intelligence does for cybersecurity.

**Definition**: Evidence-based knowledge about adversaries, their motivations, technical capabilities, attack methods, and patterns that informs prevention, detection, response, and recovery strategies.

[[Threat Intelligence]] powers the entire security operation—it's not optional, it's foundational.

---

### [[Threat Intelligence]] Levels

**Analogy**: Intelligence exists at different altitudes. Pilots (executives) need weather patterns. Controllers (managers) need runway conditions. Ground crew (analysts) need exact wind speeds and precipitation data right now.

**Definition**: Intelligence is tiered by abstraction level and audience:

| Level | Audience | Detail | Use Case |
|-------|----------|--------|----------|
| **Strategic** | C-suite, risk officers | Industry trends, threat landscape, business impact | Annual risk planning |
| **Tactical** | Security analysts, defenders | Technical indicators, malware signatures, TTPs | Daily detection work |
| **Operational** | Incident responders, threat hunters | Attack sequences, delivery chains, remediation paths | Active incidents |

[[Strategic Intelligence]] sets the direction. [[Tactical Intelligence]] arms your defenses. [[Operational Intelligence]] wins the fight.

---

### Threat Data Sources

**Analogy**: You could learn about weather from a single station, but you'd miss the bigger picture. Meteorologists use satellites, ground stations, ships, and radar. Threat analysts need diverse sources too.

**Definition**: Raw threat data comes from multiple channels and varies in quality:

| Data Type | Example | Reliability |
|-----------|---------|-------------|
| **Indicators of Compromise** | IP addresses, file hashes, domains | Depends on source verification |
| **Behavioral Data** | Attack patterns, TTPs, malware analysis | Higher when corroborated |
| **Contextual Intelligence** | Threat actor profiles, motivations | Varies by source reputation |

Low-quality data wastes analyst time. High-quality data prevents breaches.

---

### [[Open Source Intelligence (OSINT)]]

**Analogy**: OSINT is like reading the news—anyone can do it, but not all newspapers are equally accurate. Some articles break stories first. Others sensationalize. You need to know which to trust.

**Definition**: Publicly available threat intelligence from non-classified sources that anyone can access:

**Common sources:**
- Government agencies ([[CISA]], US-CERT bulletins)
- [[CERT/CSIRT]] organizations
- Vendor security blogs and advisories
- Security research forums and communities
- Dark web and deep web reconnaissance
- Academic research and technical writeups

**The challenge**: OSINT is free and timely but noisy. Social media breaks stories fast but includes misinformation. You must validate relevance before acting.

---

### [[Proprietary/Closed Source Intelligence]]

**Analogy**: Like subscribing to premium news services—you pay for editorial control, accuracy vetting, and early access to information competitors don't have yet.

**Definition**: Threat intelligence created and restricted by vendors, governments, and private organizations. Higher fidelity but paid, less transparent, and sharing is contractually limited.

**Trade-offs:**
- Better accuracy (vendor investment in vetting)
- Earlier warning (exclusive research)
- Licensing restrictions (can't share freely)
- Cost (paid subscriptions)

---

### [[Threat Intelligence]] Sharing

**Analogy**: Imagine you found a burglar casing your neighborhood. If you tell your neighbors, they lock their doors early. If you don't, they all get robbed. Intelligence sharing is that warning system.

**Definition**: Coordinated dissemination of threat data across organizations and communities to accelerate detection, response, and prevention.

**Sharing accelerates:**
- Incident response timelines
- Vulnerability patch deployment
- Detection rule creation
- Risk prioritization

**Sharing communities:**
- [[ISACs]] (Information Sharing and Analysis Centers) — industry-specific groups
- [[TAXII]] networks for automated data exchange
- Regional threat intelligence groups

---

### Standards-Based Intelligence Sharing

**Analogy**: Imagine if every police department used different formats for crime reports. The FBI couldn't aggregate data. Standards fix that—everyone speaks the same language.

**Definition**: Structured formats and protocols that enable consistent, automated threat intelligence sharing:

| Standard | Purpose | Example |
|----------|---------|---------|
| **[[STIX]]** (Structured Threat Information eXpression) | Defines threat data schema | Malware objects, attack patterns, relationships |
| **[[TAXII]]** (Trusted Automated eXchange of Indicator Information) | Transport protocol over HTTPS | Pushing/pulling STIX data between servers |
| **[[OpenIOC]]** (Open Indicators of Compromise) | XML-based indicator format | Suspicious file hashes, registry keys |

Standards = automation. Automation = speed at scale.

---

### Assessing [[Threat Intelligence]] Quality

**Analogy**: Not all weather reports are equally useful. A forecast for another state doesn't help you. A 10-day forecast is less reliable than tomorrow's. You need *relevant, timely* data.

**Definition**: Evaluation criteria to determine if intelligence is worth acting on:

**Critical questions:**
- **Timely?** Is it current enough to matter?
- **Accurate?** Is it from a trusted source?
- **Relevant?** Does it apply to *my* environment, industry, software?
- **Corroborated?** Does multiple sources confirm it?
- **Applicable?** Does my infrastructure match the threat profile?

Intelligence that fails these checks wastes analyst cycles.

---

### [[Confidence Levels]] in Intelligence

**Analogy**: A witness saw a crime from far away (low confidence). Security cameras recorded it from multiple angles (high confidence). Intelligence confidence works the same way.

**Definition**: A numerical scale reflecting trustworthiness of a threat report, independent of its usefulness:

| Level | Range | Meaning |
|-------|-------|---------|
| **Confirmed** | 90–100 | Multiple independent sources verify |
| **Probable** | 70–89 | Majority of sources agree |
| **Possible** | 50–69 | Reasonable but not verified |
| **Doubtful** | 30–49 | Significant contradictions exist |
| **Improbable** | 2–29 | Unlikely but not impossible |
| **Discredited** | 1 | Proven false |

**Critical distinction**: Low confidence ≠ ignore it. Low confidence ≠ base major decisions on it alone. Low confidence just means "verify before action."

---

### The [[Threat Intelligence]] Cycle

**Analogy**: Like a feedback loop in engineering—output from one phase becomes input for the next. Poor requirements waste collection efforts. Unused intelligence wastes analysis efforts.

**Definition**: Continuous process converting raw data into decision-ready intelligence:

1. **Requirements** → Define what intelligence you actually need (breach prevention? Threat hunting? Compliance?)
2. **Collection** → Gather data from identified sources (feeds, OSINT, proprietary)
3. **Processing** → Normalize, deduplicate, parse raw data
4. **Analysis** → Convert data into context (What does this mean? Who does it affect?)
5. **Dissemination** → Share intelligence with stakeholders in usable formats
6. **Feedback** → Analysts report what worked, what didn't → cycle improves

The cycle never ends. Each iteration matures your intelligence program.

---

### [[Threat Actor]] Classification

**Analogy**: A mugger, a professional thief, and a corrupt banker all steal, but their motivations, resources, and methods are completely different. Same with threat actors.

**Definition**: Categorization of attack origins by capability, motivation, and resources:

| Actor Type | Capability | Motivation | Example |
|------------|-----------|-----------|---------|
| **Nation-State** | Highest | Political/military dominance | APT28 (Russia) |
| **Organized Crime** | High | Financial gain | Wizard Spider (ransomware) |
| **Hacktivist** | Medium–High | Political/ideological | Anonymous |
| **Script Kiddie** | Low | Attention/chaos | Mass vulnerability scanning |
| **Insider Threat** | Variable | Money/revenge/ideology | Employee data theft |
| **Supply Chain Actor** | Medium–High | Compromise upstream targets | SolarWinds attackers |

Attribution matters because it predicts capability, persistence, and targets.

---

### [[Tactics, Techniques, and Procedures (TTPs)]]

**Analogy**: A chess master has a *tactic* (control the center), *techniques* (pawn advances, piece placement), and *procedures* (exact move sequences). Threat actors work the same way.

**Definition**: Hierarchical framework for describing attacker behavior:

| Layer | Definition | Example |
|-------|-----------|---------|
| **Tactics** | High-level attacker goals (the *what*) | Gain initial access, escalate privileges |
| **Techniques** | Methods to achieve tactics (the *how*) | Phishing, credential stuffing, exploit development |
| **Procedures** | Specific implementations (the *exact* steps) | Send Office macro email → execute PowerShell → C2 callback |

[[MITRE ATT&CK]] framework standardizes TTPs. Understanding TTPs enables:
- **Detection engineering** → Write rules for technique patterns
- **Attribution** → Match TTPs to known threat actors
- **Threat hunting** → Proactively search for technique usage
- **Defensive planning** → Harden against techniques, not just tools

---

## Analyst Relevance

You're on shift. Your SIEM alerts on outbound connections to an IP. Is it malicious?

**Without intelligence**: You check whitelists, dig through logs, maybe block it, maybe not. Hours wasted. Attacker keeps trying.

**With intelligence**: You query a [[threat feed]]. The IP appeared in a malware C2 report last week. You check if your environment matches the target profile (does the IP hit your industry? Your software?). You escalate immediately, initiate incident response, and block downstream. Attacker fails.

Intelligence answers: "Is this actually dangerous *to us*, right now?" That's your job.

---

## Exam Tips

### Question Type 1: Intelligence Levels and Audiences
- *"An executive asks your security team, 'What's the threat landscape for our industry next year?' Which intelligence level answers this?"* → **Strategic Intelligence**
- **Trick**: Confusing tactical (daily detection work) with strategic (annual planning). Executives don't care about file hashes. They care about trends.

### Question Type 2: Source Reliability
- *"Your SOC receives threat feeds from OSINT, a paid vendor, and an ISAC. Which is typically most reliable?"* → **ISAC data** (industry-vetted, corroborated)
- **Trick**: Free doesn't mean bad. OSINT can be excellent but requires verification. Paid isn't automatically better. ISACs work because they're peer-verified.

### Question Type 3: Confidence Levels
- *"Intelligence arrives with 40% confidence. Should you act on it?"* → **Not alone.** Corroborate first or use it for threat hunting only.
- **Trick**: Candidates ignore low-confidence intelligence entirely. Wrong. Use it strategically—don't make major blocks on it alone.

### Question Type 4: Sharing Standards
- *"Your organization needs to share threat data automatically with partners using HTTPS. Which standard handles this?"* → **[[TAXII]]** (transport layer)
- **Trick**: [[STIX]] defines *what* you're sharing. [[TAXII]] defines *how* you share it. Candidates mix these up.

### Question Type 5: TTP Application
- *"You discover attackers are using a specific privilege escalation technique. How do you apply this intelligence?"* →