# UDP

## What it is
Like shouting announcements into a crowded room — you broadcast the message without checking if anyone heard, without waiting for a reply, and without keeping a record. UDP (User Datagram Protocol) is a connectionless Layer 4 transport protocol that sends packets with no handshake, no acknowledgment, and no guaranteed delivery.

## Why it matters
UDP's stateless nature makes it a weapon for amplification attacks. In a DNS amplification DDoS attack, an attacker sends small UDP queries to open resolvers with a spoofed source IP (the victim's address) — the resolver fires back responses 50–70x larger to the victim, overwhelming their bandwidth without the attacker ever completing a three-way handshake that might expose them.

## Key facts
- UDP uses **no three-way handshake**, making source IP spoofing trivially easy — a core enabler of reflection/amplification attacks
- Common UDP ports to know: **DNS (53), DHCP (67/68), SNMP (161/162), NTP (123), TFTP (69), Syslog (514)**
- Because UDP has no session state, firewalls must use **stateful inspection** carefully — UDP "connections" are tracked by timeout, not by a formal close signal
- NTP and SNMP are frequent amplification targets because their response-to-request size ratios are extreme (NTP monlist can reach **4,000x amplification**)
- UDP is preferred for **real-time applications** (VoIP, video streaming, gaming) where retransmitting lost packets would be worse than losing them

## Related concepts
[[TCP]] [[DNS Amplification Attack]] [[DDoS]] [[SNMP]] [[Network Reconnaissance]]