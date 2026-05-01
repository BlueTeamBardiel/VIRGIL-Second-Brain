# The TCP/IP Networking Model
**Why this chapter matters:** Understanding the TCP/IP model is foundational—it's the conceptual framework that explains how networks actually work. Every protocol, every device, every packet on the internet fits into this model. Master this and everything else clicks into place.

---

## Overview: What Is a Networking Model?

Think of a networking model like a blueprint for a house. Instead of describing every single nail, wire, and brick individually, you organize the construction into layers: foundation, framing, electrical, plumbing, finishing. Each layer has specific jobs. The TCP/IP model does the same thing for networks—it organizes all the protocols and technologies into layers so we can understand how they interact.

**Why models matter:**
- They provide a common language for network engineers
- They help us understand which protocols operate at which levels
- They explain how data gets packaged (encapsulation) and unpacked (de-encapsulation)
- They're essential for troubleshooting—you need to know which layer a problem exists at

---

## The OSI Reference Model (7 Layers)

Before we dive into TCP/IP, understand that [[OSI Model]] is theoretical and comprehensive. It's what the CCNA exam uses for reference, even though the real world runs on [[TCP/IP]].

| Layer # | Name | Function | Example Protocols/Devices |
|---------|------|----------|--------------------------|
| 7 | Application | User applications, services | HTTP, HTTPS, SMTP, FTP, SSH, Telnet |
| 6 | Presentation | Encryption, translation, compression | SSL/TLS, JPEG, ASCII |
| 5 | Session | Session establishment and maintenance | NetBIOS, PPTP |
| 4 | Transport | Reliable/unreliable delivery, ports | [[TCP]], [[UDP]] |
| 3 | Network | Logical addressing, routing | [[IP]], [[ICMP]], [[IGMP]] |
| 2 | Data Link | Physical addressing (MAC), switching | [[Ethernet]], [[PPP]], [[Frame Relay]] |
| 1 | Physical | Cables, signals, electrical specs | RJ45, fiber-optic, voltage levels |

**Memory trick:** Please Do Not Throw Sausage Pizza Away (layers 7 to 1)

---

## The TCP/IP Model (4 Layers)

The TCP/IP model collapses the OSI model into 4 practical layers. This is what actually runs the internet.

### Layer Structure

| TCP/IP Layer | OSI Equivalent | Purpose | Key Protocols |
|--------------|----------------|---------|---------------|
| **Application (Layer 4)** | 5, 6, 7 | User services, applications | [[HTTP]], [[HTTP]], [[SMTP]], [[POP3]], [[IMAP]], [[DNS]], [[DHCP]], [[SSH]], [[Telnet]], [[FTP]], [[FTP]] |
| **Transport (Layer 3)** | 4 | End-to-end communication, reliability | [[TCP]], [[UDP]] |
| **Internet (Layer 2)** | 3 | Routing, logical addressing | [[IP]] (IPv4, IPv6), [[ICMP]], [[IGMP]] |
| **Link (Layer 1)** | 1, 2 | Hardware addressing, physical transmission | [[Ethernet]], [[PPP]], [[ARP]], MAC addresses, cables |

**Key difference from OSI:** TCP/IP model is what engineers actually use. The OSI model is for teaching and standardization.

---

## Understanding the Layers with Analogies

### Application Layer (Layer 4)
**Analogy:** The customer at a restaurant ordering food.

The customer doesn't care how the kitchen works, how ingredients are transported, or what road the delivery driver takes. The customer just wants to order food and receive it. Similarly, application layer protocols (HTTP, SMTP, etc.) don't care about networking details—they just want to send/receive data.

**Real-world detail:** These are the protocols you use daily:
- [[HTTP]]/[[HTTP]] for web browsing
- [[SMTP]] for sending email
- [[POP3]]/[[IMAP]] for receiving email
- [[DNS]] for translating domain names to IP addresses
- [[SSH]] for secure remote access
- [[FTP]] for file transfer

### Transport Layer (Layer 3)
**Analogy:** The delivery company that handles the package.

The delivery company decides: Do we need a signature on arrival (reliable delivery like [[TCP]])? Or can we just leave it on the porch (unreliable like [[UDP]])? The delivery company doesn't care what's in the package, just how to deliver it.

**Real-world detail:**
- **[[TCP]]** (Transmission Control Protocol): Reliable, ordered delivery. Used for email, web, SSH. Slower but guaranteed.
  - Establishes connection before data transfer (three-way handshake)
  - Ensures data arrives in order
  - Re-sends lost packets
  - Flow control and congestion control built-in

- **[[UDP]]** (User Datagram Protocol): Fast, unreliable delivery. Used for video streaming, VoIP, online gaming.
  - No connection setup
  - No guarantee data arrives
  - Lower overhead, faster
  - Acceptable for applications that can tolerate loss

### Internet Layer (Layer 2)
**Analogy:** The postal service that routes mail based on addresses.

The postal service takes your package and routes it through the network based on addresses (ZIP codes, streets). It doesn't care about the delivery method or what's inside.

**Real-world detail:**
- **[[IP]] (Internet Protocol):** Handles logical addressing (IP addresses) and routing
  - Breaks data into packets if needed
  - Adds source and destination IP addresses
  - Routes packets through the network
  - No guarantee of delivery or order (connectionless)

- **[[ICMP]] (Internet Control Message Protocol):** Diagnostic protocol
  - Used by [[Ping]] command to test reachability
  - Used by [[Traceroute]] to identify path taken
  - Reports errors (destination unreachable, etc.)

- **[[IGMP]] (Internet Group Management Protocol):** Manages multicast group membership

### Link Layer (Layer 1)
**Analogy:** The truck and driver that physically carry the mail.

The actual hardware—the truck, the road, the physical route—that moves the package from place to place within a local network.

**Real-world detail:**
- **[[Ethernet]]:** The standard for LAN communication
  - Defines frame format (header and trailer)
  - Uses [[MAC Address]] for local addressing (48-bit addresses like 00:1A:2B:3C:4D:5E)
  - Devices on the same segment find each other using [[ARP]]

- **Physical specifications:** Cables (RJ45, fiber-optic), connectors, voltage levels

---

## Data Encapsulation: How Data Moves Down the Stack

When you send an HTTP request to a web server, your data flows DOWN through the layers, and each layer adds its own header (like putting a letter in increasingly larger envelopes):

```
1. USER creates HTTP request (GET / HTTP/1.1)
   
2. TRANSPORT LAYER adds TCP header
   → Now it's a TCP segment (includes source/destination port)
   
3. INTERNET LAYER adds IP header
   → Now it's an IP packet (includes source/destination IP address)
   
4. LINK LAYER adds Ethernet header and trailer
   → Now it's an Ethernet frame (includes source/destination MAC address)
   
5. PHYSICAL LAYER converts to electrical/optical signals
   → Transmitted on the wire
```

Each step is **encapsulation**—wrapping data in headers/trailers.

### De-encapsulation: How Data Moves Up the Stack

When the destination receives the frame, it reverses the process, removing each layer's header and passing the data up:

```
1. PHYSICAL LAYER receives electrical signals
   
2. LINK LAYER removes Ethernet header/trailer
   → Passes IP packet to next layer
   
3. INTERNET LAYER removes IP header
   → Passes TCP segment to next layer
   
4. TRANSPORT LAYER removes TCP header
   → Passes HTTP request to application
   
5. APPLICATION LAYER processes the HTTP request
   → Sends HTTP response back down
```

This is **de-encapsulation**.

### Terminology at Each Layer
- **Layer 4 (Application):** Data / Message
- **Layer 3 (Transport):** Segment (TCP) or Datagram (UDP)
- **Layer 2 (Internet):** Packet
- **Layer 1 (Link):** Frame

---

## Key Protocols by Layer

### Application Layer Protocols

| Protocol | Port | Purpose | Reliability |
|----------|------|---------|------------|
| [[HTTP]] | 80 | Web browsing (unencrypted) | TCP |
| [[HTTP]] | 443 | Web browsing (encrypted) | TCP |
| [[SMTP]] | 25 | Send email | TCP |
| [[POP3]] | 110 | Receive email (downloads & deletes) | TCP |
| [[IMAP]] | 143 | Receive email (keeps copy on server) | TCP |
| [[DNS]] | 53 | Domain name resolution | UDP (or TCP for zone transfers) |
| [[DHCP]] | 67/68 | Assign IP addresses automatically | UDP |
| [[SSH]] | 22 | Secure remote access | TCP |
| [[Telnet]] | 23 | Remote access (unencrypted) | TCP |
| [[FTP]] | 20/21 | File transfer | TCP |
| [[FTP]] | 69 | Trivial file transfer (no auth) | UDP |

### Transport Layer Protocols

| Protocol | Connection-Based | Reliability | Speed | Use Cases |
|----------|------------------|-------------|-------|-----------|
| [[TCP]] | Yes | Reliable, ordered | Slower | Email, web, file transfer, SSH |
| [[UDP]] | No | Unreliable, unordered | Faster | Video, VoIP, gaming, DNS queries |

### Internet Layer Protocols

| Protocol | Purpose |
|----------|---------|
| [[IPv4]] | Logical addressing (32-bit) and routing |
| [[IPv6]] | Logical addressing (128-bit) and routing |
| [[ICMP]] | Diagnostics (ping, traceroute, error reporting) |
| [[IGMP]] | Multicast group management |

### Link Layer Protocols

| Protocol | Purpose |
|----------|---------|
| [[Ethernet]] | LAN frame format and MAC addressing |
| [[ARP]] | Maps IP addresses to MAC addresses |
| [[PPP]] | Point-to-point WAN connections |

---

## Critical Concept: Ports and Socket Pairs

**[[TCP]] and [[UDP]] use ports** to identify which application should receive data.

- **Source port:** Random high number (ephemeral port, 49152-65535) chosen by the client
- **Destination port:** Well-known port of the server (0-1023) or registered port (1024-49151)

A **socket pair** = source IP + source port + destination IP + destination port

Example: Your computer (192.168.1.100:54321) connects to Google (142.251.41.14:443)
- Source: 192.168.1.100:54321
- Destination: 142.251.41.14:443
- This combination uniquely identifies one conversation

**Why this matters:** A server can handle thousands of simultaneous connections because each connection has a different source port.

---

## Common Protocols Reference

### Email Stack
1. **User sends email:** Application layer uses [[SMTP]] (port 25) → [[TCP]] → IP → Ethernet
2. **User receives email:** Application layer uses [[POP3]] (port 110) or [[IMAP]] (port 143) → [[TCP]] → IP → Ethernet

### Web Stack
1. **Browser requests page:** [[HTTP]]/[[HTTP]] (ports 80/443) → [[TCP]] → IP → Ethernet
2. **Browser resolves domain:** [[DNS]] (port 53) → [[UDP]] → IP → Ethernet

### Remote Access Stack
1. **User connects to router:** [[SSH]] (port 22) or [[Telnet]] (port 23) → [[TCP]] → IP → Ethernet

---

## Lab Relevance

### Cisco IOS Commands Introduced in This Chapter

#### Verify IP Configuration
```
Router# show ip interface brief
! Shows all interfaces, IP addresses, and status
! Example output:
! Interface      IP-Address

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 4 | [[CCNA]]*
