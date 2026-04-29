# watering hole

## What it is
Like a lion that ignores the open savanna and instead waits patiently at the one watering hole every zebra must visit, an attacker compromises a legitimate website frequented by a specific target group rather than attacking the targets directly. The attacker injects malicious code into the trusted site, then waits for victims to walk into the trap simply by doing their normal browsing.

## Why it matters
In 2013, attackers compromised the iOS developer portal at developer.apple.com, injecting malware that infected the MacBooks of Apple, Facebook, and Twitter employees who visited it. The attack succeeded precisely because security teams trusted the site — it was part of their routine workflow, not a suspicious phishing link.

## Key facts
- **Targeting is deliberate**: attackers profile their victims first, then identify which third-party sites those victims commonly visit (forums, trade publications, vendor portals).
- **Drive-by download delivery**: the injected code typically exploits browser or plugin vulnerabilities silently — no user interaction beyond visiting the page.
- **Hard to detect via sender reputation**: unlike phishing, the malicious URL is a legitimate, often high-reputation domain, defeating many email/URL filters.
- **Defense includes browser isolation, patch management, and network monitoring** for unexpected outbound connections — not just blocking unknown URLs.
- **Often paired with zero-days**: attackers frequently reserve unpatched browser exploits specifically for watering hole campaigns to maximize success before the vulnerability is discovered.

## Related concepts
[[drive-by download]] [[spear phishing]] [[supply chain attack]]