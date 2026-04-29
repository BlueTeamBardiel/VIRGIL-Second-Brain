# DHCP

## What it is
Like a hotel front desk that hands you a room key, a Wi-Fi password, and a map the moment you check in — DHCP (Dynamic Host Configuration Protocol) automatically assigns IP addresses, subnet masks, default gateways, and DNS server addresses to devices joining a network. It operates on UDP ports 67 (server) and 68 (client) using a four-step DORA handshake: Discover, Offer, Request, Acknowledge.

## Why it matters
DHCP is a prime target for **DHCP starvation** and **rogue DHCP server** attacks. In a starvation attack, an attacker floods the server with fake MAC addresses, exhausting the IP address pool and denying service to legitimate clients. They then spin up a rogue DHCP server to hand out attacker-controlled gateway and DNS addresses — effectively performing a man-in-the-middle attack and redirecting all victim traffic through their machine. Defense: enable **DHCP snooping** on managed switches to drop DHCP responses from untrusted ports.

## Key facts
- DHCP uses **UDP**, not TCP — port **67** for servers, port **68** for clients
- The DORA process: **Discover** (client broadcast) → **Offer** (server unicast/broadcast) → **Request** (client broadcast) → **Acknowledge** (server confirms lease)
- IP addresses are leased, not permanent — lease time expiration triggers renewal, which can be exploited in timing-based attacks
- **DHCP snooping** is the primary Layer 2 defense; it builds a binding table of legitimate MAC-to-IP mappings and blocks rogue servers
- DHCPv6 serves a similar role in IPv6 networks but often works alongside **SLAAC** (Stateless Address Autoconfiguration), creating additional attack surface

## Related concepts
[[DHCP Snooping]] [[ARP Poisoning]] [[Man-in-the-Middle Attack]] [[DNS Spoofing]] [[Network Reconnaissance]]