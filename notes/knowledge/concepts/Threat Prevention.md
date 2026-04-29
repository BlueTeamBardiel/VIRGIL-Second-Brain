# Threat Prevention

## What it is
Think of it like a bouncer at a club who checks IDs at the door rather than waiting for trouble to break out on the dance floor — stopping problems before they enter, not after. Threat prevention is a proactive security posture that uses controls, policies, and technologies to block attacks before they cause damage, distinguishing it from threat detection (which identifies threats already present) and incident response (which handles damage after the fact).

## Why it matters
In 2017, the WannaCry ransomware outbreak infected over 200,000 systems across 150 countries — but organizations that had applied the MS17-010 patch (released two months earlier) were completely immune. That patch was a textbook threat prevention control: it closed the EternalBlue vulnerability before attackers could weaponize it, meaning no detection or response was ever needed for those systems.

## Key facts
- Threat prevention operates across the **NIST CSF "Protect" function**, distinct from Detect, Respond, and Recover
- **Defense in depth** is the architectural principle underlying threat prevention — layering controls so no single failure is catastrophic
- Key prevention technologies include **firewalls, IPS (Intrusion Prevention Systems), patch management, email filtering, and application whitelisting**
- An IPS differs from an IDS in that it **actively blocks** malicious traffic inline; an IDS only alerts
- Threat prevention controls are classified as **technical, administrative, or physical** — and further as **deterrent, preventive, or compensating** in control taxonomy (Security+ exam staple)
- **Zero Trust Architecture** is a modern threat prevention model: never trust, always verify, assume breach-by-default

## Related concepts
[[Defense in Depth]] [[Intrusion Prevention System]] [[Patch Management]] [[Zero Trust Architecture]] [[Security Controls]]