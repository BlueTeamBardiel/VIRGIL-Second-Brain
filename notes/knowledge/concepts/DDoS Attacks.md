# DDoS attacks

## What it is
Imagine a flash mob of 10,000 people simultaneously walking into a single McDonald's and ordering one small fry each — the restaurant can't serve real customers because every resource is consumed by noise. A Distributed Denial of Service (DDoS) attack works identically: thousands of compromised hosts (a botnet) flood a target system with illegitimate traffic until legitimate requests can't be processed. Unlike a simple DoS, the "distributed" element makes source-blocking nearly impossible.

## Why it matters
In October 2016, the Mirai botnet enslaved 600,000+ IoT devices (cameras, routers) and launched a 1.2 Tbps DDoS attack against Dyn, a major DNS provider — taking down Twitter, Netflix, and Reddit for hours. This demonstrated that the attack surface isn't just servers; insecure embedded devices are weaponized infrastructure. Defenders responded by implementing anycast routing and scrubbing centers to absorb and filter malicious traffic.

## Key facts
- **Three primary DDoS categories**: Volumetric (flood bandwidth — UDP floods, ICMP floods), Protocol (exhaust stateful devices — SYN floods exploit TCP handshake), and Application layer (Layer 7 — HTTP GET floods mimic legitimate users)
- **SYN flood mechanics**: Attacker sends SYN packets with spoofed IPs; server allocates half-open connections until the connection table fills and crashes
- **Amplification attacks** exploit protocols with asymmetric request/response ratios — DNS amplification can achieve 50:1 amplification factor, NTP (monlist) up to 556:1
- **Mitigations**: Rate limiting, ingress filtering (BCP38), black hole routing (RTBH), scrubbing centers, and CDN-based absorption
- **SYN cookies** are a key defense — server encodes state into the sequence number, eliminating the need to store half-open connections

## Related concepts
[[Botnet]] [[Amplification Attack]] [[SYN Flood]] [[Ingress Filtering]] [[Anycast Routing]]