# Watering Hole Attacks

## What it is
Like a lion that ignores the savanna and instead lurks beside the single watering hole all zebras must visit, an attacker compromises a website frequented by a specific target group rather than attacking targets directly. The attacker identifies sites their victims routinely visit, injects malicious code into those sites, and waits for victims to walk into the trap. It's a passive, patient, high-yield strategy that bypasses perimeter defenses entirely.

## Why it matters
In 2013, attackers compromised a forum used by iOS developers at Apple, Facebook, and Twitter — infecting visitors' Macs via a zero-day Java exploit within hours of arrival. The attack succeeded precisely because it targeted a trusted niche community site that security teams weren't monitoring as a threat vector, demonstrating that your attack surface includes every site your employees trust.

## Key facts
- **Attack chain:** Attacker profiles target → identifies low-security sites they visit → injects drive-by download or redirect → victim visits, exploit fires → attacker gains foothold
- **Drive-by download** is the typical payload delivery method; no user interaction beyond visiting the page is required
- Watering hole attacks often exploit **zero-day vulnerabilities** in browsers or plugins, making patching alone insufficient defense
- Detection relies heavily on **threat intelligence feeds**, anomaly-based IDS, and DNS monitoring for unusual outbound traffic patterns
- Mitigation includes **browser isolation technology**, script-blocking extensions (NoScript), and network egress filtering to catch C2 callbacks

## Related concepts
[[Drive-By Downloads]] [[Zero-Day Exploits]] [[Threat Intelligence]] [[Browser Isolation]] [[Supply Chain Attacks]]