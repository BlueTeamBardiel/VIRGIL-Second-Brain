# IPv4 Addressing
**Master the structure of IPv4 headers and addresses — this is foundational to every routing decision routers make**

## Overview

IPv4 addressing is the cornerstone of Layer 3 networking. While [[Layer 2]] (switches, [[Ethernet]]) uses MAC addresses to forward frames locally, Layer 3 uses [[IPv4]] addresses to route packets across networks and the internet. This chapter covers the [[IPv4 header]] structure and address format, which are prerequisites for understanding routing, [[subnetting]], and network design.

**Official CCNA Exam Topic:** 1.6 — Configure and verify IPv4 addressing and subnetting

**Key Distinction:** IPv4 is defined in [[RFC 791]]. Although [[IPv6]] was introduced in 1995 as its replacement, IPv4 remains dominant in production networks due to slow adoption rates.

---

## The IPv4 Header Structure

### Understanding the IPv4 Header (Feynman Approach)

**Simple explanation:** The IPv4 header is like an envelope on a package. Just as an envelope contains sender and recipient addresses plus routing instructions, the IPv4 header contains source/destination IP addresses and metadata about how to handle the packet.

**Detailed explanation:** The IPv4 header is a 20-byte minimum structure (up to 60 bytes with options) containing 14 fields. It sits between the [[Layer 2]] frame header and the [[Layer 4]] segment data. Unlike the simple 4-field [[Ethernet]] header, IPv4 must handle end-to-end delivery across potentially thousands of networks.

### Header Format Reference

| Byte Position | Bit Range | Field Name | Size | Purpose |
|---|---|---|---|---|
| 0 | 0-3 | Version | 4 bits | Identifies IP version (4 or 6) |
| 0 | 4-7 | IHL | 4 bits | Header length in 32-bit increments |
| 0 | 8-13 | DSCP | 6 bits | Quality of Service prioritization |
| 0 | 14-15 | ECN | 2 bits | Congestion notification |
| 1-2 | 16-31 | Total Length | 16 bits | Entire packet size (header + payload) in bytes |
| 3-4 | 32-47 | Identification | 16 bits | Unique packet identifier for fragmentation |
| 5 | 48-50 | Flags | 3 bits | Control fragmentation behavior |
| 5-6 | 51-63 | Fragment Offset | 13 bits | Position of fragment in original packet |
| 7 | 64-71 | TTL | 8 bits | Hops remaining before packet is discarded |
| 7 | 72-79 | Protocol | 8 bits | Identifies payload protocol (TCP, UDP, ICMP) |
| 8-9 | 80-95 | Header Checksum | 16 bits | Error detection for header only |
| 10-13 | 96-127 | Source Address | 32 bits | Sending host's IPv4 address |
| 14-17 | 128-159 | Destination Address | 32 bits | Receiving host's IPv4 address |
| 18+ | 160+ | Options (optional) | 0-40 bytes | Variable-length optional fields (rarely used) |

---

## IPv4 Header Fields in Detail

### Version Field
- **Size:** 4 bits
- **Purpose:** Identifies the IP version in use
- **Values:**
  - `0b0100` (decimal 4) = IPv4
  - `0b0110` (decimal 6) = IPv6
- **CCNA Focus:** Know the difference; version mismatch prevents communication between IPv4 and IPv6 hosts

### IHL (Internet Header Length) Field
- **Size:** 4 bits
- **Purpose:** Indicates IPv4 header length in 32-bit word increments
- **Calculation:** IHL value × 4 = header size in bytes
  - IHL = 5 → 20 bytes (minimum, no options)
  - IHL = 15 → 60 bytes (maximum, with 40-byte options field)
- **Critical Note:** Values below 5 are invalid; the IPv4 header cannot be smaller than 20 bytes

### DSCP (Differentiated Services Code Point) & ECN (Explicit Congestion Notification)
- **Combined Size:** 8 bits (DSCP 6 bits + ECN 2 bits)
- **Purpose:** [[Quality of Service]] (QoS) mechanism for traffic prioritization
- **Use Case:** Prioritizing delay-sensitive traffic (VoIP, video conferencing) over best-effort traffic
- **Legacy Name:** Previously called "Type of Service" (ToS)

### Total Length Field
- **Size:** 16 bits
- **Purpose:** Specifies total packet size (header + payload) in bytes
- **Key Difference from IHL:** 
  - IHL = header length only, measured in 4-byte units
  - Total Length = entire packet, measured in bytes
- **Range:** 0–65,535 bytes (practical max ~1,500 bytes for Ethernet MTU)
- **Example:** A packet with 20-byte header + 1,480 bytes of data = Total Length field value is 1,500

### Identification, Flags, and Fragment Offset Fields
- **Combined Size:** 32 bits (16 + 3 + 13)
- **Purpose:** Support packet fragmentation when packets exceed network [[MTU]]
- **Identification (16 bits):** Unique ID assigned to each packet; fragments share the same ID for reassembly
- **Flags (3 bits):**
  - Bit 0: Reserved (must be 0)
  - Bit 1: Don't Fragment (DF) — if set, packet will not be fragmented; if MTU is exceeded, packet is discarded
  - Bit 2: More Fragments (MF) — if set, more fragments follow; cleared on final fragment
- **Fragment Offset (13 bits):** Position of this fragment within the original packet, measured in 8-byte units

### TTL (Time To Live) Field
- **Size:** 8 bits
- **Purpose:** Prevents packets from circulating indefinitely in routing loops
- **Behavior:** Decremented by 1 at each hop (router); packet discarded when TTL reaches 0
- **Typical Values:**
  - Linux/Unix: Default 64
  - Windows: Default 128
  - Cisco routers: Typically 255 when originating
- **Tools That Use TTL:** [[traceroute]] relies on TTL expiration to map hops

### Protocol Field
- **Size:** 8 bits
- **Purpose:** Identifies the payload protocol (Layer 4 or other Layer 3 protocol)
- **Common Values:**

| Protocol Name | Number | Purpose |
|---|---|---|
| ICMP | 1 | Diagnostics, ping, error reporting |
| IGMP | 2 | Multicast group management |
| TCP | 6 | Reliable, connection-oriented transport |
| UDP | 17 | Unreliable, connectionless transport |
| EIGRP | 88 | Cisco proprietary routing protocol |
| OSPF | 89 | Open shortest path first routing |
| GRE | 47 | Generic routing encapsulation |

### Header Checksum Field
- **Size:** 16 bits
- **Purpose:** Error detection for IPv4 header only (NOT payload)
- **Calculated:** CRC-16 checksum over entire header with this field set to 0
- **Important:** Recalculated at every hop because TTL changes
- **Payload Protection:** Relies on Layer 4 ([[TCP]]/[[UDP]]) checksums for data integrity

### Source and Destination Address Fields
- **Size:** 32 bits each (128 bits total)
- **Format:** Dotted decimal notation (e.g., `192.168.1.1`)
- **Purpose:** Identify sending and receiving host IP addresses
- **Router Forwarding:** Routers forward based on the Destination Address field, not Source Address
- **Does NOT change in transit:** Unlike switches which learn MAC addresses, routers do not modify these fields (except in [[NAT]])

---

## Binary Number System Fundamentals

### Why Binary Matters for Networking

Networking requires understanding binary because:
- IPv4 addresses are 32-bit binary numbers
- [[Subnet masks]] are 32-bit binary numbers
- Header fields are defined in bits
- CCNA exam tests binary conversion skills extensively

### Decimal to Binary Conversion

**Simple Explanation:** Binary is just another way to write numbers using only 0s and 1s instead of 0-9 digits.

**Conversion Method: Positional Value**

Each bit position represents a power of 2:

```
Position:  7    6    5    4    3    2    1    0
Value:    128   64   32   16   8    4    2    1
```

**Example: Convert decimal 205 to binary**
- 205 ÷ 128 = 1 remainder 77 → bit 7 = 1
- 77 ÷ 64 = 1 remainder 13 → bit 6 = 1
- 13 ÷ 32 = 0 remainder 13 → bit 5 = 0
- 13 ÷ 16 = 0 remainder 13 → bit 4 = 0
- 13 ÷ 8 = 1 remainder 5 → bit 3 = 1
- 5 ÷ 4 = 1 remainder 1 → bit 2 = 1
- 1 ÷ 2 = 0 remainder 1 → bit 1 = 0
- 1 ÷ 1 = 1 remainder 0 → bit 0 = 1

**Result:** `205 decimal = 11001101 binary`

**Verification:** 128+64+8+4+1 = 205 ✓

### Binary to Decimal Conversion

**Simple Explanation:** Add up the values of all positions where there's a 1.

**Example: Convert binary 10110101 to decimal**

```
Position:  7    6    5    4    3    2    1    0
Binary:    1    0    1    1    0    1    0    1
Value:    128   64   32   16   8    4    2    1
```

Sum: 128 + 32 + 16 + 4 + 1 = **181 decimal**

### Common Byte Values to Memorize

Knowing these speeds up mental conversion during exams:

| Binary | Decimal | Binary | Decimal | Binary | Decimal |
|--------|---------|--------|---------|--------|---------|
| 00000000 | 0 | 10000000 | 128 | 11111111 | 255 |
| 11111110 | 254 | 11111100 | 252 | 11111000 | 248 |
| 11110000 | 240 | 11100000 | 224 | 10000000 | 128 |
| 01000000 | 64 | 00100000 | 32 | 00010000 | 16 |

---

## IPv4 Address Structure

### IPv4 Address Format

**Simple Explanation:** An IPv4 address is a 32-bit number split into 4 groups of 8 bits (octets), written in dotted decimal for human readability.

**Detailed Structure:**

```
Dotted Decimal:    192    .    168    .     1     .     1
Octet Position:    Octet 1     Octet 2    Octet 3   Octet 4
Binary:          11000000   10101000   00000001   00000001
Decimal Range:    0–255      0–255      0–255     0–255
```

- **Total Size:** 32 bits
- **Address Range:** 0.0.0.0 to 255.255.255.255
- **Total Possible Addresses:** 2³² = 4,294,967,296

### Address Classes (Classful Addressing - Legacy)

Although [[subnetting]]

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 7 | [[CCNA]]*