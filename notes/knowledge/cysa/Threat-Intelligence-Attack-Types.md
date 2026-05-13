# Threat Intelligence & Attack Types

## What it is

In **Resident Evil**, Chris and Jill don't walk into the Spencer Mansion blind. They've read the S.T.A.R.S. Bravo Team's last transmissions, they know something tore through a search party in the Arklay Mountains, and they know Umbrella has a lab somewhere underneath. The diaries scattered through the mansion — the keeper's diary tracking the T-Virus exposure day by day, the researcher's notes on the Tyrant — aren't flavor text. They're **threat intelligence**. By the time Wesker reveals he's been Umbrella the whole time, the player who read the documents already had the IoCs: missing scientists, lab access logs, a dog kennel full of corpses. The player who skipped them dies in the lab.

That's exactly what threat intelligence does — it's information about adversaries collected, processed, and analyzed *before* they hit you, so the defender walks into the mansion knowing what's behind the door.

**Technical definition (CS0-003 Obj 1.4):** Threat intelligence is the structured collection, analysis, and dissemination of information about threat actors, their tactics, techniques, and procedures (TTPs), and indicators of compromise (IoCs), used to inform detection, response, and risk decisions. **Threat hunting** is the proactive, hypothesis-driven search through telemetry for adversary activity that has evaded existing controls — assuming compromise, not waiting for the alert.

## Why it matters

The SOC analyst who only reacts to alerts is the rookie cop who only shows up after the body is found. The analyst running threat intel and threat hunting reads Umbrella's lab notes before the Cerberus comes through the window. CS0-003 Objective 1.4 is the entire reason CySA+ exists as a cert — it's the operational layer above Sec+. CompTIA tests this domain hard: source types, confidence ratings, the difference between threat actor categories, and the IR team acronyms that get swapped in distractors.

Real-world: every mature SOC has a threat intel function feeding the detection engineering team. Every breach retrospective asks the same question — *"did we have intel on this actor and ignore it, or did we genuinely not know?"* The answer determines whether the CISO keeps their job.

## Key facts

### Threat actor categories

CompTIA wants you to know who's on the other side of the keyboard. Motivation determines TTPs, and TTPs determine your detection strategy.

| Actor | Motivation | Sophistication | Typical TTPs |
|---|---|---|---|
| **Script kiddie** | Ego, boredom | Low — uses prebuilt tools | Public exploits, Metasploit, defacement |
| **Hacktivist** | Ideology, protest | Low-to-medium | DDoS, doxxing, web defacement (Anonymous-style) |
| **Organized crime** | Money | Medium-to-high | Ransomware, banking trojans, BEC, RaaS |
| **Insider threat** | Grievance, money, espionage, *or accident* | Variable | Data exfil, sabotage, privilege abuse |
| **Nation-state / APT** | Espionage, geopolitical | Very high | Zero-days, supply chain, multi-year persistence |
| **Unintentional insider** | None — they clicked the link | N/A | Phishing victims, misconfigurations, lost laptops |

**Insider threats split two ways:** intentional (the disgruntled admin) and unintentional (the helpdesk tech who plugged in the USB they found in the parking lot). CompTIA tests both as the same category.

### Advanced Persistent Threat (APT)

The defining traits, in order: **Advanced** (custom tooling, zero-days, operational security), **Persistent** (months to years of dwell time), **Threat** (funded, targeted, patient). Nation-states are the canonical APT — APT28, APT29, Lazarus Group — but organized crime increasingly behaves like an APT (Conti, FIN7).

> **CompTIA exam trap:** Zero-day is an *exploit class* (no patch exists, no signature exists). APT is an *actor archetype*. An APT may use zero-days, but a question describing "compromise for years, can't fully remove it, evades the IR team" is APT, not zero-day. CompTIA puts both options on the same question specifically to bait this swap.

> **CompTIA exam trap:** Signature-based detection is the *worst* defense against zero-days and APTs — signatures require a known pattern, and by definition zero-days don't have one. Heuristics, behavior analysis, segmentation, and threat intelligence all work without a prior signature. If the question asks "least effective against APT/zero-day," the answer is almost always signature-based.

### Collection sources

CompTIA loves to split these into open vs closed, internal vs external, free vs paid.

**Open source (OSINT):**
- Government bulletins — CISA advisories, US-CERT, NCSC (UK), national CERT/CSIRT feeds
- Vendor blogs — Mandiant, CrowdStrike, Talos, Microsoft Threat Intelligence
- Social media — Twitter/X infosec community, LinkedIn breach announcements
- Blogs/forums — Krebs on Security, Bleeping Computer, r/netsec
- Public IOC feeds — AlienVault OTX, abuse.ch, MISP communities

**Closed source / paid feeds:**
- Recorded Future, Mandiant Advantage, CrowdStrike Falcon Intelligence, Flashpoint
- ISAC/ISAO memberships — sector-specific intel (FS-ISAC for finance, H-ISAC for healthcare)
- Government-restricted feeds — TLP:RED material, classified briefings for cleared partners

**Deep/dark web:** Forums, marketplaces, ransomware leak sites. Requires Tor, careful OPSEC, and usually a vendor doing the collection for you — getting an analyst caught browsing a criminal forum on their corporate laptop is a career event.

**Internal sources:** Your own SIEM, EDR, firewall, DNS, and proxy logs. This is the highest-relevance intel you'll ever have — *it's about your own network*. Most SOCs underweight it.

### Information sharing organizations

- **CERT** — Computer Emergency Response Team. Originally Carnegie Mellon's CERT/CC, now a generic term for national/sector response teams.
- **CSIRT** — Computer Security Incident Response Team. Org-internal IR team. Same function, different scope.
- **ISAC** — Information Sharing and Analysis Center. Sector-specific (FS-ISAC, E-ISAC, H-ISAC).
- **ISAO** — Information Sharing and Analysis Organization. Broader, less sector-locked.

> **CompTIA exam trap:** CERT vs CSIRT — CompTIA will put both in the answers. CERT is typically external/national; CSIRT is typically internal/org-level. The job is the same; the boundary is different.

### Confidence levels and intel quality

Intel without a confidence rating is gossip. CompTIA tests four quality dimensions:

| Dimension | What it asks |
|---|---|
| **Timeliness** | Is this intel current, or are you defending against last quarter's TTPs? |
| **Relevancy** | Does this apply to your sector, stack, geography? Iranian APT intel matters less if you're a Midwest hospital chain. |
| **Accuracy** | Has it been verified? Single-source or corroborated? |
| **Confidence level** | High/Medium/Low — or numeric (Admiralty code, 1-6). Drives whether you block at the firewall or just monitor. |

A high-confidence IoC gets blocked. A low-confidence IoC gets watch-listed in the SIEM. Confusing the two either breaks the business (false positive block) or misses the attack (real IoC ignored).

### Indicators of Compromise (IoC)

Forensic evidence that compromise has occurred or is occurring. Hierarchy from cheap-to-change to expensive-to-change (David Bianco's Pyramid of Pain):

1. Hash values — trivially changed by attackers
2. IP addresses — rotate via VPS or VPN
3. Domain names — DGA defeats this
4. Network/host artifacts — process names, mutex, registry keys
5. Tools — the malware family itself
6. **TTPs** — tactics, techniques, procedures. Hardest for the attacker to change. Hunt at this level.

> **CompTIA exam trap:** IoC is reactive (forensic — "what happened"). **IoA** (Indicator of Attack) is behavioral and proactive — "what's happening right now, based on adversary behavior, before damage is done." CompTIA will swap the definitions.

### Threat hunting

Hypothesis-driven, assumes-breach, proactive. The hunter starts with *"if an attacker were already inside, where would I see them?"* and queries the SIEM/EDR for that pattern. Outputs: new detection rules, confirmed incidents, or validated negatives. Hunts are scoped — you don't "hunt for badness," you hunt for *specific* TTPs mapped to MITRE ATT&CK.

Common hunt focus areas: business-critical assets (crown jewels first), supply chain integrations, isolated/OT networks (where EDR coverage is thin), recently-disclosed CVEs against your stack.

### Active defense and honeypots

**Active defense** sits between passive monitoring and offensive action — deception, honeypots, honeytokens, sinkholes. A **honeypot** is a deliberately vulnerable system designed to be attacked; every connection to it is hostile by definition, so false-positive rate is zero. Honeytokens are fake credentials, fake DB rows, fake AWS keys planted in real systems — any use of them is an incident.

> **CompTIA exam trap:** Active defense is NOT "hack back." Hack back is illegal in most jurisdictions. Active defense stays inside your own perimeter — deception, attribution, intel collection. Don't pick "retaliate against the attacker's infrastructure" as the right answer. Ever.

### What an IP address actually tells you

> **CompTIA exam trap:** Given only an IP address, you can determine almost *nothing* with certainty. Not the attacker's identity (could be a proxy, VPS, compromised third-party). Not the country of origin reliably (geo-IP lies, especially for VPNs and Tor). Not the domain (PTR records are unreliable, often missing). The correct answer to "what can you determine from just an IP?" is usually **none of the above**. Attribution requires correlation across many data points.

### Integration with other SOC functions

Threat intel feeds — and is fed by — every other SOC function:

- **Vulnerability management** — intel says "actor X is exploiting CVE-2024-XXXX in the wild" → that CVE jumps to P1 even if CVSS is 7.5
- **Detection and monitoring** — IoCs become SIEM rules, TTPs become EDR behavior rules
- **Incident response** — during an active incident, intel tells you *who* you're fighting and *what they do next*
- **Risk management** — intel informs the threat side of the risk equation (likelihood, impact)
- **Security engineering** — intel drives architecture decisions (segmentation, zero trust, supply chain controls)

## SOC reality

- The intel feed dashboard fires 400 IoCs a day. Maybe 6 are relevant to your stack. The L1's job is filtering, not blocking everything that comes through the pipe.
- When a sector-mate gets hit, the ISAC channel lights up before the news does. *Read the ISAC channel before you read the news.*
- The CISO asks one question after a breach disclosure elsewhere: *"are we exposed to this?"* The answer needs to come in under an hour, with confidence levels attached. If you don't know your asset inventory, you can't answer it.
- Threat hunts have a hypothesis, a scope, a time-box, and a written outcome. "I poked around the SIEM for an hour" is not a hunt — it's screen-saver avoidance.
- Never tell leadership "this is definitely APT29." Attribution is the hardest problem in the field. Say *"the TTPs are consistent with reporting on APT29, confidence medium."* Adults respect hedged language; they distrust certainty.
- The handoff: L1 triages the IoC hit → L2 enriches with intel context (actor, campaign, severity) → IR lead decides scope/containment → threat intel team writes the post-incident actor profile update.

## Related concepts

[[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[Indicators of Compromise]] · [[Threat Hunting]] · [[SIEM]] · [[EDR]] · [[Incident Response Lifecycle]] · [[Vulnerability Management]] · [[Risk Management]] · [[STIX-TAXII]] · [[OSINT]] · [[Honeypots and Deception]]

*Source: VIRGIL knowledge base — 2026-05-11*