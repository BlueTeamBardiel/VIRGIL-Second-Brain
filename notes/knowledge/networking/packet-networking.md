# Packet Networking

A packet is the basic unit of data transmitted across networks, consisting of a header (with source/destination addresses and routing info) and a payload (the actual data). Packets enable efficient, reliable data transmission by breaking large files into manageable chunks that travel independently across network paths.

## What Is It? (Feynman Version)

Imagine a courier service that splits a big package into smaller boxes, each labeled with the sender, receiver, and a route. A packet does the same: it carries a slice of data, wrapped in a header that tells routers where it came from, where it’s going, and how to put it back together at the end.

## Why Does It Exist?

Before packets, most networks sent data as a single continuous stream. If a single byte got corrupted, the whole stream had to start over. Packets solve this by letting each chunk be sent, received, and repaired independently, so a few errors don’t ruin the whole file. This was especially vital when early telephone lines were noisy and bandwidth was scarce.

## How It Works (Under The Hood)

1. **Segmentation**: The sender’s application splits data into chunks no larger than the maximum transmission unit (MTU).  
2. **Header Construction**: For each chunk, the network layer creates a header with source IP, destination IP, protocol ID, and sequence number.  
3. **Encapsulation**: The network layer packages the header and payload into an IP datagram; the transport layer may further wrap it into a TCP segment (adding flags, ports, checksum).  
4. **Link‑Layer Framing**: The frame (e.g., Ethernet) adds its own header and trailer, including a CRC for error checking.  
5. **Routing**: Each router reads the IP header, consults its routing table, and forwards the datagram to the next hop.  
6. **Reassembly**: At the destination, the transport layer reorders segments by sequence number, verifies checksums, and delivers the payload to the application.  
7. **Error Recovery**: If a segment is missing or corrupted, the receiver requests retransmission (TCP) or discards the bad segment (UDP). The sender then resends only the affected parts.

## What Breaks When It Goes Wrong?

- **Network congestion**: Routers drop packets when buffers overflow, leading to latency spikes and retransmissions that can cripple real‑time apps.  
- **Routing misconfigurations**: Wrong IP routes can send packets to the wrong network, exposing sensitive data or causing a denial of service.  
- **Packet loss or corruption**: Unchecked errors flood the network with retransmissions, exhausting bandwidth and CPU resources.  
- **Security attacks**: Malformed packets can trigger buffer overflows or open backdoors, compromising entire systems.

When a packet system fails, the first symptom is usually a slowdown or failure in applications that rely on timely data (streaming, VoIP). System administrators notice increased retransmission rates, error logs, and packet drop counters before users report service outages.

## Structure

- **Header**: Contains metadata including source IP, destination IP, protocol type, and sequencing information
- **Payload**: The actual data being transmitted (application data, file contents, etc.)
- **Trailer/Footer**: Often includes error‑checking information (CRC/checksum)

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