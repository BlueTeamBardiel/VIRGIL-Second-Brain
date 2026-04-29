# Layer 7 DDoS attacks

## What it is
Imagine a flash mob that floods a restaurant by having thousands of people each ask the waiter for a detailed menu recitation, then order water — legitimate-looking behavior that collapses the kitchen without breaking any rules. A Layer 7 (Application Layer) DDoS attack overwhelms a target by sending high volumes of seemingly valid HTTP/S requests that exhaust server-side resources like CPU, memory, or database connections. Unlike volumetric attacks, it doesn't need massive bandwidth — a few thousand requests per second can take down a poorly protected web server.

## Why it matters
In 2023, a coordinated HTTP/2 Rapid Reset attack exploited a protocol-level weakness to generate record-breaking request floods, peaking at 398 million requests per second — achieved with a relatively small botnet. This forced major cloud providers to issue emergency patches and highlighted that application-layer attacks can bypass traditional volumetric DDoS mitigations entirely, requiring WAFs and rate-limiting logic tuned at Layer 7.

## Key facts
- Operates at the OSI Application Layer (Layer 7), targeting HTTP, HTTPS, DNS, or SMTP services specifically
- Common variants include HTTP floods, Slowloris (holds connections open with partial requests), and cache-bypass attacks that force dynamic content regeneration
- Difficult to detect because individual requests appear legitimate; distinguishing malicious from real traffic requires behavioral analysis, not just packet inspection
- Mitigations include Web Application Firewalls (WAFs), CAPTCHA challenges, rate limiting per IP/session, and challenge-response mechanisms like JavaScript challenges
- Often combined with botnets to distribute source IPs, defeating simple IP-blocklist defenses — CySA+ expects you to know why geoblocking alone is insufficient

## Related concepts
[[Denial of Service (DoS)]] [[Web Application Firewall (WAF)]] [[Slowloris Attack]] [[Botnet]] [[Rate Limiting]]