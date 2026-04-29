# Cloudflare

## What it is
Think of Cloudflare as a bouncer, traffic cop, and bullet-proof vest combined — standing between the entire internet and your web server, inspecting every car before it reaches the parking lot. Technically, it is a reverse proxy and content delivery network (CDN) that sits in front of origin servers, filtering malicious traffic, caching content, and absorbing volumetric attacks before they reach the target infrastructure. It operates across 300+ globally distributed data centers, making decisions at the network edge rather than at the origin.

## Why it matters
In 2016, Cloudflare successfully mitigated one of the largest DDoS attacks ever recorded at the time — 400 Gbps of UDP reflection traffic targeting a single customer — by absorbing and scrubbing the flood across its anycast network before a single malformed packet reached the origin server. Without a service like Cloudflare, that customer's infrastructure would have been completely unreachable, representing full availability failure in the CIA triad.

## Key facts
- Cloudflare operates as a **reverse proxy**: the client's connection terminates at Cloudflare's edge, not the origin server, masking the true server IP address
- Its **Web Application Firewall (WAF)** inspects HTTP/S traffic for OWASP Top 10 threats including SQLi, XSS, and command injection
- **Anycast routing** distributes DDoS traffic across all edge nodes simultaneously, diluting attack volume rather than blocking it at a single choke point
- Cloudflare's **DNS resolver (1.1.1.1)** supports DNS-over-HTTPS (DoH) and DNS-over-TLS (DoT) to prevent DNS snooping
- Acts as a **TLS termination point**, meaning Cloudflare decrypts, inspects, and re-encrypts traffic — making it a trusted man-in-the-middle by design

## Related concepts
[[DDoS Mitigation]] [[Web Application Firewall]] [[Reverse Proxy]] [[Content Delivery Network]] [[Anycast Routing]]