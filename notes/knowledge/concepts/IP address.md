# IP address

## What it is
Like a postal address on an envelope that tells the network where to deliver a packet and where it came from, an IP address is a numerical label assigned to every device on a network. IPv4 uses 32-bit addresses (e.g., 192.168.1.1) written in dotted-decimal notation, while IPv6 uses 128-bit addresses to solve exhaustion of the older format.

## Why it matters
In IP spoofing attacks, an adversary forges the source IP address in packet headers to impersonate a trusted host or obscure their identity — a technique central to reflected DDoS amplification attacks where responses flood a victim whose address was forged as the "sender." Defenders counter this with ingress filtering (BCP38), which instructs routers to drop outbound packets carrying source IPs that don't belong to that network's address space.

## Key facts
- **IPv4** provides ~4.3 billion addresses (2³²); **IPv6** provides ~340 undecillion (2¹²⁸), eliminating exhaustion concerns
- **Private IP ranges** (RFC 1918): 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 — these are non-routable on the public internet
- **APIPA** (169.254.0.0/16) indicates a device failed to obtain a DHCP lease — a common misconfiguration flag during troubleshooting
- IP addresses operate at **Layer 3** (Network layer) of the OSI model; MAC addresses operate at Layer 2
- **Geolocation by IP** is approximate and trivially bypassed via VPNs or Tor — never treat it as reliable identity proof in forensics

## Related concepts
[[Subnetting]] [[NAT]] [[DHCP]] [[TCP/IP model]] [[Packet filtering]]