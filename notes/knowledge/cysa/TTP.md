# TTP — Tactics, Techniques, and Procedures

## What it is

In **Destiny**, every veteran raider knows what a Hive Knight does before it does it. The **tactic** is *deny ground* — the Knight wants you off the plate. The **technique** is the **Wall of Darkness**, that suppressive shield it slams in front of itself. The **procedure** is the exact animation tell: it crouches, the screen darkens, the wall renders 4m in front, the wall lasts ~8 seconds, and if you walk through it your Light gets suppressed and a Boomer rocket clips you from the flank. Tactic, technique, procedure — three layers, top down, getting more specific each step.

That's exactly what TTPs are in threat intelligence — three layers of describing how an adversary actually fights, from their strategic goal down to the keystrokes on the keyboard.

**Plain English:** TTPs are how you describe what an attacker *does*, not what they *use*. A malware hash is a tool. A TTP is the playbook the attacker runs with that tool — and unlike the hash, the playbook is expensive for the attacker to change.

**Technical (CS0-003):** **Tactics, Techniques, and Procedures** are the behavioral fingerprint of a threat actor, organized hierarchically. **Tactics** are the adversary's tactical goals during an intrusion (the *why* of an action — e.g., Initial Access, Persistence, Exfiltration). **Techniques** are the general means of achieving a tactic (the *how* — e.g., Spearphishing Attachment, Scheduled Task). **Procedures** are the specific implementation a given actor uses (the *exactly how* — e.g., "APT29 sends an .ISO container with an LNK that launches HTA via mshta.exe pointing at a Cobalt Strike beacon on port 443"). TTPs sit at the top of the Pyramid of Pain — they are the **most expensive indicator for an adversary to change**, and therefore the most valuable for defenders to detect on.

## Why it matters

TTPs are the layer where threat intel stops being a feed of hashes and becomes a hypothesis you can hunt on. CS0-003 Objective 1.4 explicitly puts TTPs inside the threat-intel and threat-hunting comparison — the exam wants you to know that IoCs answer "did this *happen*?" while TTPs answer "is something *like this* happening anywhere in my environment?"

Operationally, TTPs are how a SOC matures. A junior team blocks hashes. A senior team writes detections for behaviors. Hashes rotate every build; TTPs rotate every six to eighteen months because changing them means retraining operators, rewriting tooling, and re-validating the kill chain. APT29 has been using DLL search-order hijacking since before some L1 analysts could drive. That's the leverage.

For the exam: TTPs anchor MITRE ATT&CK, threat actor attribution, and the higher-confidence end of the threat intel spectrum. Expect questions that ask you to differentiate TTPs from IoCs, place TTPs on the Pyramid of Pain, and identify which intelligence type best supports proactive threat hunting.

## Key facts

### The three layers, precisely

| Layer | Question it answers | Example (Initial Access) | Volatility |
|---|---|---|---|
| **Tactic** | Why? (strategic goal) | Initial Access — get a foothold | Lowest — adversaries always need it |
| **Technique** | How? (general method) | Spearphishing Attachment | Low — small set of viable methods |
| **Procedure** | Exactly how? (implementation) | Macro-enabled .docm spoofing HR, payload via certutil.exe staging | Higher — actor-specific, but still expensive to change |

The hierarchy is strict: a procedure implements a technique, a technique achieves a tactic. ATT&CK formalizes this — Tactics are columns, Techniques (and sub-techniques) are cells, Procedures are documented in the technique pages as actor-attributed examples.

### The Pyramid of Pain (David Bianco) — where TTPs sit

From easy-to-change (bottom, cheap intel) to hard-to-change (top, expensive intel):

1. **Hash values** — trivial to change (recompile)
2. **IP addresses** — easy (new VPS)
3. **Domain names** — annoying (DGA, new registration)
4. **Network/host artifacts** — moderate (mutex names, UA strings)
5. **Tools** — hard (build/buy new tooling)
6. **TTPs** — **very hard** (retrain the operators)

Detecting on TTPs forces the adversary to change *how they operate*, not just what they operate with. That's the goal.

### TTPs vs IoCs — the exam-relevant distinction

- **IoCs (Indicators of Compromise)** are forensic artifacts — a hash, a C2 IP, a registry key, a filename. They answer *did the bad thing happen here?* Reactive.
- **TTPs** are behavioral patterns — *how* an adversary operates. They answer *is anything in my environment behaving the way APT41 behaves?* Proactive — they fuel threat hunting.

> **CompTIA exam trap:** A question describes "the SHA-256 hash of a malicious loader." That is an **IoC**, not a TTP. A question describes "the adversary uses scheduled tasks for persistence and exfiltrates via DNS TXT records" — that is a **TTP**. CompTIA will list both and ask which fuels proactive hunting. Answer: TTPs.

### MITRE ATT&CK — the canonical TTP catalog

ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge) is the framework that operationalized TTPs:

- **14 Enterprise tactics** (Reconnaissance → Impact) — the kill chain in matrix form
- **~200 techniques** and **~400 sub-techniques** under those tactics
- **Procedure examples** attributed to specific named groups (APT28, FIN7, Lazarus, etc.)

ATT&CK gives every TTP a stable ID (e.g., T1566.001 = Spearphishing Attachment). When threat intel reports cite "T1059.001 PowerShell" they're speaking ATT&CK — a shared vocabulary so the SOC, the IR team, and the CTI analyst all mean the same thing.

### Threat actor classes and their TTP signatures

| Actor type | Typical TTP profile |
|---|---|
| **Nation-state / APT** | Custom malware, living-off-the-land (LOLBins), long dwell time, careful OPSEC, supply-chain compromise, zero-days |
| **Organized crime** | Ransomware affiliates, double extortion, RaaS playbooks, initial access brokers, Cobalt Strike + Mimikatz + PsExec |
| **Hacktivists** | Web defacement, DDoS, data leak for PR, low sophistication but loud |
| **Insider threat (intentional)** | Legitimate creds, data staging to USB/cloud, off-hours access, no malware needed |
| **Insider threat (unintentional)** | Misconfig, phishing victim, shadow IT — not an actor, an enabler |
| **Script kiddie** | Public exploits, Metasploit defaults, no persistence discipline |

Each class has a TTP fingerprint. CTI teams use these fingerprints for attribution — though attribution is *hard* and should ride on confidence levels, never certainty.

### Collection sources that feed TTP intelligence

CS0-003 wants you to know intel sources:

- **Open source (OSINT):** ATT&CK, vendor blogs, security researcher Twitter/Mastodon, GitHub PoCs
- **Closed source / paid feeds:** Mandiant, CrowdStrike, Recorded Future — curated, attributed, faster
- **Government bulletins:** CISA advisories, US-CERT, NCSC, FBI Flash reports
- **Information Sharing Organizations:** ISACs (FS-ISAC, H-ISAC), ISAOs, MISP communities
- **Deep/dark web:** forum chatter, leak sites, IAB listings — actor TTPs surface here before they hit corporate networks
- **Blogs/forums and social media:** noisy but timely
- **Internal sources:** your own IR retros, honeypots, SIEM patterns — the highest-relevancy intel you'll ever get because it's *yours*

### Intel quality criteria (exam favorites)

Every piece of TTP intel must be evaluated on:

- **Timeliness** — is it current? TTPs from 2019 against a 2026 adversary may be stale
- **Relevancy** — does it apply to your sector, geography, tech stack?
- **Accuracy** — confirmed by multiple sources, or single-source rumor?
- **Confidence level** — Admiralty code, MITRE confidence tiers, or simple high/med/low

> **CompTIA exam trap:** "Confidence level" is not the same as "accuracy." Accuracy is whether the data is correct. Confidence is *how sure the analyst is* that the data is correct, given the source and corroboration. CompTIA will write a question where the right answer hinges on that distinction.

### How TTPs drive detection engineering

The pipeline:

1. **CTI** consumes a report: "TA0011 / T1071.004 — adversary using DNS over HTTPS to a Cloudflare worker for C2."
2. **Detection engineering** writes a Sigma/Splunk/Sentinel rule: alert on outbound DoH from non-browser processes.
3. **Threat hunting** runs the hypothesis against 90 days of historical telemetry to find pre-existing compromise.
4. **IR** uses the same TTP knowledge during containment — if you know they use scheduled tasks for persistence, you know what to check.
5. **Active defense / honeypots** are tuned to attract and observe these specific TTPs.

### Focus areas — where TTPs matter most

Prioritize TTP coverage on **business-critical assets**: domain controllers, identity providers, payment systems, source code repos, OT/SCADA on isolated networks, supply-chain ingress points, application infrastructure. CompTIA wants you to map TTP detections to crown-jewel assets, not spread coverage evenly across every host.

## SOC reality

- **The 3am alert:** "T1003.001 — LSASS memory access by non-system process on FIN-DC-02." That's a TTP-based detection (credential dumping). L1 doesn't need to know what hash was used — the *behavior* fired the rule. Acknowledge, pull the process tree, check parent process, escalate to L2 if it's not a sanctioned EDR vendor scan.
- **What the IR lead asks:** "Which ATT&CK techniques have we confirmed, and which are hypothesized?" Confirmed techniques drive containment scope. Hypothesized techniques drive hunting queries.
- **What never to promise leadership:** "We've attributed this to APT29." Attribution on TTPs alone is *suggestive*, not conclusive. Multiple groups copy each other's playbooks. Say "TTPs consistent with APT29 tradecraft" and let the CTI team own the confidence call.
- **The handoff:** L1 triages the IoC-driven alert. L2 pivots on TTPs — "if we see T1003, we should also look for T1078 and T1021 in the next 48 hours." Senior analysts and threat hunters live in the TTP layer. CTI feeds them. IR consumes them during the incident, then writes them back to the team during the post-incident retro.
- **The tuning truth:** TTP-based detections have higher false-positive rates than hash-based ones because behavior is fuzzier than bytes. *A TTP rule that never fires is dead; a TTP rule that fires constantly is noise. Tuning is the entire job.*

## Related concepts

[[MITRE ATT&CK]] · [[Pyramid of Pain]] · [[Indicators of Compromise]] · [[Threat Hunting]] · [[Threat Intelligence Lifecycle]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[Advanced Persistent Threat]] · [[STIX TAXII]] · [[Detection Engineering]] · [[Honeypot]] · [[Active Defense]] · [[ISAC]] · [[Confidence Levels]] · [[CSIRT]] · [[Threat Actors]]

*Source: VIRGIL knowledge base — 2026-05-11*