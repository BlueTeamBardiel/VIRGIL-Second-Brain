# OSSTMM — Open Source Security Testing Methodology Manual

## What it is

In **Fallout**, before you crack open a vault you run the perimeter. You check the terminal logs, sweep for turrets, ping the protectron patrol routes, eyeball the ventilation shafts, and pop a Stealth Boy to see what the cameras can actually see versus what they're supposed to see. You're not guessing. You're measuring the gap between *what the Vault-Tec brochure says this place is* and *what it actually is right now with the door half-rusted off and a Deathclaw nesting in Engineering.* That gap — measured, not estimated — is the whole point of OSSTMM.

In plain English: OSSTMM is a testing methodology that says *stop describing security and start measuring it*. Instead of "the firewall looks good," you produce a number — a **rav** (risk assessment value) — that says exactly how much attack surface this thing actually exposes versus what the controls claim to cover.

Technical definition for CS0-003: **OSSTMM** is an open, peer-reviewed security testing methodology maintained by **ISECOM** (Institute for Security and Open Methodologies). It defines repeatable test procedures across five **channels** — Human, Physical, Wireless, Telecommunications, and Data Networks — and produces quantitative output (operational security metrics, the rav) instead of qualitative findings. It is one of the four attack methodology frameworks CompTIA expects you to recognize under Objective 3.1.

## Why it matters

CySA+ Objective 3.1 lists four frameworks the exam expects you to tell apart on sight: **Cyber Kill Chain**, **MITRE ATT&CK**, **Diamond Model**, and **OSSTMM** (often paired with the **OWASP Testing Guide**). CompTIA does not test OSSTMM deeply — they test whether you can pick it out of a lineup.

The reason it exists in the objective at all: the first three frameworks describe *what the adversary does*. OSSTMM and OWASP describe *what the tester does to find out if you're ready for them*. Different lane entirely. Kill Chain and ATT&CK are adversary lifecycles; OSSTMM is an audit methodology. Confusing the two on the exam costs you a question you should not lose.

Real-world stakes: when a pentest report says "the network is mostly secure," that's an opinion. When it says "the rav is 87.4, target baseline was 95, here are the seven specific operational controls below threshold," that's a measurement an executive can fund against. OSSTMM exists to drag pentesting out of the *vibes* era.

## Key facts

### Origin and maintenance

- **ISECOM** — Institute for Security and Open Methodologies. Non-profit. Maintains OSSTMM as a peer-reviewed open document.
- First public release **2001**. Current major version **OSSTMM 3** (with OSSTMM 4 in long-running draft). CompTIA does not care about the version number — they care about the name.
- "Open Source" in the title refers to the **methodology being open**, not the tools. You can run OSSTMM tests with commercial scanners.

### The five channels

This is the part CompTIA can actually ask about. OSSTMM splits the testable attack surface into five **channels**:

| Channel | What it covers | Example tests |
|---|---|---|
| **Human** | Personnel, social engineering, awareness | Phishing simulations, pretexting calls, badge tailgating |
| **Physical** | Tangible assets, facilities | Lock picking, door sensors, dumpster diving, camera coverage |
| **Wireless** | EM-spectrum communications | Wi-Fi, Bluetooth, RFID, NFC, cellular |
| **Telecommunications** | Analog and digital telecom | PBX, VoIP, modems, fax (yes, still) |
| **Data Networks** | Wired IP networks | Firewalls, routers, servers, web apps |

Each channel gets tested with the same **operational** discipline — same phases, same measurements, same output format. The reason that matters: when leadership asks "are we as secure on the human channel as we are on the network channel?" you can answer with two numbers instead of two paragraphs.

### Operational security and the rav

OSSTMM defines security as the separation between an asset and a threat. Three pillars of **operational security (OpSec)** in the OSSTMM sense:

- **Visibility** — how much of the asset is even discoverable by the threat
- **Access** — how many interaction points exist
- **Trust** — what relationships allow interaction without authentication

Subtract from those the **controls** (10 of them across two classes — Class A: Authentication, Indemnification, Resilience, Subjugation, Continuity; Class B: Non-repudiation, Confidentiality, Privacy, Integrity, Alarm) and the **limitations** (vulnerabilities, weaknesses, concerns, exposures, anomalies), and the math spits out the **rav** — a single decimal value representing the actual operational security state.

You don't need to compute a rav for the exam. You need to know **OSSTMM produces quantitative, repeatable metrics** — that's the differentiator versus a normal pentest report.

### The four-phase test flow

OSSTMM testing runs through four phases (sometimes called the **STAR** flow with extra steps, but four is the clean version):

1. **Induction** — define the scope, the target's posture, applicable regulations
2. **Inquest** — passive recon, enumeration, fingerprinting (what's visible)
3. **Interaction** — active probing, access attempts, trust mapping (what responds)
4. **Intervention** — controlled disruption, resilience testing, response measurement (what breaks)

If that sounds like every other pentest flow you've seen — yes. The discipline is that each phase has defined inputs, outputs, and a required level of evidence.

### The six test types (rules of engagement)

OSSTMM classifies engagements by how much the tester and target know about each other. CompTIA does not test these directly but they map cleanly to terms the exam *does* test (black-box, white-box, gray-box):

| OSSTMM type | Tester knows target | Target knows tester | Common name |
|---|---|---|---|
| Blind | No | Yes | Announced black-box |
| Double-blind | No | No | Red team |
| Gray-box | Partial | Yes | Gray-box |
| Double gray-box | Partial | Partial | Gray-box, mutual |
| Tandem | Yes | Yes | Crystal-box / white-box |
| Reversal | Yes | No | Surprise audit |

### OSSTMM vs. the other 3.1 frameworks

This is the table CompTIA will test you on. Memorize the *purpose column*.

| Framework | Purpose | Type | Owner |
|---|---|---|---|
| **Cyber Kill Chain** | Describes 7 phases of an attack | Adversary lifecycle | Lockheed Martin |
| **MITRE ATT&CK** | Matrix of adversary tactics + techniques | Adversary behavior catalog | MITRE |
| **Diamond Model** | 4 vertices: adversary, capability, infrastructure, victim | Intrusion analysis | DoD-origin, public |
| **OWASP Testing Guide** | Web application testing methodology | Tester methodology (web-focused) | OWASP |
| **OSSTMM** | Operational security testing methodology with metrics | Tester methodology (broad, 5 channels) | ISECOM |

### CompTIA exam traps

> **CompTIA exam trap:** OSSTMM is **not** an adversary framework. If the question describes "how an attacker progresses through a network" or "phases of an attack," the answer is Kill Chain or ATT&CK — never OSSTMM. OSSTMM is what the *tester* does, not what the *attacker* does.

> **CompTIA exam trap:** OSSTMM vs. OWASP — both are tester methodologies, easy to swap. **OWASP Testing Guide is scoped to web applications.** OSSTMM covers five channels including physical, human, and wireless. If the scenario mentions XSS, SQLi, or web app testing → OWASP. If it mentions a broad operational audit with metrics → OSSTMM.

> **CompTIA exam trap:** "Open Source" in OSSTMM refers to the **methodology being publicly available and peer-reviewed**, not the tools used. A pentester running Nessus (commercial) is still doing OSSTMM-aligned work if they follow the methodology.

> **CompTIA exam trap:** OSSTMM produces a **rav** (operational metric), Diamond Model produces an **event** with four vertices, ATT&CK produces **techniques mapped to tactics**, Kill Chain produces **phase identification**. Different output = different framework. The output language is the giveaway.

## SOC reality

- **You will almost never run OSSTMM as an L1/L2 SOC analyst.** It's a pentest/audit methodology. You will *consume* its output — the rav report lands on your manager's desk and turns into tickets for you to validate the listed control gaps.
- **When the pentest report comes back, the first question leadership asks is "did we improve?"** OSSTMM's whole reason for existing is that you can answer with last year's rav vs. this year's rav. Qualitative reports can't do that. Watch managers pivot hard when they realize this.
- **Recognize the language in vendor pitches.** A pentest firm saying "we use OSSTMM-aligned testing with rav metrics" is telling you their reports include quantitative output. A firm that doesn't mention a methodology is selling you vibes and a logo.
- **In the war room during IR, no one cites OSSTMM.** They cite ATT&CK ("this is T1059.001, PowerShell execution") or Kill Chain ("we're catching them at lateral movement"). OSSTMM lives in the audit and assurance lane — pre-incident and post-incident review, not active triage.
- **Never promise an executive a single number captures security.** *The rav is a measurement, not a verdict.* A rav of 92 with a known unpatched RCE on the perimeter is still a bad day waiting to happen. Frameworks help you talk; they don't make you safe.

## Related concepts

[[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model of Intrusion Analysis]] · [[OWASP Testing Guide]] · [[Penetration Testing]] · [[Vulnerability Assessment]] · [[Red Team vs Blue Team]] · [[Rules of Engagement]] · [[Risk Assessment]] · [[Security Metrics]] · [[ISECOM]] · [[Black Box Testing]] · [[White Box Testing]] · [[Gray Box Testing]] · [[Attack Surface]]

*Source: VIRGIL knowledge base — 2026-05-11*