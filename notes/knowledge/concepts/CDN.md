# CDN

## What it is
Think of a CDN like a chain of convenience stores stocked with copies of a warehouse's inventory — customers get what they need from the nearest store instead of driving to the distant warehouse. A Content Delivery Network (CDN) is a geographically distributed network of proxy servers that cache and serve web content from nodes closest to end users. This reduces latency, distributes load, and shields the origin server from direct exposure to the public internet.

## Why it matters
CDNs are a frontline DDoS mitigation tool — when attackers flood a site with volumetric traffic, the CDN's distributed infrastructure absorbs the traffic across hundreds of nodes rather than overwhelming a single origin server. However, CDNs also introduce a trust boundary risk: misconfigured CDN cache rules can expose sensitive data (e.g., authenticated responses cached and served to unauthenticated users), a vulnerability known as **web cache poisoning**. Attackers have exploited CDN caching logic to serve malicious content to thousands of users simultaneously by manipulating cache keys.

## Key facts
- CDNs operate at the **network edge**, acting as reverse proxies between clients and origin servers
- **Web cache poisoning** occurs when an attacker manipulates cached HTTP responses to deliver malicious content to legitimate users
- CDNs can terminate **TLS connections** at the edge, meaning the CDN provider sees unencrypted traffic — a critical trust consideration
- Major CDN providers (Cloudflare, Akamai, Fastly) offer integrated **WAF** and **DDoS mitigation** as part of their services
- CDN IP ranges are public and well-known; attackers may attempt **origin server discovery** to bypass CDN protections and attack directly

## Related concepts
[[DDoS Mitigation]] [[Web Cache Poisoning]] [[Reverse Proxy]] [[WAF]] [[TLS Termination]]