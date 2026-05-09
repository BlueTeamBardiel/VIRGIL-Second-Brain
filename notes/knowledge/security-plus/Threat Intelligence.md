# Threat Intelligence

## What it is

In DOTA 2, the **ward** is everything. A Sentry Ward placed in the Roshan pit doesn't kill anyone — it just *sees*. It reveals invisible enemies, tracks rune spawns, and tells your team that the enemy carry just stepped into your jungle with a Blink Dagger. The ward itself does no damage. Its entire value is converting the *fog of war* into actionable map awareness so your team can rotate, gank, or back off before the fight even starts. A team without vision plays blind; a team with good ward coverage plays the future.

That is exactly what **threat intelligence** is for a security program. It does not block the attacker. It does not patch the vulnerability. It is the ward placed in the dark corners of the internet — the underground forum, the malware repository, the IP reputation feed — that turns the unknown into the *known* so your defenders can act before contact.

In plain English: threat intelligence is the practice of collecting, analyzing, and sharing information about adversaries — who they are, what tools they use, what they want, and how they operate — so you can prepare defenses before they hit you.

**Technical definition:** [[Threat intelligence]] is evidence-based knowledge — including context, mechanisms, indicators, implications, and actionable advice — about existing or emerging threats to assets, used to inform decisions regarding the subject's response to that threat. It is the structured output of the [[intelligence cycle]]: planning, collection, processing, analysis, dissemination, and feedback.

## Why it matters

Imagine your SOC analyst sees a beacon to `185.x.x.42` over port 443. Without threat intelligence, it's just an outbound HTTPS connection — one of millions that day. With threat intelligence, that IP is flagged as a known [[Cobalt Strike]] command-and-control server tied to a [[ransomware]] affiliate group that has hit three companies in your sector this month. Same packet. Completely different decision.

This is why CompTIA tests it heavily in Domain 4 (Security Operations) and Domain 2 (Threats, Vulnerabilities, and Mitigations). Threat intelligence drives:

- **Proactive blocking** — adding malicious IPs/domains to firewalls and DNS sinkholes before they're used against you
- **Detection engineering** — writing SIEM correlation rules around known attacker [[TTPs]]
- **Incident response prioritization** — knowing whether the alert maps to a state actor or a script kiddie
- **Risk assessments** — quantifying which threats are realistic versus theoretical
- **Executive reporting** — translating "we saw 47 indicators" into "APT29 is targeting our industry"

> **Why CompTIA tests this:** The exam wants you to distinguish *information* (raw data) from *intelligence* (analyzed, contextual, actionable). It also wants you to match intelligence sources to use cases — which feed do you use, who do you share with, and what format do you exchange it in.

## Key facts

### The four levels of threat intelligence

| Level | Audience | Time horizon | Example |
|-------|----------|--------------|---------|
| **Strategic** | Executives, board | Months to years | "Ransomware-as-a-service is targeting healthcare in EMEA" |
| **Tactical** | SOC managers, architects | Weeks to months | "FIN7 uses signed loaders and abuses MSI installers" |
| **Operational** | Incident responders | Days to weeks | "Campaign X uses spear-phishing with .iso attachments next week" |
| **Technical** | Analysts, tools | Hours to days | IOCs: hashes, IPs, domains, registry keys |

CompTIA loves to mix up "tactical" and "technical." Remember: **tactical = behaviors and TTPs**, **technical = atomic indicators**.

### Sources of threat intelligence

#### Open Source Intelligence (OSINT)

[[OSINT]] is publicly available information — no special access required. It is free, plentiful, and *noisy*.

- **Vendor blogs** (CrowdStrike, Mandiant, Talos, Unit 42) — high-quality writeups of campaigns
- **Government feeds** — [[CISA]] alerts, US-CERT, NCSC advisories
- **Social media** — security Twitter/X, Mastodon infosec community
- **Public IOC repositories** — abuse.ch (URLhaus, MalwareBazaar), AlienVault [[OTX]]
- **Search engines for devices** — Shodan, Censys (find your own exposed assets)
- **Code repositories** — GitHub leaks, Pastebin dumps
- **WHOIS, DNS, certificate transparency** — passive enrichment

> **Exam trap:** OSINT is *not* limited to "the dark web." Government bulletins and vendor blogs are OSINT too. The defining quality is *publicly available*, not *hidden*.

#### Closed / Proprietary Intelligence

Paid commercial feeds you subscribe to.

- Recorded Future, Mandiant Advantage, Flashpoint, Intel 471
- Often include dark-web monitoring, actor profiles, and curated IOCs
- Lower noise, higher confidence, but **expensive** and **licensed** (you typically can't redistribute)

#### Information Sharing Organizations

| Acronym | Full name | Scope |
|---------|-----------|-------|
| **ISAC** | Information Sharing and Analysis Center | Sector-specific (FS-ISAC for finance, H-ISAC for health) |
| **ISAO** | Information Sharing and Analysis Organization | Broader/looser than ISAC; any group |
| **CISA** | Cybersecurity and Infrastructure Security Agency | US federal coordinating body |
| **InfraGard** | FBI–private sector partnership | US critical infrastructure |

> **Exam trap:** ISACs are organized **by industry vertical**. ISAOs are organized **by anything** (geography, topic, ad hoc). If the question mentions a specific sector — pick ISAC.

#### Dark Web and Deep Web

- **Deep web** — anything not indexed by search engines (databases, paywalled content, your webmail)
- **Dark web** — intentionally hidden networks (Tor `.onion`, I2P) where threat actors trade exploits, credentials, and access
- Used for early warning: leaked credentials for sale, initial access broker listings mentioning your company, ransomware victim shaming sites

#### Internal Intelligence

Often overlooked on exams but critical: your own SIEM logs, past incident reports, honeypot data, and red team findings are first-party threat intelligence.

### Indicators of Compromise (IOCs) vs Indicators of Attack (IOAs)

This is a high-value distinction:

- **[[IOC]]** — *forensic artifact* showing a compromise has already happened (file hash, malicious IP, registry key, mutex). Reactive.
- **[[IOA]]** — *behavioral pattern* showing an attack is in progress regardless of specific tools (process injection, credential dumping behavior, lateral movement pattern). Proactive.

A hash is an IOC. "PowerShell spawning from Word with encoded command" is an IOA — it catches the *technique* even when the malware is brand new.

### Threat Intelligence Frameworks

#### MITRE ATT&CK
[[MITRE ATT&CK]] is the encyclopedia of adversary behavior — a matrix of **Tactics** (the *why*: Initial Access, Execution, Persistence, etc.) and **Techniques** (the *how*: Spearphishing Attachment T1566.001, Scheduled Task T1053.005). Used to map detections, identify coverage gaps, and describe actor TTPs in a common language.

#### Cyber Kill Chain
Lockheed Martin's seven-stage model:
1. Reconnaissance
2. Weaponization
3. Delivery
4. Exploitation
5. Installation
6. Command & Control (C2)
7. Actions on Objectives

Linear and attacker-centric. Useful for showing where a control breaks the chain.

#### Diamond Model
Every intrusion has four corners: **Adversary**, **Capability**, **Infrastructure**, **Victim**. Pivot from any vertex to discover the others. ("This C2 IP — what other victims have hit it? What capability did it deliver?")

> **Exam trap:** Don't confuse the frameworks. Kill Chain = *stages*. ATT&CK = *tactics + techniques matrix*. Diamond = *four-corner pivot model*.

### Standards and formats for sharing intelligence

| Standard | Purpose |
|----------|---------|
| **[[STIX]]** (Structured Threat Information eXpression) | Language/format for *describing* threat intel — actors, campaigns, indicators, TTPs |
| **[[TAXII]]** (Trusted Automated eXchange of Indicator Information) | Transport protocol for *exchanging* STIX over HTTPS |
| **OpenIOC** | Mandiant's older XML schema for indicators |
| **MISP** | Open-source threat intel platform and its own format |
| **YARA** | Pattern matching for malware classification ("rules for describing malware families") |

The mnemonic: **STIX is the language; TAXII is the transport.** STIX is *what* you say; TAXII is *how* you deliver it.

> **Exam trap:** If a question asks "what protocol exchanges threat data?" the answer is **TAXII**. If it asks "what format describes a threat actor and their TTPs?" the answer is **STIX**. They almost always appear together — but they are not the same thing.

### Threat Actors (the "who")

Threat intelligence is incomplete without actor attribution and motivation:

| Actor type | Motivation | Sophistication |
|------------|-----------|----------------|
| **Nation-state / APT** | Espionage, geopolitical | Very high |
| **Organized crime** | Financial | High |
| **Hacktivist** | Ideology, publicity | Low–medium |
| **Insider** | Revenge, money, coercion | Variable (high access) |
| **Script kiddie / unskilled** | Curiosity, clout | Low |
| **Shadow IT** | Convenience (not malicious) | N/A |

[[Threat actor]] attributes the exam tests: **internal vs external**, **resources/funding**, **level of sophistication/capability**, and **motivation** (data exfiltration, espionage, service disruption, blackmail, financial gain, philosophical/political beliefs, ethical, revenge, disruption/chaos, war).

### Threat Intelligence Lifecycle

The intelligence cycle is exam-friendly because it's a clean six-step process:

1. **Planning & Direction** — What questions are we trying to answer? (Requirements)
2. **Collection** — Gather raw data from feeds, OSINT, internal logs
3. **Processing** — Normalize, deduplicate, translate, structure
4. **Analysis** — Add context, assess confidence, draw conclusions
5. **Dissemination** — Deliver to the right audience in the right format
6. **Feedback** — Did it help? Refine requirements and repeat

Skipping any step turns intelligence back into mere information.

### Confidence Levels and the Admiralty Code

Good intelligence has a **confidence rating**. The classic Admiralty (NATO) system rates source reliability A–F and information credibility 1–6. Modern equivalents include high/medium/low confidence with rationale. Never present an indicator without an assessment of how much you trust it.

### Threat Hunting

[[Threat hunting]] is the *active*, hypothesis-driven search for adversaries that have evaded automated defenses. Where SOC analysts wait for alerts, hunters assume compromise and go looking. A hunt starts with a hypothesis ("our SAP server might have an unauthorized PowerShell process beaconing out"), pulls relevant telemetry, validates or refutes the hypothesis, and feeds findings back into detection rules.

Common hunt hypotheses come from:
- New CVE disclosures relevant to your environment
- Published TTPs from a recent breach in your sector
- Anomalies in baseline telemetry (auth, DNS, process creation)
- Tips from threat intelligence feeds

Tools: **EDR query languages** (CrowdStrike CQL, Microsoft Defender KQL), **SIEM** ad-hoc queries, **Sigma rules**, **YARA rules** for malware artifact matching.

### Real-world threat intel feeds

| Source | What it provides |
|---|---|
| **CISA AIS / KEV** | Federally curated indicators + actively-exploited vuln catalog |
| **MITRE ATT&CK** | Adversary TTPs mapped to a standard taxonomy |
| **Mandiant / CrowdStrike / Microsoft TI** | Commercial reports on named threat groups |
| **AlienVault OTX** | Free crowdsourced indicators |
| **Abuse.ch** (URLhaus, ThreatFox, MalwareBazaar) | Free, high-signal malware/IOC feeds |
| **VirusTotal** | File and URL reputation + community submissions |
| **Sector ISACs** (FS-ISAC, H-ISAC, E-ISAC) | Industry-specific threat sharing |

### CompTIA exam traps

- **OSINT vs. proprietary intelligence.** OSINT is open-source (free, broad, often noisy); proprietary feeds are paid (curated, higher confidence, narrower). The exam tests the trade-off, not which is better.
- **STIX vs. TAXII.** STIX is the format (the language); TAXII is the protocol (the transport). They are not interchangeable.
- **Strategic vs. operational vs. tactical.** Strategic = leadership/long-term; operational = campaigns/months; tactical = TTPs and indicators/days-weeks. Match the audience to the level.
- **Threat hunting ≠ incident response.** Hunting is proactive (no known incident); IR is reactive (incident has occurred). The exam loves this distinction.
- **CISA KEV** is not just a list — it's a **federal mandate** for civilian agencies (BOD 22-01) and a strong prioritization signal for everyone else.

## Related concepts

[[STIX]] · [[TAXII]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[Indicators of Compromise]] · [[TTP|Tactics, Techniques, and Procedures]] · [[CISA KEV]] · [[OSINT]] · [[Dark Web Monitoring]] · [[Threat Actor]] · [[Advanced Persistent Threat]] · [[Threat Hunting]] · [[Sigma]] · [[YARA]] · [[ISACs]] · [[Vulnerability Management]] · [[Incident Response]] · [[Security Monitoring]] · [[SOC]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
