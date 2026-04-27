# Packet Networking

A packet is the basic unit of data transmitted across networks, consisting of a header (with source/destination addresses and routing info) and a payload (the actual data). Packets enable efficient, reliable data transmission by breaking large files into manageable chunks that travel independently across network paths.

## Structure

- **Header**: Contains metadata including source IP, destination IP, protocol type, and sequencing information
- **Payload**: The actual data being transmitted (application data, file contents, etc.)
- **Trailer/Footer**: Often includes error-checking information (CRC/checksum)

## Key Concepts

- **Packet Switching**: Networks route packets independently; they may take different paths and arrive out of order, then get reassembled at destination
- **Size**: Typically limited by [[MTU]] (Maximum Transmission Unit), usually 1500 bytes on Ethernet
- **Protocols**: Packets are used at multiple [[OSI]] layers—IP packets at Layer 3, TCP/UDP segments at Layer 4, Ethernet frames at Layer 2
- **Efficiency**: Breaking data into packets allows networks to multiplex traffic and recover from transmission errors without resending entire files

## Related Concepts

- [[TCP/IP]]
- [[IP addressing]]
- [[Network routing]]
- [[Data encapsulation]]
- [[Latency]] and [[throughput]]

## Tags

#networking #fundamentals #packet #layer3 #protocols

---
_Ingested: 2026-04-15 20:20 | Source: https://www.cloudflare.com/learning/network-layer/what-is-a-packet/_
