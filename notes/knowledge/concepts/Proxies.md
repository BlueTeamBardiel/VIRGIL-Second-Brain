# Proxies

## What it is
Like a personal assistant who makes calls on your behalf so the other party never gets your real number, a proxy is an intermediary server that sits between a client and a destination server, forwarding requests and responses while masking the originating identity. Precisely: a proxy intercepts network traffic at the application layer, making requests on behalf of clients and returning responses — optionally filtering, logging, or modifying content in transit.

## Why it matters
Attackers route malicious traffic through proxy chains (often using SOCKS5 proxies or Tor exit nodes) to obscure their true IP address, making attribution nearly impossible during an intrusion. Defenders deploy **forward proxies** (like Squid) to inspect outbound user traffic for data exfiltration attempts and malware C2 callbacks — a single proxy log can reveal an entire beaconing pattern that endpoint tools missed.

## Key facts
- **Forward proxy**: sits in front of clients, controls outbound access (content filtering, anonymity)
- **Reverse proxy**: sits in front of servers, protects backend infrastructure and enables load balancing — attackers often target these to reach internal services (e.g., SSRF attacks)
- **Transparent proxy**: intercepts traffic without client configuration; users may not know it exists — common in corporate environments for SSL inspection
- **SOCKS proxies** operate at Layer 5 and handle any traffic type, making them more versatile (and abused) than HTTP-only proxies
- Web Application Firewalls (WAFs) are a specialized form of reverse proxy operating at Layer 7, filtering HTTP/HTTPS requests before they hit the application

## Related concepts
[[Firewalls]] [[Network Address Translation]] [[VPN]] [[SSRF]] [[Tor Network]]