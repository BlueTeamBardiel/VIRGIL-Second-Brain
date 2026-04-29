# reverse proxy

## What it is
Like a bouncer at a club who stands at the door, checks your ID, and then decides which bartender serves you — all without you ever knowing the bartenders exist. A reverse proxy is a server that sits in front of backend servers, intercepting client requests and forwarding them while hiding the real infrastructure. Unlike a forward proxy (which represents the client), a reverse proxy represents the server.

## Why it matters
A web application firewall (WAF) is commonly deployed as a reverse proxy, meaning all HTTP traffic is inspected before it ever reaches the application server. This single chokepoint allowed defenders at Cloudflare to absorb a record-breaking 71 million RPS DDoS attack in 2023 by filtering malicious traffic upstream — the actual origin servers never saw the flood. Without the reverse proxy layer, origin IPs would be exposed and overwhelmed directly.

## Key facts
- Hides the IP addresses and architecture of backend servers, preventing direct targeting
- Enables **TLS termination** — the proxy handles encryption/decryption, offloading overhead from backend servers
- Provides **load balancing** by distributing requests across multiple backend servers
- WAFs (Web Application Firewalls) are architecturally reverse proxies — this appears frequently on CySA+ scenarios
- An attacker who discovers the **origin IP** behind a reverse proxy (via DNS history, email headers, or certificate leaks) can bypass DDoS protection entirely — a known evasion technique

## Related concepts
[[forward proxy]] [[web application firewall]] [[load balancer]] [[TLS termination]] [[DDoS mitigation]]