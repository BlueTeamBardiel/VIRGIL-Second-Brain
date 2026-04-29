# wargame

## What it is
Like a flight simulator that lets pilots crash safely a thousand times before touching a real cockpit, a wargame is a structured, gamified cybersecurity exercise where participants practice offensive and defensive skills against intentionally vulnerable systems. Specifically, wargames present a series of escalating challenges — typically CTF-style puzzles or deliberately misconfigured environments — designed to teach exploitation techniques, cryptanalysis, forensics, and system hardening through hands-on failure.

## Why it matters
Security teams at organizations like the NSA and CISA run internal wargames before deploying new infrastructure to discover exploitable misconfigurations before adversaries do. A red team practicing lateral movement techniques in a wargame environment directly maps to detecting real-world attacks like Pass-the-Hash or Kerberoasting, because the defender learns *exactly* what the attacker's footprints look like in logs.

## Key facts
- Platforms like **OverTheWire**, **HackTheBox**, and **PicoCTF** are well-known wargame environments used for Security+ and CySA+ skill development
- Wargames differ from live penetration tests: they use **controlled, isolated environments** — no real systems are harmed or breached
- Challenges are typically organized by **category**: binary exploitation, web vulnerabilities, reverse engineering, cryptography, and OSINT
- The **"Bandit" wargame** on OverTheWire is a canonical entry point, teaching Linux privilege escalation through 34 sequential levels
- NIST and DoD frameworks encourage wargaming as part of **continuous security validation** — it maps directly to the *Test* phase of the NIST Cybersecurity Framework

## Related concepts
[[Capture The Flag (CTF)]] [[penetration testing]] [[red team vs blue team]] [[privilege escalation]] [[threat emulation]]