# denial of service

## What it is
Imagine a restaurant where one person calls to make 10,000 fake reservations — the phone lines jam and real customers can't get through. A Denial of Service (DoS) attack works the same way: an attacker floods a target system with illegitimate traffic or requests, exhausting its resources (bandwidth, CPU, memory, connections) until it can no longer serve legitimate users.

## Why it matters
In October 2016, the Mirai botnet launched a massive Distributed DoS (DDoS) attack against Dyn, a major DNS provider, taking down Twitter, Reddit, Netflix, and dozens of other services for hours. The attack used compromised IoT devices (cameras, routers) to generate ~1.2 Tbps of traffic — demonstrating that availability is a first-class security concern, not an afterthought.

## Key facts
- **DoS vs. DDoS**: DoS originates from a single source; DDoS uses many distributed sources (often a botnet), making it far harder to block by simply blacklisting one IP.
- **Attack types**: Volumetric (flood bandwidth), Protocol (exploit TCP handshake — SYN flood), and Application-layer (HTTP GET flood targeting web servers) — all three categories appear on Security+ exams.
- **SYN flood mechanics**: Attacker sends TCP SYN packets but never completes the three-way handshake, filling the server's half-open connection table until it stops accepting new connections.
- **Amplification attacks**: DNS and NTP amplification exploit small requests that generate large responses, multiplying attack traffic with spoofed source IPs — amplification ratios can exceed 50:1.
- **Mitigations**: Rate limiting, SYN cookies, ingress filtering (BCP38), scrubbing centers (e.g., Cloudflare, Akamai), and anycast diffusion are standard defensive controls.

## Related concepts
[[DDoS]] [[botnet]] [[SYN flood]] [[amplification attack]] [[availability]]