# Levels of Threat Intelligence

## What it is

In **Marvel Rivals**, the way a team prepares for a ranked match has three layers. The shot-caller studies meta trends across the season — Hela's been nerfed, dive comps are dominating, Cloak & Dagger is the must-pick support. That's the macro read. The IGL studies team comps and counter-picks — if the enemy locks Hulk, we need anti-dive; if they run Storm + Thor, we need hitscan. That's the mid layer. The individual player studies frame data and ability cooldowns — Spider-Man's Get Over Here has an 8-second cooldown, so after he uses it on our backline, we have 8 seconds to push. That's the micro layer.

All three layers describe the same enemy. They serve different humans making different decisions on different clocks.

That's exactly what the levels of threat intelligence do. The CISO doesn't need Spider-Man's cooldown timer. The L1 SOC analyst doesn't need the quarterly threat landscape. Each layer of intel is shaped for the decision it has to support.

**Technical definition.** Threat intelligence is structured information about adversaries — their motivations, capabilities, infrastructure, and behaviors — produced through a [[Threat Intelligence Lifecycle]] of collection, processing, analysis, and dissemination. It exists at three levels distinguished by **audience, time horizon, and abstraction**: **strategic** (executive, long-term, business-risk language), **operational** (manager/IR lead, campaign-level, adversary-focused), and **tactical** (analyst/engineer, immediate, IoC and TTP-focused).

CompTIA tests this under **Objective 1.4 — Compare and contrast threat-intelligence and threat-hunting concepts**, and they will absolutely give you a scenario and ask which level applies.

## Why it matters

Threat intel is only useful if it reaches the right human in the right form on the right clock. A board presentation full of MD5 hashes is malpractice. A detection engineer reading a McKinsey-style "geopolitical risk outlook" can't write a Sigma rule from it. Misrouted intel doesn't just waste cycles — it teaches leadership that the threat program is noise, and that's how budget gets cut.

For the exam: CompTIA loves to give you a quote ("The CFO wants to understand how ransomware trends affect our insurance posture") and ask which level of intel applies. Recognize the audience and the time horizon, and the answer falls out.

For the career: every analyst eventually writes intel products. Knowing which level you're writing for is the difference between a brief that gets actioned and a brief that gets archived.

## Key facts

### The three levels at a glance

| Level | Audience | Time horizon | Abstraction | Example output |
|---|---|---|---|---|
| **Strategic** | C-suite, board, risk committee | Months to years | High — business risk language | "Ransomware groups are increasingly targeting our sector; cyber insurance premiums will rise 30%" |
| **Operational** | SOC manager, IR lead, threat hunter | Days to weeks | Mid — adversary campaigns and TTPs | "FIN7 is running a phishing campaign against retail; expect ISO attachments with HTA payloads" |
| **Tactical** | L1/L2 analysts, detection engineers, firewall admins | Minutes to hours | Low — atomic IoCs and rules | "Block IP 185.220.101.47; YARA rule for Cobalt Strike beacon config X" |

### Strategic intelligence

The boardroom layer. It answers: *What threats matter to our business over the next 12–36 months, and how should we invest?*

- **Inputs:** [[Government bulletins]] (CISA advisories, NCSC reports), industry [[ISACs]] (FS-ISAC, H-ISAC), [[Closed source]] vendor reports (Mandiant M-Trends, CrowdStrike GTR), geopolitical analysis, [[Open source]] news and blogs/forums
- **Outputs:** Annual threat assessments, board briefings, [[Risk Management]] inputs, budget justifications, cyber insurance posture docs
- **Consumers:** CISO, CIO, CFO, board, audit committee, legal
- **Time horizon:** Quarterly to annual
- **Language:** Dollars, regulatory exposure, brand impact, business continuity. **No hashes. No CVEs. No tool names.** If a hash makes it into the board deck, somebody failed to translate.

Example strategic finding: *"Nation-state actors aligned with [country] have demonstrated sustained interest in our supply chain over the past 18 months. Recommend allocating $2.4M to third-party risk management and supply-chain monitoring in FY27."*

### Operational intelligence

The war-room layer. It answers: *Which threat actors are targeting organizations like us right now, how do they operate, and what should our defenders prepare for this quarter?*

- **Inputs:** [[MITRE ATT&CK]] mappings, [[Threat Actor]] profiles, campaign reports, [[Paid feeds]] (Recorded Future, Intel 471), [[Information Sharing]] partnerships, [[Deep/Dark Web]] monitoring, [[Honeypot]] telemetry
- **Outputs:** Adversary playbooks, [[Threat Hunting]] hypotheses, [[Detection]] engineering priorities, tabletop scenarios, [[Active Defense]] planning
- **Consumers:** SOC manager, IR lead, threat hunters, detection engineers, [[CSIRT]] / [[CERT]] leads
- **Time horizon:** Weeks to months
- **Language:** Adversary names (APT29, LockBit, Scattered Spider), TTPs, kill-chain phases, campaign attribution

Operational intel is where the threat program earns its keep. It connects strategic concerns ("ransomware risk to our sector") to tactical action ("hunt for Rclone usage on file servers"). It's the IGL of the threat program.

### Tactical intelligence

The keyboard layer. It answers: *What do I block, alert on, or hunt for in the next hour?*

- **Inputs:** [[IoC]] feeds (file hashes, IPs, domains, URLs, JA3 fingerprints), [[STIX/TAXII]] structured feeds, sandbox detonation results, [[Internal Sources]] (your own SIEM, your own past incidents)
- **Outputs:** Firewall blocklists, EDR custom rules, Sigma/YARA signatures, SIEM correlation searches, IDS/IPS signatures
- **Consumers:** L1/L2 SOC analysts, detection engineers, firewall and proxy admins, [[Vulnerability Management]] teams
- **Time horizon:** Minutes to days — IoCs decay fast. An IP that was C2 yesterday may be a coffee shop's NAT today.
- **Language:** Atomic. `sha256:abc123...`, `185.220.101.47`, `evil-domain[.]com`, `T1059.001`

*The half-life of a tactical IoC is shorter than a Doctor Strange portal — useful in the moment, gone before you can document it.*

### Threat actor categories that show up at every level

Each actor type appears differently at each level. Strategic intel says "nation-state risk is rising"; operational intel says "APT29 is using SVG smuggling"; tactical intel says "block these 14 domains."

- **[[Nation-state]]** — well-resourced, patient, geopolitical motivation, APT behavior
- **Organized crime** — financially motivated, ransomware, BEC, credential theft
- **[[Hacktivists]]** — ideologically motivated, defacement, DDoS, doxxing
- **[[Insider Threat]]** — intentional (malicious employee) or unintentional (clicked the phish)
- **Script kiddies** — low skill, public tooling, opportunistic
- **Supply chain actors** — compromise the vendor to reach the target ([[Supply Chain]] attacks like SolarWinds, MOVEit)

### Intel quality dimensions — apply at every level

Every piece of intel, regardless of level, must be evaluated against:

- **Timeliness** — Did it arrive before it mattered? A tactical IoC delivered after the breach is a postmortem artifact, not intel.
- **Relevancy** — Does it apply to your sector, geography, tech stack? A retail-sector ransomware report is less relevant to a hospital.
- **Accuracy** — Is the attribution sound? Are the IoCs validated, or did someone scrape Twitter?
- **Confidence levels** — Reputable intel products tag confidence (e.g., Admiralty Code, or simply High/Medium/Low). *"FIN7 attribution, medium confidence"* is honest. *"This is definitely China"* with no sourcing is a red flag.

### Collection sources mapped to levels

| Source | Strategic | Operational | Tactical |
|---|---|---|---|
| [[Government Bulletins]] (CISA, NCSC) | ✓ | ✓ | ✓ |
| ISACs / [[Information Sharing]] | ✓ | ✓ | ✓ |
| [[OSINT]] — blogs, forums, social media | ✓ | ✓ | ✓ |
| [[Closed Source]] vendor reports | ✓ | ✓ | — |
| [[Paid Feeds]] (commercial intel) | — | ✓ | ✓ |
| [[Deep/Dark Web]] monitoring | — | ✓ | ✓ |
| [[Honeypot]] / internal telemetry | — | ✓ | ✓ |
| STIX/TAXII structured feeds | — | — | ✓ |

### CompTIA exam traps

> **CompTIA exam trap:** "The CISO needs to brief the board on ransomware exposure." That's **strategic**, not operational. The audience flag (board) and time horizon (quarterly briefing) decide it, not the topic. Ransomware can be discussed at any level — what matters is who's reading and what decision they're making.

> **CompTIA exam trap:** "An analyst needs to block a malicious IP found in a feed." That's **tactical**. If the question said "an analyst is planning detection coverage for the next quarter based on APT41's known TTPs," that would be **operational**. The clock and the abstraction level give it away.

> **CompTIA exam trap:** Don't confuse **operational intelligence** with **operations** (the verb). Operational intel is a *level*, not an activity. CompTIA will write distractors that conflate "operational intel" with "SOC operations" or "incident response operations." They're different concepts.

> **CompTIA exam trap:** Strategic intel **does not** include IoCs. If an answer choice describes strategic-level work but lists "file hashes and IP addresses" as the output, it's wrong. Strategic is risk language; tactical is atomic indicators.

## SOC reality

- **The L1 dashboard never shows strategic intel.** It shows tactical IoCs — blocklists, EDR alerts, SIEM correlations. If your L1s are reading McKinsey-style threat-landscape PDFs, somebody routed the intel wrong.
- **The 8am SOC standup runs on operational intel.** "Mandiant published a report yesterday on UNC4841 — they're hitting Barracuda appliances. We have 12 of those. Threat hunt today, patching by Friday." That's operational intel translated into action.
- **The board meeting runs on strategic intel.** The CISO walks in with three slides: top threats to the sector, our posture relative to peers, budget asks. If a hash appears on a board slide, the briefing is going to be painful.
- **What the IR lead asks during an incident:** *"Do we have any prior intel on this actor? What's the campaign context? What's the expected next move?"* That's operational intel pulled forward into the live response. Good IR programs have the threat intel analyst sitting next to the IR lead.
- **What never to promise leadership:** "Our intel feeds will catch this next time." Tactical IoCs decay. Attribution shifts. The intel program reduces surprise; it does not eliminate it. *Intel is a probability lens, not a crystal ball.*
- **The handoff:** Tactical analyst spots an IoC pattern across multiple incidents → escalates to operational threat intel team → they build an adversary profile → CISO uses that profile in the next board brief to justify the SIEM budget increase. All three levels, one organism.

## Related concepts

[[Threat Intelligence Lifecycle]] · [[Threat Hunting]] · [[IoC]] · [[MITRE ATT&CK]] · [[STIX/TAXII]] · [[OSINT]] · [[Closed Source Intelligence]] · [[Information Sharing]] · [[ISACs]] · [[Government Bulletins]] · [[Threat Actors]] · [[APT]] · [[Insider Threat]] · [[Supply Chain]] · [[Honeypot]] · [[Active Defense]] · [[Risk Management]] · [[Vulnerability Management]] · [[Incident Response]] · [[CSIRT]] · [[CERT]]

*Source: VIRGIL knowledge base — 2026-05-11*