# Neighbor Discovery Protocol

## What it is
Think of NDP as the neighborhood watch coordinator for IPv6 networks — it knocks on doors to learn who lives where, announces arrivals, and keeps an updated directory of local residents. More precisely, NDP (defined in RFC 4861) is the IPv6 replacement for ARP, using ICMPv6 messages to perform address resolution, router discovery, and stateless address autoconfiguration (SLAAC) on a local link.

## Why it matters
Because NDP lacks built-in authentication, attackers can perform **NDP spoofing** (the IPv6 equivalent of ARP poisoning) by sending fraudulent Neighbor Advertisement messages, poisoning a victim's neighbor cache to redirect traffic through an attacker-controlled host. A defender can deploy **RA Guard** on managed switches to block rogue Router Advertisement messages that could redirect all local traffic or assign malicious DNS servers via SLAAC.

## Key facts
- NDP uses five ICMPv6 message types: **Router Solicitation (133), Router Advertisement (134), Neighbor Solicitation (135), Neighbor Advertisement (136), and Redirect (137)**
- **SEND (Secure Neighbor Discovery)** is the cryptographic extension to NDP that uses RSA signatures to authenticate messages — but it sees little real-world deployment
- NDP spoofing and rogue RA attacks are the IPv6 equivalents of ARP spoofing and rogue DHCP attacks respectively
- **DAD (Duplicate Address Detection)** uses Neighbor Solicitation messages to verify an address isn't already in use before claiming it — attackers can exploit this to cause DoS by always responding to DAD probes
- Mitigations include RA Guard (RFC 6105), DHCPv6 Guard, and IPv6 First-Hop Security features available on enterprise-grade switches

## Related concepts
[[ARP Spoofing]] [[IPv6 Security]] [[ICMP]] [[Stateless Address Autoconfiguration]] [[Man-in-the-Middle Attack]]