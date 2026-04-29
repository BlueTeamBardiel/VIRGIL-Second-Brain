# UDP flood

## What it is
Imagine calling every extension at a company simultaneously, then hanging up before anyone answers — the switchboard collapses trying to process phantom calls. A UDP flood is a volumetric DDoS attack where an attacker sends massive quantities of forged UDP datagrams to random ports on a target, forcing it to repeatedly check for listening applications, generate ICMP "Destination Unreachable" replies, and exhaust both CPU and bandwidth in the process.

## Why it matters
In 2016, the Mirai botnet leveraged UDP floods (among other vectors) against Dyn DNS, taking down major platforms including Twitter, Netflix, and Reddit for hours. This demonstrated that volumetric UDP attacks don't need to be technically sophisticated — just large enough to saturate upstream links and overwhelm stateless protocol handlers at scale.

## Key facts
- UDP is connectionless and requires no handshake, making spoofing trivial — attackers forge source IPs so victims can't easily filter or trace the origin
- The attack exploits the victim's obligation to respond: for every unknown port hit, the OS generates an ICMP Type 3 (Port Unreachable) packet, multiplying processing overhead
- Measured in packets-per-second (PPS) and gigabits-per-second (Gbps); modern attacks routinely exceed 100 Gbps
- Primary mitigations include rate limiting ICMP responses, blocking unexpected UDP traffic at the perimeter, and upstream scrubbing via DDoS protection services (e.g., Cloudflare Magic Transit, AWS Shield)
- Classified as a **volumetric attack** in the DDoS taxonomy (alongside ICMP floods), distinct from protocol attacks (SYN flood) and application-layer attacks (HTTP flood)

## Related concepts
[[DDoS attack]] [[ICMP flood]] [[Amplification attack]] [[Botnet]] [[Rate limiting]]