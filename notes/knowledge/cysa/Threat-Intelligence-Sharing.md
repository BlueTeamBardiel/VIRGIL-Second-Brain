# Threat Intelligence Sharing

## What it is

In **Subnautica**, your PDA has a database of every leviathan, every wreck, every fragment scan — but only because previous Aurora crew, Degasi survivors, and Sunbeam transmissions seeded it. When you scan a Reaper jaw fragment, the entry doesn't say "unknown sea monster, good luck" — it tells you the Reaper's roar frequency, its territory, and that it will eat your Seamoth. That intel didn't come from you. It came from the dead people who logged it first. You're alive because someone else got eaten and wrote it down. That's exactly what threat intelligence sharing does — one organization gets hit, documents the indicators, and pushes them out so the next target sees the Reaper coming before it bites.

**Threat intelligence sharing** is the structured exchange of cyber threat data — indicators of compromise, tactics/techniques/procedures, threat actor profiles, vulnerability context — between organizations, sectors, and governments, so that one victim's incident becomes the rest of the community's early warning. It is one of the few defensive disciplines where altruism is also self-interest: the more you share, the more the community can detect the attacker pivoting to you next.

## Why it matters

Threat actors share. The ransomware affiliates rent kits, swap creds on the dark web, and trade exploit code on closed forums. Defenders who don't share are fighting solo against a coordinated supply chain. Sharing flips the asymmetry: the adversary has to burn a new TTP every time the old one gets published, which raises their cost and shortens their dwell time.

For the exam, this lives in **CS0-003 Objective 1.4** — collection sources, sharing communities, and the supported security functions (incident response, vulnerability management, detection and monitoring, security engineering, risk management). CompTIA tests whether you know *which sharing source feeds which function* and *what makes intel actually useful* (the three-attribute test: timely, relevant, accurate).

In the field, it matters because the alert you don't have a signature for is the one that owns you for 90 days. ISAC feeds are how mid-size shops without a 50-person threat intel team stay current.

## Key facts

### What sharing actually supports

| Security function | How shared intel feeds it |
|---|---|
| **Incident response** | IoCs from peer breaches accelerate scoping — "is this hash in our environment?" |
| **Vulnerability management** | Exploited-in-the-wild signal prioritizes which CVEs jump the queue (CISA KEV is the canonical example) |
| **Detection and monitoring** | New IoCs become SIEM correlation rules and EDR detections within hours |
| **Security engineering** | Architectural lessons — "this sector got hit through exposed RDP" reshapes the firewall posture |
| **Risk management** | Sector-specific threat data feeds the risk register and justifies budget |

### Sharing communities and sources

**ISACs (Information Sharing and Analysis Centers)** — sector-specific. FS-ISAC (financial), H-ISAC (health), E-ISAC (electricity), Auto-ISAC, MS-ISAC (state/local government). Membership-based. The intel is curated, sector-relevant, and often comes with TLP markings (Traffic Light Protocol — RED/AMBER/GREEN/CLEAR controls redistribution).

**ISAOs (Information Sharing and Analysis Organizations)** — broader than ISACs. Created by US Executive Order 13691 to let non-sector groups share without forming a formal ISAC. Think regional coalitions, supply chain groups.

**Government bulletins** — CISA advisories, FBI Flash reports, NSA cybersecurity advisories, US-CERT alerts, NCSC (UK) advisories. Free, authoritative, often slow because they go through review.

**CERTs / CSIRTs** — Computer Emergency Response Teams and Computer Security Incident Response Teams. National CERTs (US-CERT, JPCERT, AusCERT) publish advisories; private-sector CSIRTs share within trust groups.

**Open source (OSINT)** — security vendor blogs, researcher Twitter/Mastodon, GitHub IoC repos, abuse.ch (URLhaus, MalwareBazaar, ThreatFox), AlienVault OTX. Free, fast, variable quality.

**Closed source / paid feeds** — Mandiant, Recorded Future, CrowdStrike, Flashpoint, Intel 471. Higher fidelity, attribution, dark-web access, finished intelligence reports. Expensive — five to seven figures a year.

**Deep/dark web sources** — paste sites, criminal forums, Telegram channels, leak sites. Either you hire a vendor with access or you build burner personas and accept the legal/operational risk.

**Social media, blogs, forums** — InfoSec Twitter is still where zero-day chatter breaks first. Reddit r/netsec, Mastodon infosec.exchange, vendor blogs. Treat as raw signal — requires analyst triage.

**Internal sources** — your own SIEM, EDR telemetry, honeypot logs, past incident reports. The most relevant intel you have, and the one most teams undervalue.

### The three-attribute test for useful intel

CompTIA hammers this. Intel is only worth ingesting if it passes:

- **Timeliness** — does it arrive before the attack hits you, or three weeks after? A C2 IP shared 30 days post-compromise is archaeology, not defense.
- **Relevancy** — does the threat actor target your sector, your tech stack, your geography? FS-ISAC intel about SWIFT fraud is gold for a bank, noise for a hospital.
- **Accuracy** — is the indicator confirmed, or is it a half-baked rumor that'll fill your blocklist with false positives and break production?

Add a fourth in practice: **confidence level**. Most feeds tag entries with high/medium/low confidence. Auto-block on high; alert-only on medium; ignore or hunt manually on low.

### Threat actors you'll see in shared intel

| Actor type | What sharing tells you about them |
|---|---|
| **Nation-state / APT** | Long campaigns, sector targeting, TTPs mapped to ATT&CK groups (APT29, Lazarus, etc.) |
| **Organized crime** | Ransomware affiliates, BEC crews, financially motivated, share infrastructure across victims |
| **Hacktivists** | Issue-driven, often noisy, DDoS and defacement, telegraphed on social media |
| **Insider threat (intentional)** | Rare in shared feeds — mostly internal indicators; sector ISACs share behavioral patterns |
| **Insider threat (unintentional)** | Phishing victims, misconfigurations — feeds share the lure, not the user |
| **Script kiddies** | Mass-scan signatures, exploit-of-the-week — abuse.ch and honeypot feeds cover this |
| **Supply chain** | Third-party compromise indicators — SolarWinds-style. ISACs and CISA lead here |

### Formats and protocols

- **STIX** (Structured Threat Information eXpression) — the data format. Objects: indicator, malware, threat-actor, campaign, attack-pattern.
- **TAXII** (Trusted Automated eXchange of Intelligence Information) — the transport. Pull/push between TAXII servers and clients.
- **MISP** (Malware Information Sharing Platform) — open-source platform many ISACs run on. Free, federates with peers.
- **OpenIOC, YARA, Sigma** — IoC and detection-rule formats that travel inside shared feeds.

If you see STIX/TAXII on the exam, the pair is the answer for "automated structured sharing."

### Where sharing supports active defense

**Active defense** is the cluster of techniques that go beyond passive blocking — honeypots, honeynets, deception grids, sinkholes, beacon-back. Shared intel feeds these: a peer's malware sample becomes your honeypot lure; a peer's C2 domain becomes your DNS sinkhole. Isolated networks (air-gapped OT, classified enclaves) still benefit — intel gets one-way diode'd in and shapes detection without exposing the segment.

### CompTIA exam traps

> **CompTIA exam trap:** *ISAC vs CERT vs CSIRT.* ISAC = sector-specific sharing community (FS-ISAC, H-ISAC). CERT = the team that responds to incidents and publishes advisories (US-CERT, national CERTs). CSIRT = an organization's internal incident response team. CompTIA will hand you a scenario about "sector peers sharing ransomware IoCs" — that's ISAC, not CERT. They will also hand you "national-level advisory" — that's CERT/CISA.

> **CompTIA exam trap:** *Timeliness vs relevancy vs accuracy.* When the question describes intel that's "fast and confirmed but for a different sector," the failing attribute is **relevancy**, not timeliness. Read the scenario for which of the three is broken.

> **CompTIA exam trap:** *Open source ≠ free and good.* OSINT is free; it is not curated. The exam likes to contrast OSINT (fast, noisy, unverified) with closed/paid feeds (slower, verified, attributed). "Highest fidelity" answers point to paid/closed; "fastest signal on emerging threat" can point to either depending on the scenario.

> **CompTIA exam trap:** *STIX is the format, TAXII is the transport.* They are not interchangeable. If the question asks how intel is *structured*, it's STIX. How it's *exchanged*, it's TAXII.

### Inhibitors to sharing

Real organizations don't share as much as they should because:

- **Legal counsel** — fear of liability, regulatory exposure, antitrust concerns (DHS PCII protections and CISA 2015 exist partly to fix this)
- **Competitive concern** — "if we admit we got breached, our competitors win"
- **Attribution risk** — exposing your detection capability tells the adversary what you can see
- **Lack of process** — no one's job to read the feed, no automation to ingest it
- **Confidence/quality** — burned once on a bad indicator, the team stops trusting the feed

These are CS0-003 inhibitors-to-remediation cousins. Know them.

## SOC reality

- The L1 morning routine includes scrolling the ISAC daily digest and CISA alerts before touching the queue. If there's a sector-relevant IoC drop, it goes into a hunt query against the last 30 days of logs before lunch.
- **The 3am alert that names a known APT group is almost always a feed hit, not novel detection** — your EDR matched a hash from yesterday's Mandiant report. The L1 confirms the hash, scopes the host, checks for lateral movement, and escalates to L2 with the threat actor profile already attached. That profile came from sharing.
- The CISO asks one question after a peer-sector breach hits the news: *"are we seeing any of those indicators?"* If you don't have an ISAC subscription or a TAXII feed, your answer is "give us 48 hours to manually check," which is the wrong answer.
- *Never promise leadership that a shared IoC list is comprehensive.* It's a floor, not a ceiling — the attacker may have already rotated infrastructure by the time the indicator was published. Hunt for behavior, not just hashes.
- The handoff: L1 ingests and triages feed hits → L2 enriches and hunts → threat intel analyst (if you have one) curates what gets ingested and what gets published back to the ISAC. Mature shops *contribute* to the feed, not just consume it. *That's the maturity tell — if your shop only consumes, the program is half-built.*

## Related concepts

[[Threat Intelligence]] · [[Indicators of Compromise]] · [[Threat Hunting]] · [[STIX-TAXII]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[ISACs]] · [[CISA KEV]] · [[OSINT]] · [[Honeypot]] · [[Active Defense]] · [[Advanced Persistent Threat]] · [[Supply Chain Attack]] · [[Traffic Light Protocol]] · [[Incident Response]] · [[Vulnerability Management]]

*Source: VIRGIL knowledge base — 2026-05-11*