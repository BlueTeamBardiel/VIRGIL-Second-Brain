# Honeynet

## What it is
Like setting up a fake entire neighborhood of houses wired with hidden cameras to watch burglars move between properties — a honeynet is a network of intentionally vulnerable decoy systems designed to attract, observe, and analyze attacker behavior across multiple interconnected honeypots. Unlike a single honeypot, a honeynet simulates a realistic multi-system environment, complete with routers, servers, and workstations, making the deception far more convincing and the intelligence gathered far richer.

## Why it matters
In 2010, researchers used a honeynet to study the Conficker worm's propagation techniques in real time — watching how it moved laterally, exploited SMB vulnerabilities, and phoned home to command-and-control servers. This intelligence directly informed defensive signatures and patch prioritization without exposing any production systems to risk.

## Key facts
- A honeynet contains multiple honeypots networked together, mimicking a realistic enterprise environment to study complex attack chains, not just single exploitation events.
- **Honeywall** is the gateway device controlling traffic into and out of a honeynet, capturing all attacker activity while preventing the honeynet from being weaponized to attack external systems.
- Honeynets are classified as **high-interaction** deception systems — attackers interact with real or near-real operating systems, providing maximum intelligence but requiring careful containment.
- Data collected from a honeynet (keystroke logs, malware samples, TTPs) feeds directly into threat intelligence programs and can improve SIEM rules and IOC databases.
- Any traffic entering a honeynet is **presumed malicious by default** — there is no legitimate reason for real users to access decoy systems, making alert fidelity extremely high with near-zero false positives.

## Related concepts
[[Honeypot]] [[Deception Technology]] [[Threat Intelligence]] [[Lateral Movement]] [[SIEM]]