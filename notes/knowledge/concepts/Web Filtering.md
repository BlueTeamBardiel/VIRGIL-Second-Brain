# Web Filtering

## What it is
Think of it as a bouncer at a club who checks every URL against a guest list before letting traffic through — legitimate sites get waved in, malicious or policy-violating sites get turned away at the door. Web filtering is the practice of inspecting, categorizing, and controlling HTTP/HTTPS traffic to block access to prohibited or dangerous web content based on predefined rules, URL categories, or reputation scores.

## Why it matters
During a phishing campaign, an attacker sends employees a link to a credential-harvesting site hosted on a newly registered domain. A properly configured web filter with threat intelligence integration recognizes the domain's poor reputation score and blocks the connection before the user ever sees the fake login page — stopping the attack even if the user clicked the link.

## Key facts
- **Content categorization** groups URLs into categories (malware, adult content, gambling, social media) allowing organizations to enforce acceptable use policies at scale
- **SSL/TLS inspection** (HTTPS inspection) is required to examine encrypted traffic; without it, approximately 80%+ of modern malicious traffic hides in HTTPS and bypasses filtering
- **DNS-based filtering** (e.g., Cisco Umbrella) blocks malicious domains at the DNS resolution layer before any TCP connection is established — the fastest possible block point
- **Agent-based vs. proxy-based**: Agent-based filters protect roaming users off-network; proxy-based filters work only while the device is on the corporate network or VPN
- Web filtering is a **compensating control** for user behavior and appears as a defensive layer in the **NIST CSF Protect function** and aligns with **Zero Trust** principles by assuming no destination is inherently safe

## Related concepts
[[DNS Security]] [[Proxy Servers]] [[SSL Inspection]] [[Acceptable Use Policy]] [[URL Analysis]]