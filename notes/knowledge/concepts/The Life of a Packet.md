# The Life of a Packet

## What it is
Like a letter traveling through a postal system — getting stamped, sorted, and handed off at each stop — a packet is a unit of data that moves through a network by passing through successive layers of encapsulation and forwarding decisions. Precisely, it is a structured data unit traversing the OSI/TCP-IP stack, gaining and shedding headers at each layer as it moves from source to destination.

## Why it matters
Understanding a packet's journey is the foundation of detecting attacks like man-in-the-middle (MitM) interception, where an adversary positions themselves between two hosts to capture or modify packets in transit. Wireshark captures at Layer 2, revealing raw frames; if an analyst sees ARP replies flooding the network mapping one IP to the attacker's MAC, they can trace exactly where the packet's path was hijacked. Without knowing how encapsulation works, that evidence is invisible.

## Key facts
- A packet travels down the OSI stack at the sender (encapsulation) and up the stack at the receiver (decapsulation) — each layer adds/removes its own header
- At Layer 3 (Network), routers make forwarding decisions based on the **destination IP address** in the packet header
- At Layer 2 (Data Link), switches forward based on **MAC addresses**; the MAC address changes at each hop, but the IP address remains constant end-to-end (without NAT)
- TTL (Time to Live) decrements by 1 at each router hop; reaching 0 causes packet drop and an ICMP "Time Exceeded" message — the mechanism traceroute exploits
- Packet capture (PCAP) analysis is a core skill for CySA+ — analysts examine flags (SYN, ACK, FIN), ports, and payloads to identify anomalies like port scans or data exfiltration

## Related concepts
[[OSI Model]] [[TCP Three-Way Handshake]] [[Network Packet Analysis]] [[ARP Poisoning]] [[Encapsulation]]