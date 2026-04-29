# Honeypot

## What it is
Like a jar of honey left on the counter to catch ants — you don't care about the jar, you care about *which ants show up and how they behave*. A honeypot is a deliberately vulnerable decoy system designed to attract attackers, observe their tactics, and gather threat intelligence without exposing real production assets.

## Why it matters
In 2015, security researchers deployed a network of SSH honeypots and discovered a coordinated botnet systematically brute-forcing default credentials across thousands of IoT devices — intelligence that directly preceded public awareness of Mirai-style attacks. Without the honeypot, those reconnaissance patterns would have been invisible noise in legitimate traffic logs.

## Key facts
- **Interaction levels matter**: Low-interaction honeypots simulate services (easy to deploy, limited intel); high-interaction honeypots run real OSes and applications (rich intel, higher risk of attacker escape/pivot)
- **Honeynet** = a network of multiple honeypots, used to observe lateral movement and multi-stage attack chains
- **Legal caveat**: Honeypots must be designed carefully — actively *luring* attackers can raise entrapment concerns, though passive deception is generally legally sound
- **Detection signatures**: Attackers increasingly fingerprint honeypots (e.g., checking for Honeyd artifacts or unrealistic system responses), making realism a critical design consideration
- **Pseudo-flaw** is a related technique — intentionally planted fake vulnerabilities used to misdirect attackers inside a real environment (distinct from a full honeypot deployment)

## Related concepts
[[Threat Intelligence]] [[Intrusion Detection System]] [[Deception Technology]] [[Network Traffic Analysis]] [[Indicator of Compromise]]