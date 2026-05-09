# Penetration Tests

## What it is

In Demon's Souls, before you commit to fighting the Tower Knight, a sensible player walks the fog gate's edge, scouts the soldiers on the walls, tests which arrows stagger the boss's shield, and dies a few times learning the moveset — all so the *real* run doesn't end in soul-loss. That's exactly what a penetration test does — pay someone to die in your dungeon first, on purpose, with permission, so the actual invader doesn't get the kill.

A **penetration test** is an authorized, goal-oriented simulated attack against a system, network, or application to identify exploitable vulnerabilities and validate the effectiveness of security controls.

## Why it matters

A scan tells you the door is unlocked; a pentest tells you what someone walks out with after they open it. SY0-701 Objective 5.5 explicitly lists pentesting under audits and assessments, and the exam loves to test the difference between **vulnerability scanning** (finds flaws) and **penetration testing** (exploits them to prove impact). The classic CompTIA trap: confusing **knowledge environments** (known/partially known/unknown) with the older "white/gray/black box" terminology, or mixing up **reconnaissance types** (active vs. passive). Get those wrong and you lose easy points.

## Key facts

### Knowledge environments (the SY0-701 terminology)

| Environment | What the tester knows | Simulates |
|---|---|---|
| **[[Known environment]]** | Full info: source code, creds, architecture | Malicious insider / informed auditor |
| **[[Partially known environment]]** | Limited info: maybe creds, no source | Compromised user account |
| **[[Unknown environment]]** | Nothing — tester starts from zero | External attacker / APT |

Old names you may still see: white box, gray box, black box. SY0-701 prefers the new wording.

### Reconnaissance types

- **[[Passive reconnaissance]]** — gather data without touching the target. [[OSINT]], WHOIS, [[Shodan]], LinkedIn scraping, DNS lookups via third-party resolvers, Google dorking. Target sees nothing.
- **[[Active reconnaissance]]** — directly probe the target. [[Port scanning]] ([[Nmap]]), banner grabbing, ping sweeps, [[vulnerability scanning]]. Target's logs light up.

### Phases of a penetration test

1. **Planning / pre-engagement** — define scope, [[rules of engagement]] (RoE), authorization, [[Statement of Work]].
2. **Reconnaissance** — passive then active.
3. **Scanning / enumeration** — identify services, versions, weaknesses.
4. **Exploitation / gaining access** — leverage [[CVE]]s, misconfigurations, weak creds.
5. **Post-exploitation** — [[privilege escalation]], [[lateral movement]], [[pivoting]], [[persistence]].
6. **Reporting** — findings, severity, remediation guidance, evidence.
7. **Cleanup** — remove tools, accounts, backdoors, test artifacts.

### Critical pre-engagement documents

- **[[Rules of Engagement]] (RoE)** — what's in scope, what's off-limits, hours of testing, allowed techniques (e.g., no DoS), emergency contacts.
- **[[Statement of Work]] (SOW)** — deliverables, timeline, payment.
- **Written authorization** — the "get out of jail free" letter. Without it, a pentest is just a felony with paperwork.

### Specialized pentest types

| Type | Focus |
|---|---|
| **[[Physical penetration test]]** | Tailgating, lock picking, badge cloning |
| **[[Wireless penetration test]]** | Rogue APs, [[WPA cracking]], evil twins |
| **[[Web application pentest]]** | [[OWASP Top 10]], [[SQL injection]], [[XSS]] |
| **[[Social engineering]] engagement** | Phishing, vishing, pretexting |
| **Red team engagement** | Goal-based, stealthy, simulates real adversary |

### Team color terminology

- **[[Red team]]** — offense; simulates adversaries.
- **[[Blue team]]** — defense; detects and responds.
- **[[Purple team]]** — collaboration between red and blue to improve detection.
- **White team** — referees; manage the exercise, enforce RoE.

### Pentest vs. vulnerability scan (the trap question)

| | Vulnerability scan | Penetration test |
|---|---|---|
| Automated? | Mostly yes | Largely manual |
| Exploits flaws? | No | Yes |
| Proves impact? | No | Yes |
| Frequency | Continuous / monthly | Annual / quarterly |
| Cost | Low | High |

### Common pitfalls CompTIA tests

- **Scope creep** — testing outside the authorized boundary. Career-ending and possibly criminal.
- **Lack of authorization** — see above.
- **Pivoting into out-of-scope systems** during post-exploitation.
- Confusing **bug bounty** (crowdsourced, ongoing) with **pentest** (contracted, time-boxed).

## Related concepts

[[Vulnerability assessment]] · [[Red team]] · [[Blue team]] · [[Purple team]] · [[Rules of Engagement]] · [[OSINT]] · [[Bug bounty]] · [[Responsible disclosure]] · [[Attestation]] · [[Audit]] · [[MITRE ATT&CK]] · [[Threat hunting]]

---
*Source: VIRGIL knowledge base — 2026-05-08*