# Watering Hole Attack

## What it is
Like a lion that ignores the vast savanna and instead waits patiently at the single watering hole where prey *must* come to drink, an attacker compromises a website that a specific target group is known to visit regularly. Rather than attacking victims directly, the attacker poisons the trusted ground and lets the victims walk into it themselves. It is a strategic, passive infection technique that exploits implicit trust in familiar websites.

## Why it matters
In 2013, attackers compromised the iOS developer forum at iphonedevSDK.com, knowing Apple, Facebook, and Twitter employees frequented it. Visiting the site delivered a zero-day Java exploit that infected corporate machines, resulting in breaches at all three companies. This demonstrates why high-value organizations can be compromised through third-party sites entirely outside their security perimeter.

## Key facts
- Attackers **profile the target group first**, identifying which niche forums, industry news sites, or supplier portals they habitually visit
- The injected payload is often a **drive-by download** using browser or plugin exploits, requiring no user interaction beyond visiting the page
- Attacks are frequently **highly targeted** (nation-state level) and use zero-days to evade detection, making them difficult to attribute quickly
- Defenders use **web content filtering, browser isolation, and threat intelligence feeds** to detect unusual outbound connections from compromised sites
- On Security+/CySA+: classified as a **targeted, passive attack** that exploits trust relationships rather than direct phishing or brute force

## Related concepts
[[Drive-By Download]] [[Spear Phishing]] [[Zero-Day Exploit]] [[Threat Intelligence]] [[Supply Chain Attack]]