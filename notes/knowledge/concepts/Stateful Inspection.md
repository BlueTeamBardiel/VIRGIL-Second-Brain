# Stateful Inspection

## What it is
Like a bouncer who remembers not just your face but the full context of your evening — who you came with, when you entered, and whether you're leaving or sneaking back in — stateful inspection tracks the *state* of network connections, not just individual packets. Formally, it's a firewall technique that maintains a state table recording active connections, allowing it to evaluate whether an incoming packet legitimately belongs to an established session rather than judging each packet in isolation.

## Why it matters
In a TCP session hijacking attack, an adversary crafts spoofed packets with a valid source IP and sequence number, hoping to inject malicious data mid-stream. A stateless (packet-filter) firewall would pass these packets if the port and IP rules match, but a stateful firewall cross-references its connection table — if the sequence number or handshake state doesn't match a tracked session, the packet is dropped before it can cause damage.

## Key facts
- Stateful inspection firewalls maintain a **state table** (also called a connection table) tracking source/destination IP, port, protocol, and TCP sequence numbers.
- A packet claiming to be part of a TCP session is validated against the state table; packets arriving without a matching entry (e.g., unsolicited ACKs) are dropped.
- Operates at **Layer 3 and Layer 4** of the OSI model; it does *not* inspect application-layer payload (that's Next-Generation Firewall / NGFW territory).
- UDP and ICMP, being connectionless, are handled by **pseudo-state** tracking based on timeouts and expected response patterns.
- First commercially implemented by Check Point in their **FireWall-1** product (1994), making it a foundational modern firewall feature.

## Related concepts
[[Packet Filtering]] [[Next-Generation Firewall (NGFW)]] [[TCP Three-Way Handshake]] [[Session Hijacking]] [[Deep Packet Inspection]]