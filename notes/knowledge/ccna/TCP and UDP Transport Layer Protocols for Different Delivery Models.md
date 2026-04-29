# TCP and UDP: Transport Layer Protocols for Different Delivery Models
**Why it matters:** TCP and UDP operate at Layer 4 and determine how data is reliably delivered (TCP) or quickly sent (UDP). Understanding their differences, header structures, and use cases is critical for diagnosing network issues, configuring services, and passing the CCNA exam.

---

## Overview: The Transport Layer Decision

Think of TCP and UDP like two postal services:
- **TCP** is like registered mail: it guarantees delivery, confirms receipt, and resends if something gets lost. It's slower but reliable.
- **UDP** is like throwing a postcard in the mail: it gets sent once and fast, but there's no guarantee it arrives.

Both live at **[[Layer 4 (Transport Layer)]]** of the [[TCP/IP model]]. They sit between applications (Layer 7) and the network layer ([[IPv4 addressing|IPv4]]/[[IPv6 addressing|IPv6]]), deciding *how* data gets to its destination, not *where* it goes.

---

## TCP (Transmission Control Protocol)

### Characteristics

| Feature | TCP |
|---------|-----|
| **Reliability** | Guaranteed delivery (with retransmission) |
| **Ordering** | Maintains packet sequence |
| **Flow Control** | Yes (prevents sender overwhelming receiver) |
| **Connection** | Connection-oriented (3-way handshake required) |
| **Speed** | Slower (overhead from acknowledgments) |
| **Header Size** | 20–60 bytes (minimum) |
| **Error Checking** | Yes (checksums validate data integrity) |

### The TCP Three-Way Handshake

Before any data flows, TCP establishes a connection:

1. **SYN** (Synchronization): Client sends a segment with the SYN flag set, offering an initial sequence number.
2. **SYN-ACK** (Synchronization-Acknowledgment): Server responds with its own sequence number and acknowledges the client's.
3. **ACK** (Acknowledgment): Client acknowledges the server's sequence number.

Only after this "handshake" can data be reliably transmitted.

### TCP Header Fields (Simplified)

| Field | Size | Purpose |
|-------|------|---------|
| Source Port | 16 bits | Sending application's port |
| Destination Port | 16 bits | Receiving application's port |
| Sequence Number | 32 bits | Tracks packet order (prevents duplicates) |
| Acknowledgment Number | 32 bits | Confirms received data |
| Flags | 9 bits | SYN, ACK, FIN, RST, PSH, URG, etc. |
| Window Size | 16 bits | Flow control (how much data recipient can accept) |
| Checksum | 16 bits | Error detection |

### Key TCP Flags (FLAGS field)

- **SYN** (Synchronize): Initiates connection
- **ACK** (Acknowledgment): Confirms receipt of data
- **FIN** (Finish): Gracefully closes connection
- **RST** (Reset): Forcefully closes connection (often indicates an error)
- **PSH** (Push): Tells receiver to process data immediately
- **URG** (Urgent): Marks data as urgent (rarely used)

### TCP Reliability Mechanism

TCP uses **sequence numbers** and **acknowledgments**:
- Sender includes a sequence number in each segment.
- Receiver acknowledges successful receipt, telling the sender what sequence number it expects next.
- If an acknowledgment isn't received within a timeout, the sender retransmits the data.

This is overhead, but guarantees nothing is lost.

### TCP Use Cases

| Application | Port | Purpose |
|-------------|------|---------|
| [[HTTP]]/[[HTTPS]] | 80/443 | Web browsing |
| [[SSH]] | 22 | Secure remote login |
| [[Telnet]] | 23 | Remote login (unencrypted) |
| [[SMTP]] | 25 | Email transmission |
| [[DNS]] | 53 | Domain name resolution (sometimes) |
| [[POP3]] | 110 | Email retrieval |
| [[IMAP]] | 143 | Email retrieval (advanced) |
| [[FTP]] | 20/21 | File transfer |
| [[SNMP]] | 161 | Network management (uses UDP primarily) |

---

## UDP (User Datagram Protocol)

### Characteristics

| Feature | UDP |
|---------|-----|
| **Reliability** | Best-effort only (no retransmission) |
| **Ordering** | No guaranteed sequence |
| **Flow Control** | No |
| **Connection** | Connectionless (no handshake) |
| **Speed** | Fast (minimal overhead) |
| **Header Size** | 8 bytes (fixed) |
| **Error Checking** | Basic checksum only |

### Why UDP Exists

Some applications prioritize **speed and low latency** over reliability:
- **Voice over IP (VoIP)**: A dropped voice packet is less noticeable than a delayed connection.
- **Online Gaming**: Real-time position updates don't need perfect accuracy.
- **Streaming Video**: Lost frames are acceptable; waiting for retransmission isn't.
- **DNS Queries**: If no response, the client just retransmits the query itself.

### UDP Header (Minimal)

| Field | Size | Purpose |
|-------|------|---------|
| Source Port | 16 bits | Sending application's port |
| Destination Port | 16 bits | Receiving application's port |
| Length | 16 bits | Size of header + data |
| Checksum | 16 bits | Error detection (optional in IPv4) |

That's it. 8 bytes total, vs. TCP's minimum 20 bytes.

### UDP Use Cases

| Application | Port | Purpose |
|-------------|------|---------|
| [[DNS]] | 53 | Domain name resolution (primary) |
| [[DHCP]] | 67/68 | IP address assignment |
| [[SNMP]] | 161 | Network device management |
| [[NTP]] | 123 | Time synchronization |
| [[VoIP/SIP]] | 5060 | Session initiation |
| [[RTP]] | Variable | Real-time media transport |
| [[TFTP]] | 69 | Simple file transfer (no auth) |
| [[SYSLOG]] | 514 | System logging |

---

## TCP vs. UDP: Head-to-Head Comparison

| Aspect | TCP | UDP |
|--------|-----|-----|
| **Connection Setup** | 3-way handshake required | None |
| **Reliability** | Guaranteed delivery | Best-effort |
| **Ordering** | Guaranteed sequence | No guarantee |
| **Speed** | Slower (acknowledgments) | Faster (fire and forget) |
| **Overhead** | Higher (20+ byte header) | Lower (8 byte header) |
| **Flow Control** | Yes (window-based) | No |
| **Congestion Control** | Yes (adjusts to network) | No |
| **Use Case** | Data integrity critical | Speed critical |
| **Example Applications** | HTTP, FTP, SSH, Email | DNS, VoIP, Gaming, Streaming |

---

## Port Numbers and Well-Known Services

### Well-Known Ports (0–1023)
These are reserved for standard services. A few key ones for CCNA:

| Port | Protocol | Service |
|------|----------|---------|
| 20–21 | TCP | [[FTP]] (data/control) |
| 22 | TCP | [[SSH]] |
| 23 | TCP | [[Telnet]] |
| 25 | TCP | [[SMTP]] |
| 53 | TCP/UDP | [[DNS]] |
| 67–68 | UDP | [[DHCP]] |
| 80 | TCP | [[HTTP]] |
| 110 | TCP | [[POP3]] |
| 123 | UDP | [[NTP]] |
| 143 | TCP | [[IMAP]] |
| 161 | UDP | [[SNMP]] |
| 443 | TCP | [[HTTPS]] |

### Registered Ports (1024–49151)
Used by applications and services that aren't "standard." Applications can request these.

### Dynamic/Private Ports (49152–65535)
Ephemeral ports used for temporary client-side connections. When you open a browser, your OS picks a random port in this range.

---

## Connection-Oriented vs. Connectionless

### TCP: Connection-Oriented (Stateful)

The connection exists in states:
1. **Closed** → **Listen** (server waiting)
2. **SYN Sent** (client initiates)
3. **SYN Received** (server responds)
4. **Established** (both sides confirm)
5. **Fin Wait** → **Closed** (graceful shutdown)

Routers and firewalls must track these states. A firewall can "see" that a connection is established and allow related traffic.

### UDP: Connectionless (Stateless)

No connection states. A UDP client just sends a datagram to a server. The server responds (or doesn't). There's no "connection" to establish or tear down—just discrete messages.

Stateless protocols are simpler but require the application layer to handle ordering and reliability itself.

---

## Segmentation, Datagrams, and Data Units

- **TCP Segments**: TCP breaks data into segments. Each segment has a sequence number, so the receiver can reassemble them in order, even if they arrive out of order.
- **UDP Datagrams**: UDP sends data as discrete datagrams. There's no reassembly; if a datagram is lost, the application handles it (or ignores it).

**Analogy**: TCP is like mailing a book in chapters, numbered so you can reassemble it. UDP is like mailing postcards—each stands alone.

---

## Windowing and Flow Control (TCP Only)

TCP's **window size** (in the header) is a flow control mechanism:

1. Receiver tells sender: "I can accept 64 KB of data from you right now."
2. Sender transmits up to 64 KB.
3. Receiver processes data and sends a new window size: "Now I can accept another 32 KB."

This prevents the sender from overwhelming the receiver with data faster than it can process it.

---

## Lab Relevance

### Cisco IOS Commands for TCP/UDP Verification

#### Display Active Connections and Listening Ports
```bash
Router# show tcp brief
Router# show udp brief
```
*(Note: Some older IOS versions may not support these exactly; use on modern routers.)*

#### Verify Listening Ports (TCP/UDP)
```bash
Router# show ip sockets
```
Shows which local TCP/UDP ports the router is listening on.

#### Trace TCP/UDP Traffic (Debugging)
```bash
Router# debug ip tcp transactions
Router# debug ip udp transactions
```
*(Use sparingly; generates high CPU overhead.)*

#### Telnet (TCP port 23) - Basic Connectivity Test
```bash
Router# telnet <destination_ip> [port]
Router# telnet 192.168.1.1 23
```

#### SSH (TCP port 22) - Secure Remote Access
```bash
Router# ssh -l <username> <destination_ip>
Router# ssh -l admin 192.168.1.1
```

#### Verify SSH Configuration
```bash
Router# show ip ssh
```

#### SNMP (UDP port 161) Configuration
```bash
Router(config)# snmp-server community <community_string> RO
Router(config)# snmp-server host <destination_ip> <community_string>
```

#### NTP (UDP port 123) Configuration
```bash
Router(config)# ntp server <ntp_server_ip>
Router(config)# ntp master [stratum_level]
```

#### Syslog (UDP port 514) Configuration
```bash
Router(config)# logging <syslog_server_ip>
Router(config)# logging trap <severity>
```

#### DNS (UDP port 53, TCP for zone transfers)
```bash
Router(config)# ip name-server <dns_server_ip>
Router(config)# ip domain-name <domain_name>
Router# show hosts
```

#### DHCP (UDP ports 67/68)
```bash
Router(config)# ip dhcp pool <pool_name

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 22 | [[CCNA]]*