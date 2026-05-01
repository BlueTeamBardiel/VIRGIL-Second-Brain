# Ethernet LAN Switching
**Why it matters:** LAN switching is the foundation of modern networks—understanding how switches learn MAC addresses and forward frames is essential to passing the CCNA and designing reliable networks.

---

## Overview

Ethernet switching operates at [[Layer 2 (Data Link Layer)]] and is responsible for delivering frames between devices on the same local area network ([[VLAN]]). Unlike routers (which work at Layer 3), switches make forwarding decisions based on **MAC addresses**, not IP addresses. This chapter covers the mechanics of frame forwarding, MAC address learning, and the critical protocols that keep switching networks functional.

Think of a switch like a post office sorting mail by street address (MAC address) instead of ZIP code (IP address). The post office (switch) learns which mail carriers (ports) service which streets (MAC addresses) by watching mail go out, then uses that knowledge to deliver incoming mail efficiently.

---

## ## The Ethernet Frame: Structure and Purpose

### What is an Ethernet Frame?

An Ethernet frame is a Layer 2 packet—the fundamental unit of data transmitted on a LAN. Every device on an Ethernet network wraps its data in a frame before sending it.

**Frame Structure (in order):**

| Field | Size | Purpose |
|-------|------|---------|
| **Preamble** | 7 bytes | Synchronization signal; tells NIC to "wake up" |
| **Start Frame Delimiter (SFD)** | 1 byte | Marks the actual start of frame data |
| **Destination MAC Address** | 6 bytes | Where the frame is going (48 bits) |
| **Source MAC Address** | 6 bytes | Where the frame originated |
| **Type/Length** | 2 bytes | Identifies the Layer 3 protocol (e.g., IPv4 = 0x0800) |
| **Payload (Data)** | 46–1500 bytes | The actual Layer 3 packet |
| **Frame Check Sequence (FCS)** | 4 bytes | Error detection using CRC-32 |

**Important Note:** The preamble and SFD are handled by the NIC hardware and are **not counted** in the 64-byte minimum frame size.

### MAC Addresses Explained

A **MAC (Media Access Control) address** is a 48-bit identifier burned into every network interface card. It's written in hexadecimal as six pairs separated by colons:

```
00:1A:2B:3C:4D:5E
```

- **First 3 octets (24 bits):** Organizationally Unique Identifier (OUI) — identifies the vendor (e.g., Cisco = 00:00:0C)
- **Last 3 octets (24 bits):** Device-specific ID assigned by the manufacturer

MAC addresses have **no hierarchy**—they're flat, not routable. They only work on the local network segment.

### The Type/Length Field

This 2-byte field serves dual purposes depending on the value:

- **Values 0x0600 or higher:** Frame **Type** — identifies the Layer 3 protocol
  - `0x0800` = IPv4
  - `0x0806` = [[ARP]] (Address Resolution Protocol)
  - `0x86DD` = IPv6
- **Values below 0x0600:** Frame **Length** — indicates the payload size (rarely used in modern networks)

### Frame Check Sequence (FCS)

The **FCS** is a 32-bit cyclic redundancy check (CRC) that detects transmission errors. It's calculated by the sending NIC and verified by the receiving NIC. If the FCS doesn't match, the frame is discarded silently (no error notification is sent back).

---

## ## Frame Switching: How Switches Work

### The MAC Address Table

Switches maintain a **MAC address table** (also called a CAM table or forwarding table) that maps MAC addresses to physical ports. This table is **learned dynamically** by observing frames as they arrive.

**Key characteristics:**
- Built from examining the **source MAC address** of incoming frames
- Each entry is a mapping: `MAC Address → Switch Port → VLAN → Age`
- Entries **age out** after a timeout (default 300 seconds on Cisco switches)
- Limited size (~8,000 entries on older switches; 100,000+ on modern ones)

### MAC Address Learning Process

When a frame arrives at a switch:

1. Switch examines the **source MAC address** and inbound **port**
2. If not already in the table, creates a new entry mapping that MAC to that port
3. Stores the entry with a timestamp for aging purposes

**Example:**
```
PC1 (MAC: 00:11:22:33:44:55) sends a frame out port Fa0/1

Switch learns: 00:11:22:33:44:55 → Fa0/1

[Later, a frame arrives destined for 00:11:22:33:44:55]
Switch looks up the MAC → finds Fa0/1 → forwards frame only to Fa0/1
```

### Frame Flooding and Forwarding

When a frame arrives, the switch examines the **destination MAC address**:

**Case 1: Destination MAC is in the table**
- Frame is forwarded **only** to the port mapped to that MAC address (unicast forwarding)
- More efficient; unknown devices don't receive the frame

**Case 2: Destination MAC is NOT in the table (unknown unicast)**
- Frame is **flooded** to all ports except the inbound port
- Broadcast frames (destination = FF:FF:FF:FF:FF:FF) are always flooded
- Multicast frames may be flooded (depends on [[IGMP snooping]] configuration)

**Case 3: Frame arrives on a trunk port (tagged with VLAN)**
- Switch examines the 802.1Q tag and floods/forwards only on ports in that VLAN

**Important:** Switches are **transparent**—they don't modify frames, don't decrement TTL, and don't inspect Layer 3 addresses (unless acting as a [[multilayer switch]]).

### Viewing the MAC Address Table in Cisco IOS

The command to display a switch's MAC address table:

```cisco
show mac-address-table
```

**Output example:**
```
Vlan    Mac Address       Type        Ports
----    -----------       --------    -----
1       00:11:22:33:44:55 DYNAMIC     Fa0/1
1       00:AA:BB:CC:DD:EE STATIC      Cpu
1       FF:FF:FF:FF:FF:FF STATIC      Fa0/2, Fa0/3
```

**Columns explained:**
- **Vlan:** Which VLAN this MAC belongs to
- **Mac Address:** The MAC address
- **Type:** DYNAMIC (learned from traffic) or STATIC (manually configured)
- **Ports:** Which port(s) this MAC is associated with

To view MAC addresses on a specific VLAN or port:

```cisco
show mac-address-table vlan 10
show mac-address-table interface fa0/1
```

---

## ## Address Resolution Protocol (ARP)

### What is ARP?

[[ARP]] is a Layer 2 protocol that solves a critical problem: **mapping IP addresses to MAC addresses**. When Device A knows the IP address of Device B but needs the MAC address to send a frame, it uses ARP.

**Analogy:** You know someone's phone number (IP address) but need their home address (MAC address) to send a letter.

### How ARP Works

**ARP Request (Broadcast):**
1. Device A doesn't know the MAC address of Device B (same subnet)
2. Device A sends an ARP Request frame: *"Who has IP 192.168.1.20? Tell 192.168.1.10"*
3. Frame is broadcast (destination MAC = FF:FF:FF:FF:FF:FF)
4. All devices on the segment receive it

**ARP Reply (Unicast):**
1. Device B recognizes its own IP address
2. Sends ARP Reply: *"192.168.1.20 is at MAC 00:BB:BB:BB:BB:BB"*
3. Frame is unicast directly to Device A
4. Device A updates its **ARP cache** with the mapping

**ARP Cache:**
Each device maintains a local ARP cache (typically expires after 240 seconds on Windows, 20 minutes on Linux).

View ARP cache on Cisco devices:
```cisco
show ip arp
show arp
```

### Why ARP Matters for CCNA

- **ARP is only used on the local segment** (same subnet, no routers in between)
- Devices outside the subnet require Layer 3 routing, not ARP
- ARP attacks ([[ARP spoofing]]) can be security issues
- ARP floods can impact switch CPU if misconfigured

---

## ## Ping: Testing Layer 2 and Layer 3 Connectivity

### What is Ping?

**Ping** is a network diagnostic utility that tests reachability and latency. It uses the [[ICMP (Internet Control Message Protocol)]] and combines Layer 2 (MAC/ARP) and Layer 3 (IP routing) concepts.

**Basic process:**
1. Sender crafts an ICMP Echo Request packet (Layer 3)
2. If destination is remote, packet is routed across Layer 3
3. Destination responds with ICMP Echo Reply
4. Sender measures round-trip time (RTT)

### Ping Syntax on Cisco Devices

```cisco
ping <destination-ip>
ping <destination-ip> <options>
```

**Common options:**
```cisco
ping 192.168.1.20 repeat 10 timeout 2 size 1500
  repeat:   number of ICMP Echo Requests (default 5)
  timeout:  seconds to wait for reply (default 2)
  size:     payload size in bytes (default 56)
```

### Interpreting Ping Results

| Result | Meaning |
|--------|---------|
| **Reply from X.X.X.X: bytes=56 time=2ms TTL=64** | Successful; device is reachable |
| **Request timed out** | No reply received; destination unreachable, packet dropped, or ACL blocking |
| **Destination host unreachable** | Router received ARP request for next-hop but got no ARP reply |
| **Network is unreachable** | No route to destination in routing table |

### Why Ping Fails (and What to Check)

1. **No route to destination** → Check routing table (`show ip route`)
2. **ARP not resolving** → Check if devices are on same subnet, check for ARP spoofing
3. **ACL blocking ICMP** → Review inbound/outbound ACLs
4. **Interface down** → Check interface status (`show ip interface brief`)
5. **Firewall/security appliance** → Some devices block ICMP intentionally

---

## ## Lab Relevance

### Critical Cisco IOS Commands

#### MAC Address Table Inspection
```cisco
show mac-address-table
  ! Display all learned MAC addresses

show mac-address-table vlan <vlan-id>
  ! Show MACs on specific VLAN

show mac-address-table interface <interface>
  ! Show MACs learned on specific port

show mac-address-table dynamic
  ! Show only dynamically learned (not static) entries

clear mac-address-table dynamic
  ! Clear all dynamic MAC entries (useful for lab troubleshooting)

clear mac-address-table dynamic interface <interface>
  ! Clear MAC entries learned on specific port only
```

#### Static MAC Configuration
```cisco
mac-address-table static <mac-address> vlan <vlan-id> interface <interface>
  ! Manually add a static MAC entry
  ! Example: mac-address-table static 0000.0000.0001 vlan 1 interface fa0/1
```

#### ARP Inspection and Configuration
```cisco
show ip arp
  ! Display ARP cache

show arp
  ! Same as above (alternative syntax)

arp <ip-address> <mac-address> arpa
  ! Manually add static ARP entry

clear arp-cache
  ! Clear all ARP entries

ip arp inspection vlan <vlan-id>
  ! Enable Dynamic ARP Inspection (DAI) for security
```

#### Ping Command
```cisco
ping <destination-ip>
  ! Basic ping

ping
  ! Extended ping (interactive, more options)

ping 192.168.

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 6 | [[CCNA]]*
