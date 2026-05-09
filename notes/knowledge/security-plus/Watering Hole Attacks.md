# Watering Hole Attacks

## What it is

In Street Fighter, Sagat doesn't chase Ryu around the stage — he plants himself in the corner, throws Tiger Shots at predictable intervals, and waits for Ryu to walk into the trap on his own approach. That's exactly what a watering hole attack does — the attacker doesn't target the victim directly; they poison a website the victim already visits regularly and waits for them to walk in.

A **watering hole attack** is a targeted compromise in which an adversary infects a third-party website frequented by a specific user demographic, organization, or industry vertical to deliver malware to those visitors when they browse normally.

## Why it matters

Watering hole attacks bypass perimeter defenses entirely because the malicious payload arrives over an outbound, user-initiated, trusted HTTPS connection — your firewall sees a legitimate employee visiting a legitimate industry site. They are favored by **APT groups** for espionage against sectors that share niche resources (defense contractors visiting an industry forum, energy firms reading a regulator's site). On the SY0-701 exam, this falls under **Objective 2.2 (threat vectors and attack surfaces)**, and CompTIA's classic trap is making you confuse it with **phishing** (delivery is direct) or **supply chain attacks** (compromise is upstream in the vendor pipeline). Watering hole = attacker compromises a *site the victim trusts and visits unprompted*.

## Key facts

### Attack mechanics

1. **Reconnaissance** — attacker profiles the target's browsing habits, often via OSINT or prior breach data.
2. **Site selection** — picks a low-security third-party site the target visits (industry blog, vendor portal, local news).
3. **Compromise** — exploits the site itself, often via [[CMS vulnerabilities]] (WordPress plugins, outdated Drupal), [[SQL injection]], or [[stolen credentials]].
4. **Payload staging** — injects malicious JavaScript, drive-by download, or fake update prompt.
5. **Targeting filter** — payload often fires only for specific IP ranges, user agents, or geolocations to avoid detection.
6. **Exploitation** — visitor's browser executes [[zero-day]] or unpatched exploit; malware is delivered.

### Real-world examples

| Year | Campaign | Target |
|------|----------|--------|
| 2012 | **VOHO** | US defense / financial sector |
| 2013 | **Department of Labor compromise** | Nuclear-research staff visiting SEM page |
| 2017 | **CCleaner backdoor** (hybrid) | Tech sector users |
| 2019 | **Holy Water** | Asian religious / charity groups |

### Defenses

- **Patch management** — keep browsers, plugins, and OS current to neutralize drive-by exploits. ([[Vulnerability management]])
- **[[Endpoint Detection and Response]] (EDR)** — catches post-exploitation behavior even when delivery is novel.
- **[[DNS filtering]]** / [[Secure Web Gateway]] — blocks known malicious domains and newly-registered domains.
- **[[Browser isolation]]** — renders untrusted sites in a remote sandbox; payload never touches the endpoint.
- **[[Application allow-listing]]** — unauthorized binaries can't execute even if downloaded.
- **[[Threat intelligence]] feeds** — IOC sharing across an ISAC catches industry-targeted campaigns early.
- **User awareness** — limited utility here, since the user did nothing wrong; this is why technical controls dominate.

### Comparison to similar attacks

| Attack | Delivery vector | Targeting |
|--------|-----------------|-----------|
| **Watering hole** | Compromised third-party site visited by victim | Group / industry |
| **Phishing** | Email or message sent to victim | Individual or broad |
| **Spear phishing** | Tailored email to specific individual | Individual |
| **Pharming** | DNS poisoning redirects victim | Anyone resolving the domain |
| **Supply chain** | Compromised vendor software/hardware | Customers of vendor |

### Exam-trap distinctions

- The victim **initiates the connection** — that's the watering hole signature.
- It is a form of **client-side attack** but is *not* phishing.
- Often paired with [[zero-day]] exploits, but doesn't require one.
- Frequently classified as a [[targeted attack]] vector used by [[advanced persistent threat]] actors.

## Related concepts

[[Phishing]] · [[Spear phishing]] · [[Drive-by download]] · [[Supply chain attack]] · [[Advanced Persistent Threat]] · [[Zero-day]] · [[Browser isolation]] · [[DNS filtering]] · [[Threat intelligence]] · [[Cross-site scripting]]

---
*Source: VIRGIL knowledge base — 2026-05-08*