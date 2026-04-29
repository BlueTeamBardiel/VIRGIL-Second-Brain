# network protocol

## What it is
Think of a network protocol like the rules of formal diplomacy — both parties must follow strict procedures (handshakes, specific language, turn-taking) or communication completely breaks down. Precisely: a network protocol is a standardized set of rules governing how data is formatted, transmitted, and received between devices on a network. Protocols define everything from packet structure to error-handling behavior.

## Why it matters
Protocol weaknesses are a primary attack surface. In 2014, the SSLv3 POODLE attack exploited the fallback behavior built into the SSL 3.0 protocol itself — not a misconfiguration, but a flaw in how the protocol handled block cipher padding. Defenders must understand protocols deeply enough to recognize when "normal" protocol behavior is being weaponized.

## Key facts
- **TCP vs UDP**: TCP (port-based, three-way handshake: SYN/SYN-ACK/ACK) is connection-oriented and reliable; UDP is connectionless and faster but unverified — attackers exploit UDP for amplification DDoS attacks
- **OSI layer matters**: Attacks targeting Layer 2 (ARP spoofing) require different defenses than Layer 4 (TCP SYN floods) or Layer 7 (HTTP request smuggling)
- **ICMP** is a Layer 3 protocol with no authentication — enabling ping sweeps, redirect attacks, and covert tunneling
- **DNS (UDP/TCP port 53)** is a protocol frequently abused for data exfiltration via DNS tunneling because DNS traffic is rarely blocked at firewalls
- **Protocol downgrade attacks** force systems to negotiate weaker protocol versions (e.g., TLS 1.0 instead of 1.3) — mitigated by disabling legacy protocol support in server configuration

## Related concepts
[[TCP/IP model]] [[OSI model]] [[DNS poisoning]] [[TLS handshake]] [[packet analysis]]