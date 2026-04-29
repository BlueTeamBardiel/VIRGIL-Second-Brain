# proxy

## What it is
Like a personal assistant who makes phone calls on your behalf — the other party sees your assistant's number, not yours — a proxy is an intermediary server that forwards requests between a client and a destination server. The client communicates with the proxy, which relays traffic, masking the originating IP address from the destination.

## Why it matters
Attackers use anonymizing proxies (like Tor exit nodes or rented VPS servers) to launder their origin during reconnaissance and exploitation, making attribution extremely difficult for defenders. Blue teams combat this by deploying **forward proxies** that inspect and log all outbound traffic, allowing analysts to catch malware beaconing to command-and-control servers even when the malware tries to blend in with normal HTTP traffic.

## Key facts
- **Forward proxy**: sits between internal clients and the internet; controls and monitors outbound traffic (common in corporate environments via Squid or Zscaler)
- **Reverse proxy**: sits in front of internal servers, fielding inbound requests; provides load balancing, SSL termination, and hides server architecture (e.g., Nginx, HAProxy)
- **Transparent proxy**: intercepts traffic without client configuration; the client doesn't know it exists — commonly used for content filtering in schools/ISPs
- **SOCKS5 proxies** operate at Layer 5 and handle any TCP/UDP traffic (not just HTTP), making them preferred by attackers for tunneling arbitrary protocols
- Web Application Firewalls (WAFs) are a specialized form of reverse proxy that inspect HTTP/S payloads for SQLi, XSS, and other application-layer attacks

## Related concepts
[[firewall]] [[VPN]] [[network address translation]] [[command and control]] [[web application firewall]]