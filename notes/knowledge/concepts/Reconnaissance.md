# reconnaissance

## What it is
Like a burglar who spends a week watching a house — noting when lights go off, where the dog is, and whether the alarm panel is visible through the window — reconnaissance is the attacker's information-gathering phase before any attack is launched. Formally, it is the systematic collection of data about a target (hosts, services, users, network topology, vulnerabilities) to inform and improve subsequent attack stages. In the MITRE ATT&CK framework, it is the very first tactic in the enterprise matrix.

## Why it matters
Before the 2013 Target breach, attackers conducted reconnaissance to identify that a third-party HVAC vendor had network access — this single piece of intelligence became the pivot point for stealing 40 million credit card numbers. Defenders who monitor for reconnaissance behavior (port scans, WHOIS lookups, abnormal DNS queries) can detect and disrupt the kill chain before any exploitation begins.

## Key facts
- **Passive reconnaissance** gathers information without directly touching the target (OSINT, Shodan, WHOIS, Google dorking) — leaves no logs on victim systems
- **Active reconnaissance** directly probes the target (Nmap scans, banner grabbing, ping sweeps) — detectable in network logs and IDS alerts
- **Footprinting** is the broader term for the full reconnaissance process; **scanning** is the active sub-phase focused on live hosts and open ports
- Tools commonly associated: `nmap`, `recon-ng`, `theHarvester`, `Maltego`, and `Shodan`
- On Security+/CySA+, reconnaissance maps to the **first phase** of both the Cyber Kill Chain (Lockheed Martin) and MITRE ATT&CK; recognizing its indicators is a core analyst skill

## Related concepts
[[OSINT]] [[network scanning]] [[Cyber Kill Chain]] [[footprinting]] [[threat intelligence]]