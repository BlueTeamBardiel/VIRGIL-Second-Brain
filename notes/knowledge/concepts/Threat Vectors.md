# Threat Vectors

## What it is
Think of a threat vector like a delivery route a pizza driver uses — it's not the pizza itself (the malware or attack), but the specific path taken to get it to your door. Precisely defined, a threat vector is the method or pathway an attacker uses to gain unauthorized access to a system or network. It describes *how* an attack arrives, not what damage it causes.

## Why it matters
In the 2016 Democratic National Committee breach, spear-phishing emails were the threat vector — attackers didn't hack through firewalls directly, they simply sent a convincing email that tricked a user into surrendering credentials. Defenders who focused only on perimeter hardening missed the human-layer vector entirely, demonstrating why mapping all possible vectors is essential before prioritizing controls.

## Key facts
- **Common threat vectors**: phishing (email), removable media (USB), unsecured wireless, supply chain compromise, unpatched software vulnerabilities, and direct physical access
- **Vector vs. threat vs. vulnerability**: a *threat* is the potential harm, a *vulnerability* is the weakness exploited, and the *vector* is the specific delivery mechanism — Security+ tests these distinctions directly
- **Supply chain vectors** are increasingly critical — the SolarWinds attack used a trusted software update as its vector, bypassing nearly all traditional defenses
- **Attack surface reduction** works by eliminating or hardening vectors — disabling unused USB ports, blocking external email attachments, and patching exposed services all shrink available routes
- **Direct-access (physical) vectors** are often overlooked — tailgating into a server room or plugging in a rogue device bypasses all logical security controls entirely

## Related concepts
[[Attack Surface]] [[Threat Actor]] [[Vulnerability Management]] [[Social Engineering]] [[Supply Chain Attack]]