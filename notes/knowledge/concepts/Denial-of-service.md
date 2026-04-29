# denial-of-service

## What it is
Imagine a restaurant where a prankster reserves every single table using fake names — real customers can't get a seat, not because the restaurant is broken, but because its resources are exhausted. A Denial-of-Service (DoS) attack works the same way: an attacker floods a target system with illegitimate traffic or requests, consuming bandwidth, memory, or processing power until legitimate users can no longer be served.

## Why it matters
In 2016, the Mirai botnet hijacked hundreds of thousands of IoT devices — cameras, routers, baby monitors — and directed them at Dyn, a major DNS provider, knocking offline Twitter, Netflix, Reddit, and PayPal for hours. This demonstrated that DoS doesn't require sophistication; it requires scale. Defenders responded by implementing anycast routing and traffic scrubbing through CDN providers like Cloudflare to absorb volumetric attacks.

## Key facts
- **DoS vs. DDoS**: A standard DoS attack originates from a single source; a Distributed DoS (DDoS) uses many compromised systems (a botnet) simultaneously, making source-blocking ineffective.
- **SYN Flood**: Exploits the TCP three-way handshake by sending SYN packets without completing the connection, filling the server's half-open connection table until it stops accepting legitimate connections.
- **Amplification attacks** (e.g., DNS, NTP, SSDP reflection) send small spoofed requests to third-party servers that reply with much larger responses directed at the victim — amplifying bandwidth by factors of 10–500×.
- **Permanent DoS (PDoS / "phlashing")** destroys firmware on a device, requiring physical replacement — far more damaging than temporary availability loss.
- **Mitigation strategies** include rate limiting, ingress filtering (BCP38), blackhole routing, traffic scrubbing centers, and SYN cookies to counter SYN flood attacks.

## Related concepts
[[distributed-denial-of-service]] [[botnet]] [[syn-flood]] [[amplification-attack]] [[ingress-filtering]]