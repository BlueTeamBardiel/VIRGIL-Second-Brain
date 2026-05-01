---  
tags: [knowledge, ccna, chapter-5]  
created: 2026-04-30  
cert: CCNA  
chapter: 5  
source: rewritten  
---  

# 5. Ethernet LAN Switching  
**A quick tour of how switches keep local traffic moving fast and error‑free, from the wire‑level frame to MAC learning and ARP resolution.**  

---  

## LAN & Layer 2 Switching  

### Local Area Network Basics  

**Analogy**: Picture a bustling office hallway where people (hosts) shout to each other directly—no security guard (router) needed for internal conversations.  

**LAN**: A network of devices physically connected by cables or Wi‑Fi, confined to a single building or campus. [[LAN]]  
**Layer 2 domain**: The scope within which a switch handles traffic based solely on MAC addresses, without examining higher‑layer protocols. [[Layer 2]]  

| Feature | LAN | Router‑based communication |
|---------|-----|-----------------------------|
| Path control | Switches forward by MAC table | Routers forward by IP routing tables |
| Protocol inspection | None | IP, TCP/UDP, etc. |
| Typical use | Local office or campus | Inter‑network connectivity |

### Switch Operation  

**Analogy**: Think of a postal sorting office that reads the address on each envelope and sends it to the correct mailbox, but never opens the letter itself.  

**Switch**: A network device that forwards Ethernet frames within a LAN by consulting its MAC address table. [[Switch]]  

---  

## Ethernet Frame Structure  

### Frame Anatomy  

**Analogy**: Imagine a postcard: it has a header (sender & receiver stamps), the message (payload), and a post‑mark (checksum).  

**Ethernet Frame**: The basic unit of data on a LAN, consisting of header, payload, and trailer. [[Ethernet frame]]  

| Component | Size | Purpose |
|-----------|------|---------|
| **Preamble** | 7 bytes | Syncs clocks; pattern 101010… |
| **Start Frame Delimiter (SFD)** | 1 byte | Marks frame start; value 10101011 |
| **Destination MAC** | 6 bytes | Who receives the frame |
| **Source MAC** | 6 bytes | Who sent the frame |
| **Type/Length** | 2 bytes | Determines payload type or length |
| **Payload** | 46–1500 bytes | Encapsulated higher‑layer data |
| **Padding** | 0–20 bytes | If payload < 46 bytes, pad to min size |
| **Frame Check Sequence (FCS)** | 4 bytes | CRC‑32 error check |

> **Note**: Preamble + SFD are usually *not* counted in the 18‑byte Ethernet header.  

### Type/Length vs EtherType  

**Analogy**: A librarian uses a sign on a book to decide whether to read the full title (EtherType) or just check the page count (Length).  

| Value | Meaning | Example |
|-------|---------|---------|
| ≤ 1500 | Payload length in bytes | 1200 bytes |
| ≥ 1536 | EtherType field | 0x0800 → IPv4 [[IPv4]] |
| | | 0x86DD → IPv6 [[IPv6]] |

> **Tip**: Values 0x0001–0x0FFF are reserved for length; 0x1000–0xFFFF for EtherType.

### Frame Size Limits  

**Analogy**: A courier can carry at most a certain weight; anything heavier needs to be split.  

| Size | Description |
|------|-------------|
| **Minimum** | 64 bytes (header + payload + FCS) |
| **Maximum** | 1518 bytes (header + max payload + FCS) |
| **Jumbo Frames** | > 1518 bytes (optional, > 9000 bytes) |

---  

## MAC Addressing & CAM Table  

### MAC Address  

**Analogy**: Like a house number that uniquely identifies a residence, a MAC address pinpoints a specific network interface on the LAN.  

**MAC Address**: A 48‑bit identifier, formatted as six pairs of hexadecimal digits. [[MAC address]]  

| Field | Bits | Role |
|-------|------|------|
| **OUI** | 24 | Organizationally Unique Identifier assigned by IEEE |
| **NIC** | 24 | Device‑specific identifier from manufacturer |

### MAC Address Table (CAM Table)  

**Analogy**: A phone book that lists which extension number (port) belongs to each employee’s badge number (MAC).  

**CAM Table**: Content‑Addressable Memory that maps learned MAC addresses to switch ports for efficient forwarding. [[CAM table]]  

| Entry Type | Persistence | Trigger |
|------------|-------------|---------|
| **Dynamic** | Cleared after 5 min idle | Learned from incoming frames |
| **Static** | Manually configured | Never ages |

### Frame Forwarding & Flooding  

**Analogy**: A courier only delivers a letter to a known address; if the address is unknown, they drop it at every mailbox (flood).  

| Traffic | Action |
|---------|--------|
| **Known Unicast** | Forward to associated port |
| **Unknown Unicast** | Flood all ports except source |
| **Broadcast** | Flood to all ports |
| **ARP Request** | Broadcast, expects unicast reply |

### Viewing & Managing the MAC Address Table (Cisco IOS)  

**Analogy**: Inspecting a register to see who’s on which floor, or clearing out outdated names.  

```bash
# Show all learned MACs
show mac address-table

# Clear all dynamic entries
clear mac address-table dynamic

# Clear specific dynamic MAC
clear mac address-table dynamic address 00:11:22:33:44:55

# Clear all dynamic entries on an interface
clear mac address-table dynamic interface GigabitEthernet0/1
```

---  

## ARP & IP Reachability  

### Address Resolution Protocol (ARP)  

**Analogy**: Asking a neighbor for the exact address of a mailbox that you know the street name (IP) of.  

**ARP Request**: Broadcast packet asking "Who has IP X.X.X.X?"  
**ARP Reply**: Unicast response providing the MAC address of the IP owner.  

| Type | Frame Nature |
|------|--------------|
| **ARP Request** | Broadcast |
| **ARP Reply** | Unicast |

### ARP Table  

**Analogy**: A sticky note board where you write down which phone number belongs to each contact.  

```bash
# Display ARP cache
arp -a
```

| Entry | Details |
|-------|---------|
| **Internet Address** | IP address (Layer 3) |
| **Physical Address** | MAC address (Layer 2) |
| **Type** | static (manual) or dynamic (ARP learned) |

### Ping  

**Analogy**: Sending a quick “ping” to a friend’s house to see if they’re home and how long it takes to hear back.  

**Ping**: Utility that sends ICMP Echo Requests and waits for Echo Replies to test connectivity and measure round‑trip time.  

```bash
# Ping an IP
ping 192.168.1.1
```

---  

## Exam Tips  

### Question Type 1: Multiple Choice  
- *"Which component of an Ethernet frame contains the CRC value?"* → **FCS**  
- **Trick**: Some questions may list FCS as part of the header; remember it is actually the trailer.  

### Question Type 2: Configuration  
- *"Configure a switch to clear only dynamic MAC addresses on interface GigabitEthernet0/2."* →  
  ```bash
  clear mac address-table dynamic interface GigabitEthernet0/2
  ```  
- **Trick**: Forgetting the `dynamic` keyword can result in a syntax error.  

### Question Type 3: Troubleshooting  
- *"A host cannot resolve the IP of a router using ARP. Which command should you run to verify the ARP entry?"* → `arp -a`  
- **Trick**: Do not confuse ARP with DNS lookups.  

---  

## Common Mistakes  

### Mistake 1: Confusing Preamble with Header  
- **Wrong**: "The Ethernet header is 18 bytes, including the preamble."  
- **Right**: "The header starts after the 8‑byte preamble/SFD; the header is 14 bytes plus 4 bytes FCS."  
- **Impact on Exam**: Misunderstanding header size leads to incorrect calculations of frame size limits.  

### Mistake 2: Assuming All MACs Age the Same  
- **Wrong**: "All MAC entries, dynamic or static, age out after five minutes."  
- **Right**: "Dynamic entries age after five minutes of inactivity; static entries never age."  
- **Impact on Exam**: Questions about port security or static entries may be answered incorrectly.  

---  

## Related Topics  
- [[VLANs]]  
- [[Spanning Tree Protocol (STP)]]  

---  

*Source: CCNA 200-301 Study Notes | [[CCNA]]*