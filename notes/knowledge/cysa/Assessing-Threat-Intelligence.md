# Assessing Threat Intelligence

## What it is

In **Red Dead Redemption 2**, when you ride into Valentine, NPCs tell you things. The drunk at the saloon swears there's gold buried up near Cairn Lake. A stranger at the gunsmith mentions a stagecoach route that's "ripe for the picking." A wanted poster on the sheriff's wall puts a bounty on a man you've never heard of. Some of it is true. Some of it is a setup — ride to the gold and three O'Driscolls put a bullet in your back. Arthur Morgan learns fast: the source matters, the timing matters, and a tip about a stagecoach yesterday is worthless if the stagecoach already passed. Hosea cross-references with Dutch before the gang commits to a job. *That's exactly what assessing threat intelligence does* — you treat every feed, every blog post, every government bulletin like a saloon rumor until you've weighed who said it, when, and whether it actually applies to your trail.

Technical definition: **assessing threat intelligence** is the analyst process of evaluating threat data against five criteria — **timeliness, accuracy, relevancy, confidence level, and source corroboration** — before letting it drive detection rules, hunts, or executive decisions. CS0-003 Objective 1.4 puts this squarely in the threat-intelligence and threat-hunting lane, and the exam will test whether you can separate signal from noise without burning analyst hours chasing a rumor.

## Why it matters

Threat intel is the cheapest way to lose a week. A free OSINT feed dumps 40,000 "malicious" IPs into your SIEM block list, half of them are CDN edge nodes, and now marketing can't reach Cloudflare. A vendor sells you a "premium APT feed" full of indicators from a campaign that targeted Southeast Asian banks — you're a North American hospital. The intel was technically accurate. It was useless to you.

Career-wise, this is the skill that separates an L1 who forwards every FBI flash report to the team channel from an L2 who reads the report, checks if the TTPs match your stack, and either opens a hunt or files it under "monitor." Exam-wise, CS0-003 Objective 1.4 explicitly lists **confidence levels, timeliness, relevancy, accuracy** as evaluation criteria — CompTIA wants you to name them and apply them.

## Key facts

### The five evaluation criteria

| Criterion | Question | Failure mode |
|---|---|---|
| **Timeliness** | Is this current enough to act on? | Yesterday's C2 IP is today's reassigned DHCP lease at a coffee shop |
| **Accuracy** | Is the indicator correctly attributed and technically right? | False positives flood the SIEM, analysts stop trusting the feed |
| **Relevancy** | Does this apply to my industry, stack, geography, threat model? | You block exploits for software you don't run |
| **Confidence level** | How sure is the source, and how sure am I? | High-confidence intel acted on; low-confidence intel watched, not blocked |
| **Corroboration** | Does a second independent source confirm? | One-source intel is a rumor; two independent sources is signal |

Memorize these. CompTIA tests them by name and by scenario.

### Confidence levels — admiralty grading

Mature intel programs grade with the **Admiralty System** (NATO origin) on two axes: **source reliability** (A–F) and **information credibility** (1–6). An "A1" report is from a fully reliable source and confirmed by other intel. An "F6" is unreliable source, truth cannot be judged. Most real intel lands in the B2–C3 zone — "usually reliable, probably true."

In practice most teams collapse this to **High / Medium / Low** or numeric (1–5). What matters for the exam: confidence isn't a vibe, it's a documented attribute attached to every indicator. A [[SIEM]] block rule fed by Low-confidence IoCs is malpractice.

### Collection methods and sources

CS0-003 splits intel sources three ways:

**Open source (OSINT)** — free, public, broad:
- Government bulletins: **CISA alerts, US-CERT, FBI flash reports, NCSC** (UK), national [[CSIRT]] / CERT feeds
- Vendor blogs: Mandiant, CrowdStrike, Microsoft Threat Intelligence, Talos
- Forums and social media: Twitter/X infosec community, Reddit r/netsec, Mastodon
- ISACs (Information Sharing and Analysis Centers) — sector-specific (FS-ISAC for finance, H-ISAC for health)
- **STIX/TAXII** public feeds (AlienVault OTX, abuse.ch)

**Closed source / proprietary** — paid feeds:
- Recorded Future, Mandiant Advantage, Flashpoint, ZeroFox
- Higher signal, curated, often pre-correlated with [[MITRE ATT&CK]]
- Cost ranges from low five figures to mid six figures annually

**Deep / dark web** — Tor-accessible forums, ransomware leak sites, criminal marketplaces. Usually consumed through a vendor that does the access for you — sending analysts onto dark-web forums directly is a legal and OPSEC minefield.

### Threat actors and what intel about them looks like

| Actor type | Motivation | Intel signal |
|---|---|---|
| **Nation-state / APT** | Espionage, strategic disruption | Government bulletins, vendor APT reports (APT28, APT29, Volt Typhoon) |
| **Organized crime** | Financial — ransomware, BEC, carding | Ransomware leak sites, FS-ISAC, law-enforcement takedown reports |
| **Hacktivists** | Ideological — defacement, doxxing, DDoS | Social media chatter, manifesto posts, target lists |
| **Insider threat** | Grievance, greed, ideology (intentional); negligence (unintentional) | UEBA anomalies, internal HR signals — rarely external intel |
| **Script kiddie** | Status, curiosity | Pastebin dumps, forum boasting — high volume, low sophistication |
| **Supply chain** | Compromise the vendor to reach the customer | Vendor disclosure, SBOM analysis, third-party breach notifications |

The exam wants you to map an actor to a likely TTP profile. APTs do long-dwell quiet recon and exfil. Organized crime does fast, loud, monetizable. Hacktivists do public and symbolic. Don't confuse the categories on test day.

### Information sharing organizations

- **ISACs** — industry-specific, member-funded (FS-ISAC, H-ISAC, E-ISAC for energy, MS-ISAC for state/local government)
- **ISAOs** — broader, less formal than ISACs, encouraged by US Executive Order 13691
- **CERT / CSIRT** — national or organizational response teams that publish bulletins and coordinate disclosure. **CERT** = Computer Emergency Response Team (originally Carnegie Mellon, now a generic term). **CSIRT** = Computer Security Incident Response Team (functionally the same with different naming preference)
- **InfraGard** — FBI-private sector partnership for critical infrastructure
- Joint task forces and government-industry briefings (TLP-coded — see traps)

### Relevancy — the question most analysts skip

Relevancy filters intel against four dimensions:

1. **Industry** — is this campaign targeting my sector?
2. **Geography** — are the targets in my region?
3. **Technology stack** — do I run the vulnerable software/version?
4. **Business-critical assets** — does this threaten what actually matters (the crown jewels), or just a dev sandbox?

A CVSS 10.0 in Oracle WebLogic is a P1 emergency if you run WebLogic facing the internet. It's a calendar reminder if you don't run WebLogic at all. Relevancy is the difference.

### CompTIA exam traps

> **CompTIA exam trap:** Open source vs closed source vs proprietary. **Open source** = freely available (OSINT, government bulletins). **Closed source** = restricted access, often paid (Recorded Future, Mandiant Advantage). **Proprietary** can mean either internal-only intel your org generates, or vendor-confidential — context matters. CompTIA usually uses "closed source" and "proprietary" as paid commercial feeds and "open source" as free public intel.

> **CompTIA exam trap:** Confidence level vs accuracy. **Accuracy** is whether the indicator is technically correct (the IP really is malicious). **Confidence** is how sure the source is, and how much you trust the source. An accurate indicator from a low-confidence source still gets graded low until corroborated.

> **CompTIA exam trap:** Timeliness ≠ real-time. Intel can be "timely" and still be 24–48 hours old if the threat campaign is long-running. Timeliness is relative to actor dwell time and indicator decay rate. A C2 domain registered yesterday and burned today is short-lived; a TTP describing how APT29 uses [[Golden Ticket]] attacks is timely for years.

> **CompTIA exam trap:** TLP (Traffic Light Protocol) classifies how intel may be shared. **TLP:RED** = recipient only, no sharing. **TLP:AMBER** = limited within recipient org. **TLP:GREEN** = community, not public. **TLP:CLEAR** (formerly TLP:WHITE) = public. Mishandling TLP:RED intel by forwarding it to your team Slack is a breach of trust that gets your org cut off from the sharing community.

### Intel feeds the operational pipeline

Assessed intel doesn't sit in a PDF. It feeds:

- **Detection and monitoring** — IoCs become [[SIEM]] correlation rules and [[EDR]] watchlists
- **Threat hunting** — TTPs from intel become hunt hypotheses ("if APT41 uses this technique, would I see it in my data?")
- **Vulnerability management** — intel on actively exploited CVEs reprioritizes the patch queue (see CISA KEV catalog)
- **Incident response** — during an active incident, intel tells you what the actor is likely to do next
- **Active defense** — [[honeypot]] placement, deception tech tuned to the actor's known TTPs
- **Security engineering** — architecture decisions (network segmentation, [[isolated networks]] for OT/ICS) informed by adversary capability
- **Risk management** — quantitative inputs to risk registers, board-level reporting

## SOC reality

- **The morning intel review.** L2 opens the overnight ISAC digest, the CISA daily, two vendor blogs, and three Twitter lists. 90% gets skimmed. The 10% that mentions a CVE in your stack, a TTP matching recent alerts, or an actor known to target your sector — that gets a ticket and a hunt task.
- **The "block this list" request.** Someone forwards a 12,000-IP threat feed and asks the firewall team to block it. The right answer is "show me the confidence rating, the false-positive history, and let me sample 50 entries against our traffic first." The wrong answer is "sure, deploying now." *I learned this the hard way when a 'high-confidence malicious IP' list included a Microsoft Azure egress range and broke Outlook for 4,000 users.*
- **What the CISO asks.** "Are we exposed to [breaking news vulnerability]?" The answer is never "I don't know." The answer is "checking — give me 30 minutes" followed by inventory query, intel correlation, and a one-line response with confidence level attached.
- **Never promise leadership the intel is "confirmed" when it's single-sourced.** *Single-source intel acted on as gospel is how you brick production over a rumor.*
- **Escalation path.** L1 sees the alert → L2 correlates against current intel → IR lead decides if it's an incident → threat intel team writes the post-incident IoC package for sharing back to the ISAC. Intel flows both ways: you consume it and, when something hits you, you produce it.

## Related concepts

[[Threat Hunting]] · [[Indicators of Compromise]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[STIX/TAXII]] · [[SIEM]] · [[EDR]] · [[CSIRT]] · [[Vulnerability Management]] · [[Honeypot]] · [[Advanced Persistent Threat]] · [[Information Sharing]] · [[OSINT]] · [[Traffic Light Protocol]]

*Source: VIRGIL knowledge base — 2026-05-11*