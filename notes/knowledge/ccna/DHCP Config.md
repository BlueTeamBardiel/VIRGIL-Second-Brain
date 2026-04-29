# DHCP Config

## What it is
Like a hotel front desk that hands out room keys and tells guests where the elevator, restaurant, and emergency exits are — DHCP (Dynamic Host Configuration Protocol) automatically assigns IP addresses, subnet masks, default gateways, and DNS server addresses to devices joining a network. It operates on a four-step handshake: Discover, Offer, Request, Acknowledge (DORA).

## Why it matters
An attacker on the same network segment can spin up a rogue DHCP server that responds faster than the legitimate one, handing out a malicious default gateway or DNS server to victims — a classic man-in-the-middle setup called a **DHCP starvation + rogue server attack**. The defense is **DHCP snooping**, a switch-level control that whitelists trusted DHCP server ports and drops unauthorized offers.

## Key facts
- DHCP uses **UDP ports 67 (server) and 68 (client)**; broadcasts can't cross routers without a **DHCP relay agent** (ip helper-address)
- **DHCP starvation** floods the server with spoofed MAC addresses, exhausting the IP pool and enabling a denial-of-service condition
- **DHCP snooping** builds a binding table mapping MAC addresses, IPs, ports, and VLANs — used downstream by **Dynamic ARP Inspection (DAI)** to validate ARP packets
- A rogue DHCP server can redirect DNS to attacker-controlled resolvers, enabling **DNS poisoning without touching the legitimate DNS server**
- DHCP leases have a **T1 (50% of lease) renewal timer** — understanding lease duration is relevant for incident response IP-to-user attribution

## Related concepts
[[Rogue DHCP Server]] [[DHCP Snooping]] [[Dynamic ARP Inspection]] [[DNS Poisoning]] [[Man-in-the-Middle Attack]]