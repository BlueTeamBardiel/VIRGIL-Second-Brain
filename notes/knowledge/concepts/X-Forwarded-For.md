# X-Forwarded-For

## What it is
Like a postal relay stamp showing every sorting facility a letter passed through, X-Forwarded-For (XFF) is an HTTP request header that records the chain of IP addresses a request traveled through before reaching a server. When a client connects through proxies or load balancers, XFF preserves the originating client IP that would otherwise be masked by the intermediary's address.

## Why it matters
Attackers routinely spoof XFF headers to bypass IP-based access controls or rate limiting — if a web application trusts XFF to identify "real" client IPs without validating that the request actually came through a trusted proxy, an attacker can inject `X-Forwarded-For: 127.0.0.1` and trick the server into treating their request as internal traffic. This has been used to bypass admin panel restrictions and circumvent brute-force lockouts in real-world applications.

## Key facts
- XFF format is a comma-separated list: `X-Forwarded-For: client, proxy1, proxy2` — the leftmost IP is the claimed originating client
- The header is **not authenticated** — any client can forge it entirely; servers must only trust it when received from a known, trusted proxy
- Web application firewalls (WAFs) and logging systems that naively read XFF for geolocation or blocking purposes are vulnerable to IP spoofing via header injection
- `X-Real-IP` and the standardized `Forwarded` header (RFC 7239) are related alternatives; RFC 7239 was designed to address XFF's lack of standardization
- Security misconfiguration (OWASP A05) is the root cause when applications blindly trust XFF — proper implementation requires validating the request's actual TCP source IP against an allowlist of trusted proxies

## Related concepts
[[HTTP Header Injection]] [[Proxy Servers]] [[IP Spoofing]] [[Web Application Firewall]] [[OWASP Top 10]]