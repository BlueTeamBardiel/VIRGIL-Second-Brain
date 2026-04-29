# Content Delivery Networks

## What it is
Think of a CDN like a chain of convenience stores stocked with copies of a popular product — instead of everyone driving to one central warehouse, locals grab what they need nearby. A CDN is a geographically distributed network of proxy servers that cache and deliver web content (images, scripts, video) from edge nodes closest to the user, reducing latency and offloading traffic from origin servers.

## Why it matters
During the 2016 Dyn DNS attack, a Mirai botnet generated ~1.2 Tbps of traffic, taking down major sites. Organizations using CDN providers like Cloudflare or Akamai were partially shielded because the CDN's distributed infrastructure absorbed traffic before it reached origin servers — this is CDN-based DDoS mitigation in practice. Conversely, attackers have abused CDN infrastructure to host malware, exploiting the trusted reputation of CDN domains to bypass content filters.

## Key facts
- CDNs mitigate **volumetric DDoS attacks** by distributing traffic across hundreds of PoPs (Points of Presence), making it harder to saturate any single link
- **TLS termination** often occurs at the CDN edge, meaning the CDN provider decrypts your users' HTTPS traffic — a significant trust and data-privacy consideration
- CDN **cache poisoning** is a real attack vector: malicious content injected into cached responses gets served to thousands of users simultaneously
- Many CDNs provide **WAF (Web Application Firewall)** capabilities, filtering SQLi and XSS at the edge before requests reach the origin
- CDN origin servers should be protected by **IP allowlisting** to only accept traffic from CDN edge nodes; failure to do so exposes the origin to direct attack, bypassing all CDN protections

## Related concepts
[[DDoS Mitigation]] [[Web Application Firewall]] [[TLS/SSL Inspection]] [[Cache Poisoning]] [[DNS Security]]