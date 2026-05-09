# Penetration Testing

## What it is

In Escape from Tarkov, before you raid Reserve for real loot, you might run a Scav raid first — same map, lower stakes, you learn the extraction routes, where the AI camps, where players bottleneck at the bunker doors. You're testing the territory before it costs you your kit. That's exactly what penetration testing does — you hire someone to break into your systems on purpose, with permission, so you find the holes before a real raider does.

**Penetration testing** is an authorized, simulated cyberattack against an organization's systems, performed under defined rules of engagement to identify exploitable vulnerabilities and validate the effectiveness of security controls.

## Why it matters

Vulnerability scans tell you a door is unlocked; pentests prove the attacker can walk in, reach the safe, and leave with the contents. Without pentesting, organizations rely on theoretical control coverage — and that's how breaches like Equifax happen, where a known Apache Struts flaw sat unexploited in the scanner output and very exploited in production. PCI DSS, HIPAA, and FedRAMP all explicitly require periodic penetration testing.

**Exam angle (4.3):** CompTIA wants you to distinguish **pentest types** (known/partially known/unknown environment), **reconnaissance modes** (active vs. passive), and the difference between a **pentest** and a **vulnerability scan**. The classic trap: confusing **black box / white box / gray box** terminology — the SY0-701 vocabulary has shifted to **unknown / known / partially known environment**. Know both sets.

## Key facts

### Penetration test types (knowledge of environment)

| Type | Old name | Tester knows | Simulates |
|---|---|---|---|
| [[Unknown environment]] | Black box | Nothing | External attacker with zero insider info |
| [[Known environment]] | White box | Full architecture, source, creds | Insider threat or worst-case disclosure |
| [[Partially known environment]] | Gray box | Limited info (e.g., user creds) | Compromised user account, focused engagement |

### Reconnaissance

- **[[Passive reconnaissance]]** — gathering data without touching the target. [[OSINT]] from LinkedIn, [[Shodan]], DNS records, [[WHOIS]], cached pages, social media. Stealthy, legal, slow.
- **[[Active reconnaissance]]** — directly probing the target. [[Nmap]] scans, banner grabbing, [[ping sweeps]], DNS zone transfers. Faster, noisier, generates logs.

### Engagement phases

1. **Planning / [[Rules of Engagement]] (RoE)** — scope, timing, targets in/out, contacts, legal authorization, [[Statement of Work]].
2. **Reconnaissance** — passive, then active.
3. **[[Vulnerability scanning]] / enumeration** — identifying attack surface.
4. **Exploitation / attack** — gaining access (e.g., [[Metasploit]], custom payloads).
5. **[[Persistence]] / [[lateral movement]] / [[privilege escalation]]** — moving deeper, simulating dwell time.
6. **Reporting** — findings, severity, reproduction steps, remediation guidance.
7. **Cleanup** — remove implants, test artifacts, accounts.

### Pentest environments and targets

- **[[Offensive security]]** (red team) — attacker emulation, often long-duration, [[TTPs]] aligned to specific threat actors via [[MITRE ATT&CK]].
- **[[Defensive security]]** (blue team) — detection and response side; pentests measure their effectiveness.
- **[[Purple team]]** — red and blue collaborate in real time; tests become tuning exercises.
- **[[Physical penetration testing]]** — tailgating, lock picking, badge cloning, dumpster diving.
- **[[Integrated penetration testing]]** — combines digital, physical, and social engineering.

### Pentest vs. vulnerability scan (high-frequency exam contrast)

| | Vulnerability Scan | Penetration Test |
|---|---|---|
| Goal | Identify weaknesses | Exploit weaknesses |
| Method | Automated tools | Tools + human creativity |
| Output | List of CVEs | Proof of impact |
| Disruption | Minimal | Possible |
| Cost | Low | High |
| Frequency | Continuous/weekly | Annual or per change |

### Key supporting documents

- **[[Rules of Engagement]]** — what's allowed, when, by whom.
- **[[Statement of Work]] (SOW)** — deliverables, timeline.
- **[[Master Service Agreement]] (MSA)** — overarching legal terms.
- **[[Non-Disclosure Agreement]] (NDA)** — protects findings.
- **[[Authorization letter]]** ("get out of jail free card") — proves the tester isn't committing a felony.

### Common pitfalls CompTIA likes to test

- **Scope creep** — testing systems outside the RoE is unauthorized access, period.
- **No authorization = [[Computer Fraud and Abuse Act]] violation**, regardless of intent.
- A pentest is a **point-in-time snapshot**; it doesn't replace continuous monitoring.
- **[[Bug bounty]] programs** are not pentests — they're ongoing crowdsourced vulnerability disclosure.

## Related concepts

[[Vulnerability assessment]] · [[Red team]] · [[Blue team]] · [[Purple team]] · [[MITRE ATT&CK]] · [[OSINT]] · [[Rules of Engagement]] · [[Bug bounty]] · [[Responsible disclosure]] · [[Threat hunting]] · [[Audit and assessment]]

---
*Source: VIRGIL knowledge base — 2026-05-08*