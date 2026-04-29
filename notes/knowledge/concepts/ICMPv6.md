# ICMPv6

## What it is
Think of ICMPv6 as the nervous system of an IPv6 network — it carries diagnostic signals, error messages, and the coordination messages that keep the network alive and self-organizing. Precisely, ICMPv6 (Internet Control Message Protocol version 6) is a mandatory component of IPv6 defined in RFC 4443, handling error reporting, diagnostics (like ping), and critical network functions such as Neighbor Discovery Protocol (NDP) and Multicast Listener Discovery (MLD). Unlike ICMPv4, it is not optional — IPv6 cannot function without it.

## Why it matters
Because NDP runs entirely over ICMPv6, an attacker on a local IPv6 network can send crafted ICMPv6 Neighbor Advertisement messages to poison a victim's neighbor cache — the IPv6 equivalent of ARP poisoning — redirecting traffic through an attacker-controlled machine for man-in-the-middle attacks. Defenders use tools like RA Guard and SEND (Secure Neighbor Discovery) to authenticate ICMPv6 NDP messages and prevent this class of attack.

## Key facts
- ICMPv6 **replaces both ICMPv4 and ARP** in IPv6 environments; ARP does not exist in IPv6
- **Type 133-137** are the core NDP message types: Router Solicitation, Router Advertisement, Neighbor Solicitation, Neighbor Advertisement, and Redirect
- **Router Advertisement (Type 134) attacks** can assign rogue IPv6 prefixes or default gateways to hosts — a common local network attack vector
- ICMPv6 **must not be fully blocked** at firewalls; blocking it indiscriminately breaks path MTU discovery and neighbor resolution
- **Multicast Listener Discovery (MLD)** — also carried by ICMPv6 — manages IPv6 multicast group membership, analogous to IGMP in IPv4

## Related concepts
[[Neighbor Discovery Protocol]] [[IPv6 Security]] [[ARP Poisoning]] [[Router Advertisement Guard]] [[Man-in-the-Middle Attack]]