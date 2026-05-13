# Threat Intelligence Overview

## What it is

In **Rainbow Six Siege**, the first 45 seconds of a round aren't combat — they're drones. Attackers roll Twitch's Shock Drone under the door, Valkyrie's Black Eye cameras are already stuck to the rafters from the defender prep phase, and somewhere on the team a Dokkaebi is hijacking phones to see exactly what the defenders see. Nobody breaches a wall until they know which room hides the objective, which corner Jäger's ADS is covering, and whether Caveira is roaming the basement waiting to interrogate the first idiot who pushes alone. The team that wins is the team that *knew the map of the enemy before contact*. That's exactly what threat intelligence does — it's the drone phase of cyber defense, where you learn the adversary before they touch the wire.

In plain English: threat intelligence is the practice of collecting, analyzing, and acting on information about the people who want to hurt your network — who they are, what they want, what tools they use, and how to spot them.

Technically: per CS0-003, **threat intelligence (CTI)** is evidence-based knowledge about existing or emerging threats — including indicators, context, mechanisms, implications, and actionable advice — used to inform decisions about response. It is distinct from raw data (a hash) and from information (a hash tied to a malware family). Intelligence is *information plus context plus a decision it enables*.

## Why it matters

A SOC without threat intelligence is a defender on Siege without drones — running blind, reacting to footsteps. With intel, you know that the FIN7 crew you read about in last week's bulletin uses a specific PowerShell loader, so when your EDR fires on `powershell.exe -enc` from a finance workstation at 2am, you don't triage it as routine — you escalate it as a likely FIN7 intrusion and pull the playbook for that actor.

CTI feeds **vulnerability management** (patch what's being exploited in the wild first), **detection engineering** (build rules for the TTPs your sector actually faces), **incident response** (know the actor's next move before they make it), and **risk management** (quantify which threats are real versus theoretical).

Exam relevance: **CS0-003 Objective 1.4** explicitly tests threat intelligence and threat hunting concepts — sources (open/closed/paid), confidence levels, timeliness/relevancy/accuracy, threat actor categories, and intelligence sharing. Expect questions that force you to pick the *right source* for a *specific scenario* and to distinguish intelligence from raw data.

## Key facts

### The threat actor taxonomy

CompTIA wants you to recognize the actor categories and what motivates each. Motivation drives TTPs, and TTPs drive your detection strategy.

| Actor | Motivation | Sophistication | Example TTPs |
|---|---|---|---|
| **[[Nation-state]]** / [[APT]] | Espionage, geopolitical disruption | Very high | Custom malware, zero-days, long dwell time, supply-chain compromise |
| **[[Organized crime]]** | Financial gain | High | [[Ransomware]], BEC, banking trojans, RaaS affiliates |
| **[[Hacktivists]]** | Ideological, political | Medium | DDoS, defacement, doxing, leak sites |
| **[[Insider threat]] — intentional** | Revenge, money, ideology | Variable (already inside) | Data exfiltration, sabotage, credential abuse |
| **[[Insider threat]] — unintentional** | None — negligence or error | N/A | Misconfigurations, phishing victims, lost devices |
| **[[Script kiddie]]** | Clout, curiosity | Low | Off-the-shelf tools (Metasploit, LOIC), public exploits |
| **[[Supply chain]] adversary** | Varies — often nation-state proxy | High | Trojanized updates (SolarWinds-style), compromised vendors |

The **[[Advanced Persistent Threat]] (APT)** isn't a single actor — it's a *behavior pattern*. Persistent (months to years of dwell time), advanced (custom tooling, operational security), and threat-focused (specific targets, specific objectives). Most APTs are nation-state or nation-state-adjacent.

### Collection sources

This is the part of Objective 1.4 CompTIA loves to test. Know the categories cold.

| Source type | What it is | Strength | Weakness |
|---|---|---|---|
| **[[Open source intelligence]] (OSINT)** | Public — blogs, forums, social media, GitHub, news | Free, broad, fast | Noisy, unverified, widely seen |
| **[[Closed source]]** | Vendor-proprietary, internal telemetry | Curated, contextualized | Limited scope, vendor bias |
| **[[Paid feeds]]** | Commercial intel (Mandiant, Recorded Future, etc.) | High fidelity, analyst-vetted | Expensive, may overlap |
| **Government bulletins** | CISA alerts, FBI flash reports, NCSC advisories | Authoritative, sector-targeted | Slow, sanitized for public release |
| **Information Sharing Organizations** | [[ISAC]]s, [[ISAO]]s — sector-specific (FS-ISAC, H-ISAC) | Peer intel from same threat surface | Membership required, trust-gated |
| **CERT/CSIRT advisories** | US-CERT, national CERTs | Coordinated disclosure, vendor-linked | Often after the fact |
| **[[Deep web]] / [[Dark web]]** | Forums, marketplaces, leak sites | Adversary chatter, leaked credentials, IAB listings | Legal/ethical gates, OpSec required |
| **Blogs and forums** | Researcher writeups, vendor blogs | Detailed technical analysis | Quality varies wildly |
| **Social media** | Twitter/X infosec community, LinkedIn | Speed — IoCs hit feeds in hours | Unverified, hype-prone |
| **Internal sources** | Your own SIEM, EDR, IR retros | Most relevant — it's *your* threat surface | Limited to what's already hit you |

### The three quality dimensions

CompTIA tests this triangle. Every piece of intel gets scored on all three.

- **Timeliness** — Is it current? An IoC for a C2 that went dark six months ago is archaeology, not intelligence.
- **Relevancy** — Does it apply to *your* environment? A healthcare ransomware advisory is gold for a hospital, noise for an aerospace contractor.
- **Accuracy** — Is it correct? Bad intel causes false positives, wastes analyst hours, and erodes trust in the program.

Add **confidence levels** — most CTI uses an Admiralty-style or Low/Medium/High rating. A High-confidence indicator from a vetted paid feed gets blocked at the firewall. A Low-confidence OSINT IoC gets a watchlist entry, not a block — you don't break production on a hunch.

### Tactics, Techniques, and Procedures (TTPs)

The intel pyramid (David Bianco's Pyramid of Pain, often referenced indirectly on the exam):

1. **Hash values** — easy for attacker to change, low pain
2. **IP addresses** — easy to rotate
3. **Domain names** — slightly harder
4. **Network/host artifacts** — moderate pain
5. **Tools** — significant pain to swap
6. **[[TTPs]]** — *maximum pain* — changing how you operate is a fundamental rewrite

Intelligence focused on TTPs (mapped to [[MITRE ATT&CK]]) is durable. Intel focused on hashes ages in hours.

### Indicators of Compromise

**[[IoC]]s** are forensic artifacts that suggest an intrusion has already occurred — file hashes, malicious IPs, registry keys, mutex names, domain names, user-agent strings, unusual processes. They're the breadcrumbs left after the breach. Distinguish from **indicators of attack (IoA)** — behavioral patterns suggesting an attack is *in progress* (e.g., a workstation suddenly running `net group "Domain Admins"`).

### The intelligence lifecycle

Five phases — CompTIA expects you to know the order:

1. **Requirements / Planning** — what do stakeholders need to know?
2. **Collection** — pull from the sources above
3. **Analysis** — turn data into intelligence (context, attribution, confidence)
4. **Dissemination** — push to consumers (SOC, IR, leadership, detection engineering)
5. **Feedback** — did it help? Refine requirements, repeat.

### Sharing and standards

- **[[STIX]]** (Structured Threat Information Expression) — the language for describing threats
- **[[TAXII]]** (Trusted Automated eXchange of Indicator Information) — the transport protocol for sharing them
- **[[ISAC]]s / [[ISAO]]s** — sector trust circles for peer sharing
- **Traffic Light Protocol (TLP)** — RED / AMBER / GREEN / CLEAR — governs who can see what

### Active defense and honeypots

**[[Active defense]]** is the controlled use of deception and engagement to detect and study adversaries — not "hacking back" (which is illegal in most jurisdictions). The classic tool is the **[[honeypot]]** — a deliberately exposed, instrumented decoy system that has no legitimate business purpose. Any interaction with it is, by definition, suspicious. Honeynets (networks of honeypots) generate first-party intelligence on the actors actively targeting your environment.

### CompTIA exam traps

> **CompTIA exam trap:** *Data vs. information vs. intelligence.* A list of malicious IPs is data. Those IPs attributed to APT29 is information. APT29 actively targeting your industry vertical with those C2 nodes this week, with recommended blocks and detection logic, is intelligence. Exam will offer all three as answers — pick the one with context and decision support.

> **CompTIA exam trap:** *OSINT is not free intelligence.* It's free *data*. Turning it into intelligence costs analyst hours. CompTIA will ask "lowest-cost source" — OSINT is the answer. They'll separately ask "highest-fidelity source" — paid feeds or ISAC sharing, not OSINT.

> **CompTIA exam trap:** *ISAC vs. CERT vs. CSIRT.* ISACs are *sector* sharing groups (FS-ISAC for finance). CERTs are *coordination* centers (US-CERT, CERT/CC at Carnegie Mellon). CSIRTs are *organizational* response teams. They overlap but aren't synonyms — and CompTIA will swap them on you.

> **CompTIA exam trap:** *Confidence level is not severity.* High confidence that a low-severity threat is happening ≠ a P1 incident. Both axes matter for prioritization.

## SOC reality

- The 7am intel brief is real. Your CTI team (or your senior analyst wearing the CTI hat) drops a Slack summary every morning: new CVEs being exploited in the wild, sector-relevant advisories, IoCs added to the SIEM watchlist overnight. If you skip it, you triage tickets blind for the rest of the day.
- When an alert fires, the first L1 reflex should be *"is this actor in our threat profile?"* — pivot the indicator (IP, hash, domain) through your intel platform (MISP, ThreatConnect, Anomali) before you escalate. Half the time you find prior reporting that tells you exactly what stage of the kill chain you're in.
- The IR lead's first question during a live incident is almost always *"who are we dealing with?"* — not because attribution changes containment, but because it predicts the *next move*. Knowing the actor tells you whether to expect ransomware deployment in 30 minutes or quiet exfil over 30 days.
- Never promise leadership *"we have intel on this actor"* without specifying confidence level and source. *"Medium-confidence reporting from FS-ISAC, corroborated by one paid feed"* is a defensible statement. *"We know it's them"* is how you end up in front of the board explaining the wrong attribution.
- Escalation path: L1 enriches with intel context → L2 confirms TTP match against ATT&CK → IR lead correlates against active campaign reporting → CISO gets a one-page summary with actor, confidence, scope, and recommended action. The intel team is upstream of all of it.

*The drone phase isn't optional. The team that skips it gets shot in the back walking through the front door.*

## Related concepts

[[Threat Hunting]] · [[Indicators of Compromise]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[STIX]] · [[TAXII]] · [[ISAC]] · [[Advanced Persistent Threat]] · [[Threat Actors]] · [[Open Source Intelligence]] · [[Dark Web Monitoring]] · [[Honeypot]] · [[Active Defense]] · [[Incident Response]] · [[Vulnerability Management]] · [[Pyramid of Pain]] · [[TLP]]

*Source: VIRGIL knowledge base — 2026-05-11*