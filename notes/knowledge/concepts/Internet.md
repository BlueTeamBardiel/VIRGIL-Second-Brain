# Internet

## What it is
Think of it as a postal system where millions of post offices (routers) agree to forward packages (packets) using shared addressing rules — except anyone can read your mail unless you seal it yourself. The Internet is a global network of interconnected networks using the TCP/IP protocol suite, where data is routed across autonomous systems (AS) using protocols like BGP to reach any addressed endpoint worldwide.

## Why it matters
In 2010, a BGP hijacking attack allowed an ISP (China Telecom) to briefly reroute roughly 15% of global Internet traffic through Chinese servers — capturing data from U.S. military, government, and commercial sites. This illustrates that the Internet's foundational routing protocols were designed for trust, not security, making traffic interception and rerouting a persistent infrastructure-level threat.

## Key facts
- The Internet uses a **packet-switched** model — data is broken into packets, routed independently, and reassembled at the destination (contrast with circuit-switched telephony)
- **BGP (Border Gateway Protocol)** controls routing between autonomous systems and has no built-in authentication, making it vulnerable to hijacking and route poisoning
- **ICANN** manages the global DNS root and IP address allocation; **RIRs** (like ARIN, RIPE) distribute IP blocks regionally
- The Internet is **not the same as the Web** — the Web (HTTP/HTTPS) is one application layer service running on top of the Internet, alongside email, DNS, FTP, etc.
- **IPv4 exhaustion** drove adoption of IPv6 (128-bit addresses); many networks run **dual-stack**, creating dual attack surfaces security teams must monitor

## Related concepts
[[TCP/IP Model]] [[BGP Hijacking]] [[DNS]] [[Packet Switching]] [[IPv6 Security]]