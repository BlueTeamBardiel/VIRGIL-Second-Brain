# Network Packet Fundamentals

A network packet is a small unit of data transmitted across a network, containing both the actual payload and metadata needed for routing and delivery. Packets are the fundamental building blocks of data communication in modern networks.

## Definition

A packet is a formatted unit of data that travels across a [[network]]. It consists of:
- **Header**: Contains metadata like source/destination [[IP address|IP addresses]], [[protocol]] information, and packet sequencing
- **Payload**: The actual data being transmitted (file contents, messages, etc.)
- **Footer/Trailer**: Typically includes error-checking information such as checksums

## Why Packets?

Packets enable:
- **Efficient resource sharing**: Multiple communications can share the same network simultaneously
- **Reliability**: Damaged packets can be resent without retransmitting entire messages
- **Routing flexibility**: Each packet can take different paths to reach the destination
- **Scalability**: Networks can handle many concurrent transmissions

## Packet Structure

Packets follow a layered structure defined by the [[OSI model]]:
- **Data Link Layer** frames wrap packets
- **Network Layer** (IP) adds routing information
- **Transport Layer** ([[TCP]]/[[UDP]]) manages end-to-end delivery
- **Application Layer** data forms the payload

## Packet Size

Typical packet sizes:
- **Maximum Transmission Unit (MTU)**: Usually 1,500 bytes on [[Ethernet]]
- Larger messages are fragmented into multiple packets
- Smaller packets reduce latency for time-sensitive applications

## Related Concepts

- [[Datagram]]: Connectionless packet transmission
- [[Network switching]]: Moving packets between network segments
- [[Bandwidth]]: Measured partly by packets per second
- [[Packet loss]]: When packets fail to reach destination

## Tags

#networking #packet #data-transmission #network-layer #protocols

---
_Ingested: 2026-04-15 20:19 | Source: https://www.cloudflare.com/learning/network-layer/what-is-a-packet/_
