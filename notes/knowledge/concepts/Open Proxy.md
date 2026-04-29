# Open Proxy

## What it is
Think of an open proxy like a mail forwarding service that accepts packages from *anyone* — no account, no ID, no questions asked. Technically, it's a proxy server that relays requests on behalf of any client without authentication or access restrictions, effectively hiding the client's true IP address from the destination server.

## Why it matters
Attackers routinely chain open proxies to obscure the origin of reconnaissance scans, web scraping, or credential-stuffing attacks — making it appear traffic originates from a trusted geographic region. A threat actor in Eastern Europe, for example, might route attack traffic through open proxies in the U.S. to bypass geo-blocking controls on a banking portal. Defenders use proxy reputation feeds and egress filtering to detect or block known open proxy IPs.

## Key facts
- Open proxies operate at Layer 7 (application layer) and are commonly found on TCP port 8080, 3128, or 80
- They are frequently exploited for **IP evasion**, bypassing access controls, and launching anonymous attacks against third parties
- **Anonymous proxies** hide the client IP; **transparent proxies** do not — open proxies are typically anonymous by design
- Organizations should block outbound connections to known open proxy lists using threat intelligence feeds (e.g., Spamhaus, Emerging Threats)
- Misconfigured internal servers (e.g., Squid with no ACL) can accidentally become open proxies, creating an **unintended egress point** that attackers may discover and abuse
- On Security+ exams, open proxies appear in the context of **anonymization techniques**, indicators of compromise, and network access control bypass

## Related concepts
[[Proxy Server]] [[Anonymization]] [[Egress Filtering]] [[Threat Intelligence]] [[IP Spoofing]]