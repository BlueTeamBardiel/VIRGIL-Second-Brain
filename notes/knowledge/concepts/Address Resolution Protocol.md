# Address Resolution Protocol

## What it is
Like shouting "Hey, who owns this phone number?" in a crowded room and waiting for someone to answer, ARP broadcasts a question across a local network: "Who has this IP address? Tell me your MAC address." It is a Layer 2 protocol that maps IPv4 addresses to physical MAC addresses so that frames can actually be delivered on a local Ethernet segment.

## Why it matters
ARP has no authentication whatsoever, which makes ARP poisoning (or ARP spoofing) trivially easy — an attacker sends unsolicited ARP replies telling hosts "I am the gateway," redirecting all traffic through their machine for a classic man-in-the-middle attack. Tools like Ettercap and Arpspoof automate this, enabling credential harvesting on unencrypted protocols like HTTP or FTP with minimal effort. Defenses include Dynamic ARP Inspection (DAI) on managed switches, which validates ARP packets against a trusted DHCP snooping binding table.

## Key facts
- ARP operates at **Layer 2 (Data Link)** but resolves **Layer 3 (Network)** addresses — it bridges the OSI gap
- ARP replies are **stateless and trusted by default**; hosts cache them in an ARP table without verifying they asked for them
- **Gratuitous ARP** — an unsolicited ARP reply — is the core mechanism exploited in ARP spoofing attacks
- ARP cache entries are **temporary**; on Linux/Windows they expire in ~60–120 seconds, which attackers must continuously refresh to maintain a MITM position
- **IPv6 does not use ARP**; it replaces it with Neighbor Discovery Protocol (NDP), which also has its own spoofing vulnerabilities

## Related concepts
[[Man-in-the-Middle Attack]] [[Dynamic ARP Inspection]] [[DHCP Snooping]] [[MAC Address Flooding]] [[Neighbor Discovery Protocol]]