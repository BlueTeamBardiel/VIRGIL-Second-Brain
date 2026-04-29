# DENIAL_OF_SERVICE

## What it is
Imagine a prankster calling a pizza shop every 30 seconds with fake orders until the phone line is permanently busy and real customers can't get through. A Denial-of-Service (DoS) attack works exactly like this — flooding a target system with illegitimate requests until it exhausts its resources and becomes unavailable to legitimate users.

## Why it matters
In October 2016, the Mirai botnet launched a massive Distributed DoS (DDoS) attack against Dyn, a major DNS provider, taking down Twitter, Netflix, Reddit, and dozens of other services for hours. Attackers had hijacked thousands of IoT devices (cameras, routers) and directed their combined traffic at a single chokepoint — demonstrating that even critical internet infrastructure is vulnerable to resource exhaustion.

## Key facts
- **DoS vs. DDoS**: DoS originates from a single source; DDoS uses many distributed sources (often a botnet), making it far harder to block with simple IP filtering.
- **Attack types**: Volumetric (bandwidth flooding), Protocol (SYN flood exploiting TCP handshake), and Application-layer (HTTP flood targeting web servers) — Security+ distinguishes all three.
- **SYN Flood mechanics**: Attacker sends TCP SYN packets without completing the handshake, filling the server's half-open connection table until it stops accepting new connections.
- **Amplification attacks** (e.g., DNS, NTP amplification) exploit protocols where a small spoofed request triggers a large response — multiplying attack bandwidth by 50–70x.
- **Mitigations**: Rate limiting, SYN cookies, blackhole routing, upstream scrubbing centers (e.g., Cloudflare, Akamai), and ingress filtering (BCP38) to block spoofed source IPs.

## Related concepts
[[DISTRIBUTED_DENIAL_OF_SERVICE]] [[BOTNET]] [[SYN_FLOOD]] [[AMPLIFICATION_ATTACK]] [[RATE_LIMITING]]