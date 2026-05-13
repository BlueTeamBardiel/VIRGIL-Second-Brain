# Applying Threat Intelligence Organization-Wide

## What it is

In **Gran Turismo**, before a race at Trial Mountain you do a reconnaissance lap — not to win, but to map the circuit. You learn the apex of the Turn 1 hairpin, the bump on the back straight that unsettles the rear, the braking marker before the tunnel. Then you take that information and *apply it everywhere*: your gearing changes, your downforce settings change, your tire compound choice changes, your fuel map changes, your overtake strategy changes. The reconnaissance lap is worthless if it stays in your head. It only pays off when it reshapes every system on the car for that specific track.

That's exactly what applying threat intelligence organization-wide does — you collect what you know about the adversaries hunting your industry, then push that knowledge into every defensive system that can use it.

**Technical definition (CS0-023 1.4):** Applying threat intelligence organization-wide is the operational practice of distributing curated, contextual threat data — IoCs, TTPs, threat actor profiles, vulnerability intelligence — across multiple defensive functions (incident response, vulnerability management, risk management, security engineering, detection engineering) so the same intelligence improves outcomes everywhere it touches. It turns a [[threat intelligence]] feed from an inbox into a control plane.

## Why it matters

Threat intel that lives only in the threat intel team's Confluence page is wasted money. The whole point of paying for [[paid feeds]], parsing [[government bulletins]], scraping [[deep/dark web]] forums, and joining an ISAC is to *change defensive behavior*. If the SOC detection rules don't get updated, if the vuln scanner doesn't get the new CVE priority, if the architects don't know which threat actor targets your sector — the intelligence program is a cost center.

CompTIA objective 1.4 specifically tests your ability to recognize where threat intel plugs in across the organization. The exam will hand you a scenario — "a new APT campaign targets your industry using CVE-2024-XXXX and PowerShell living-off-the-land" — and ask which teams need what. You need to answer fast and right.

Career-wise: the analyst who can articulate how a single piece of intel reshapes five different teams' work is the analyst who gets promoted to threat intel lead. The one who just forwards the FBI flash report to a distribution list does not.

## Key facts

### The four core consumers of threat intelligence

CompTIA explicitly lists these as the operational focus areas. Memorize them.

| Consumer | What they need from intel | Example output |
|---|---|---|
| **[[Incident response]]** | IoCs, TTPs, attribution context, known C2 infrastructure | Faster triage, scoped containment, accurate adversary modeling |
| **[[Vulnerability management]]** | Which CVEs are actively exploited, by whom, against whom | Reprioritized patch queue — exploited-in-wild jumps the line over CVSS score |
| **[[Risk management]]** | Threat actor capability + intent against your sector | Updated risk register, justified control investment, board-ready risk narrative |
| **[[Security engineering]]** | Adversary TTPs, attack patterns, defensive gaps | Architecture changes, new detection rules, segmentation decisions, honeypot placement |

### Collection sources — where the intel comes from

Same intel, different provenance. CompTIA tests the categories.

**Open source ([[OSINT]]):**
- Government bulletins — CISA advisories, FBI flash reports, NCSC alerts
- [[Computer Emergency Response Team]] (CERT) and [[CSIRT]] (Computer Security Incident Response Team) feeds — US-CERT, country-CERTs, sector CERTs
- Blogs and forums — vendor research blogs (Mandiant, CrowdStrike, Talos), Reddit r/netsec, security Twitter/Mastodon
- [[Social media]] — threat actors brag, researchers post early IoCs
- Vendor advisories — Microsoft, Cisco, Fortinet patch notes

**Closed source / paid feeds:**
- Commercial threat intel (Recorded Future, Mandiant Advantage, Flashpoint)
- ISAC/ISAO membership (FS-ISAC for finance, H-ISAC for health, E-ISAC for energy)
- Government-restricted feeds (TLP:AMBER+STRICT, classified briefings for cleared orgs)

**Deep/dark web:**
- Criminal marketplaces, ransomware leak sites, initial access broker forums
- High signal but operationally expensive and legally sensitive — most orgs consume this through a vendor, not directly

**Internal sources:**
- Your own [[SIEM]] historical data, past incident reports, honeypot captures, EDR telemetry
- Often the highest-relevance source you have — and the one most teams ignore

### Threat actor categories (1.4 explicit)

Intel is useless without knowing *who* you're up against. CompTIA's actor taxonomy:

- **[[Nation-state]] / APT** — patient, well-funded, geopolitical objectives, custom malware, supply-chain attacks. Think APT29 (Cozy Bear), APT41, Lazarus.
- **[[Organized crime]]** — ransomware affiliates, banking trojan crews, BEC rings. Money-motivated, increasingly using APT-grade tooling.
- **[[Hacktivists]]** — ideologically motivated, DDoS and defacement common, occasional leak-and-shame.
- **[[Insider threat]]** — split into **intentional** (malicious employee/contractor) and **unintentional** (the person who clicked the phish). Intel here comes from UEBA and HR signals, not OSINT.
- **[[Script kiddie]]** — low skill, high noise, opportunistic, uses public exploits. The reason you patch internet-facing assets within hours of disclosure.
- **[[Supply chain]] threats** — not an actor per se but a vector. Trusted third party gets compromised, the attack rides the trust relationship in (SolarWinds, 3CX, MOVEit).

### Intelligence quality dimensions

When CompTIA asks "what makes intelligence actionable," the answer set is:

- **Timeliness** — IoCs decay fast. A C2 IP from six months ago is probably parked or repurposed. A hash from yesterday is gold.
- **Relevancy** — APT activity against pharma manufacturing matters to you if you're pharma. If you're a regional credit union, it's noise.
- **Accuracy** — false positives in intel feeds poison detection. A bad IoC blocking your CDN at 2pm is a self-inflicted incident.
- **Confidence levels** — every IoC and assessment carries a confidence rating (low/medium/high, or the Admiralty scale). High-confidence intel drives blocking; low-confidence drives hunting.

### Information sharing mechanisms

- **STIX** (Structured Threat Information eXpression) — the data format
- **TAXII** (Trusted Automated eXchange of Indicator Information) — the transport protocol
- **TLP** (Traffic Light Protocol) — handling restrictions: RED (eyes only), AMBER (limited internal), GREEN (community), CLEAR (public)
- **ISACs/ISAOs** — sector sharing communities, peer-to-peer intel with an NDA wrapper

### How intel applies in each defensive function

**Detection and monitoring:**
- IoCs become SIEM correlation rules and EDR custom indicators
- TTPs become behavioral detections mapped to [[MITRE ATT&CK]]
- New campaign details trigger threat hunts in historical data — "did we see this before we knew to look?"

**Vulnerability management:**
- KEV-listed CVEs (CISA Known Exploited Vulnerabilities) get patched ahead of higher-CVSS-but-not-exploited bugs
- Intel on threat actor targeting reshapes asset prioritization — the CVE in your VPN concentrator matters more when intel says ransomware crews are scanning for it right now

**Risk management:**
- Threat landscape reports update the risk register quarterly
- Board reporting frames investments against named actor capabilities, not abstract risk scores

**Security engineering:**
- Architecture decisions account for known TTPs (segment OT from IT because Volt Typhoon)
- [[Active defense]] postures — [[honeypot]] placement, deception tokens, [[isolated networks]] for crown-jewel assets — get tuned to observed adversary behavior
- Business-critical assets get wrapped in layered controls informed by who's actually trying to reach them

### CompTIA exam traps

> **CompTIA exam trap:** "Threat intelligence" and "indicators of compromise" are not synonyms. IoCs are *one product* of intelligence — atomic facts (hash, IP, domain). Intelligence is the full picture including TTPs, attribution, motivation, and assessed intent. Exam questions that ask "what is threat intelligence" with an "IPs and hashes" option are baiting you.

> **CompTIA exam trap:** CERT vs CSIRT. **CERT** (Computer Emergency Response Team) is a trademarked term originating at Carnegie Mellon, often used for national/sector-level teams (US-CERT). **CSIRT** (Computer Security Incident Response Team) is the generic term for an internal corporate response team. Same function, different scope and naming convention. CompTIA will use them as distractors against each other.

> **CompTIA exam trap:** Open source ≠ free. OSINT means publicly available, not no-cost-to-operationalize. Curating, deduplicating, and validating OSINT feeds requires real labor or a paid platform that does it for you.

> **CompTIA exam trap:** Intentional vs unintentional insider. The phishing victim is an **unintentional insider threat**, not a victim-only category. The exam separates these and expects you to know that user awareness training is the control for unintentional, while UEBA + DLP + access reviews target intentional.

## SOC reality

- The threat intel team drops a Slack message at 9am: "New IAB advertising access to a healthcare org matching your size profile — credentials priced at $4k, no buyer yet." The L1 doesn't act on this. The L2 pulls credential exposure reports, the IR lead briefs the CISO, the vuln team checks external-facing auth surfaces. *Same intel, four different workflows fired in parallel.*
- The CISO asks one question after any major industry breach hits the news: "Are we exposed to that, and how do we know?" Your intel program exists to answer that question in minutes, not days. If you can't, the program is failing regardless of how many feeds you subscribe to.
- 80% of paid feed IoCs will never match anything in your environment. That's not a failure — that's the feed doing its job covering the threat landscape. The 20% that hit are why you pay.
- Never blocklist a feed IoC straight into production without a confidence threshold and a sunset date. *I have watched a vendor's bad domain IoC blackhole our own marketing site for three hours on a Friday afternoon. The vendor's "high confidence" was a typo in their pipeline.*
- The handoff that breaks intel programs: threat intel team → detection engineering. If the detection engineers don't have intake SLAs for new IoCs and TTPs, the intel sits in Confluence and nothing changes on the wire. Build the pipeline before you buy the feed.

## Related concepts

[[Threat Intelligence]] · [[Threat Hunting]] · [[Indicators of Compromise]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[STIX TAXII]] · [[Traffic Light Protocol]] · [[Vulnerability Management]] · [[Incident Response Lifecycle]] · [[CSIRT]] · [[Honeypot]] · [[Active Defense]] · [[Threat Actors]] · [[Advanced Persistent Threat]] · [[Supply Chain Attacks]] · [[Insider Threat]] · [[OSINT]] · [[ISAC]]

*Source: VIRGIL knowledge base — 2026-05-11*