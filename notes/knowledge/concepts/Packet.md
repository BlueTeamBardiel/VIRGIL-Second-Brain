# Packet

## What it is
Like slicing a long letter into numbered puzzle pieces so they can travel separately through the postal system and be reassembled at the destination — a packet is a fixed-size chunk of data with a header (addressing/control info) and a payload (the actual content). Specifically, packets are the Protocol Data Units (PDUs) at Layer 3 (Network layer) of the OSI model, containing source/destination IP addresses and routing information.

## Why it matters
Packet inspection is the backbone of most network defense tools. A Wireshark capture during an incident investigation lets a analyst reconstruct a TCP stream packet-by-packet to find data exfiltration — for example, seeing plaintext credentials leaving on port 23 (Telnet) confirms a misconfiguration that TLS would have prevented. Attackers also exploit packet structure directly through IP fragmentation attacks, splitting malicious payloads across fragments to bypass signature-based IDS rules.

## Key facts
- A packet has two core sections: **header** (source IP, destination IP, TTL, protocol) and **payload** (the data being transported)
- **TTL (Time to Live)** decrements by 1 at each router hop; when it hits 0 the packet is dropped — this prevents infinite routing loops
- Maximum Transmission Unit (**MTU**) for Ethernet is **1500 bytes**; packets larger than this get fragmented
- Packet-filtering firewalls inspect headers only (Layer 3/4); **Deep Packet Inspection (DPI)** examines the payload too
- **Stateless** inspection evaluates each packet in isolation; **stateful** inspection tracks the connection context (SYN, SYN-ACK, ACK handshake)

## Related concepts
[[Deep Packet Inspection]] [[IP Fragmentation Attack]] [[Stateful Firewall]] [[Wireshark]] [[OSI Model]]