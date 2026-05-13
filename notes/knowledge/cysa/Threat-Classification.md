# Threat Classification

## What it is

In **Civilization VI**, when an enemy unit appears at your border, the game tells you exactly what you're looking at: a Barbarian Scout, a Khmer Domrey siege elephant under Jayavarman VII, a Spy from a city-state, or Eleanor of Aquitaine running Loyalty pressure against your border city. Same map tile, totally different threats. You scramble a Warrior for the Scout. You evacuate the worker and pull catapults back for the Domrey. You raise Counterspies for the spy. For Eleanor, you build Monuments and Amphitheaters because the threat is *cultural*, not military, and a unit won't fix it.

That's exactly what threat classification does — it forces you to name what you're looking at so you can pick the right response.

Technically: **threat classification** is the standardized vocabulary a security team uses to describe **who** is attacking (threat actor), **what they're doing** (threat activity / TTPs), and **what it would cost you** (threat impact). Without it, the SOC writes "suspicious behavior detected" tickets that nobody can triage. With it, the L1 analyst opens a ticket that reads *"likely organized-crime ransomware precursor — Cobalt Strike beacon on FIN-DB-01, business-critical, escalating to L2"* and the entire war room knows what to do in the next ten seconds.

This is CS0-003 Objective 1.4 territory — threat intelligence and threat hunting concepts. CompTIA tests whether you can read a scenario and correctly bucket the adversary, motive, capability, and what feeds you'd use to track them.

## Why it matters

Classification is the API between intelligence and operations. The CTI analyst reads a government bulletin about a nation-state campaign. The SOC analyst reads an alert from EDR. The IR lead reads a ransom note. All three need to converge on the same answer: *what is this, and how bad is it?* If they don't share vocabulary, the bulletin sits in a Slack channel, the alert gets closed as benign, and the ransom note becomes a Monday-morning surprise for the CISO.

On the exam, expect scenario questions where you must pick the most likely **threat actor** given clues (motive, sophistication, target), the right **intelligence source** for a given need (timely vs. authoritative vs. cheap), and the correct **classification** of an incident (intentional vs. unintentional, internal vs. external, supply chain vs. direct).

## Key facts

### Threat actor categories

The five buckets CompTIA tests, ranked by capability and patience:

| Actor | Motive | Capability | Tells |
|---|---|---|---|
| **Nation-state / APT** | Espionage, sabotage, geopolitical leverage | Highest — zero-days, custom malware, multi-year campaigns | Targeted, quiet, persistent, supply-chain pivots |
| **Organized crime** | Money — ransomware, BEC, fraud, data resale | High and rising — RaaS marketplaces, professional ops | Financially motivated, opportunistic but well-tooled |
| **Hacktivist** | Ideology, protest, embarrassment | Medium — defacements, DDoS, dox dumps | Loud, public claim of responsibility, timed to news cycles |
| **Insider threat** | Grievance, greed, coercion, ego — or accident | Variable — already inside, no perimeter to cross | Anomalous access patterns, off-hours, large pulls to USB or cloud |
| **Script kiddie** | Clout, curiosity, boredom | Low — runs other people's tools | Noisy, public-facing exploits, opportunistic targets |

[[Advanced persistent threat]] (APT) is not a separate actor — it's a *behavior profile*. A nation-state campaign is the textbook APT. Organized crime can also operate as an APT once they've established persistence and patience inside your network. The "P" is the killer — they don't leave.

**Insider threats** split two ways CompTIA loves:
- **Intentional** — the leaving employee who tarballs the customer database on their last day.
- **Unintentional** — the helpdesk tech who emails a credential file to the wrong distro list.

Same impact, totally different control set. Intentional needs DLP, UEBA, and legal hold. Unintentional needs training, MFA, and better tooling defaults.

### Threat activity — what they're doing

This is where [[Tactics, techniques, and procedures (TTPs)]] live. Tactics = the *why* (initial access, persistence, exfiltration). Techniques = the *how* (spearphishing attachment, scheduled task, DNS tunneling). Procedures = the *specific implementation* (the exact PowerShell one-liner, the exact C2 domain naming convention).

[[Indicators of compromise]] (IoCs) are the forensic artifacts that prove the activity happened — file hashes, IPs, domains, registry keys, mutex names. IoCs are atomic. TTPs are behavioral. CompTIA will give you a scenario with both and ask which is which.

### Threat impact — what it costs you

Classify by what gets hit:
- **Business-critical asset** compromise — the crown-jewel database, the SCADA controller, the domain controller.
- **Data classification** affected — PII, PHI, PCI, IP, classified.
- **Operational impact** — outage, degradation, BPI (business process interruption).
- **Reputational and regulatory** — GDPR 72-hour clock, CIRCIA reporting, customer notification.

A CVSS 9.8 on a sandboxed dev box without internet egress is a P3 ticket. A CVSS 6.5 on the financial DB is a P1. Impact reframes severity.

### Intelligence collection sources

This is the section CompTIA bullet-tests hardest. Know the categories:

| Source | What it is | Strength | Weakness |
|---|---|---|---|
| **Open source (OSINT)** | Public — blogs, news, social media, GitHub, Shodan | Free, broad coverage | Noisy, slow, unverified |
| **Closed source** | Vendor-internal telemetry not sold publicly | High signal, vendor-specific | Limited to that vendor's view |
| **Paid feeds** | Commercial CTI subscriptions (Recorded Future, Mandiant, CrowdStrike) | Curated, fast, attribution work included | Expensive, vendor bias |
| **Government bulletins** | CISA, US-CERT, FBI flash, NCSC advisories | Authoritative, sector-specific | Slower, often sanitized |
| **CERT / CSIRT advisories** | Computer Emergency / Incident Response Team national or industry orgs | Trusted, well-formatted (often STIX/TAXII) | Lagging real-time threats |
| **Information sharing organizations** | ISACs (FS-ISAC, H-ISAC, E-ISAC), ISAOs | Peer-shared, sector-relevant | Membership required, trust-gated |
| **Blogs / forums** | Vendor research blogs, security Twitter, Reddit | Fast, often first to report | Quality varies wildly |
| **Deep / dark web** | Forums, marketplaces, leak sites | Pre-breach signal (credentials for sale, ransomware leak countdowns) | Legal/operational risk to collect directly |

The skill is matching source to need. If you need fast tactical IoCs for a campaign hitting your sector right now: ISAC + paid feed. If you need strategic background on a nation-state actor: government bulletins + vendor reports. If you want to know your own credentials are being sold: dark web monitoring.

### Intelligence evaluation — the four qualities

Every piece of intel gets scored on:

- **Timeliness** — is it current enough to act on? Yesterday's IoC for an actor who already rotated infrastructure is archaeology.
- **Relevancy** — does it apply to your sector, geography, tech stack? A SCADA advisory means nothing to a SaaS shop.
- **Accuracy** — is the technical content correct? False IoCs burn analyst hours.
- **Confidence level** — analyst-assigned (low/medium/high, or admiralty-grade A1–F6). Forces honesty about what you actually know vs. assume.

> **CompTIA exam trap:** Timeliness ≠ relevancy ≠ accuracy ≠ confidence. CompTIA will hand you a scenario where intel is *accurate* but *not relevant* (correct IoCs for a different sector) and ask why you'd deprioritize it. The answer is relevancy, not accuracy.

### Threat hunting vs. detection-and-monitoring

[[Detection and monitoring]] is **reactive** — the SIEM rule fires, the analyst responds. [[Threat hunting]] is **proactive** — the hunter assumes compromise has already happened and goes looking for what the alerts missed. Hunts are hypothesis-driven: *"if a Cobalt Strike beacon were on our network, where would I see it?"* Then you query.

Hunting focus areas the exam expects you to name:
- **Configurations / misconfigurations** — open S3 buckets, exposed Kibana, default creds
- **Isolated networks** — air-gapped segments that haven't been audited in years
- **Business-critical assets** — go where the money is
- **Supply chain** — third-party software, MSP access, library dependencies
- **Internal sources and processes** — your own scheduled tasks, service accounts, shadow IT

### Active defense and honeypots

[[Active defense]] is the deliberate engagement of an adversary inside an environment you control — not "hack back," which is illegal in most jurisdictions. A [[Honeypot]] is a decoy system designed to attract and observe attackers. Honeynets are networks of them. Honeytokens are decoy *credentials* or *files* — if anyone touches them, you know you have an intruder, because no legitimate process should.

### Threat intelligence sharing

[[Threat intelligence sharing]] flows through STIX (structured language) and TAXII (transport protocol). ISACs share within a sector. CISA's AIS (Automated Indicator Sharing) is the US government feed. Trust matters — sharing is gated by NDAs, MOUs, and TLP (Traffic Light Protocol: TLP:RED = named recipients only, TLP:AMBER = limited distribution, TLP:GREEN = community, TLP:WHITE/CLEAR = public).

### CompTIA exam traps

> **Trap:** APT is a *descriptor*, not an *actor*. A nation-state can be an APT. A criminal group can be an APT. "APT" alone is not the answer when the question asks *who* — it's the answer when the question asks *how they behave*.

> **Trap:** Open source means *publicly available*, not "free as in beer only." Paid feeds can aggregate open-source data. The distinction is access model, not cost.

> **Trap:** A CERT (Computer Emergency Response Team) is typically a national or sector-level coordination body (US-CERT, JPCERT). A CSIRT (Computer Security Incident Response Team) is typically the *internal* team at your org. CompTIA will swap them.

> **Trap:** Unintentional insider threat is still an insider threat. Don't pick "external" just because the employee didn't mean it.

## SOC reality

- At 3am, the alert says *"unusual SMB activity from FIN-DB-01."* The L1's first move is not classification — it's preservation. Snapshot the host, pull the EDR timeline, then classify. Classification without evidence is guessing.
- The CISO will ask three questions in this order: **scope** (how many hosts?), **attribution** (who?), and **impact** (what data?). Attribution is the one you'll be wrong about most often. Hedge with confidence levels. *"Medium confidence, financially motivated organized crime, behavioral overlap with the LockBit affiliate cluster"* is honest. *"It's LockBit"* on day one is a career-shortening sentence.
- ISAC membership is the cheapest force multiplier in the budget. A peer org saw the same IoCs four hours ago and posted them. You catch the campaign before it lands.
- Threat hunts that find nothing are not failed hunts. They're evidence of absence — document the hypothesis, the queries, the negative result, and the date. Next quarter you re-run them.
- Never tell leadership *"it's just a script kiddie"* on day one. The kiddie running someone else's RaaS affiliate kit will still encrypt your file servers. Classify the *activity*, not the *vibe*.

## Related concepts

[[Threat actors]] · [[Advanced persistent threat]] · [[Indicators of compromise]] · [[Tactics, techniques, and procedures (TTPs)]] · [[Threat hunting]] · [[Detection and monitoring]] · [[Open-source intelligence (OSINT)]] · [[STIX and TAXII]] · [[ISAC]] · [[Honeypot]] · [[Active defense]] · [[Incident response lifecycle]] · [[Supply chain risk]] · [[Insider threat]] · [[Confidence levels and admiralty grading]]

*Source: VIRGIL knowledge base — 2026-05-11*