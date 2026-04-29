# IPv4 header

## What it is
Think of the IPv4 header as the shipping label on a FedEx box — it tells the network *who* sent the package, *where* it's going, how to handle it if it gets too big, and whether it's still "alive" enough to keep forwarding. Precisely, it is the 20–60 byte control structure prepended to every IPv4 packet, containing fields that routers use to make forwarding decisions and reassemble fragmented data.

## Why it matters
Attackers manipulate IPv4 header fields to bypass firewalls and conduct reconnaissance. In a classic **IP fragmentation attack** (like Teardrop), adversaries craft overlapping fragments with malformed offset values — exploiting how the header's Fragment Offset field guides reassembly — causing target systems to crash or behave unpredictably. Defenders use deep packet inspection to validate header field consistency and drop malformed packets before reassembly occurs.

## Key facts
- The header is **20 bytes minimum**, expandable to **60 bytes** with optional fields; the IHL (Internet Header Length) field specifies the actual size in 32-bit words
- **TTL (Time to Live)** is decremented by 1 at each hop; hitting zero causes the packet to be dropped and an ICMP "Time Exceeded" message returned — attackers use TTL manipulation for firewall evasion and traceroute-style mapping
- The **Protocol field** (8 bits) identifies the encapsulated transport layer — TCP=6, UDP=17, ICMP=1 — critical for ACL and firewall rule matching
- **IP spoofing** exploits the Source Address field (32 bits), which is not cryptographically verified, enabling DDoS amplification and blind injection attacks
- The **DF (Don't Fragment) bit** in the Flags field is used in Path MTU Discovery; attackers set it to probe network topology or cause black-hole routing issues

## Related concepts
[[IP Spoofing]] [[IP Fragmentation Attack]] [[TTL Manipulation]] [[ICMP]] [[Packet Filtering]]