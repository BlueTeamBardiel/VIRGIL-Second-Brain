# CVSS — Common Vulnerability Scoring System

## What it is

In **Elden Ring**, every weapon shows you a scaling sheet: physical attack power, strength scaling B, dexterity scaling D, passive bleed buildup, weight, range. The numbers tell you what the weapon *can* do in a vacuum. Then you walk into the Caelid swamp infested with Scarlet Rot and realize your fire-damage katana with the perfect raw stats is the wrong call because the enemies here resist fire. The weapon's stat block didn't lie — it just didn't know where you were fighting. That's exactly what CVSS does. It scores a vulnerability's intrinsic nastiness with a number, but the number doesn't know your environment, your compensating controls, or whether the vulnerable host is internet-facing or sitting in an isolated VLAN with no egress.

Technically: **CVSS (Common Vulnerability Scoring System)** is an open framework — currently v3.1 with v4.0 published — maintained by FIRST.org for communicating the characteristics and severity of software vulnerabilities. It outputs a score 0.0–10.0 across three metric groups: **Base** (intrinsic, never changes), **Temporal** (changes as exploits mature), and **Environmental** (changes per organization). Scanners and NVD publish the Base score. The other two are your job.

## Why it matters

Patch Tuesday drops 140 CVEs. You have three patch windows this quarter and a change board that asks "why this one and not that one" for every emergency RFC. CVSS is the lingua franca for that conversation — every CVE in the [[NVD]] has one, every scanner output sorts by it, every executive dashboard color-codes off it. If you can't read a CVSS vector string and explain why a 9.8 isn't always P1, you lose the argument to the app owner who doesn't want their service rebooted.

CySA+ tests CVSS heavily under **Objective 2.3 (analyze data to prioritize vulnerabilities)** and **Objective 2.5 (vulnerability response, handling, and management)**. Expect vector-string interpretation questions and prioritization scenarios where the highest CVSS isn't the right answer.

## Key facts

### The three metric groups

| Group | Who sets it | When it changes |
|---|---|---|
| **Base** | Vendor / NVD analyst | Never (intrinsic to the flaw) |
| **Temporal** | Vendor / threat intel | As exploit code matures, patches release |
| **Environmental** | You, the defender | Per asset, per deployment context |

The Base score is what your scanner shows you. The Environmental score is what your boss should care about. Most orgs never compute Environmental and then wonder why they patch the wrong things.

### Base metrics — exploitability sub-score

These describe **how hard it is to land the hit**:

- **Attack Vector (AV)** — where the attacker has to stand.
  - **Network (N)** — remote, across the internet. Worst case. *Spamming arrows from across the lake.*
  - **Adjacent (A)** — same subnet, Bluetooth range, same VLAN. Limited blast radius.
  - **Local (L)** — already on the box, local shell or SSH session.
  - **Physical (P)** — hands on the device. USB, console cable, evil-maid scenario.
- **Attack Complexity (AC)** — does the exploit just work, or does it need stars to align?
  - **Low (L)** — fire-and-forget, repeatable, weaponized in Metasploit.
  - **High (H)** — race condition, specific config, MITM position required.
- **Privileges Required (PR)** — what account does the attacker need first?
  - **None (N)** — unauthenticated. Pre-auth RCE territory.
  - **Low (L)** — any authenticated user.
  - **High (H)** — admin/root already.
- **User Interaction (UI)** — does a victim have to click something?
  - **None (N)** — no human in the loop. Wormable.
  - **Required (R)** — phishing link, malicious doc, drive-by.

### Base metrics — impact sub-score

These describe **what the hit does** once it lands — the CIA triad:

- **Confidentiality (C)** — data disclosure. None / Low / High.
- **Integrity (I)** — data modification. None / Low / High.
- **Availability (A)** — service uptime. None / Low / High.

### Scope (S) — the multiplier nobody reads carefully

**Scope** is the metric CompTIA loves to ambush you with. It asks: does the exploit break out of the vulnerable component's security authority?

- **Unchanged (U)** — the blast stays inside the vulnerable component. SQL injection that reads the app DB.
- **Changed (C)** — the blast crosses a trust boundary. VM escape that hits the hypervisor. Browser sandbox break that touches the host OS.

Scope: Changed cranks the score significantly. A hypervisor escape isn't just "code execution in the VM" — it's code execution somewhere the VM was never supposed to reach.

### The vector string

Every CVSS score ships with a vector string that encodes every metric. Learn to read these — exam questions hand you a string and ask for the severity band.

```
CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H
```

Parse it left to right: v3.1, Network attack vector, Low complexity, No privileges required, No user interaction, Scope Unchanged, High confidentiality / integrity / availability impact. That's a 9.8 Critical. That's Log4Shell. That's the pager going off on a Friday.

### Severity bands (v3.x)

| Score | Band |
|---|---|
| 0.0 | None |
| 0.1 – 3.9 | Low |
| 4.0 – 6.9 | Medium |
| 7.0 – 8.9 | High |
| 9.0 – 10.0 | Critical |

### Temporal metrics (the maturity clock)

These adjust the Base score down (rarely up) based on real-world conditions:

- **Exploit Code Maturity (E)** — Unproven → Proof-of-Concept → Functional → **High (weaponized, in Metasploit, in the wild)**.
- **Remediation Level (RL)** — Official Fix → Temporary Fix → Workaround → Unavailable.
- **Report Confidence (RC)** — Unknown → Reasonable → Confirmed.

A CVSS 7.5 with weaponized exploit code and no vendor patch is more dangerous *right now* than a CVSS 9.0 with an official patch and no public PoC. Temporal captures that.

### Environmental metrics (the context layer)

This is where **context awareness** lives — and where CompTIA Objective 2.3 lives:

- **Confidentiality / Integrity / Availability Requirements (CR / IR / AR)** — how much you, *this org*, care about each CIA pillar for *this asset*. The patient billing database has CR: High. The dev sandbox has CR: Low.
- **Modified Base Metrics** — re-score AV, AC, PR, UI, S, C, I, A with your environment in mind. Vuln scored AV: Network by NVD? If the host is on an isolated OT segment with no internet route, your modified AV is Adjacent or Local. The score drops.

This is how a 9.8 Critical becomes a 4.0 Medium for your environment. Or how a 5.3 Medium becomes an 8.0 High because the asset is your crown-jewel database.

### CVSS v4.0 — what changed

Published 2023, slowly being adopted. Key differences CySA+ may touch:

- New **Attack Requirements (AT)** metric separated from Attack Complexity.
- User Interaction split: None / Passive / Active.
- Better handling of supplemental metrics (Safety, Automatable, Recovery, Value Density).
- New nomenclature: **CVSS-B** (Base only), **CVSS-BT** (Base + Temporal/Threat), **CVSS-BE** (Base + Environmental), **CVSS-BTE** (everything).

Most scanners and NVD still report v3.1. Know v3.1 cold; recognize v4.0 vector strings if they appear.

### CompTIA exam traps

> **CompTIA exam trap — CVSS is not risk.** CVSS is *severity*. Risk = severity × likelihood × asset value × exposure. A CVSS 10 on an air-gapped lab box is lower risk than a CVSS 6 on the internet-facing payment gateway. If the answer is "patch the highest CVSS first" with no context, suspect the trick.

> **CompTIA exam trap — Scope: Changed.** Scope flipping from Unchanged to Changed isn't a minor adjustment — it's the single largest multiplier in v3.1. VM escapes, container escapes, sandbox breaks all set Scope: Changed. Recognize these scenarios.

> **CompTIA exam trap — Validation matters.** Scanner output is not ground truth. A reported CVSS 9.8 on a service that isn't actually running is a **false positive**. A missed vuln on a host the scanner couldn't authenticate to is a **false negative**. Always validate before pulling the emergency-change cord.

### Prioritization in practice — beyond the number

CVSS is one input. The real prioritization stack:

1. **CVSS Base** — starting point, one decimal place of nuance.
2. **Exploitability / weaponization** — is there a public PoC? CISA KEV listing? Metasploit module? **A CVSS 7.5 in CISA KEV outranks a CVSS 9.0 that's theoretical.**
3. **Asset value / criticality** — crown jewel vs. dev box. Business owner classification.
4. **Exposure** — internet-facing vs. internal vs. isolated. Compensating controls (WAF, IPS signature, network segmentation).
5. **Zero-day status** — no patch available means workaround or accept-risk only.
6. **Threat intel context** — is a named threat actor actively exploiting this against your sector?

The org that patches by CVSS alone wastes cycles on dev-box criticals and misses the internet-facing medium that just got a working exploit dropped on GitHub.

## SOC reality

- **Scanner output Monday morning.** Qualys/Tenable/Rapid7 dump 4,000 findings. Sorted by CVSS, the top 50 are critical. Half are on hosts that don't actually run the vulnerable service — **false positives** from version-string matching. Your first hour is validation, not patching.
- **The change board argument.** App owner: "It's only exploitable from the same VLAN, we have segmentation." You: "Modified AV is still Adjacent, modified score is 7.1, and your segmentation has three firewall exceptions I can show you in the ruleset." Bring the vector string to the meeting.
- **What the CISO actually asks:** "How many criticals on internet-facing assets, what's our SLA, and which ones are in CISA KEV?" Never just the count. Always the exposed-and-exploited count.
- **Zero-day drops.** No CVSS yet, no NVD entry, vendor scrambling. You score it yourself from the advisory, communicate the vector string to leadership, and stand up compensating controls before the official score lands. *I learned to write Base vectors in my head because waiting for NVD during a zero-day costs you the first 48 hours.*
- **The handoff.** L1 validates the finding isn't a false positive. L2 computes Environmental score and prioritizes. Vulnerability management lead negotiates the patch window. IR gets involved only if exploitation is suspected — at which point CVSS stops mattering and the [[Incident Response Lifecycle]] takes over.

## Related concepts

[[Vulnerability Scanning]] · [[CVE]] · [[NVD]] · [[CISA KEV]] · [[CWE]] · [[CPE]] · [[EPSS]] · [[Risk Assessment]] · [[Asset Inventory and Classification]] · [[True and False Positives]] · [[Zero-day Vulnerabilities]] · [[Compensating Controls]] · [[Patch Management]] · [[Vulnerability Response and Remediation]]

*Source: VIRGIL knowledge base — 2026-05-11*