# OSPFv3

## What it is
Like a city's GPS update system rewritten entirely for new street addresses, OSPFv3 is the IPv6-native rewrite of the OSPF link-state routing protocol. It operates at the network layer to dynamically discover and maintain routes between routers, now natively supporting 128-bit IPv6 addressing while decoupling addressing from the protocol logic itself.

## Why it matters
In enterprise environments, an attacker who gains access to the internal network can inject fraudulent OSPFv3 Link State Advertisements (LSAs) to poison routing tables — a technique called route injection — redirecting traffic through a malicious router for man-in-the-middle interception. Unlike OSPFv2, OSPFv3 relies on IPsec (specifically AH or ESP headers) rather than built-in MD5 authentication for neighbor authentication, meaning misconfigured IPsec policies leave the entire routing infrastructure exposed.

## Key facts
- OSPFv3 runs directly over IPv6 (protocol number 89) and uses link-local addresses for neighbor adjacency formation, not global unicast addresses
- Authentication was **removed** from the OSPFv3 protocol itself — it delegates entirely to IPsec (RFC 4552), making IPsec deployment mandatory for secure operation
- OSPFv3 uses multicast addresses **FF02::5** (AllSPFRouters) and **FF02::6** (AllDRRouters) for neighbor communication
- A rogue router sending crafted LSAs can manipulate the LSDB (Link State Database), causing routers to forward packets along attacker-controlled paths — this is a critical threat in poorly segmented networks
- OSPFv3 separates the protocol from addressing: one OSPFv3 instance can carry multiple address families (IPv4 and IPv6), unlike OSPFv2

## Related concepts
[[OSPFv2]] [[IPsec]] [[BGP Route Hijacking]] [[Link-State Advertisement Poisoning]] [[IPv6 Security]]