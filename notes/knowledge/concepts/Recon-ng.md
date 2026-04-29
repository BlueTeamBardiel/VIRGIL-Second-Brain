# Recon-ng

## What it is
Think of it as a Swiss Army knife built specifically for OSINT — the way Metasploit organizes exploits into modules, Recon-ng organizes intelligence-gathering tasks into a clean, interactive framework. It is an open-source Python-based reconnaissance framework that automates the collection of publicly available information (OSINT) about targets using modular "recipes" that query APIs, databases, and web sources.

## Why it matters
During a penetration test scoping phase, an attacker (or authorized tester) can use Recon-ng to automatically harvest employee email addresses from LinkedIn, cross-reference them with breach databases, and map subdomains — all before touching a single system. This passive reconnaissance phase is critical because it generates no alerts on the target's IDS/IPS, making it a stealthy first step before active scanning with tools like Nmap.

## Key facts
- Recon-ng uses a **modular architecture** nearly identical to Metasploit — users load specific modules (e.g., `recon/domains-hosts/hackertarget`) to perform discrete tasks
- It stores all gathered data in a **local SQLite database**, allowing analysts to correlate and query findings across multiple modules in one workspace
- Modules interact with **third-party APIs** (Shodan, VirusTotal, Hunter.io) — requiring API keys configured in the framework's `keys` store
- Recon-ng operates entirely through **passive/OSINT methods**; it does not send packets directly to the target, making it legally and operationally safer during early recon
- Relevant to **CySA+ and OSCP** as a standard tool for the intelligence-gathering phase of the penetration testing lifecycle

## Related concepts
[[OSINT]] [[Passive Reconnaissance]] [[Metasploit Framework]] [[Shodan]] [[Penetration Testing Phases]]