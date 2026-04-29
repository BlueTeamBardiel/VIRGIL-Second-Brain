# FreePBX

## What it is
Think of it as WordPress for phone systems — a web-based graphical front-end that sits on top of Asterisk, letting administrators manage a full VoIP PBX without touching the command line. FreePBX is an open-source telephony management platform that configures extensions, trunks, call routing, and voicemail through a browser interface running on Linux servers.

## Why it matters
In 2019, attackers exploited CVE-2019-19006, an authentication bypass in FreePBX's admin panel, to gain root-level access to corporate phone systems. Once inside, threat actors redirected calls to premium-rate numbers (toll fraud), racking up thousands of dollars in charges within hours — a classic VoIP abuse scenario that bypasses traditional network security controls entirely.

## Key facts
- **Toll fraud** is the primary threat: compromised FreePBX installations are weaponized to place international calls through the victim's SIP trunk, generating fraudulent charges
- FreePBX runs on **port 80/443** (web GUI) and relies on **SIP (port 5060/5061)** and **RTP (ports 10000–20000)** for call media — all common attack surfaces
- Default installations historically shipped with **weak credentials** and exposed admin portals — CySA+ candidates should flag internet-facing admin UIs as critical findings
- **CVE-2014-7235** allowed remote code execution via the recordings module — illustrating how web application vulnerabilities in telecom software lead to full system compromise
- Hardening includes disabling the web GUI on public interfaces, enabling **fail2ban** for SIP brute-force protection, and restricting SIP registration by IP whitelist

## Related concepts
[[VoIP Security]] [[SIP Protocol]] [[Toll Fraud]] [[Asterisk PBX]] [[Remote Code Execution]]