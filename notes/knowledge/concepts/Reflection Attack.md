# Reflection Attack

## What it is
Imagine signing a letter with "I agree to whatever you wrote" — then someone hands that letter back to *you* as proof *you* made a request. A reflection attack tricks a system into sending its own challenge response back to itself, or redirects a server's amplified traffic toward a victim, by spoofing the source address so the server becomes both weapon and unknowing attacker. The attacker never directly floods the target — the legitimate infrastructure does it for them.

## Why it matters
The 2013 Spamhaus DDoS attack used DNS reflection to generate over 300 Gbps of traffic — attackers sent small DNS queries with spoofed source IPs (the victim's address), and thousands of open resolvers replied with massive responses directly to Spamhaus. This attack highlighted how misconfigured public DNS servers could be weaponized without the attacker touching the target at all, and accelerated industry adoption of BCP38 ingress filtering to block spoofed packets at the source ISP level.

## Key facts
- **Amplification factor** is key: DNS can amplify ~70×, NTP (monlist command) up to ~556×, making reflection attacks devastatingly bandwidth-efficient
- Attackers exploit **stateless, UDP-based protocols** (DNS, NTP, SSDP, memcached) because UDP requires no handshake, making source IP spoofing trivial
- The victim receives unsolicited, legitimate-looking responses from trusted servers, making traffic filtering difficult without blocking real services
- **BCP38 (Network Ingress Filtering)** is the primary countermeasure — ISPs drop packets where source IP doesn't match the originating network
- Distinguished from a pure **amplification attack**: reflection is the *redirection mechanism*; amplification is the *volume multiplier* — they almost always occur together

## Related concepts
[[Amplification Attack]] [[DDoS]] [[UDP Flood]] [[DNS Spoofing]] [[IP Spoofing]]