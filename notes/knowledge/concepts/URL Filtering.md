# URL Filtering

## What it is
Like a bouncer with a clipboard who checks every guest's name against an approved (or banned) list before letting them into the club, URL filtering inspects outbound web requests and blocks or allows them based on predefined policies. It is a network security control that evaluates URLs against category databases, reputation scores, or explicit allow/blocklists to prevent users from reaching malicious or policy-violating destinations. It operates at the application layer and is commonly enforced by next-generation firewalls, web proxies, and Secure Web Gateways (SWGs).

## Why it matters
During a phishing campaign, an attacker emails employees a link to a convincing fake login page hosted on a newly registered domain. Even if users click the link, URL filtering with reputation-based blocking can intercept the request and block the connection before the browser loads the credential-harvesting page, breaking the attack chain at the delivery stage.

## Key facts
- URL filtering differs from DNS filtering: DNS filtering blocks at domain resolution, while URL filtering can block specific paths (e.g., `malicious.com/payload` while allowing `malicious.com/home`)
- Categories commonly blocked include: malware sites, phishing, peer-to-peer, gambling, and adult content — used for both security and acceptable use policy enforcement
- Secure Web Gateways (SWGs) combine URL filtering with SSL/TLS inspection, allowing filtering of HTTPS traffic that would otherwise be opaque
- False positives (blocking legitimate sites) are a known operational challenge, often requiring an allow-list override process
- URL filtering is a **compensating control** for user behavior — it reduces risk but is bypassed by tunneling, URL shorteners, or compromised legitimate domains

## Related concepts
[[DNS Filtering]] [[Web Proxy]] [[Secure Web Gateway]] [[Content Filtering]] [[SSL Inspection]]