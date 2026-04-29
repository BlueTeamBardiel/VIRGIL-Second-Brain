# Network Packet Fundamentals

A network packet is a small unit of data transmitted across a network, containing both the actual payload and metadata needed for routing and delivery. Packets are the fundamental building blocks of data communication in modern networks.

## What Is It? (Feynman Version)

Think of a packet like a postcard you send through a global post office: it’s a lightweight envelope that contains a message (the payload) and a stamp with the sender’s and receiver’s addresses (the header). Once it leaves your mailbox, it can take any route the post office chooses to reach the destination.

**Definition**  
A packet is a formatted unit of data that travels across a [[network]]. It consists of:
- **Header**: Contains metadata like source/destination [[IP address|IP addresses]], [[protocol]] information, and packet sequencing
- **Payload**: The actual data being transmitted (file contents, messages, etc.)
- **Footer/Trailer**: Typically includes error‑checking information such as checksums

## Why Does It Exist?

Before packets, communication looked like a set of dedicated wires: a single telephone line for each call, a fixed channel for each TV broadcast. That made every new service expensive to deploy and difficult to scale. Packets solve the problem of *shared bandwidth* by allowing many conversations to hop on the same physical medium and by letting routers decide the best path for each piece of data.  

A real‑world failure that packets fixed was the 1970s ARPANET’s inability to deliver messages efficiently: the network could send a whole message as one giant block, causing bottlenecks and loss of reliability. Splitting data into packets enabled retransmission of only the missing fragments, dramatically improving throughput and resilience.

## How It Works (Under The Hood)

1. **Application Layer**  
   An application (e.g., an email client) hands its data to the transport layer.  
2. **Transport Layer (TCP/UDP)**  
   *TCP* chops the data into segments, adds a header with sequence numbers, acknowledgments, and flags, and checksums each segment.  
   *UDP* simply adds a minimal header (source/destination ports, length, checksum) without ordering or reliability guarantees.  
3. **Network Layer (IP)**  
   The transport segment is wrapped in an IP packet. The IP header contains source/destination [[IP address|IP addresses]] and a Time‑To‑Live (TTL) counter to prevent infinite looping.  
4. **Data Link Layer**  
   The IP packet is encapsulated in a frame suitable for the local link (e.g., Ethernet). The frame header contains MAC addresses and a frame checksum.  
5. **Physical Layer**  
   The frame is converted into electrical, optical, or radio signals and transmitted over the medium.  
6. **Receiving Path**  
   The process reverses: frame checksum validation, IP routing, transport reassembly, and finally delivery to the application. Missing or corrupted packets are retransmitted (TCP) or discarded (UDP).

## What Breaks When It Goes Wrong?

When packets fail, the damage ripples from the bottom of the stack upward:

- **Lost or Corrupted Packets**  
  Users notice slowness or missing content. If critical data is lost, services may crash or produce errors.  
- **Fragmentation Issues**  
  Large packets that exceed the [[MTU]] are split. If fragments arrive out of order or are lost, reassembly stalls, stalling the entire connection.  
- **Routing Loops or TTL Expiration**  
  Misconfigured routers can send packets in circles until TTL hits zero, consuming bandwidth and potentially causing denial‑of‑service.  
- **Security Implications**  
  Malicious actors craft packets with forged headers to hijack sessions, inject malware, or launch denial‑of‑service attacks by flooding a target with bogus packets.

A notable incident: the 2009 "iTunes File Not Found" glitch occurred because an overloaded server dropped packets, causing clients to lose entire song downloads. In 2020, a misconfigured DNS server sent malformed packets that led to a global DNS outage, demonstrating how a single packet error can cascade into widespread service disruption.

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
- Smaller packets reduce latency for time‑sensitive applications

## Related Concepts

- [[Datagram]]: Connectionless packet transmission
- [[Network switching]]: Moving packets between network segments
- [[Bandwidth]]: Measured partly by packets per second
- [[Packet loss]]: When packets fail to reach destination

## Tags

#networking #packet #data-transmission #network-layer #protocols

_Ingested: 2026-04-15 20:19 | Source: https://www.cloudflare.com/learning/network-layer/what-is-a-packet/_