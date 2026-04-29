# HTTP proxying

## What it is
Like a postal clerk who reads your letter, reseals it in their own envelope, and delivers it on your behalf — an HTTP proxy sits between a client and server, intercepting and forwarding web requests in its own name. Precisely: an HTTP proxy is an intermediary server that receives client HTTP requests, optionally inspects or modifies them, and forwards them to the destination server, returning the response back through itself.

## Why it matters
Defenders deploy **SSL-intercepting proxies** (e.g., Zscaler, Squid with TLS inspection) inside corporate networks to decrypt HTTPS traffic, scan for malware, and enforce DLP policies before re-encrypting and forwarding. Attackers abuse this same architecture by routing C2 traffic through legitimate proxy services (like Cloudflare Workers) to blend malicious traffic with normal HTTPS and evade detection — a technique called *domain fronting*.

## Key facts
- **Forward proxy**: client-facing; hides the client's identity from the server (used in corporate egress filtering and anonymization).
- **Reverse proxy**: server-facing; hides backend servers from clients; common in load balancing and WAF deployments (e.g., NGINX, AWS ALB).
- **CONNECT method**: HTTP verb that establishes a TCP tunnel through the proxy, enabling HTTPS and non-HTTP protocols — frequently abused for tunneling C2 traffic.
- **Transparent proxy**: intercepts traffic without client configuration; common in ISPs and some enterprise environments; clients may not know they're being proxied.
- **Burp Suite** operates as an intercepting proxy on `127.0.0.1:8080`, making it the standard tool for web application penetration testing and manual traffic manipulation.

## Related concepts
[[Man-in-the-Middle Attack]] [[TLS Inspection]] [[Reverse Proxy]] [[Domain Fronting]] [[Web Application Firewall]]