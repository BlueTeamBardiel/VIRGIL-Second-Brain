# STIX — Structured Threat Information Expression

## What it is

In **Persona 5**, when the Phantom Thieves study a Palace before infiltration, they don't just say "the target is bad." They build a dossier: the ruler's distortion, the cognitive Shadows, the Treasure, the safe rooms, the security level meter, the route the Shadows patrol. Everything goes on the board in the Leblanc attic — structured, shared, so Makoto can plan, Futaba can hack, and Joker can call the shot. If Futaba tried to relay intel by yelling vibes through the comms, the run dies on the first ambush.

That's exactly what **STIX** does — it's the structured language threat intel teams use so "the target is bad" becomes machine-readable evidence everyone can act on.

**Technical definition:** STIX (Structured Threat Information Expression) is an open-standard JSON-based language, maintained by OASIS, for representing **cyber threat intelligence (CTI)**. It defines a fixed set of objects — threat actors, malware, indicators, campaigns, attack patterns, TTPs — and the relationships between them. STIX is the *content*. Its transport partner [[TAXII]] is the *delivery mechanism*. Together they let organizations share intel between SIEMs, TIPs, and ISACs without anyone parsing a PDF by hand.

## Why it matters

Threat intel without structure is a Slack channel full of screenshots. Structure is what lets a SOC at 3am pull an IoC from a feed, match it against [[SIEM]] logs, attribute it to an actor, and pivot to related indicators — in seconds, not hours.

CompTIA tests STIX under **Objective 1.4** (threat intelligence and threat hunting). Expect questions on:

- What STIX is vs what TAXII does (content vs transport — they always pair them)
- STIX object types (SDOs, SROs, SCOs)
- Why structured sharing beats unstructured (machine-readable, automatable, deduplicates)
- How it fits into the [[intelligence cycle]] — specifically the **dissemination** phase

Career-wise: every mature SOC, every ISAC, every government bulletin feed (CISA, US-CERT, sector ISACs) speaks STIX. If you're going to be a CTI analyst, threat hunter, or detection engineer, you will read and write STIX objects. It's not optional.

## Key facts

### The STIX object model

STIX 2.1 (current version) defines three flavors of objects:

| Object class | What it is | Examples |
|---|---|---|
| **STIX Domain Objects (SDOs)** | The "nouns" — high-level threat concepts | Threat Actor, Malware, Campaign, Indicator, Attack Pattern, Intrusion Set, Tool, Vulnerability, Identity, Report, Course of Action |
| **STIX Cyber-observable Objects (SCOs)** | Raw technical artifacts | IPv4 Address, Domain Name, File (with hashes), URL, Email Address, Process, Windows Registry Key |
| **STIX Relationship Objects (SROs)** | The "verbs" — links between SDOs/SCOs | `uses`, `targets`, `attributed-to`, `indicates`, `mitigates`, `variant-of` |

Every object has an `id` (UUID), a `created` timestamp, a `modified` timestamp, and a `spec_version`. Everything is JSON. Everything is signable.

### A concrete example

```json
{
  "type": "indicator",
  "spec_version": "2.1",
  "id": "indicator--a932fcc6-...",
  "created": "2026-05-11T14:22:00Z",
  "pattern": "[file:hashes.'SHA-256' = 'aec070...']",
  "pattern_type": "stix",
  "valid_from": "2026-05-11T14:22:00Z",
  "indicator_types": ["malicious-activity"],
  "confidence": 85
}
```

That's a single [[indicator of compromise|IoC]] — a file hash — with a confidence score and a validity window. Pair it with a `malware` SDO and a `relationship` SRO that says `indicates`, and now you've told a story a machine can act on.

### What STIX actually represents

STIX is designed to carry the full picture, not just the IoC at the bottom:

- **Who** — Threat Actor SDO (name, aliases, sophistication, motivation — financial, ideological, [[nation-state]], [[hacktivist]], [[organized crime]], [[insider threat]])
- **What they use** — Malware, Tool, Attack Pattern (often linked to [[MITRE ATT&CK]] technique IDs)
- **How they operate** — TTPs (tactics, techniques, procedures) via Attack Pattern objects
- **Who they target** — Identity SDO + `targets` relationship (sectors, regions, [[business-critical assets]])
- **What to look for** — Indicator SDO with a STIX pattern matching observables
- **What to do about it** — Course of Action SDO (the remediation recommendation)
- **Provenance** — created_by_ref, confidence, granular markings (TLP)

### STIX patterns — the query language inside the language

Indicator objects carry a `pattern` field written in STIX Patterning syntax. It looks like a SQL/regex hybrid:

```
[file:hashes.MD5 = 'd41d8cd98f00b204e9800998ecf8427e' AND file:size = 0]
[network-traffic:dst_ref.value = '192.0.2.1' AND network-traffic:dst_port = 4444]
```

This matters because the pattern is what your SIEM, EDR, or TIP actually executes. A well-formed pattern is detection logic. A sloppy pattern is a [[false positive]] generator.

### STIX vs TAXII — don't confuse them

> **CompTIA exam trap:** STIX is the **format**, TAXII is the **transport**. STIX is the language you write the intel in (JSON objects). [[TAXII]] (Trusted Automated Exchange of Intelligence Information) is the HTTPS-based protocol that moves STIX bundles between servers and clients via collections and channels. If a question asks what carries STIX over the network — the answer is TAXII. If a question asks what structures the threat data itself — the answer is STIX. They are *always* taught together but they are not the same thing.

### Confidence, TLP, and the trust problem

STIX includes mechanisms for the things that actually make intel usable:

- **Confidence** — integer 0–100 on most SDOs. Tells you how sure the producer is.
- **TLP (Traffic Light Protocol)** — markings on objects: TLP:CLEAR, TLP:GREEN, TLP:AMBER, TLP:RED. Controls who you're allowed to share it with downstream.
- **Granular markings** — different fields in the same object can carry different TLPs.

This is the part juniors skip and seniors live by. *An IoC marked TLP:RED that you forwarded to your vendor portal is a career-ending mistake — read the markings before you click share.*

### Where STIX fits in the intelligence cycle

The [[intelligence cycle]] runs: Requirements → Collection → Processing → Analysis → Dissemination → Feedback. STIX lives primarily in **Processing** (normalizing raw feeds into structured objects) and **Dissemination** (publishing to consumers via TAXII).

Sources STIX commonly carries:
- **[[Open source]] intel (OSINT)** — public feeds, [[blogs and forums]], [[social media]] scrapes
- **[[Closed source]] / paid feeds** — Mandiant, Recorded Future, CrowdStrike Falcon Intel
- **Government bulletins** — CISA AIS (Automated Indicator Sharing), US-CERT, sector ISACs (FS-ISAC for finance, H-ISAC for healthcare)
- **Internal sources** — your own [[honeypot]] hits, [[CSIRT]] post-incident artifacts, [[deep/dark web]] monitoring

### Information sharing organizations

STIX is the lingua franca for:

- **ISACs/ISAOs** — sector-specific sharing communities
- **CISA AIS** — the US federal automated sharing program, STIX/TAXII native
- **CERTs/[[CSIRT]]s** — Computer Security Incident Response Teams publishing bulletins
- **Bilateral trust groups** — closed circles of vetted analysts

### The five qualities of usable intel

CompTIA loves these. STIX supports all of them but doesn't guarantee them:

| Quality | What it means | STIX feature that supports it |
|---|---|---|
| **Timeliness** | Fresh enough to act on | `valid_from`, `valid_until` |
| **Relevancy** | Matches your environment | Identity targeting, sector tagging |
| **Accuracy** | The data is correct | `confidence`, producer reputation |
| **Confidence level** | How sure the producer is | `confidence` field (0–100) |
| **Actionability** | You can do something with it | Course of Action SDO, machine-readable patterns |

> **CompTIA exam trap:** A high-confidence indicator from six months ago is **stale**, not actionable. Timeliness and confidence are independent dimensions. CompTIA will give you a scenario where the data is highly accurate but expired and ask why it's not useful — the answer is timeliness, not accuracy.

### What STIX is *not*

- Not a tool. It's a specification. Tools (MISP, OpenCTI, Anomali ThreatStream, ThreatConnect) *consume and produce* STIX.
- Not encryption. TAXII rides HTTPS for transport security; STIX content itself is plaintext JSON.
- Not attribution. STIX can *represent* attribution claims, but a Threat Actor SDO is only as good as the analyst who wrote it.
- Not a replacement for analysis. Structured data still needs an analyst to interpret it. *A TIP full of STIX objects nobody reads is just an expensive database.*

## SOC reality

- **The L1 reality:** You don't write STIX from scratch. Your [[TIP]] (Threat Intelligence Platform) ingests STIX bundles from a dozen TAXII feeds, deduplicates, scores, and pushes IoCs into the [[SIEM]] and EDR as detection rules. Your job is to triage what fires.
- **The 3am alert:** SIEM throws "IoC match — STIX indicator id `indicator--a932...`, confidence 85, source CISA AIS, attributed to APT29." You don't celebrate. You check the indicator's `valid_from`, the source's track record, and whether your asset matches the targeting. *A confidence-85 STIX indicator from a feed your org doesn't trust is still a false positive in waiting.*
- **What the IR lead asks:** "What's the provenance? Who published it, what's the TLP, can we share the hit back upstream?" If you can't answer in 60 seconds, your TIP is misconfigured.
- **What you never promise leadership:** "We're protected from APT29 because we ingest the feed." Ingestion is not coverage. Coverage means the indicator actually fires against your telemetry and you have a playbook when it does.
- **Escalation:** L1 confirms the match isn't tuning noise → L2 enriches with the full STIX bundle (related malware, attack patterns, courses of action) → IR team scopes blast radius → CTI analyst writes a new internal STIX object capturing what *you* saw and pushes it back to the ISAC. The loop closes. That's how herd immunity works.

## Related concepts

[[TAXII]] · [[Threat intelligence]] · [[Intelligence cycle]] · [[Indicators of compromise]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[TIP]] · [[SIEM]] · [[OSINT]] · [[ISAC]] · [[CSIRT]] · [[CERT]] · [[TLP]] · [[Threat hunting]] · [[Threat actors]] · [[APT]] · [[Honeypot]] · [[Active defense]]

*Source: VIRGIL knowledge base — 2026-05-11*