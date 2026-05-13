# Open Source Intelligence (OSINT)

## What it is

In **Need for Speed: Most Wanted**, before you challenge a Blacklist rival you study the Heat dossier — what car they drive, which routes they favor, which cops chase hardest in their zone, the scanner chatter from prior pursuits, the in-world rumor mill. None of that is classified. It's the radio, the speed traps, the rap sheet, the gossip in the parking lot at Rockport. You assemble it before the race because going in blind is how you eat a roadblock at 180 mph. **That's exactly what OSINT does** — it's the public-source dossier you build on a threat actor before they hit you, so when they do hit you, you already know how they drive.

**Open Source Intelligence (OSINT)** is threat intelligence collected from publicly available sources — government advisories, vendor blogs, social media, forums, code repos, the dark web, news, leaked dumps, search engines — and processed into actionable signal. No subscription, no NDA, no clearance. The cost is analyst time and the discipline to separate signal from noise.

CS0-003 puts OSINT under collection methods and sources alongside **closed source** (paid feeds, ISAC-restricted intel) and **proprietary** (your own internal telemetry). OSINT is the cheapest and the noisiest of the three.

## Why it matters

Every SOC runs on OSINT whether they admit it or not. The CISA advisory you read with morning coffee, the Mandiant blog your hunt team forwarded, the Twitter thread where a researcher dropped IoCs for a fresh CVE four hours before the vendor advisory — all OSINT. A team that ignores it is a team that learns about the breach from a journalist.

For the exam: **Objective 1.4** asks you to compare threat-intelligence sources, evaluate them on **timeliness, relevancy, accuracy, and confidence**, and know which actor types (nation-state, organized crime, hacktivist, insider, script kiddie) show up in which feeds. OSINT is the source you'll be asked about the most because it's where most SOC analysts actually live.

For the career: writing a clean OSINT-driven threat brief is the single fastest way for a junior analyst to get noticed. Anyone can forward a CISA alert. Few can read it, correlate it to internal telemetry, and tell the IR lead *"we should hunt for this hash on the finance subnet by EOD."*

## Key facts

### The OSINT source landscape

| Source type | What you get | Timeliness | Accuracy | Watch out for |
|---|---|---|---|---|
| **Government bulletins** (CISA, US-CERT, NCSC, ACSC) | Validated IoCs, TTPs, mitigations, attributed campaigns | Hours to days | High | Lags the actual attack wave |
| **CERT / CSIRT advisories** | Sector-specific incident detail | Days | High | Often anonymized — hard to map to your environment |
| **Vendor blogs** (Mandiant, CrowdStrike, Talos, Unit 42, Microsoft MSTIC) | Deep technical writeups, malware analysis, attribution | Days to weeks | High | Marketing-flavored; vendor wants you to buy something |
| **Social media** (X, Mastodon, LinkedIn) | Breaking IoCs from researchers | Minutes | Mixed | Hoaxes, hype, half-IoCs without context |
| **Blogs / forums** (Reddit r/netsec, personal researcher blogs) | Technical deep-dives, PoC code | Days | Mixed | PoC code may be weaponized |
| **GitHub / code repos** | Leaked credentials, exposed configs, exploit PoCs | Real-time | High for raw data | Legality of scraping varies |
| **Deep / dark web** (forums, marketplaces, leak sites) | Ransomware victim lists, credential dumps, initial-access broker listings | Real-time to days | Mixed | Requires safe-handling tradecraft; some content is illegal to possess |
| **News media** | Breach disclosures, geopolitical context | Hours | Low-to-mixed | Journalists get details wrong constantly |
| **Search engines** (Shodan, Censys, FOFA) | Internet-exposed assets, banner data | Real-time | High | Includes your own exposed assets — check yourself first |

### CompTIA's evaluation criteria — the four dials

Every intel source gets rated on these. Memorize them.

- **Timeliness** — how fresh is it? An IoC for a campaign that ended six months ago is archaeology, not intel.
- **Relevancy** — does it apply to your environment? A SCADA-targeting campaign means nothing to a SaaS company with no OT.
- **Accuracy** — is it correct? False IoCs burn analyst hours and erode trust in the feed.
- **Confidence level** — how sure is the source? Mature intel uses **Admiralty Code** or similar (A1 = reliable source + confirmed info; F6 = unreliable + cannot judge).

### Threat actor types you'll see in OSINT

| Actor | Motivation | OSINT footprint |
|---|---|---|
| **Nation-state / APT** | Espionage, sabotage, geopolitical | Heavy — government bulletins, vendor reports name them (APT29, Lazarus, Volt Typhoon) |
| **Organized crime** | Financial — ransomware, BEC, fraud | Heavy — leak sites, dark web forums, ransomware tracker feeds |
| **Hacktivist** | Ideology, attention | Loud on social media — they *want* to be seen |
| **Insider** (intentional / unintentional) | Grievance, greed, accident | Minimal — by definition, insiders don't post on dark web forums first |
| **Script kiddie** | Clout, boredom | Discord, Telegram, low-tier forums, public exploit reuse |

*Insiders barely show up in OSINT. That's why internal telemetry — UEBA, DLP, access logs — exists. OSINT is for outside threats; your SIEM is for the threat already inside.*

### The OSINT intelligence cycle

1. **Planning & direction** — what are we trying to learn? "Threats to Q2 cloud migration" beats "threats in general."
2. **Collection** — pull from the sources above, automate where possible (RSS, API, TAXII/STIX for structured feeds).
3. **Processing** — deduplicate, normalize formats, tag with MITRE ATT&CK techniques.
4. **Analysis** — correlate against internal telemetry, business-critical assets, known exposure.
5. **Dissemination** — brief the SOC, feed IoCs into SIEM/EDR, file the threat note.
6. **Feedback** — did the intel matter? Tune the sources that produce signal, drop the ones that produce noise.

### OSINT feeds the rest of the stack

- **Vulnerability management** — CISA KEV catalog tells you which CVEs are being actively exploited *right now*. Prioritize those over CVSS-10s with no in-the-wild activity.
- **Threat hunting** — fresh TTPs from a vendor writeup become this week's hunt hypothesis. ("APT29 is using OAuth device-code phishing — let's hunt our M365 auth logs for it.")
- **Detection engineering** — OSINT IoCs become SIEM correlation rules and EDR custom indicators.
- **Incident response** — during an active incident, OSINT tells you if the TTPs match a known actor, which tells you what they'll do next.
- **Active defense / honeypots** — OSINT on attacker tooling tells you what to bait the honeypot with.
- **Supply chain** — vendor breach disclosures (OSINT) tell you which of your suppliers just became a risk vector.

### CompTIA exam traps

> **CompTIA exam trap:** **OSINT vs closed-source vs proprietary.** OSINT = free and public. Closed-source = paid commercial feeds (Recorded Future, Mandiant Advantage, Flashpoint) or restricted-sharing communities (ISACs). Proprietary = your *own* internal telemetry and incident history. CompTIA will offer "internal SIEM logs" as an OSINT answer — wrong. Those are proprietary.

> **CompTIA exam trap:** **Government bulletins are OSINT.** CISA, US-CERT, NCSC — all free, all public, all OSINT. Candidates sometimes assume "government source = classified = closed." Wrong. If you can read it without a clearance or a contract, it's open source.

> **CompTIA exam trap:** **Dark web ≠ deep web.** Deep web is anything not indexed by search engines — your bank portal, a private SharePoint. Dark web is the Tor/I2P subset requiring special tooling. CompTIA tests the distinction. Most "dark web monitoring" services actually scrape both.

> **CompTIA exam trap:** **STIX/TAXII is the format, not the source.** STIX is the structured-data language; TAXII is the transport protocol. They can carry OSINT *or* closed-source intel. Don't confuse "structured" with "open."

> **CompTIA exam trap:** **Timeliness vs accuracy tradeoff.** Social media wins on timeliness, loses on accuracy. Government bulletins are the reverse. CompTIA loves scenarios that force you to pick which dial matters more for the situation — for an active campaign hitting your sector right now, timeliness wins. For your annual risk report, accuracy wins.

### OSINT tradecraft — the boring stuff that keeps you employed

- **Never pivot from your corporate IP** when researching threat-actor infrastructure. Use a dedicated VM, separate network, attribution-managed browser. Some actors fingerprint who's looking at their C2.
- **Don't download malware samples to your workstation.** Detonate in a sandbox you control or pull hashes only.
- **Legal review before dark-web work.** Possession of certain leaked data (PII, CSAM, classified material) is illegal even for defenders. Run it past counsel before you build a dark-web monitoring program.
- **Cite your sources in the threat note.** When the IR lead asks "where did this IoC come from," "some tweet" is not an answer. URL, timestamp, author, confidence level.

## SOC reality

- **The morning OSINT triage** — most SOCs have a 30-minute analyst slot to scan CISA, vendor blogs, and curated feeds, then flag anything sector-relevant to the hunt team. If you're the L1 doing this rotation, your deliverable is a 3-bullet Slack post, not an essay.
- **What the alert looks like:** an automated TIP (threat intel platform) ingests an OSINT feed, matches a freshly-published IoC against last week's proxy logs, and fires a retroactive hit. The ticket reads "*historical match: IP 185.x.x.x contacted by HOST-FIN-04 on 2026-05-03, IoC published 2026-05-10 by Mandiant.*" That's a hunt, not an incident — yet.
- **What the IR lead asks:** "Source? Confidence? Does it match anything in our environment in the last 90 days? Is the IoC still live or is the C2 dead?" You answer in that order or you get sent back to answer in that order.
- **Never promise leadership** that an OSINT-sourced attribution is correct. "Vendor X assesses with moderate confidence that this is APT-Y" is not "APT-Y attacked us." Attribution is hard, public attribution is harder, and the C-suite will quote you in a board deck if you let them.
- **The handoff:** L1 ingests and tags → L2 correlates against internal telemetry → threat-hunt or detection-engineering team productionizes the IoC → IR team owns it if it lights up. Every step gets logged in the TIP.

## Related concepts

[[Threat Intelligence]] · [[Closed-Source Intelligence]] · [[STIX TAXII]] · [[Threat Hunting]] · [[Indicators of Compromise IoC]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[CISA KEV Catalog]] · [[ISAC Information Sharing]] · [[Threat Actors]] · [[Advanced Persistent Threat APT]] · [[Dark Web Monitoring]] · [[Honeypot]] · [[Active Defense]] · [[Vulnerability Management]] · [[Supply Chain Risk]]

*Source: VIRGIL knowledge base — 2026-05-11*