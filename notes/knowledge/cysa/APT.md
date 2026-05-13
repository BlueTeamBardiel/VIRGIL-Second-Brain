# APT — Advanced Persistent Threat

## What it is

In **Doom (2016)**, you clear a room on Mars, glory-kill the last Imp, and the Praetor Suit reads green. Then you walk into the next sector and the lights cut. The Cyberdemon was already there, in the walls of the facility, before you breached the door. Hayden's been letting demons through portals for months — quietly, deliberately, with executive approval. The invasion isn't loud. It's *resident*. By the time UAC noticed, Hell had already built infrastructure inside the base.

That's exactly what an **APT** does — gets in, stays in, sets up shop, and you find out months later that the corp network was Hell's outpost the whole time.

Technical definition: an **Advanced Persistent Threat** is a threat actor — almost always a [[nation-state]] or state-sponsored group, occasionally elite [[organized crime]] — who breaches a target, establishes long-term covert access, and operates with strategic patience toward intelligence collection, IP theft, or pre-positioning for sabotage. "Advanced" = custom malware, zero-days, operational security. "Persistent" = months to years of dwell time. "Threat" = funded, staffed, and not going away because you blocked one C2 domain.

## Why it matters

APT is the boss-level threat actor in [[CS0-003 Objective 1.4]] and it shapes every other concept in Domain 1.0 — threat intel sources exist because APTs are too well-funded to detect with signatures alone. [[Threat hunting]] exists because APTs sit below the SIEM noise floor. The MITRE ATT&CK matrix exists in its current form *because* CrowdStrike and Mandiant kept finding the same Russian and Chinese groups using the same TTPs across hundreds of victims.

If you work in defense, finance, energy, healthcare, telco, defense industrial base, or any company with IP a foreign government wants — you have an APT problem whether you've detected one or not. Average dwell time was 416 days in 2011 and dropped to ~10 days by 2023 for ransomware crews, but APTs still average **6–9 months** because they're not trying to encrypt your files. They want your CAD drawings, your negotiation positions, your source code, your customer list, your firmware signing keys.

## Key facts

### What makes an actor "APT"

| Trait | What it means in ops |
|---|---|
| **Funded** | Salaries, infrastructure, 0-days bought or developed |
| **Staffed** | Recon team, dev team, operator team, analyst team — like a real SOC, but red |
| **Targeted** | They picked *you* specifically. Not opportunistic. |
| **Persistent** | Multiple [[backdoor]]s, multiple C2 channels, redundant access |
| **Stealthy** | Low-and-slow. Lives off the land. Uses your own admin tools. |
| **Strategic** | Goals align with a sponsor (intel, IP, pre-position for conflict) |

The cutoff between "advanced crimeware crew" and "APT" is fuzzy. Conti and LockBit had APT-grade tooling. Some "APT" groups recycle public exploits. Stop arguing about the label and look at the TTPs.

### Named groups you should recognize

- **APT28 / Fancy Bear** — Russian GRU. DNC hack, Olympic doping leaks.
- **APT29 / Cozy Bear** — Russian SVR. SolarWinds supply-chain compromise.
- **APT1 / Comment Crew** — Chinese PLA Unit 61398. Mandiant's 2013 report named-and-shamed them publicly.
- **APT41** — Chinese, dual-hat: state espionage by day, financial crime by night.
- **Lazarus Group** — North Korean. SWIFT bank heists, WannaCry, crypto exchange theft. They steal to fund the regime.
- **Equation Group** — Attributed to NSA. Stuxnet-adjacent tooling.
- **Sandworm** — Russian GRU Unit 74455. Ukraine grid attacks, NotPetya.

You don't memorize all of these for the exam. You memorize the *categories* — Russian intel services, Chinese MSS/PLA, North Korean revenue ops, Iranian, and the "Five Eyes" allies.

### The APT lifecycle (raid mechanics view)

This maps to the [[Cyber Kill Chain]] and [[MITRE ATT&CK]], but read it as a raid timeline:

1. **Reconnaissance** — scouting party. [[OSINT]] from [[social media]], LinkedIn for org charts, scraping [[blogs/forums]], harvesting emails. Sometimes physical recon.
2. **Initial Access** — breach the gate. Spear-phish, [[supply chain]] compromise (SolarWinds), watering-hole, exploit on edge VPN/firewall.
3. **Execution & Persistence** — drop the soulcube. Scheduled tasks, services, WMI subscriptions, signed [[backdoor]]s, golden tickets.
4. **Privilege Escalation** — kill the throne-room guards. Kerberoasting, token theft, exploiting unpatched local privesc CVEs.
5. **Defense Evasion** — turn off the Praetor Suit's alarms. Disable AV/EDR, clear logs, timestomp files, sign malware with stolen certs.
6. **Credential Access** — Mimikatz, LSASS dumping, NTDS.dit extraction.
7. **Discovery & Lateral Movement** — boss summons adds. Internal port scans, AD enumeration, pivoting via RDP/SMB/PsExec/WMI.
8. **Collection & Exfiltration** — dragon takes the relic. Stage data in archives, encrypt, exfil via DNS, HTTPS to legitimate cloud services, or low-and-slow beacon.
9. **Command & Control** — the portal stays open. Beaconing to C2, often through CDNs or compromised legit sites to blend in.

Dwell time happens between steps 3 and 8. That's where [[threat hunting]] earns its paycheck.

### Detection — why your SIEM rule didn't catch it

APTs defeat signature-based detection by design. Your detections come from:

- **[[Indicators of compromise]] (IoC)** — hashes, IPs, domains. Cheap. APTs rotate them weekly. Necessary, not sufficient.
- **[[Indicators of attack]] (IoA)** — behaviors. `cmd.exe` spawning from a Word macro. Service creation from a non-admin tool. These survive IoC rotation.
- **TTPs** — the [[MITRE ATT&CK]] technique level. Hardest for the adversary to change. T1003.001 (LSASS dump) looks the same whether it's Cozy Bear or a pentester.
- **[[Threat hunting]]** — proactive queries against [[EDR]]/[[SIEM]] data assuming you're already compromised. Hunt for the persistence mechanism, not the malware.

> **CompTIA exam trap:** IoC vs IoA. IoC is forensic — *what happened, what artifact was left.* IoA is behavioral — *what's happening right now, regardless of whether we've seen this hash before.* CompTIA will give you a scenario about anomalous PowerShell behavior with no known hash match and ask which type of indicator triggered. The answer is IoA. If the question describes a file hash matching a known-bad list, it's IoC.

### Threat intelligence — fuel for hunting APTs

Intel sources, by Objective 1.4:

| Source type | Examples | Trade-offs |
|---|---|---|
| **Open source** ([[OSINT]]) | VirusTotal, AlienVault OTX, abuse.ch, Twitter/X, [[blogs/forums]] | Free, broad, noisy. Lower confidence. |
| **Closed source** | Vendor portals, ISAC member-only feeds | Paid or membership. Higher confidence. |
| **Paid feeds** | Mandiant, CrowdStrike, Recorded Future | Expensive. High-confidence APT attribution. |
| **Government bulletins** | CISA alerts, FBI Flash, NCSC advisories, NSA cybersecurity advisories | Authoritative. Often the first naming of new APT campaigns. |
| **Deep/dark web** | Underground forums, leak sites | Specialized collection. Often via paid services or law enforcement liaison. |
| **Internal sources** | Your own [[EDR]] telemetry, past incidents, honeypot data | Most relevant to you specifically. Undervalued. |
| **ISACs / sharing orgs** | FS-ISAC, H-ISAC, E-ISAC | Sector-specific. Best context-aware feeds. |

Evaluate every feed on four axes:

- **Timeliness** — is the IoC fresh or already burned?
- **Relevancy** — does the actor target your sector?
- **Accuracy** — false-positive rate
- **Confidence level** — high/medium/low — what does the provider stand behind?

[[STIX]]/[[TAXII]] is the structured format for sharing this. [[Information sharing]] organizations (ISACs, CERT, [[CSIRT]]) coordinate distribution.

> **CompTIA exam trap:** CERT vs CSIRT. **CERT** (Computer Emergency Response Team) is a trademarked term originating at Carnegie Mellon; nationally it's often a coordinating body (US-CERT, now under CISA). **CSIRT** (Computer Security Incident Response Team) is the generic org-level team. On the exam: if the scenario is *your company's internal IR team*, it's CSIRT. If it's a *national or coordinating body publishing advisories*, it's CERT.

### Active defense and deception

APTs are patient, which means you can be patient back. [[Active defense]] is the spectrum between passive monitoring and outright hack-back (don't hack back — it's illegal in most jurisdictions).

- **[[Honeypot]]** — a fake server with no business purpose. Any traffic to it is suspicious by definition. Cheap APT canary.
- **Honeytoken** — fake credentials in a password vault, fake records in a database. If they appear in [[exfiltration]] traffic, you know exactly which system was breached.
- **Honeynet** — an entire fake subnet. Used by researchers and high-end SOCs.
- **[[Isolated networks]]** — air-gapped or tightly segmented enclaves for [[business-critical assets]]. APT41 has shown supply-chain attacks can cross air gaps via USB, so "isolated" is relative.

> **CompTIA exam trap:** APT is **not** [[hacktivist]], [[script kiddie]], or [[insider threat]] — those are separate threat actor categories. APT is specifically a *sophisticated, sustained, resourced* adversary, usually [[nation-state]]. CompTIA will offer "Anonymous launches a DDoS" as an APT distractor. That's hacktivism. APTs don't announce themselves on Twitter.

### Where APTs hurt — focus areas

- **Supply chain** — SolarWinds (APT29), 3CX (Lazarus), Kaseya. Compromise the vendor, get the customers for free.
- **Identity** — federation servers, AD, Okta, signing certs. Owning identity = owning the kingdom.
- **Edge devices** — VPN concentrators, firewalls, email gateways. Often unpatched, often internet-facing, often not running [[EDR]].
- **Cloud control planes** — AWS/Azure/GCP IAM, especially long-lived access keys.

## SOC reality

- Your SIEM doesn't alert "APT detected." It alerts on `lsass.exe` accessed by `rundll32.exe` from a temp directory at 2:14am, and you have ten minutes to decide if it's a pentest, a misconfigured tool, or Cozy Bear.
- L1 acknowledges, pulls the host into containment via [[EDR]], escalates to L2/IR. **Do not power off the host** — you lose memory artifacts. Network-isolate via EDR instead.
- The CISO's first three questions: *scope* (how many hosts?), *dwell time* (when did they get in?), *exfil* (did data leave?). You will not have answers in the first hour. Don't invent them.
- Never tell leadership "we're clean" after eradicating one [[backdoor]]. APTs plant multiple persistence mechanisms. *I learned this the hard way: re-imaging one box doesn't mean re-imaging the threat.*
- The handoff: L1 → L2 hunt → IR lead → external IR firm (Mandiant, CrowdStrike) for full-blown nation-state intrusions → legal → executive → law enforcement (FBI for US). Government bulletins flow back through CISA.
- Most "APT" alerts are pentests, red-team exercises, or sysadmins doing weird things. The 1% that aren't will define your career.

## Related concepts

[[Threat actors]] · [[Threat hunting]] · [[Threat intelligence]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[IoC]] · [[IoA]] · [[STIX]] · [[TAXII]] · [[OSINT]] · [[Nation-state]] · [[Organized crime]] · [[Insider threat]] · [[Hacktivist]] · [[Supply chain attack]] · [[Honeypot]] · [[Active defense]] · [[CSIRT]] · [[CERT]] · [[EDR]] · [[SIEM]] · [[Incident response]]

*Source: VIRGIL knowledge base — 2026-05-11*