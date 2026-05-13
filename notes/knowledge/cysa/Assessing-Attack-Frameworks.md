# Assessing Attack Frameworks

## What it is

In **DayZ**, you spawn on the coast with a flashlight and a can of beans. The map you choose to play — Chernarus, Livonia, Namalsk — dictates everything: Chernarus is dense forest and Soviet-era villages, Livonia is open farmland with wolves, Namalsk is a frozen hellscape where you die of hypothermia before a player ever shoots you. A veteran picks the map based on how they want to play and what threats they can handle. Bringing a Chernarus loot route to Namalsk gets you killed by the cold before you find a coat. That's exactly what assessing attack frameworks does — you don't pick one because it's famous, you pick the one that matches your terrain, your threats, and the gear your team actually has.

In CySA+ terms, **assessing attack frameworks** is the analyst's job of evaluating which adversary model — Lockheed Martin Cyber Kill Chain, MITRE ATT&CK, the Diamond Model, OWASP, or some hybrid — actually fits the organization's threat landscape, business context, and defender maturity. No framework is universal. The framework is a lens; you choose the lens that brings *your* attackers into focus.

## Why it matters

CompTIA tests this under Objective 3.3 (Preparation phase of incident management). The exam treats framework selection as a **preparation activity** — you bake the framework into your playbooks, your detection engineering, your training, and your post-incident reporting *before* the incident hits. Pick the wrong framework, or stack three of them with no integration, and your IR team is speaking different languages mid-pull.

Career relevance is bigger than the test. Job descriptions for SOC L2, threat hunter, and detection engineer roles will name-drop ATT&CK like it's table stakes. But mature shops use ATT&CK *plus* Diamond Model for attribution work, *plus* Kill Chain for executive briefings — because each framework answers a different question. A CySA+ analyst who can articulate why is the one who gets the L3 promotion.

## Key facts

### The four frameworks CompTIA expects you to know

| Framework | Origin | Structure | Best for |
|---|---|---|---|
| **Cyber Kill Chain** | Lockheed Martin (2011) | 7 linear phases | Executive briefings, perimeter-era thinking, malware delivery analysis |
| **MITRE ATT&CK** | MITRE (2013, ongoing) | 14 tactics × ~200 techniques matrix | Detection engineering, threat hunting, purple team |
| **Diamond Model** | DoD (2013) | 4 vertices: adversary, capability, infrastructure, victim | Intel analysis, attribution, campaign tracking |
| **OWASP** | OWASP Foundation | Top 10 list + testing guides | Web app security, AppSec, secure SDLC |

### Cyber Kill Chain — the 7 phases

1. **Reconnaissance** — adversary scouts you (OSINT, scanning)
2. **Weaponization** — builds the payload (malware + exploit)
3. **Delivery** — gets it to you (phish, USB, watering hole)
4. **Exploitation** — code executes on the target
5. **Installation** — persistence is established
6. **Command and Control (C2)** — beacon home
7. **Actions on Objectives** — exfil, destruction, ransomware detonation

Strengths: simple, linear, executives understand it. Weaknesses: assumes a single perimeter breach, doesn't model lateral movement well, weak on insider threats and cloud-native attacks.

### MITRE ATT&CK — the 14 enterprise tactics

Reconnaissance · Resource Development · Initial Access · Execution · Persistence · Privilege Escalation · Defense Evasion · Credential Access · Discovery · Lateral Movement · Collection · Command and Control · Exfiltration · Impact.

Each tactic contains techniques (T1566 Phishing) and sub-techniques (T1566.001 Spearphishing Attachment). Strengths: granular, behavior-based, maps directly to detection rules and EDR telemetry. Weaknesses: huge surface area, easy to get lost mapping coverage that no one operationalizes.

### Diamond Model — the 4 vertices

**Adversary** ↔ **Victim** is the social axis. **Capability** ↔ **Infrastructure** is the technical axis. Every intrusion event connects all four. Pivot from any vertex to discover more — find a C2 IP (infrastructure), pivot to other malware that beaconed to it (capability), pivot to other victims that beaconed there too. Strengths: built for attribution and campaign clustering. Weaknesses: doesn't tell you what to detect, only how to organize what you've already found.

### OWASP — the web app lens

Top 10 (Broken Access Control, Cryptographic Failures, Injection, etc.), plus ASVS for verification, plus the Testing Guide. Strengths: the only framework that takes web app threat modeling seriously. Weaknesses: scoped to web apps and APIs — does not cover endpoint, network, identity, or cloud control plane attacks.

### How to actually assess which framework fits

The selection isn't aesthetic. Three inputs drive the decision:

**1. Threat landscape.** Are you a defense contractor staring down nation-state APTs? ATT&CK + Diamond for campaign tracking. Are you a SaaS startup whose entire attack surface is a React frontend and a Postgres backend? OWASP first, ATT&CK Cloud matrix second. Healthcare org dealing with opportunistic ransomware gangs? Kill Chain works fine because the attack pattern *is* linear: phish → loader → ransomware.

**2. Business environment.** Regulated industries (finance, healthcare, federal) often have framework mandates baked into their compliance posture — NIST CSF maps cleanly to ATT&CK, so federal shops use ATT&CK. Retail and PCI-scoped shops lean on OWASP for the cardholder web surface. Industrial / OT environments use **ATT&CK for ICS** (a separate matrix) because enterprise ATT&CK doesn't cover Modbus and PLC ladder logic.

**3. Defender capability.** This is the one teams get wrong. ATT&CK is *huge*. If your SOC is three analysts and a tuned-poorly SIEM, mapping coverage against 200+ techniques is theater. Start with the top 20 techniques the Center for Threat-Informed Defense calls out as highest-impact, prove detection on those, expand. Don't buy a framework you can't operationalize.

### Combining frameworks (the mature approach)

Real SOCs stack them:

- **Kill Chain** for the executive deck — board members understand "stopped them at delivery"
- **ATT&CK** for detection engineering — every SIEM rule tagged with a technique ID
- **Diamond Model** for threat intel — clustering campaigns, sharing IoCs with ISACs
- **OWASP** for AppSec — handed to the dev team, baked into CI/CD security gates

The frameworks don't compete. They answer different questions: Kill Chain answers *how far did they get*, ATT&CK answers *what did they do*, Diamond answers *who are they and where else are they*, OWASP answers *what's wrong with my code*.

### CompTIA exam traps

> **CompTIA exam trap:** Kill Chain has **7 phases**, not 8. CompTIA will list "Installation" and "Exploitation" in swapped order to bait you. Memorize the order: Recon → Weaponize → Deliver → Exploit → Install → C2 → Actions. The mnemonic that sticks is *"Real Wizards Don't Eat Inside Coffee Aisles."*

> **CompTIA exam trap:** ATT&CK is a **matrix of tactics and techniques**, not a linear sequence. Questions will describe a phased attack and ask which framework "best models" it. If the question emphasizes order and progression, Kill Chain. If it emphasizes specific adversary behaviors and detection mapping, ATT&CK. If it emphasizes attribution and infrastructure pivoting, Diamond.

> **CompTIA exam trap:** Diamond Model has **4 vertices**, not 4 phases. It's relational, not temporal. The vertices are **Adversary, Capability, Infrastructure, Victim** — meta-features (timestamp, phase, result) live on the edges. CompTIA will offer "Tools" or "Targets" as a wrong vertex.

> **CompTIA exam trap:** OWASP is **not a general-purpose attack framework** — it's web app focused. If a question describes a domain controller compromise or lateral movement and offers OWASP as an answer, it's wrong.

### Where framework selection lives in the IR life cycle

Framework selection is **preparation** (Objective 3.3). You bake it in before the incident:

- **Incident response plan** references the framework — "for every confirmed intrusion, map observed behaviors to ATT&CK techniques in the IR ticket"
- **Playbooks** use the framework vocabulary — the phishing playbook calls out T1566 sub-techniques
- **Training** teaches analysts the framework — new L1s should be able to map an alert to a tactic on day 30
- **Tabletop exercises** run scenarios through the framework — "the red team is at Lateral Movement, what's our containment?"
- **Tools** are configured around it — SIEM rules tagged with ATT&CK IDs, EDR coverage gaps tracked on the matrix

Then post-incident, the framework structures the **lessons learned** and **root cause analysis** — *we had no detection for T1078 Valid Accounts, that's our gap.* It feeds back into **BC/DR** posture by showing which capabilities the adversary disrupted and which compensating controls held. Forensic analysis output gets framework-tagged so the next incident's hunters can find prior art.

The framework is the shared language. Without it, your post-incident report says "the attacker did some stuff and we found them." With it, the report says "TA0008 Lateral Movement via T1021.001 RDP, detected at T1486 Data Encrypted for Impact, MTTD 47 hours, gap identified at T1021." That second version gets the budget approved.

## SOC reality

- The L1 alert doesn't say "this is T1059.001 PowerShell." The L1 has to *map it* — that's the skill. Tuned SIEMs tag rules with technique IDs so the mapping is half-done; immature SIEMs don't, and the analyst learns the matrix the hard way.
- The CISO asks "where on the Kill Chain are they?" because the board understands Kill Chain. The IR lead translates: "C2 established, no Actions on Objectives yet, we're containing." Same incident, two vocabularies. Know both.
- Never tell leadership "we have full ATT&CK coverage." No one does. The honest answer is "we have detection for our top 40 techniques based on threat modeling for our sector, gaps documented, quarterly review." That's mature. "Full coverage" is a lie that gets you fired after the breach.
- Threat intel reports from ISACs and vendors (Mandiant, CrowdStrike, Microsoft) are written in ATT&CK. If your team can't read them fluently, you're paying for intel you can't operationalize.
- The handoff from L1 → L2 → IR lead works because the framework is shared. *"L2, the L1 tagged this as T1190 against the public-facing Jira — your call on containment."* No framework, no shorthand, and the 3am phone call takes ten minutes instead of ninety seconds.

*The framework you can actually operationalize beats the framework that looks impressive on the slide deck. Always.*

## Related concepts

[[Cyber Kill Chain]] · [[MITRE ATT&CK]] · [[Diamond Model of Intrusion Analysis]] · [[OWASP Top 10]] · [[Incident Response Plan]] · [[Playbooks]] · [[Tabletop Exercises]] · [[Threat Intelligence]] · [[Indicators of Compromise]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Detection Engineering]] · [[Threat Hunting]] · [[Purple Team]]

*Source: VIRGIL knowledge base — 2026-05-11*