# Attack Modeling and Analysis Frameworks

## What it is

In **Silent Hill**, the fog isn't just atmosphere — it's a render budget. The town hides what it can't show you. Harry Mason walks into Midwich Elementary with a radio that hisses static when monsters are near, a flashlight that draws their attention, and a map that only updates as he scribbles on it himself. He doesn't know what's hunting him, where it came from, or what it wants. He just builds a model of the town one room at a time: *the radio means contact, the locked door means come back later, the bloody hallway means the geometry is about to change.* By the end, he can predict the next monster from the room's shape.

That's exactly what attack modeling frameworks do — they're the map you scribble on while the adversary is still in the fog. You can't see the whole intrusion at once, but you can name what you've seen, slot it into a structured model, and predict what's coming next.

Technically: an attack modeling framework is a structured taxonomy for describing adversary behavior so defenders can correlate observations, share intelligence in a common language, and drive detection engineering. The four CySA+ frameworks are the **Lockheed Martin Cyber Kill Chain**, **MITRE ATT&CK**, the **Diamond Model of Intrusion Analysis**, and the **Unified Kill Chain**. Each one carves up the same intrusion from a different angle.

## Why it matters

You can't write a detection rule for "bad stuff." You write it for **T1059.001 — PowerShell** or for **Delivery via spearphishing attachment**. Frameworks give the SOC a shared vocabulary so an L1 analyst, an L3 threat hunter, a CISO, and an FBI liaison can all talk about the same incident without playing telephone.

For CS0-003 the frameworks land in **Objective 1.4** (threat intelligence and adversary behavior) and **Objective 3.3** (preparation — playbooks and tabletops reference these models constantly). CompTIA will absolutely hand you a scenario and ask which framework fits, or list a stage and ask which model it belongs to. Mixing them up is the #1 framework trap on this exam.

## Key facts

### Lockheed Martin Cyber Kill Chain — the linear story

Seven stages of an external intrusion, in order. Memorize the order; CompTIA scrambles it.

| # | Stage | What it looks like |
|---|-------|---------------------|
| 1 | **Reconnaissance** | OSINT, LinkedIn scraping, port scans, WHOIS, Shodan |
| 2 | **Weaponization** | Building the payload — malicious doc, exploit kit, packed binary |
| 3 | **Delivery** | Spearphishing email, watering hole, USB drop, exposed RDP |
| 4 | **Exploitation** | The vuln triggers — macro executes, CVE pops, credential stuffed |
| 5 | **Installation** | Persistence — scheduled task, registry Run key, service install |
| 6 | **Command and Control (C2)** | Beacon home — Cobalt Strike, DNS tunneling, HTTPS to a CDN |
| 7 | **Actions on Objectives** | Exfil, ransomware deploy, lateral movement, sabotage |

**Defender value:** the kill chain is sequential, so breaking any earlier link kills the whole intrusion. A blocked phishing email at stage 3 means stages 4–7 never happen. This is where "shift left" thinking comes from in detection engineering.

**Limitations:** built in 2011 for APT-style external attacks. Weak on insider threats, weak on cloud, weak on assume-breach scenarios where the adversary is already past stage 4 before you see them.

### MITRE ATT&CK — the behavior matrix

Not a chain. A **matrix** of **tactics** (the *why*) and **techniques** (the *how*). Currently 14 enterprise tactics across the columns, with hundreds of techniques and sub-techniques in the rows.

The 14 tactics, in order:

1. Reconnaissance
2. Resource Development
3. Initial Access
4. Execution
5. Persistence
6. Privilege Escalation
7. Defense Evasion
8. Credential Access
9. Discovery
10. Lateral Movement
11. Collection
12. Command and Control
13. Exfiltration
14. Impact

Each technique has a code: **T1566** is Phishing, **T1566.001** is the spearphishing-attachment sub-technique. Each one ships with detection guidance, mitigations, and a list of threat groups known to use it. APT29 (Cozy Bear) has a full profile. So does FIN7. So does the malware family Emotet.

**Where it shines:**
- **Detection engineering** — write a Sigma rule, tag it with the technique ID, you can measure coverage
- **Threat hunting** — pick a technique, hunt for it across the fleet
- **Purple teaming** — red team executes T1003.001 (LSASS dump), blue team confirms the alert fires
- **Reporting** — CISO asks "where are our gaps?" — you show an ATT&CK heatmap

**Sub-frameworks worth knowing:** ATT&CK for **Mobile**, ATT&CK for **ICS** (industrial control systems), and **PRE-ATT&CK** (folded into Recon and Resource Development in newer versions).

### Diamond Model — the four-vertex pivot

Four core features of any intrusion event. Imagine a diamond shape on the whiteboard:

```
        Adversary
           /\
          /  \
Infra ---+    +--- Capability
          \  /
           \/
          Victim
```

- **Adversary** — who. The threat group, the persona, the operator behind the keyboard.
- **Capability** — what they used. Malware family, exploit, tool, TTP.
- **Infrastructure** — what they ran it from. C2 domains, VPS providers, redirector IPs, compromised relay hosts.
- **Victim** — who or what they hit. The organization, the asset, the user account, the data.

**Meta-features** layer on top: timestamp, phase (often mapped to kill-chain stage), result, direction, methodology, resources.

**Why analysts love it:** pivot pivot pivot. You start with one vertex and pivot to the others. *I have a malware sample (capability) → it beacons to this IP (infrastructure) → that IP also showed up in last month's incident at a peer org (victim) → which means this is the same adversary cluster.* The Diamond Model is the framework that makes threat intel feel like detective work.

**Best for:** intel correlation, campaign tracking, attribution analysis, and writing the "what we know about this actor" section of an IR report.

### Unified Kill Chain — the merger

Paul Pols' 2017/2022 framework. Eighteen phases. Combines the linear story of the Kill Chain with the behavioral granularity of ATT&CK, and explicitly handles **internal** attacker movement (the part Lockheed Martin glossed over).

Three meta-phases:
1. **In** — Recon, Weaponization, Delivery, Social Engineering, Exploitation, Persistence, Defense Evasion, Command and Control
2. **Through** — Pivoting, Discovery, Privilege Escalation, Execution, Credential Access, Lateral Movement
3. **Out** — Collection, Exfiltration, Target Manipulation, Objectives

Useful conceptually. Lighter on the exam — CompTIA will name-drop it but not test the 18 phases in order.

### How they compose in practice

| Question you're asking | Framework |
|-----------------------|-----------|
| What stage of the attack are we at? | Kill Chain |
| What technique fired and how do we detect it? | MITRE ATT&CK |
| Who is this and what else have they done? | Diamond Model |
| End-to-end including lateral movement? | Unified Kill Chain |

They're not competitors. A mature SOC uses all four — Kill Chain on the executive slide, ATT&CK in the SIEM, Diamond Model in the intel platform, Unified Kill Chain in the tabletop exercise.

### CompTIA exam traps

> **CompTIA exam trap — framework mismatch.** Lockheed Martin = **linear seven-stage chain**. MITRE = **behavioral matrix of tactics and techniques**. Diamond = **four vertices (Adversary, Capability, Infrastructure, Victim)**. Unified = **merger of Kill Chain and ATT&CK with 18 phases**. If the question says "matrix" the answer is ATT&CK. If it says "four core features" the answer is Diamond. If it says "seven stages" the answer is Kill Chain. CompTIA writes the distractors to look interchangeable on purpose.

> **CompTIA exam trap — Kill Chain stage order.** Reconnaissance → Weaponization → Delivery → Exploitation → Installation → C2 → Actions on Objectives. CompTIA will swap Delivery and Exploitation, or put Installation before Exploitation. The mnemonic that survives 3am: *Recon, Weaponize, Deliver, Exploit, Install, Control, Act.*

> **CompTIA exam trap — Diamond Model vertices.** It is NOT a kill chain. It does NOT have stages. It has **four vertices** describing a single event. If you see "stages" or "phases" with Diamond Model in the same answer, that answer is wrong.

> **CompTIA exam trap — ATT&CK is not a methodology.** It's a knowledge base. You don't "perform ATT&CK on a host." You map observed behavior *to* ATT&CK technique IDs. Watch for answer choices that conflate ATT&CK with a scanning tool or assessment process.

### Where frameworks live in the IR life cycle

CompTIA's incident response life cycle (Objective 3.3) maps onto these frameworks at every phase:

- **Preparation** — playbooks reference ATT&CK technique IDs; tabletop exercises walk a scenario through the Kill Chain so each role (SOC, IR, legal, comms) knows their stage; training uses Diamond Model to teach pivot thinking.
- **Detection and Analysis** — alerts get tagged with ATT&CK IDs in the SIEM; analysts use the Kill Chain to estimate how deep the adversary already is.
- **Containment, Eradication, Recovery** — containment priorities depend on stage. Kill at Delivery = block sender. Kill at C2 = sinkhole the domain. Kill at Actions on Objectives = pull the plug and pray your backups are clean.
- **Post-incident Activity** — root cause analysis writes the timeline in Kill Chain order; lessons learned identifies which ATT&CK techniques had no detection coverage; the Diamond Model writeup feeds the threat intel platform so the next victim isn't you.

## SOC reality

- The SIEM alert at 3am won't say "Stage 5 — Installation." It'll say *"suspicious registry Run key write by winword.exe child process."* You map it: T1547.001 Registry Run Key, sub-technique of Persistence. Now you know stage 5 fired, which means stages 1–4 already happened and you missed them. Go find them.
- The CISO does not want to hear "we saw some weird PowerShell." The CISO wants to hear *"adversary completed Initial Access and Execution; we contained at Persistence; no evidence of Lateral Movement, Exfiltration, or Impact."* That sentence is only possible because of ATT&CK.
- Threat intel feeds dump indicators all day. The Diamond Model is what stops them from being noise. *This IP (infrastructure) hosted this malware (capability) used by this group (adversary) against this sector (victim).* Now it's intelligence, not a CSV row.
- Tabletop exercises that work always pick a Kill Chain stage and ask: *"the adversary is here — what do you do?"* Tabletops that don't work ask *"there's a breach, discuss."* Frameworks turn a bull session into a drill.
- Never tell leadership "we're at stage 7." Tell them which observables you have for each stage, and which stages you have *no visibility into.* The gaps are the actual story. Frameworks make the gaps legible.

## Related concepts

[[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[Unified Kill Chain]] · [[Threat Intelligence]] · [[Indicators of Compromise]] · [[Threat Hunting]] · [[SIEM]] · [[Detection Engineering]] · [[Tabletop Exercise]] · [[Incident Response Plan]] · [[Playbooks]] · [[Root Cause Analysis]] · [[Lessons Learned]]

*Source: VIRGIL knowledge base — 2026-05-11*