# Deception and Disruption

## What it is

In Metal Gear, Snake leaves a cardboard box in the middle of a corridor. The guard sees the box, walks over to investigate, and gets a tranquilizer dart for his curiosity. That's exactly what deception and disruption technologies do — they place fake assets in the network so attackers waste time on bait while you watch them do it.

**Deception and disruption** is the deliberate deployment of decoy systems, fabricated data, and misleading network artifacts to detect, delay, and analyze adversaries during reconnaissance and lateral movement.

## Why it matters

Real intrusion detection has a signal-to-noise problem. A single touch on a honeypot is high-fidelity by definition — nobody legitimate has business there. CompTIA explicitly enumerates these under Objective 1.2: **honeypot, honeynet, honeyfile, honeytoken**. The exam trap is conflating them — a honeyfile is not a honeypot, and a honeytoken is not a honeynet. Know the singular versus plural, the file versus token, and which one screams when touched versus which one quietly tracks.

## Key facts

### The four CompTIA-named primitives

| Term | What it is | Scale | Trigger |
|------|-----------|-------|---------|
| [[Honeypot]] | Single decoy system mimicking a real host | One machine | Connection / probe |
| [[Honeynet]] | Entire fake network of decoy systems | Subnet of decoys | Lateral movement |
| [[Honeyfile]] | Bait file (e.g., `passwords.xlsx`) on real systems | One file | File access / open |
| [[Honeytoken]] | Fake credential, API key, or record planted to be stolen | Data element | Use of the token anywhere |

### Honeypot mechanics

- **Low-interaction**: emulates services (fake SSH banner, fake SMB share). Cheap, safe, limited intel.
- **High-interaction**: real OS, real services, fully instrumented. Rich intel, higher risk if attacker pivots out.
- Common platforms: **Cowrie** (SSH/Telnet), **Dionaea** (malware capture), **T-Pot** (multi-honeypot framework).
- Placement: DMZ-adjacent, internal segments, cloud-facing — wherever you want to catch [[reconnaissance]].

### Honeynet

- Multiple honeypots wired together to simulate a believable enterprise: domain controller, file server, workstation.
- Goal: observe **lateral movement**, **privilege escalation**, **C2 behavior** end-to-end.
- The [[Honeynet Project]] is the canonical research consortium.

### Honeyfile

- A document with an enticing name (`Q4_Salaries.xlsx`, `vpn_keys.txt`) placed on a legitimate share.
- Access generates a [[SIEM]] alert. No legitimate user has a reason to open it.
- Often paired with **canary tokens** embedded inside the file.

### Honeytoken

- A planted artifact designed to be exfiltrated and reused: fake AWS keys, bogus DB rows, fake customer records.
- When the token is **used** — queried, authenticated with, looked up — you get a beacon revealing the breach.
- Services like **Canarytokens** (Thinkst) generate URL, DNS, AWS-key, and document tokens.
- Detects [[insider threat]], [[credential theft]], [[data exfiltration]] post-compromise.

### Disruption techniques (beyond detection)

- **Fake DNS records** pointing scanners into tarpits.
- **Tarpits** (e.g., LaBrea) — accept TCP connections then slow them to a crawl, wasting attacker time.
- **Bogus AD accounts and SPNs** — Kerberoasting attempts hit fake service accounts and trigger alerts.
- **Breadcrumb credentials** in memory or registry that lead only to monitored systems.

### Legal and operational caveats

- Deception is **detection**, not entrapment. Document it in policy.
- High-interaction honeypots require [[network segmentation]] — never let an attacker pivot from decoy to production.
- Decoys must look **plausible**: stale services and obviously empty hosts get ignored.

### Exam-ready distinctions

- Honeypot = **system**. Honeyfile = **file**. Honeytoken = **data/credential**. Honeynet = **network**.
- A honeytoken's value is in being **stolen and used elsewhere** — that's the alert vector.
- All four fall under **deceptive and disruption technology** in Objective 1.2.

## Related concepts

[[Threat intelligence]] · [[Indicators of Compromise]] · [[SIEM]] · [[Reconnaissance]] · [[Lateral movement]] · [[Insider threat]] · [[Network segmentation]] · [[Canary tokens]] · [[MITRE ATT&CK]]

---
*Source: VIRGIL knowledge base — 2026-05-08*