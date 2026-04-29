# forward proxy

## What it is
Think of a forward proxy like a travel agent who books all your trips on your behalf — the hotels never know *you* personally, only the agency. Technically, a forward proxy is a server that sits between internal clients and the internet, forwarding outbound requests on their behalf. The destination server sees the proxy's IP, not the originating client's.

## Why it matters
Organizations deploy forward proxies to enforce web content filtering and inspect outbound traffic for data exfiltration. Attackers, however, abuse this architecture by routing C2 (command-and-control) traffic through legitimate proxy services like Cloudflare Workers — making malicious callbacks appear to originate from trusted infrastructure, bypassing IP reputation blockers.

## Key facts
- A forward proxy serves **clients** making outbound requests; a reverse proxy serves **servers** receiving inbound requests — confusing the two is a common exam trap
- Forward proxies can perform **SSL/TLS inspection** (also called SSL bumping) by acting as a MITM, re-signing certificates with an internal CA trusted by endpoints
- They enforce **egress filtering** — blocking access to known malicious domains, adult content, or unauthorized cloud storage (DLP use case)
- **Anonymous proxies** strip identifying headers (e.g., `X-Forwarded-For`); **transparent proxies** do not — users may not even know a transparent proxy exists
- Attackers use forward proxies to **proxy-chain** through multiple hops (e.g., Tor + VPN + open proxy), deliberately degrading attribution forensics

## Related concepts
[[reverse proxy]] [[SSL inspection]] [[data loss prevention]] [[egress filtering]] [[command and control]]