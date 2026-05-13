# Threat Intelligence Cycle

## What it is

In **Minecraft**, you don't wander into the Nether on day one with leather armor and a wooden sword. You scout first. You note where ghasts spawn and what their fireballs do to your obsidian. You watch the piglins' aggro range. You log which biome the fortress sits in. You bring that intel back to base, smelt it into a plan — netherite armor, fire resistance pots, a cobblestone tunnel through the soul sand valley — then you raid. After the raid, you debrief: what worked, what almost killed you, what you need next time. Then you scout again, because the Nether changes when you change.

That loop — scout, collect, refine, plan, raid, debrief, re-scout — is the **Threat Intelligence Cycle** in plain English.

Technically: the threat intelligence cycle is the structured process that converts raw data about adversaries, vulnerabilities, and indicators into **finished intelligence** that drives defensive decisions. It is iterative, not linear. The output of one cycle becomes the input of the next. CompTIA codifies it in five phases — **Requirements → Collection → Analysis → Dissemination → Feedback** — and CS0-003 Objective 1.4 expects you to know the phases, the sources that feed Collection, and the quality attributes that judge whether the intelligence is worth acting on.

## Why it matters

Threat intel is the difference between a SOC that reacts and a SOC that anticipates. Without it, you tune SIEM rules based on yesterday's incident and last quarter's vendor pitch. With it, you tune based on what threat actors are doing **right now** to organizations that look like yours.

It also matters on the exam. Objective 1.4 is one of the densest in Domain 1.0, and CompTIA loves to test the cycle order, source taxonomy (open vs closed vs paid), and intelligence quality attributes (timeliness, relevancy, accuracy, confidence). Expect at least one question that scrambles the phase order and one that asks you to classify a source.

Career-wise: every mid-level SOC analyst job description lists "threat intelligence consumption" as a requirement. You're not expected to be a threat intel analyst on day one — you're expected to read a [[STIX/TAXII]] feed, understand what an [[Indicators of Compromise|IoC]] from US-CERT means for your environment, and not pivot the whole SOC because a vendor blog said APT-of-the-week is "trending."

## Key facts

### The five phases (memorize the order)

| # | Phase | What happens | War-room version |
|---|-------|--------------|------------------|
| 1 | **Requirements / Planning** | Stakeholders define what they need to know and why | "CISO wants to know if we're exposed to the ransomware group hitting our sector" |
| 2 | **Collection** | Gather raw data from defined sources | Pulling feeds, OSINT scrapes, dark web monitoring, internal telemetry |
| 3 | **Analysis** | Normalize, correlate, enrich, evaluate confidence | "Three of these IoCs match traffic from our edge firewall last week" |
| 4 | **Dissemination** | Deliver finished intel to the right audience in the right format | TIP push to SIEM, exec brief, hunt package to IR |
| 5 | **Feedback** | Stakeholders tell you what was useful, what was noise, what's still missing | "The exec brief was too technical, the SIEM IoCs caught two beacons" |

> **CompTIA exam trap:** Some sources call Phase 3 "Processing and Analysis" and split it into two. CompTIA's CS0-003 framing keeps it as one phase but the question may use either label. Don't pick "Dissemination" just because the question mentions "sharing" — sharing inside the cycle (to internal stakeholders) is Dissemination; sharing **outside** the org (ISAC, peers) is a separate concept called **Information Sharing**.

### Phase 1: Requirements — the part everyone skips

This is where intel programs die. Skip it and you end up paying for a $200k feed that gives you Russian APT TTPs when your actual threat is commodity ransomware hitting your law firm clients through phishing.

Requirements come from:
- **Business-critical assets** — what would hurt most if it went down or got stolen
- **Risk assessments** — what the [[Risk Management]] register says is exposed
- **Recent incidents** — what just punched you in the face
- **Sector / vertical** — what's hitting your peers (healthcare, finance, OT, etc.)
- **Regulatory pressure** — what auditors and frameworks demand visibility on

The output is a set of **Priority Intelligence Requirements (PIRs)** — specific questions intel must answer. "Are we exposed to CVE-2026-XXXX?" is a PIR. "Tell me about threats" is not.

### Phase 2: Collection — sources and how to classify them

CompTIA tests source taxonomy hard. Know these:

| Source type | What it is | Examples |
|-------------|------------|----------|
| **Open source (OSINT)** | Publicly available, free | Blogs, forums, social media, Shodan, VirusTotal free tier, vendor research blogs |
| **Closed source** | Not public but available — vendor-specific or community-restricted | Vendor portal feeds, ISAC member feeds, CERT bulletins to verified members |
| **Paid feeds** | Commercial subscription, curated | Mandiant, Recorded Future, CrowdStrike Intel, Flashpoint |
| **Government bulletins** | Public-sector advisories | US-CERT / CISA alerts, NCSC, FBI Flash, MS-ISAC |
| **Internal sources** | Your own telemetry | SIEM events, EDR alerts, [[Honeypot]] hits, firewall logs, prior incidents |
| **Deep/dark web** | Forums, marketplaces, leak sites behind auth or Tor | Ransomware leak sites, initial-access-broker forums, credential dumps |
| **Information sharing orgs** | Sector-specific cooperatives | FS-ISAC, H-ISAC, Auto-ISAC, MS-ISAC |

The collection layer also covers **threat actor categories** you're gathering against:

- **Nation-state** — long-dwell, well-funded, stealthy. The classic [[Advanced Persistent Threat|APT]].
- **Organized crime** — financially motivated, ransomware and BEC operators
- **Hacktivists** — ideology-driven, often DDoS and defacement, sometimes data leaks
- **Insider threat** — intentional (disgruntled, paid) or unintentional (clicked the link)
- **Script kiddies** — low skill, public tooling, opportunistic
- **Supply chain** — third parties compromised to reach you (SolarWinds, Kaseya pattern)

### Phase 3: Analysis — turning data into intelligence

Raw data is not intelligence. An IP address in a feed is data. "This IP is a C2 server used by the threat group hitting your sector this month, seen beaconing every 47 seconds, observed in three of your firewall logs last Tuesday" is intelligence.

Analysis evaluates four quality attributes — CompTIA will test these:

- **Timeliness** — is it current enough to act on? IoCs decay fast; an IP that was C2 last month is a Starbucks WiFi this month.
- **Relevancy** — does it apply to your environment, sector, stack?
- **Accuracy** — is it correct, or is it a false positive someone scraped from Twitter?
- **Confidence level** — how sure is the analyst? Often graded (Admiralty scale, or high/medium/low). Low confidence intel still gets shared, but it's tagged.

Analysis also classifies intel by altitude:

| Tier | Audience | Content |
|------|----------|---------|
| **Strategic** | Executives, board | Trends, geopolitical risk, sector threat landscape |
| **Operational** | SOC management, IR leads | Campaign details, threat actor capabilities, TTPs |
| **Tactical** | Hunters, IR responders | TTPs ([[MITRE ATT&CK]] techniques), behavioral patterns |
| **Technical** | SOC L1/L2, SIEM engineers | IoCs — hashes, IPs, domains, signatures |

### Phase 4: Dissemination — right format, right audience

Bad dissemination kills good intel. The CISO doesn't want a list of SHA-256 hashes. The SIEM engineer doesn't want a 40-page geopolitical brief.

Common formats:
- **STIX/TAXII** — structured machine-readable, pushed to TIPs and SIEMs
- **Threat bulletins** — human-readable PDFs for ops and management
- **Hunt packages** — hypotheses, queries, expected artifacts, for [[Threat Hunting]] teams
- **Executive briefs** — strategic-level, short, decision-oriented
- **Indicator feeds** — IPs, hashes, domains pushed to detection tooling

### Phase 5: Feedback — the part that closes the loop

Without feedback, the cycle is a line. Feedback asks consumers:
- Did the intel answer your PIR?
- Was it timely?
- What did you do with it?
- What's still missing?

Feedback rewrites the requirements for the next cycle. *I have watched intel teams produce gorgeous reports for two years that nobody read because nobody ever asked what the SOC actually needed.*

### CompTIA exam traps

> **CompTIA exam trap — cycle order:** CompTIA will list the five phases out of order and ask which sequence is correct. Memorize: **Requirements → Collection → Analysis → Dissemination → Feedback**. The trap answer usually swaps Analysis and Dissemination, or puts Feedback before Dissemination.

> **CompTIA exam trap — open vs closed vs paid:** A vendor blog you read for free is **open source**. A vendor portal you log into as a paying customer is **paid** (and may also be called closed source depending on framing). An ISAC feed restricted to verified sector members is **closed source**. CompTIA tests this distinction.

> **CompTIA exam trap — IoC vs IoA:** An IoC ([[Indicators of Compromise]]) is forensic — "this hash was on disk." An IoA (indicator of attack) is behavioral — "this process spawned a child process that's beaconing." Threat intel feeds carry both; CompTIA will ask which one matches a scenario.

> **CompTIA exam trap — confidence vs accuracy:** Confidence is the analyst's certainty. Accuracy is whether the intel is actually correct. High-confidence intel can still be inaccurate. Low-confidence accurate intel still helps. They are not the same attribute.

## SOC reality

- **The 3am alert nobody ordered.** A paid feed pushes a new IoC list to your SIEM at 2:47am. By 3:02am, the SIEM has flagged 14 hits — all of them are your own vulnerability scanner. *Intel without environmental context is just noise that fires pagers.*
- **The L1 first action** is never "block the IP." It's: check the IoC's age, check confidence level, check whether the hit is from a known internal asset, check whether your asset inventory says that host should be talking to that IP at all. **Then** decide.
- **The IR lead's question** when intel claims a campaign is hitting your sector is always the same three: "What's the IoC overlap with our telemetry in the last 30 days? What's the TTP overlap with detections we already have? What gap does this expose in our coverage?" Anything else is a vendor pitch.
- **Never promise the CISO** that a new feed "covers" a threat actor. Feeds cover **observed indicators** of past activity. The actor adapts. *Intelligence reduces uncertainty; it does not eliminate it.*
- **The handoff:** Intel team produces → SOC consumes for detection → Hunt team consumes for proactive sweeps → IR team consumes during active incidents → Vulnerability management consumes for prioritization. If any of those four don't get the intel in a format they can use, dissemination failed.

## Related concepts

[[Threat Hunting]] · [[Indicators of Compromise]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[STIX/TAXII]] · [[Advanced Persistent Threat]] · [[Threat Actors]] · [[OSINT]] · [[ISAC]] · [[Honeypot]] · [[Active Defense]] · [[Risk Management]] · [[Vulnerability Management]] · [[Incident Response]] · [[SIEM]]

*Source: VIRGIL knowledge base — 2026-05-11*