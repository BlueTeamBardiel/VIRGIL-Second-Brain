# OSI Model

The Open Systems Interconnection (OSI) model is a conceptual framework that standardizes the functions of a telecommunication or computing system into seven abstracted layers, enabling interoperability between different systems and protocols. It provides a universal language for describing network communication and is fundamental to understanding how data moves across networks.

## Overview

The OSI model was developed by the International Organization for Standardization (ISO) to standardize network communication. It divides the communication process into seven distinct layers, each with specific functions and responsibilities. This layered approach allows different protocols and technologies to work together seamlessly.

## The Seven Layers

### Layer 7: Application Layer
- End‑user services and applications
- Examples: [[HTTP]], [[HTTPS]], [[FTP]], [[SMTP]], [[DNS]]
- User‑facing protocols and services

### Layer 6: Presentation Layer
- Data formatting and encryption
- Translation between application and network formats
- Compression and encryption/decryption

### Layer 5: Session Layer
- Manages communication sessions
- Establishes, maintains, and terminates connections
- Dialog control and synchronization

### Layer 4: Transport Layer
- End‑to‑end communication and reliability
- Examples: [[TCP]], [[UDP]]
- Flow control and error handling

### Layer 3: Network Layer
- Routing and logical addressing
- Examples: [[IP]], [[ICMP]]
- Path determination and packet forwarding

### Layer 2: Data Link Layer
- Physical addressing (MAC addresses)
- Examples: [[Ethernet]], [[PPP]]
- Frame formatting and error detection

### Layer 1: Physical Layer
- Physical transmission media
- Examples: cables, fiber optics, radio waves
- Bit transmission and hardware specifications

## Importance for Security

Understanding the OSI model is critical for network security, as [[DDoS]] attacks and other threats operate at different layers. For example, [[Layer 7 DDoS attacks]] target application‑level vulnerabilities, while [[Layer 3]] and [[Layer 4]] attacks focus on network infrastructure.

## Related Concepts

- [[TCP/IP model]] (practical implementation alternative)
- [[Network protocols]]
- [[DDoS attacks]]
- [[Network security]]

## What Is It? (Feynman Version)

Think of a city’s postal system: a letter travels from the sender to the recipient, passing through sorting centers, transport trucks, and finally the post office before delivery. The OSI model is the same system for data: it breaks the journey of a message into distinct stages, each handled by different “postal workers” (protocols). In plain English, the OSI model is a seven‑layer recipe that tells every computer how to pack, ship, route, and unpack information so they can talk to each other.

## Why Does It Exist?

Before the OSI model, every vendor invented its own set of rules for exchanging data, leading to a maze of incompatible protocols. Imagine trying to deliver a package that could only be opened by a lock that only a handful of people know how to pick—communication stalls, data never arrives, and businesses can’t rely on each other. The OSI model solved this by establishing a common hierarchy: vendors could plug into the same layers, ensuring their systems could interoperate. The model also provides a reference for troubleshooting and designing security measures, like knowing whether a firewall should inspect packets at Layer 4 (TCP/UDP) or Layer 7 (HTTP).

## How It Works (Under The Hood)

1. **Layer 1 (Physical)**  
   The sender turns the data into electrical or optical signals on a cable. A bit pattern is transmitted as voltage pulses, light pulses, or radio waves.

2. **Layer 2 (Data Link)**  
   The bit stream is segmented into frames. Each frame gets a MAC address (sender/receiver), a CRC checksum, and error‑detection logic. The MAC ensures the frame goes to the correct device on a LAN.

3. **Layer 3 (Network)**  
   Frames become packets. The IP header adds source/destination addresses, TTL, and routing information. Routers read this header, decide the next hop, and forward the packet.

4. **Layer 4 (Transport)**  
   The packet payload is split into segments (TCP) or datagrams (UDP). TCP adds sequence numbers, checksums, and ACKs to guarantee reliable delivery; UDP simply passes data along with a checksum.

5. **Layer 5 (Session)**  
   Applications establish a session ID, keep track of turns (e.g., request/response), and synchronize data streams. For example, a web browser keeps a TCP session open while loading a page.

6. **Layer 6 (Presentation)**  
   The data is formatted: encryption keys are applied, data may be compressed, or a character set is converted so that the receiving application can read it.

7. **Layer 7 (Application)**  
   The application protocol (HTTP, FTP, SMTP) defines how the payload is interpreted. The web server responds with an HTTP status code, headers, and a body that the browser displays.

Each layer hands off a “packet” (or frame, or segment) to the next, adding its own header and taking care of its own responsibilities. The process is symmetrical: the receiving end strips headers layer by layer until the original application data arrives.

## What Breaks When It Goes Wrong?

- **Layer 1 failures**: A broken cable or a misconfigured radio makes the signal vanish. The first person to notice is often the network admin, but end users see a blank screen or a “cannot connect” message.

- **Layer 2 errors**: A bad MAC table or a duplicated address can cause data loops or collisions. A miswired switch can broadcast a packet to every device, flooding the network.

- **Layer 3 misrouting**: Wrong routing tables cause packets to wander or be dropped, leading to latency spikes or unreachable hosts. A misconfigured router can become a single point of failure for an entire subnet.

- **Layer 4 issues**: TCP retransmission storms or UDP flooding can saturate a link. A misbehaving firewall that drops ACKs causes a TCP session to hang, locking up applications.

- **Layer 5 problems**: Session timeouts can break long‑running transactions, affecting database replication or file transfers. A poorly coded session manager can leak memory, draining a server.

- **Layer 6 errors**: Incorrect encryption keys or corrupted compression streams can corrupt data, making it unreadable. A broken SSL handshake can prevent secure sites from loading.

- **Layer 7 attacks**: A Layer 7 DDoS sends a flood of HTTP requests, exhausting server CPU or database connections. An application‑level exploit (e.g., SQL injection) can give attackers control over a database. The blast radius is the end‑user experience, business revenue, and trust.

In practice, most outages trace back to Layer 4–7, where traffic is filtered or inspected. A misconfigured load balancer at Layer 4 can drop all inbound traffic, while a faulty reverse proxy at Layer 7 can return error pages to every user.

---

_Ingested: 2026-04-15 20:22 | Source: https://www.cloudflare.com/learning/ddos/glossary/open-systems-interconnection-model-osi/_

---

#networking #osi-model #educational #fundamentals #cloudflare