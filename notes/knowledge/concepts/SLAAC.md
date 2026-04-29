# SLAAC

## What it is
Like a city that hands out house numbers automatically based on your driver's license number — no DMV visit required — SLAAC lets IPv6 devices generate their own IP addresses without a DHCP server. Stateless Address Autoconfiguration (SLAAC) works by combining a network prefix (advertised by a router) with the device's interface identifier, typically derived from its MAC address, to self-assign a globally routable IPv6 address.

## Why it matters
Attackers can launch a **Rogue Router Advertisement** attack by sending forged ICMPv6 Router Advertisement messages, tricking hosts into using a malicious router as their default gateway — effectively performing a man-in-the-middle attack without touching DHCP at all. This bypasses traditional DHCP-based defenses like DHCP snooping, making it particularly dangerous in enterprise environments that haven't deployed RA Guard on their switches.

## Key facts
- SLAAC uses **ICMPv6 Router Advertisement (RA) messages** (Type 134) to distribute network prefix information to hosts
- Devices generate their Interface ID using **EUI-64** format (derived from MAC address) or a random value via **RFC 7217 / Privacy Extensions** to prevent tracking
- Privacy Extensions (RFC 4941) generate temporary, randomized addresses specifically to defeat device fingerprinting through stable SLAAC addresses
- **RA Guard** (RFC 6105) is the primary mitigation — configured on switches to drop RA messages from unauthorized ports
- SLAAC operates **without any central server**, meaning standard DHCP logs will show no record of address assignment — a blind spot for network defenders

## Related concepts
[[IPv6 Security]] [[ICMPv6]] [[Rogue DHCP Server]] [[Man-in-the-Middle Attack]] [[RA Guard]]