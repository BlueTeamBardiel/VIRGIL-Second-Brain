# Standards-Based Intelligence Sharing

## What it is

In **Factorio**, the moment your factory crosses from "I'm doing this by hand" to "this scales" is the moment you stop carrying iron plates in your pockets and start running them on belts with a known item size and a known throughput. The belt doesn't care what you're shipping — iron, copper, green circuits — it cares that the shape is standardized so an inserter at the other end can grab it without negotiation. Then you build train networks: stations have names, schedules read those names, fluid wagons only dock with fluid stations. Every piece of infrastructure agrees on the format. The day you try to bolt on a mod that uses a different fluid-type definition, the train sits at the station forever because nothing can parse what the wagon is carrying.

That's exactly what standards-based intelligence sharing does — it gives threat intel a belt size and a station name so machines on both ends can read it without a human translating.

Technically: **standards-based intelligence sharing** is the use of agreed-upon data formats and transport protocols to exchange [[Threat Intelligence]] between organizations, governments, ISACs, and vendor platforms. The dominant standards are **STIX** (the data format), **TAXII** (the transport), and **OpenIOC** (a legacy indicator format still seen in the wild). Without standards, intel arrives as a PDF that an analyst copy-pastes into the SIEM at 2am. With standards, the SIEM ingests it on a schedule and the [[SOAR]] platform starts blocking IPs before the analyst finishes their coffee.

## Why it matters

Threat intel without standards is gossip. A vendor emails you a Word doc of IoCs, your L1 analyst manually pastes 47 hashes into your EDR, three of them are malformed, two are typo'd, and the campaign moves on while you're still fixing the spreadsheet. Standards eliminate that friction.

CompTIA tests this directly under **Objective 1.4** (threat intelligence concepts) and adjacent to **1.5** (efficiency in security operations). Expect questions on:
- Which standard is the **format** vs the **transport** (STIX vs TAXII — guaranteed trap)
- TAXII's push vs pull collection models
- The role of [[ISAC|ISACs]] and CERTs in distributing STIX bundles
- Why automated sharing improves [[Mean Time to Detect|MTTD]] and supports [[Active Defense]]

Career-wise: if you join any SOC bigger than a small MSSP, you'll touch STIX/TAXII within your first month. Threat intel platforms — Anomali, ThreatConnect, MISP, OpenCTI — all speak it natively. Knowing the vocabulary is table stakes.

## Key facts

### STIX — Structured Threat Information Expression

STIX is the **data language**. Not transport. Not a feed. A schema.

Currently at **STIX 2.1**, JSON-based (STIX 1.x was XML, which is why old documentation looks different). It defines **STIX Domain Objects (SDOs)** and **STIX Relationship Objects (SROs)** — nouns and verbs.

| SDO | What it represents |
|---|---|
| `threat-actor` | The adversary (FIN7, APT29) |
| `intrusion-set` | A grouped campaign of related activity |
| `campaign` | Time-bounded operation by an actor |
| `malware` | Specific malware family |
| `tool` | Legitimate software abused (PsExec, Mimikatz) |
| `attack-pattern` | TTP, mapped to [[MITRE ATT&CK]] |
| `indicator` | Detection pattern (hash, IP, domain) with a confidence and a validity window |
| `observed-data` | Raw telemetry you actually saw |
| `vulnerability` | CVE reference |
| `course-of-action` | Recommended mitigation |
| `identity` | The victim, sector, or reporting org |

SROs glue them together: `relationship` (e.g., `malware --uses--> attack-pattern`) and `sighting` (you saw this indicator in your environment).

The win: STIX captures **context**, not just IoCs. An IP address by itself is noise. The same IP wrapped in a STIX bundle that says "indicator, used by APT29 campaign Cozy Bear, sighted by US-CERT, confidence high, valid until 2026-08-01, mitigation: block at egress" is intelligence.

### TAXII — Trusted Automated Exchange of Intelligence Information

TAXII is the **transport**. HTTPS at the application layer, RESTful API. It moves STIX bundles between producers and consumers.

Two collection models — CompTIA loves this distinction:

- **Collections** — pull model. Consumer requests data from a server. Like polling a mailbox.
- **Channels** — push/subscribe model. Producer broadcasts to subscribers. Defined in TAXII 2.0 but **deprecated/optional in TAXII 2.1**; most real-world deployments are Collections-only.

TAXII servers expose **API Roots** (the URL path for a group of collections) and require authentication (typically API key or basic auth over TLS). You point your TIP at the API root, authenticate, and start pulling.

> **CompTIA exam trap:** STIX is the **format**, TAXII is the **transport**. The question will phrase it as "Which standard describes the structured representation of threat data?" (STIX) vs "Which protocol is used to exchange threat data between systems?" (TAXII). They are not interchangeable. Memorize: **S**TIX = **S**tructure, **T**AXII = **T**ransport.

### OpenIOC

Legacy. XML-based, originally from Mandiant (now part of Trellix). Focused narrowly on **host-based indicators** — file hashes, registry keys, mutex names, process artifacts.

Still seen because Mandiant reports historically published OpenIOC alongside PDFs, and some forensic tools (Redline, IOC Editor) consumed it natively. Modern pipelines convert OpenIOC → STIX on ingest. Know the name, know it's older, know it's narrower in scope than STIX.

### Other formats you'll see in the wild

- **MISP format** — JSON used by the open-source MISP platform. Translates to/from STIX.
- **YARA** — pattern-matching rules for malware identification. Not a sharing standard per se, but YARA rules are shared inside STIX `indicator` objects.
- **Sigma** — generic SIEM detection rule format. Converts to Splunk SPL, Elastic queries, etc.
- **CybOX** — was the observables sub-standard in STIX 1.x; folded into STIX 2.x as `observed-data`.

### Who produces and consumes this stuff

| Source | What they ship |
|---|---|
| **US-CERT / CISA** | Government bulletins, automated indicator sharing (AIS) via TAXII |
| **ISACs** (FS-ISAC, H-ISAC, E-ISAC, MS-ISAC) | Sector-specific intel; STIX/TAXII feeds for members |
| **MITRE** | ATT&CK as STIX 2.1 (downloadable bundle) |
| **Commercial feeds** | Recorded Future, Mandiant, CrowdStrike — premium STIX collections |
| **Open source** | AlienVault OTX, abuse.ch (URLhaus, MalwareBazaar), MISP communities |
| **Internal** | Your own SOC's confirmed IoCs, shipped to peers via TAXII |

> **CompTIA exam trap:** The exam distinguishes **open source** intel (free, public — OTX, abuse.ch, government bulletins) from **closed source / proprietary / paid feeds** (Mandiant, Recorded Future). Both can be STIX-formatted. The format is independent of the cost model. Don't conflate "open source intel" with "open standard."

### Confidence, timeliness, relevancy, accuracy

STIX bakes intel quality directly into the schema. Every `indicator` carries:

- **Confidence** — 0–100 score (or `none/low/med/high/very-high`). How sure is the producer?
- **Valid_from / valid_until** — timeliness. An IoC that was hot in March is noise by November.
- **Labels and kill-chain phases** — relevancy filtering.
- **Created_by_ref** — provenance for accuracy assessment.

These four (confidence, timeliness, relevancy, accuracy) are the canonical CySA+ criteria for evaluating intel sources. STIX is the standard that makes them queryable instead of vibes.

### Automation — why this exists at all

A SOC analyst manually triaging 10,000 IoCs/day from email PDFs is a SOC analyst quitting in six months. Standards-based sharing enables:

- **Auto-ingest** — TAXII client pulls collection every 15 minutes
- **Auto-enrichment** — STIX context (actor, campaign, TTP) attaches to alerts in the SIEM
- **Auto-blocking** — high-confidence indicators push to firewall/EDR/DNS sinkhole via SOAR playbook
- **Auto-expiry** — `valid_until` field retires stale indicators so your blocklist doesn't grow to a million dead IPs
- **Auto-sighting** — when your SIEM matches an indicator, it pushes a `sighting` back upstream so the producer knows their intel landed

> **CompTIA exam trap:** Automation is the *point* of standards. If a question asks why STIX/TAXII matter over emailed PDFs, the answer is some flavor of "machine-readable enables automation, consistency, and scale." Not "they're more secure" — TLS handles that. Not "they're free" — they're not always.

### Information sharing organizations

- **ISAC** — Information Sharing and Analysis Center. Sector-aligned (FS-ISAC for finance, H-ISAC for health). Membership-based.
- **ISAO** — Information Sharing and Analysis Organization. Broader, not sector-locked. Created under a 2015 US executive order.
- **CERT / CSIRT** — Computer Emergency Response Team / Computer Security Incident Response Team. National-level (US-CERT, CERT-EU) or organizational. CERTs publish bulletins; many ship STIX.
- **CISA AIS** — Automated Indicator Sharing program. Free TAXII feed from the US government for participating organizations.

## SOC reality

- At 9am your TIP (threat intelligence platform) shows 1,247 new indicators ingested overnight from six TAXII collections. You don't read them. You let SOAR auto-block anything with confidence ≥ 85 and `valid_until` > 7 days, and you spot-check the rejections.
- An L2 sees a SIEM alert correlate against a STIX indicator tagged `intrusion-set: APT29`. The escalation isn't "we have a hash hit" — it's "we have a hash hit attributed to a nation-state actor with this confidence from this source." The STIX context changes the IR posture in one sentence.
- The IR lead asks: "Where did this intel come from, when was it published, what's the confidence, and have we shared our sighting back?" If you can't answer all four in 30 seconds, your TIP isn't configured right.
- The CISO asks why you're paying $180k/year for a commercial feed when CISA AIS is free. Real answer: paid feeds publish faster, with higher confidence and richer context. AIS is a floor, not a ceiling.
- Never promise leadership "we're blocking everything from the feed." High-confidence IoCs auto-block. Medium goes to watchlist. Low goes to enrichment. If you auto-blocked everything, you'd null-route Cloudflare by Tuesday.

## Related concepts

[[Threat Intelligence]] · [[Indicators of Compromise (IoC)]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[SOAR]] · [[SIEM]] · [[Threat Hunting]] · [[Active Defense]] · [[ISAC]] · [[CSIRT]] · [[Open Source Intelligence (OSINT)]] · [[Confidence Levels]] · [[YARA Rules]] · [[Sigma Rules]] · [[Threat Feeds]]

*Source: VIRGIL knowledge base — 2026-05-11*