# IoC — Indicators of Compromise

## What it is

In **Sonic the Hedgehog**, you know Robotnik's been through a zone before you ever see him. The badniks are wrong — a Motobug where a Crabmeat should be. A capsule of flickies cracked open and empty. Rings scattered in a pattern that says somebody got hit at full speed right here. You haven't caught Robotnik. You're reading the trail he left in the level geometry.

That's exactly what an Indicator of Compromise is — physical evidence in your environment that an attacker has already been there, or is there now, left behind in logs, files, registry keys, network flows, and process trees.

Technically: an **IoC** is any observable artifact — a hash, an IP, a domain, a file path, a registry mod, a process behavior, an authentication anomaly — that, when present, suggests a system has been compromised. IoCs are **forensic and retrospective** by nature. They describe what happened or is happening. They are the breadcrumb trail of the intruder, and they are the raw fuel of every [[SIEM]] correlation rule, [[EDR]] detection, and threat hunt your SOC runs.

CompTIA's CS0-003 puts IoCs at the center of Objective 1.4 — threat intelligence and threat hunting. You consume IoCs from feeds, generate IoCs from your own incidents, and apply IoCs through detection tooling. The lifecycle has three lenses: **collection, analysis, application**.

## Why it matters

An IoC is the difference between knowing you got breached and reading about it in the news six months later. The 2020 industry average dwell time — the gap between initial access and detection — was measured in months for a reason: nobody was looking for the right artifacts. If you can't recognize the badnik pattern, Robotnik finishes the zone.

For the CySA+ analyst, IoCs show up in three exam-relevant places:

- **Objective 1.3** — vulnerability management uses IoCs to validate exploited-in-the-wild status.
- **Objective 1.4** — threat intelligence consumes and produces them.
- **Objective 3.x** — incident response detection, containment, and post-incident lessons learned all turn on them.

On the job, an IoC is what gets typed into the search bar when someone in leadership asks, *"are we affected by that thing in the news?"* If you don't have an answer in under an hour, you have a tooling problem, a data problem, or a staffing problem — pick at least one.

## Key facts

### The three lenses (CompTIA's IoC lifecycle)

| Lens | What it is | Tooling | Output |
|---|---|---|---|
| **Collection** | Pulling artifacts from endpoints, network, cloud, identity, threat feeds | [[EDR]], [[SIEM]], NetFlow, DNS logs, [[STIX/TAXII]] feeds | Raw observables |
| **Analysis** | Determining whether an observable actually indicates compromise | Analyst, threat intel platform, sandbox, enrichment APIs | Verdict + context |
| **Application** | Feeding confirmed IoCs back into detection, blocking, and hunting | Firewall blocklists, EDR custom rules, SIEM correlation, SOAR playbooks | Defense improvement |

The full loop is the value. Collection without analysis floods the queue with noise. Analysis without application means you confirm the breach but never stop the next one.

### The Pyramid of Pain (David Bianco)

CompTIA doesn't name the pyramid explicitly, but it shapes how the exam asks about IoC quality. The higher you go, the more it hurts the adversary to change.

| Tier | IoC type | Pain to attacker |
|---|---|---|
| 1 (bottom) | Hash values | Trivial — recompile |
| 2 | IP addresses | Easy — new VPS |
| 3 | Domain names | Moderate — register new domain |
| 4 | Network/host artifacts | Annoying — change tooling output |
| 5 | Tools | Hard — develop new malware |
| 6 (top) | **TTPs** (Tactics, Techniques, Procedures) | Painful — change behavior |

*Hashes and IPs are the cheap end. Behavioral IoCs — the TTPs — are what catch [[APT]] groups that swap infrastructure every week.*

### Common IoCs by category

**Account / authentication**
- Logins at odd hours from impossible-travel geolocations
- Dormant account suddenly active
- Privileged account used outside its normal scope
- Failed-login bursts followed by one success (password spray)
- Service account interactive logon

**Host**
- Unexpected scheduled tasks or services
- New autorun keys in the registry
- `powershell.exe -EncodedCommand` from a user document folder
- Process tree where Word spawned cmd.exe spawned a network connection
- Unusual parent-child process relationships

**File / configuration**
- Hash matches a known-bad sample
- File written to `C:\Windows\Temp\` then executed
- Sysinternals tools (PsExec, ProcDump) on a workstation that shouldn't have them
- Unsigned binary in a privileged path
- Group Policy or local security policy modification

**Network**
- Beaconing — regular periodic callouts to an external host
- Large outbound transfer at 2am to a destination you've never sent to before
- DNS queries to algorithmically generated domains (DGA)
- Traffic on a non-standard port (port 443 carrying non-TLS, or TLS on port 8080)
- Connection to known [[C2]] infrastructure

**Cloud / identity**
- OAuth token grant to an unfamiliar app
- New IAM principal created outside change window
- Disabled logging in a cloud account
- Mass file access in SharePoint or Google Drive
- MFA enrollment from an unmanaged device

### IoC vs IoA

> **CompTIA exam trap:** IoC is **retrospective** — what happened. IoA (Indicator of Attack) is **behavioral and in-progress** — what's happening now. An IoC says "this hash matched a Cobalt Strike beacon." An IoA says "a process is currently exhibiting beaconing behavior, regardless of hash." CompTIA will give you a scenario describing live behavior and offer "IoC" as a tempting wrong answer. If it's happening right now and described as a pattern of action, it's an IoA.

### Sources of IoCs

**Internal sources** (highest relevance, lowest volume)
- Your own past incidents — every breach generates IoCs you should be hunting for tomorrow
- [[EDR]] and [[SIEM]] alerts that escalated to confirmed compromise
- Honeypot and deception tech captures

**External — open source**
- [[OSINT]] feeds (AlienVault OTX, abuse.ch, MISP communities)
- Vendor blogs and threat reports
- Government bulletins ([[CISA]] advisories, US-CERT, sector ISACs)
- Social media (Twitter/X infosec community moves faster than vendors)

**External — closed / paid**
- Commercial threat intel platforms (Mandiant, Recorded Future, CrowdStrike Falcon Intel)
- ISAC/ISAO memberships for your sector
- Deep and dark web monitoring (credential dumps, ransomware leak sites)

### Evaluating IoC feeds — the four quality dimensions

CompTIA tests this directly.

| Dimension | Question to ask |
|---|---|
| **Timeliness** | How old is this IoC? A C2 IP from 18 months ago is probably reassigned. |
| **Relevancy** | Does this apply to my sector, my stack, my geography? |
| **Accuracy** | What's the false-positive rate? Is `8.8.8.8` going to end up on this blocklist? |
| **Confidence level** | Is this a vetted IoC or a community-submitted observable nobody validated? |

*A high-volume free feed with no confidence scoring will brick your firewall and burn your analyst hours. Pay for fewer, better IoCs.*

### Information sharing

- **[[STIX]]** — Structured Threat Information Expression. Standardized format for describing threat data.
- **[[TAXII]]** — Trusted Automated Exchange of Indicator Information. The transport protocol that moves STIX bundles between organizations.
- **ISACs** — Information Sharing and Analysis Centers, organized by sector (FS-ISAC for financial, H-ISAC for health, E-ISAC for electricity).
- **MISP** — open-source threat intel platform widely used for community sharing.

> **CompTIA exam trap:** STIX is the **format**. TAXII is the **transport**. Easy to swap. Mnemonic: STIX is the *expression* (the words), TAXII is the *taxi* (the ride).

### Threat actor mapping to IoC behavior

The actor profile predicts the IoC type you'll see.

| Actor | Typical IoCs |
|---|---|
| **Script kiddie** | Known public exploit signatures, default Metasploit artifacts, noisy scans |
| **Hacktivist** | Web defacement, public-facing DDoS, doxxed credentials |
| **Organized crime** | Ransomware family hashes, double-extortion leak site mentions, off-the-shelf C2 (Cobalt Strike) |
| **Insider threat** | Anomalous data access, USB mass-storage events, off-hours sensitive file reads |
| **[[APT]] / nation-state** | Custom malware, living-off-the-land binaries, low-and-slow beaconing, supply chain implants |

The lower-tier actors leave hash and IP IoCs you can blocklist in a morning. The nation-state actor leaves TTPs you have to hunt for over weeks.

## SOC reality

- **3am alert.** Your [[SIEM]] fires on a custom rule built from a [[CISA]] advisory: outbound DNS to a domain matching the IoC list. L1 acknowledges, confirms the source host, and checks whether anyone else in the environment hit the same domain in the last 30 days. If yes, you have a campaign, not a one-off.
- **First action is enrichment, not isolation.** Pull the process tree on the host, the user, the parent process, the network destination. A single IoC hit is often a false positive — a researcher VM, a security tool's own callback, a stale cached DNS entry. Isolate prematurely and you'll page the wrong VP at 4am.
- **The CISO asks three things.** *"Scope — how many hosts? Impact — what data could they reach? Evidence — is it preserved?"* If you can't answer scope inside an hour, your IoC application layer is broken.
- **Never promise a clean environment from a single IoC sweep.** *"We searched for these 12 hashes and found nothing"* is not the same as *"we are not compromised."* A determined adversary recompiles. The hash search clears the question for *that specific build* and nothing else.
- **The handoff.** L1 confirms the IoC hit and enriches. L2 / threat hunter pivots — what else did that host do, what else did that user touch, are there sibling IoCs in the same campaign report. IR lead owns the containment call. Legal gets looped in the moment data exfiltration is plausible.

## Related concepts

[[Threat Intelligence]] · [[Threat Hunting]] · [[APT]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[SIEM]] · [[EDR]] · [[STIX]] · [[TAXII]] · [[OSINT]] · [[C2]] · [[Incident Response]] · [[Honeypot]] · [[CISA]] · [[Pyramid of Pain]] · [[TTPs]]

*Source: VIRGIL knowledge base — 2026-05-11*