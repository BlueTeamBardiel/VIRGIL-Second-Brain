# Threat Actors

## What it is

In **Silent Hill**, the fog isn't the threat. The fog is what hides the threats — and every monster shambling through it has a different origin story. The faceless nurses came from James's guilt. Pyramid Head is judgment, deliberate, executing a sentence. The lying figures are someone else's trauma made flesh. The radio static doesn't tell you *which* one is coming, only that something is, and you'd better know your enemy before it closes the distance, because the rusty pipe that works on a nurse won't do much against the thing waiting at the end of the hall. That's exactly what threat actor analysis does — you classify the adversary by motive, capability, and behavior so you know what tools, controls, and response posture you actually need.

**Plain English:** Not every attacker wants the same thing or fights the same way. A bored teenager with a Metasploit module is not the same problem as a Chinese state intel team with a zero-day stockpile. You map who they are, what they want, and how they operate. Then you defend accordingly.

**Technical (CS0-003 1.4):** A **threat actor** is any entity — individual, group, or nation — with the intent and capability to cause harm to an organization's information assets. Threat intelligence analysis profiles actors across motivation, sophistication, resources, typical [[TTPs]] (Tactics, Techniques, and Procedures), and likely targets. This profiling feeds [[Threat Hunting]], [[Detection and Monitoring]], and [[Incident Response]] prioritization.

## Why it matters

You can't defend equally against everything. A small healthcare clinic has a vastly different threat surface than a defense contractor — same CVEs in the patch pipeline, completely different prioritization. Threat actor classification drives risk-based [[Vulnerability Management]], [[Security Engineering]] controls selection, and where you spend your SOC analyst hours.

CompTIA tests this in CS0-003 Objective 1.4 directly: given a scenario, identify the likely actor and what their presence implies for response. Tier-1 analysts who can name the actor on sight escalate faster and make fewer wrong calls.

## Key facts

### The actor taxonomy

| Actor | Motivation | Sophistication | Resources | Typical TTPs |
|---|---|---|---|---|
| **Nation-state / APT** | Espionage, geopolitical, sabotage | Very high | Effectively unlimited | Zero-days, custom malware, [[Living Off the Land]], long dwell time |
| **Organized crime** | Financial | High and rising | Significant — RaaS economy | [[Ransomware]], BEC, banking trojans, data theft for extortion |
| **Hacktivist** | Ideological, political | Low to medium (varies wildly) | Crowdsourced | DDoS, web defacement, doxxing, leak sites |
| **Insider — intentional** | Revenge, greed, ideology | Variable, but knows your environment | Already authenticated | Data exfil, sabotage, credential abuse |
| **Insider — unintentional** | None — they screwed up | N/A | N/A | Misconfig, phishing victim, lost laptop, shadow IT |
| **Script kiddie** | Curiosity, clout | Low | Free tools off GitHub | Scanned exploits, default creds, public PoCs |
| **Supply chain** | Varies — often nation-state in disguise | High | High | Compromise vendor, push malicious update downstream |

### Nation-state and APT

The **[[Advanced Persistent Threat]]** is the label, but the words matter: **advanced** (custom tooling, zero-days, operational security), **persistent** (months to years of dwell time), **threat** (specific intent, specific target). They are not noisy. They are not opportunistic. They are reading your Outlook calendar to time the C2 beacon to coincide with the all-hands meeting.

Named groups you'll see in feeds: APT28 / Fancy Bear (Russia, GRU), APT29 / Cozy Bear (Russia, SVR), APT41 (China, dual espionage + financial), Lazarus (DPRK, financial + sabotage), Equation Group (US-attributed). MITRE ATT&CK maps each to documented TTPs — that's the lookup table when an alert pattern starts smelling state-sponsored.

> **CompTIA exam trap:** APT means the *actor*, not the *malware*. A piece of malware isn't "an APT" — it's a tool used by an APT group. CompTIA will offer "the ransomware was an APT" as a distractor. Wrong. The *group* behind it is the APT, if they meet the advanced + persistent + targeted bar.

### Organized crime

The professionalized middle. Ransomware-as-a-Service (RaaS) operators like LockBit, BlackCat/ALPHV, and their successors run affiliate programs, customer support portals, and bug bounties on their own malware. They have HR problems. They pay in crypto. They negotiate.

Financially motivated, which is the key tell — they hit whoever pays, not whoever's strategically interesting. If your incident shows clean encryption, professional ransom note with a .onion negotiation portal, and a leak-site countdown, you're looking at organized crime, not a nation-state. *Nation-states don't usually need your money.*

### Hacktivists

Anonymous-flavored. Capability varies from "12-year-old running LOIC" to "former blackhat with a grievance." Motivation is the signal: defacements with manifestos, DDoS against ideologically-tagged targets, dumps to leak sites. Election cycles, protest movements, geopolitical flashpoints all spike hacktivist activity.

Don't dismiss them. A low-skill hacktivist with a credential dump from someone else's breach can still wreck your day if you reuse passwords.

### Insider threats

The hardest class to detect because their traffic looks legitimate — *because it is*. They authenticated. They have a badge. The DLP rule doesn't fire because they're allowed to touch that share.

- **Intentional:** disgruntled employee, recruited asset, financial pressure. Watch for behavioral anomalies — odd-hours access, mass downloads, USB usage spikes, sudden interest in systems outside their role.
- **Unintentional:** clicks the phish, misconfigures the S3 bucket, emails the customer list to "themselves" at the wrong address. Most insider incidents fall here. *They're not malicious; they're tired.*

UEBA (User and Entity Behavior Analytics) tooling exists specifically because signature-based detection can't see insiders. Baseline behavior, alert on deviation.

### Script kiddies

Low sophistication, high noise. They run Metasploit modules, scrape Shodan, fire off public exploits at random IPs. Easy to catch — but if your patching is six months behind, the kiddie's prebuilt exploit works just fine. *Don't let the low skill ceiling fool you into thinking the impact ceiling is low too.*

### Supply chain actors

The category that ate the threat model. SolarWinds (2020) — nation-state (APT29) compromised the build system, pushed a backdoored Orion update to 18,000 customers. Kaseya, 3CX, MOVEit — same pattern, different vector. You didn't get breached. Your vendor did. Then their patch breached you.

This is why [[Software Bill of Materials]] (SBOM), vendor risk management, and [[Configuration Management]] of third-party software now sit on the same priority list as patching your own code.

## Intelligence sources

You don't profile actors by guessing. Threat intelligence comes from defined collection methods:

| Source | Type | What you get |
|---|---|---|
| **OSINT** (open source) | Free, public | Blogs, forums, social media, news, public reports |
| **Closed source** | Vendor / paid feeds | Curated IoCs, attribution, faster timeliness |
| **Government bulletins** | CISA, NCSC, FBI Flash, US-CERT alerts | Authoritative, often sector-specific |
| **ISACs / ISAOs** | Sector sharing groups | Peer-shared IoCs, financial services, healthcare, energy |
| **Deep / dark web** | Underground forums, marketplaces | Pre-attack chatter, leaked credentials, exploit sales |
| **Internal sources** | Your own SIEM, IR reports, honeypots | Highest relevancy — it's literally about you |
| **STIX/TAXII** | Structured threat intel transport | Machine-readable IoCs and TTPs for SIEM ingestion |

### The three quality dimensions

Every intel item is graded on:

- **Timeliness** — is it fresh enough to act on? An IoC from six months ago may already be burned infrastructure.
- **Relevancy** — does this actor target your sector, region, tech stack? Generic feeds are noise; sector-specific feeds are signal.
- **Accuracy** — has the source been right before? What's the confidence level — confirmed, probable, possible?

**Confidence levels** are usually expressed as low/medium/high or via the Admiralty Code. You report intel *with* its confidence level. Never strip the qualifier — leadership will treat "possible" as "confirmed" if you let them.

> **CompTIA exam trap:** Information sharing organizations like ISACs are *not* the same as CSIRTs. ISAC = intelligence sharing (peer-to-peer, sector-specific). CSIRT / CERT = the incident response team (yours or national). CompTIA loves to swap these in answer choices.

## From intel to action

Threat actor profiling feeds three operational workflows:

1. **[[Threat Hunting]]** — proactive search for actor TTPs in your environment, not waiting for alerts. Hypothesis-driven: "If APT29 were here, what would I see?" Then go look.
2. **Detection engineering** — building SIEM rules and EDR detections tuned to the specific TTPs of likely actors. Generic rules generate noise; actor-specific rules generate hits.
3. **[[Active Defense]]** — honeypots, decoy credentials, deception tech. Make your environment hostile to the actors you actually expect.

Your **business-critical assets** dictate prioritization. The crown-jewel database matters more than the marketing CMS. Map actors to assets — who would want this, and what would they do with it — and you've built a risk-weighted defense plan instead of a checklist.

## SOC reality

- The 3am alert says "suspicious PowerShell on FIN-DB-03." Your first move isn't running the playbook — it's checking threat intel: any recent campaigns hitting financial sector with PowerShell? Any IoCs from the last 30 days that match this hash, IP, or command line? Context first, action second.
- The CISO asks "is this nation-state?" before you have any evidence. The honest answer is *"too early — current indicators are consistent with commodity ransomware staging, but we're preserving evidence and continuing analysis. I'll have a confidence assessment in two hours."* Never attribute fast. Attribution is for the post-incident report, not the war-room call.
- Tier-1 analysts close 80% of "threat actor" tickets as script-kiddie scanner noise. The remaining 20% is where the career happens — recognizing when the noise stops looking like noise.
- Insider cases get routed differently. Loop in HR and legal *before* you confront. Evidence preservation rules tighten. Don't tip the subject — they have console access and they will burn it.
- Never tell leadership "we've identified the threat actor" based on one IP geolocation or one tool. *Attribution is a confidence spectrum, not a binary.* The CFP-grade IR report has multiple corroborating data points and a stated confidence level. Anything less is a guess wearing a suit.

## Related concepts

[[Threat Intelligence]] · [[Threat Hunting]] · [[Advanced Persistent Threat]] · [[Indicators of Compromise]] · [[TTPs]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[Incident Response]] · [[Vulnerability Management]] · [[Insider Threat]] · [[Supply Chain Attack]] · [[Active Defense]] · [[Honeypot]] · [[STIX-TAXII]] · [[Risk Management]]

*Source: VIRGIL knowledge base — 2026-05-11*