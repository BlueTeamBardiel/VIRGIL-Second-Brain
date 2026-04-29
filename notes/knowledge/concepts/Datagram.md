# Datagram

## What it is
Like dropping a postcard in a mailbox — it has a destination address, but no guarantee it arrives, no confirmation it was received, and no promise it won't be read along the way. A datagram is a self-contained, independent packet of data transmitted over a network using a connectionless protocol (primarily UDP), carrying enough header information to be routed from source to destination without a pre-established connection.

## Why it matters
UDP datagrams are the weapon of choice in amplification DDoS attacks. An attacker spoofs the victim's IP address as the source, sends small DNS or NTP request datagrams to open resolvers, and the servers blast massive response datagrams back at the victim — sometimes at 50:1 amplification ratios. Because UDP is connectionless, there's no handshake to expose the spoofed source before the damage is done.

## Key facts
- Datagrams operate at Layer 3 (Network) conceptually, but the term is most associated with **UDP at Layer 4** — no SYN/ACK, no session state
- Each datagram is **independently routed** — two successive packets between the same hosts may take different paths and arrive out of order
- UDP datagrams lack built-in error correction; **reliability must be handled by the application layer** if needed at all
- **IP spoofing** is trivially easy with datagrams because no three-way handshake validates the source address
- Common protocols using datagrams: **DNS (port 53), DHCP (67/68), NTP (123), SNMP (161), TFTP (69)** — all frequent attack vectors

## Related concepts
[[UDP Flood Attack]] [[DNS Amplification Attack]] [[IP Spoofing]] [[Connectionless Protocol]] [[Packet Sniffing]]