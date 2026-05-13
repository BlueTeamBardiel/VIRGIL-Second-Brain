# Proprietary / Closed Source Intelligence

## What it is

In **Cyberpunk 2077**, when V needs the good intel — not the rumor-mill chatter spilling out of the Afterlife bar, but the actual schematics, the patrol rotations, the netrunner countermeasures wired into an Arasaka black site — V doesn't crowdsource it. V pays a fixer. Dexter DeShawn, Rogue Amendiares, Mr. Hands in Dogtown — each one charges eddies, each one has sources you don't get to see, and each one gives you a tighter, sharper, more current picture than any open broadcast could. The catch: you signed a deal. You can't post the floor plan on the NCPD bulletin board. You don't get to know where Rogue got the patrol schedule. And if you stop paying, the feed stops cold.

That's proprietary threat intelligence. Plain English: it's the paid, contractual feed of adversary information bought from a vendor or shared inside a closed group, where you trade money and silence for higher fidelity than the open internet gives you.

Technical definition for CS0-003: **proprietary (closed source) threat intelligence** is curated adversary data — IoCs, TTPs, malware samples, infrastructure attribution, victimology — produced by commercial vendors, government partners, or sector-specific sharing groups, distributed under license or membership agreement that constrains redistribution and disclosure. Distinguished from [[Open Source Intelligence (OSINT)]] by access control, attribution rigor, and contractual handling requirements.

## Why it matters

CompTIA Objective **CS0-003 1.4** explicitly tests open source vs closed source collection methods, and the exam writes questions where the right answer hinges on knowing *why* you'd pay for intel when free feeds exist. The short version: free feeds have a noise floor. Paid feeds have analysts.

Career-wise, this is where junior analysts learn the politics of the SOC. Your CISO is going to ask whether the $180k/year Mandiant or Recorded Future or CrowdStrike Falcon Intelligence subscription is worth it. You need to know what you actually get for that money and what you give up — because the answer is never "everything." It's "earlier warning on the specific actors targeting your sector, with attribution you can defend in a board meeting, under a license that says you can't tell the ISAC down the street about it."

Real stakes: in a live intrusion, the difference between a generic AlienVault OTX pulse saying "this IP is bad" and a Mandiant report saying "this IP is APT41 staging infrastructure used against semiconductor manufacturers in Q1 2026, here's the loader hash, here's the C2 protocol, here's the dwell time observed elsewhere" is the difference between a 4-hour triage and a 30-minute scoped containment.

## Key facts

### Who produces closed-source intel

| Source type | Examples | What you get |
|---|---|---|
| **Commercial vendors** | Mandiant, Recorded Future, CrowdStrike, Flashpoint, Intel 471, Dragos (OT) | Curated reports, attributed campaigns, malware analysis, dark-web monitoring, finished intel |
| **Government / national CERTs** | CISA TLP:AMBER advisories, FBI FLASH/PIN, NSA cybersecurity advisories, UK NCSC, ACSC | Nation-state attribution, classified-derived IoCs, sector warnings |
| **Sector ISACs / ISAOs** | FS-ISAC (finance), H-ISAC (healthcare), E-ISAC (electricity), Auto-ISAC | Peer-shared incidents under NDA, sector-specific TTPs |
| **MSSP / MDR feeds** | Arctic Wolf, Expel, Red Canary intel layered into managed detection | Telemetry-derived IoCs from their other customers |
| **Industry trust groups** | Cyber Threat Alliance, regional infosec councils | Member-to-member sharing under TLP rules |

### What proprietary feeds typically deliver

- **Finished intelligence reports** — narrative analysis of campaigns, not just raw indicators. Includes adversary motive, tooling, victimology, confidence rating.
- **Attributed [[Indicators of Compromise (IoC)]]** — IPs, domains, hashes, YARA rules, JA3/JA4 fingerprints, mapped to specific actors.
- **[[TTPs|Tactics, Techniques, and Procedures]]** — mapped to [[MITRE ATT&CK]] with vendor-confirmed observations, not speculation.
- **Dark-web and underground forum monitoring** — vendor analysts have personas inside Russian-language carding forums, ransomware-affiliate channels, initial-access-broker markets. You don't.
- **Malware reverse-engineering** — full unpacked analysis with C2 protocol breakdowns, configuration extractors, sometimes decryptors.
- **Pre-disclosure vulnerability intel** — what's being weaponized in the wild before the CVE is widely known.
- **Custom RFI (request for information)** — you can ask the vendor "have you seen this hash, this IP, this actor against firms like ours?" and get a human-written answer.

### The trade-offs you sign up for

> **CompTIA exam trap:** Closed source intel is *not* automatically more accurate than open source — it's more *curated* and *attributed*, with vendor-stated confidence levels. The exam will offer "always more accurate" as a distractor. Reject it. The correct framing is higher fidelity, vetted, attributed, contractually restricted.

- **Cost** — six-figure annual subscriptions are normal for tier-one vendors. ISAC memberships are cheaper but still meaningful budget.
- **Transparency limits** — you often can't see the vendor's sources or methods. You're trusting their tradecraft.
- **Redistribution restrictions** — most contracts forbid republishing IoCs externally. [[TLP — Traffic Light Protocol]] applies: TLP:RED, AMBER, AMBER+STRICT, GREEN, CLEAR.
- **Vendor bias** — every vendor's view of the threat landscape is shaped by their customer base. A vendor heavy in finance will see finance threats clearest.
- **Lock-in** — your detections, playbooks, and SIEM correlations get tuned to the vendor's format. Switching is painful.

### The four qualities the exam cares about

CompTIA's intel-evaluation rubric — applies to any feed, but proprietary feeds typically score higher on three of four:

| Quality | What it means | Closed-source advantage |
|---|---|---|
| **Timeliness** | How fresh — minutes vs days vs weeks | Strong — vendor SOCs publish hours after observation |
| **Relevancy** | Applies to your sector, geography, tech stack | Strong — vendors segment by industry |
| **Accuracy** | Few false positives, confirmed observations | Strong — analysts vet before publication |
| **Confidence level** | Vendor-stated certainty (low/medium/high) | Explicit — open feeds rarely declare this |

Open source intel can match on timeliness (Twitter/X is fast) but rarely on accuracy or stated confidence.

### How it gets consumed in the SOC

- **TIP — Threat Intelligence Platform** (Anomali, ThreatConnect, OpenCTI) ingests feeds via [[STIX/TAXII]], deduplicates, scores, and pushes IoCs to SIEM, EDR, firewall, SOAR.
- **SIEM correlation rules** light up when proprietary IoCs match against logs.
- **Threat hunters** use the finished reports to design hypotheses — "Mandiant says APT29 is using this specific Cobalt Strike profile, let's hunt our DNS logs for it."
- **IR teams** pull the vendor's playbook on a confirmed actor mid-incident — "what does this group do at hour 4? hour 24?"

### Closed source vs open source — the comparison the exam wants

| Dimension | Open Source (OSINT) | Closed / Proprietary |
|---|---|---|
| **Cost** | Free | Paid subscription or membership |
| **Access** | Anyone | License-restricted |
| **Volume** | Massive, noisy | Curated, smaller |
| **Attribution** | Often missing/weak | Usually present, defensible |
| **Confidence levels** | Rarely stated | Explicitly rated |
| **Redistribution** | Usually free | Contractually limited |
| **Dark web coverage** | Surface scrapes | Operator-level personas |
| **Examples** | AlienVault OTX, abuse.ch, Twitter/X, blogs, [[CISA]] public advisories | Mandiant, Recorded Future, CrowdStrike, FS-ISAC, FBI FLASH |

### CompTIA exam traps

> **Trap 1:** Government bulletins are sometimes classified as closed source even though they're free. CISA TLP:AMBER advisories, FBI FLASH reports, and NSA cybersecurity advisories are *restricted distribution* — not paid, but not open either. Free ≠ open source. Access control is the dividing line.

> **Trap 2:** ISACs (Information Sharing and Analysis Centers) are closed-source channels even when membership is non-profit. Sharing happens under TLP and NDA. If the question describes "peer financial institutions sharing IoCs under membership agreement," that's closed source via ISAC, not OSINT.

> **Trap 3:** "Proprietary" on the exam means the *intelligence* is proprietary, not the tooling. A free TIP that ingests paid feeds is still consuming closed-source intel. Don't conflate the platform with the data.

> **Trap 4:** Confidence levels are a closed-source hallmark. If a question asks which intel source explicitly publishes confidence ratings on its IoCs, the answer leans proprietary/commercial — open feeds rarely bother.

## SOC reality

- The 3am alert: SIEM correlation rule fires because a domain in your proxy logs matches a Mandiant Advantage IoC tagged **APT41 — high confidence — observed in semiconductor sector Q2 2026**. That tag is the entire reason you're treating it as P1 instead of P3. Pull the full report from the portal before you escalate.
- The L1's first move: validate the IoC is current (check the feed's last-seen date — proprietary feeds age out IoCs, but check anyway), pull the report, confirm the actor profile matches your sector, then escalate to L2 with the report attached. *Never escalate an IoC hit without the context that made it interesting.*
- The CISO question after a contained incident: "Did our paid intel see this coming?" If the answer is no, you're justifying the renewal. If the answer is yes and you missed it, you're justifying the detection-engineering backlog. Both conversations are uncomfortable — keep the receipts.
- What never to promise leadership: "Our threat intel vendor would have caught this." Vendors miss things. Their telemetry is shaped by their customer base. *A finished intelligence report is a flashlight, not a floodlight — it shows what the vendor pointed it at.*
- The handoff: L1 confirms IoC match → L2 enriches with vendor report and historical telemetry → IR lead decides containment scope → threat intel analyst (if you have one) files an RFI to the vendor asking "what else have you seen from this campaign?" → legal reviews redistribution constraints before sharing with the ISAC.

## Related concepts

[[Open Source Intelligence (OSINT)]] · [[Indicators of Compromise (IoC)]] · [[STIX/TAXII]] · [[TLP — Traffic Light Protocol]] · [[MITRE ATT&CK]] · [[Threat Hunting]] · [[Threat Intelligence Platform (TIP)]] · [[ISAC — Information Sharing and Analysis Center]] · [[Advanced Persistent Threat (APT)]] · [[TTPs — Tactics, Techniques, and Procedures]] · [[Confidence Levels]] · [[Information Sharing]] · [[Government Bulletins]] · [[Deep and Dark Web Intelligence]] · [[Paid Feeds]]

*Source: VIRGIL knowledge base — 2026-05-11*