# The Life of a Packet — How data moves through the network stack from source to destination

**Why this matters:** Understanding packet lifecycle is the connective tissue between all CCNA concepts. You cannot troubleshoot networks, design them, or pass the exam without seeing how ARP, switching, routing, and encapsulation work together in real time. This chapter transforms isolated concepts into a unified mental model.

---

## 1. Overview: The Journey

Think of sending a packet like sending a physical letter through the postal system:
- **You** (source host) write a letter and put it in an envelope addressed to the recipient
- **Your local post office** (switch) sorts mail by street and passes it along
- **Regional sorting centers** (routers) read the street address and send it toward the next region
- **Each transfer point** re-envelopes the letter in a new shipping container with the next destination's address
- **The final post office** delivers it directly to the recipient's house

**The detail:** At Layer 3 (IP), the destination address never changes—the packet is always addressed to PC3's IP. But at Layer 2 (Ethernet), the destination MAC address changes at every hop because each device encapsulates the packet in a new frame addressed to the *next hop*, not the final destination.

---

## 2. The Network Topology Reference

All examples in this chapter use this topology:

```
PC1 (192.168.1.11)  -- SW1 -- R1 (192.168.1.1 / 192.168.12.1) -- R2 (192.168.12.2 / 192.168.23.1) -- SW2 -- PC3 (192.168.3.11)
     LAN 1                    Link 12                                  Link 23                     LAN 3
   192.168.1.0/24            192.168.12.0/24                        192.168.23.0/24            192.168.3.0/24
```

| Device | Role | Interface | IP Address |
|--------|------|-----------|------------|
| PC1 | Source host | ETH0 | 192.168.1.11/24 |
| SW1 | Layer 2 switch | - | No IP |
| R1 | Router | G0/1 | 192.168.1.1/24 |
| R1 | Router | G0/0 | 192.168.12.1/24 |
| R2 | Router | G0/0 | 192.168.12.2/24 |
| R2 | Router | G0/1 | 192.168.23.1/24 |
| SW2 | Layer 2 switch | - | No IP |
| PC3 | Destination host | ETH0 | 192.168.3.11/24 |

---

## 3. Packet Lifecycle: PC1 to R1

### 3.1 Host Routing Decision: Is the Destination Local?

PC1 receives the command: `ping 192.168.3.11`

**Simple version:** PC1 checks if 192.168.3.11 is on its own network. It's not, so it sends the packet to the default gateway instead of trying to deliver it directly.

**The detail:**
- PC1's IP: 192.168.1.11/24
- PC1's network range: 192.168.1.0 – 192.168.1.255 (calculated using subnet mask 255.255.255.0)
- Destination IP: 192.168.3.11
- Result: **Not in local network** → forward to default gateway (192.168.1.1)

This decision prevents PC1 from wasting time trying to reach a host on a different subnet using Layer 2 forwarding.

### 3.2 ARP: Resolving the Default Gateway's MAC Address

PC1 knows the default gateway's **IP address** (192.168.1.1) but needs its **MAC address** to create a Layer 2 frame.

| Step | Device | Action | Details |
|------|--------|--------|---------|
| 1 | PC1 | Send ARP Request | Broadcast: "Who has 192.168.1.1?" (destination MAC: `ffff.ffff.ffff`) |
| 1 | SW1 | Learn + Flood | Learns PC1's MAC on G0/1; floods broadcast to all ports except G0/1 |
| 1 | PC2 | Discard | Broadcast is not addressed to its IP, so it ignores the frame |
| 1 | R1 | Receive | Receives ARP request on G0/1 |
| 2 | R1 | Send ARP Reply | "I have 192.168.1.1, my MAC is AAAA.AAAA.AAAA"; adds PC1 → PC1's MAC to ARP table |
| 2 | SW1 | Learn + Forward | Learns R1 G0/1's MAC on G0/0; forwards unicast frame to PC1 on G0/1 |
| 3 | PC1 | Learn MAC | Adds entry: 192.168.1.1 → AAAA.AAAA.AAAA; can now send packets |

**Why this matters:** [[ARP]] reduces the need for manual MAC configuration. Without it, network administrators would have to manually enter every MAC address on every device.

**Important:** PC1 does NOT use ARP to learn PC3's MAC address. PC1 and PC3 are on different LANs—they will never communicate directly at Layer 2.

### 3.3 Switch Learning: MAC Address Table Population

As frames traverse SW1:

| Frame | Source MAC | Dest MAC | SW1 Action |
|-------|-----------|----------|-----------|
| ARP Request (PC1→broadcast) | PC1_MAC | ffff.ffff.ffff | Learn PC1_MAC on G0/1; flood to all ports |
| ARP Reply (R1→PC1) | R1_G0/1_MAC | PC1_MAC | Learn R1_G0/1_MAC on G0/0; forward to G0/1 |
| ICMP Echo Request (PC1→R1) | PC1_MAC | R1_G0/1_MAC | Already learned; forward to G0/0 |

SW1's MAC address table after these exchanges:

```
MAC Address          Port
PC1_MAC              G0/1
R1_G0/1_MAC          G0/0
```

### 3.4 Frame Encapsulation: PC1 to R1

After ARP completes, PC1 constructs the frame:

```
Layer 2 Frame (Ethernet):
┌─────────────────────────────────────────────┐
│ Dest MAC: R1_G0/1_MAC                       │
│ Source MAC: PC1_MAC                         │
│ EtherType: 0x0800 (IPv4)                    │
├─────────────────────────────────────────────┤
│ Layer 3 Packet (IPv4):                      │
│ ┌─────────────────────────────────────────┐ │
│ │ Dest IP: 192.168.3.11                   │ │
│ │ Source IP: 192.168.1.11                 │ │
│ │ Protocol: 1 (ICMP)                      │ │
│ ├─────────────────────────────────────────┤ │
│ │ Layer 4 Payload (ICMP Echo Request):    │ │
│ │ Type: 8, Code: 0, Sequence: 1, etc.     │ │
│ └─────────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
```

**Critical insight:** The Layer 3 destination address (192.168.3.11) **never changes** as the packet travels. Only the Layer 2 frame headers change at each hop.

---

## 4. Packet Lifecycle: R1 to R2

### 4.1 Router Reception and De-encapsulation

R1 receives the frame from PC1 on interface G0/1. It performs these steps:

1. **Frame validation:** Check FCS (Frame Check Sequence); discard if corrupted
2. **Destination MAC check:** Verify destination MAC matches R1 G0/1's MAC or is broadcast
3. **De-encapsulation:** Remove Layer 2 header; extract IPv4 packet
4. **TTL check:** Decrement TTL by 1; discard if TTL reaches 0 (prevents infinite loops)
5. **Routing table lookup:** Find best route for destination IP 192.168.3.11

### 4.2 Routing Table Lookup

R1's routing table (simplified):

```
R1# show ip route

     192.168.1.0/24 is variably subnetted, 2 subnets, 2 masks
C        192.168.1.0/24 [0/0] via directly connected, GigabitEthernet0/1
L        192.168.1.1/32 [0/0] via directly connected, GigabitEthernet0/1
S     192.168.3.0/24 [1/0] via 192.168.12.2, GigabitEthernet0/0
     192.168.12.0/24 is variably subnetted, 2 subnets, 2 masks
C        192.168.12.0/24 [0/0] via directly connected, GigabitEthernet0/0
L        192.168.12.1/32 [0/0] via directly connected, GigabitEthernet0/0
```

**Lookup process for destination 192.168.3.11:**
- Candidate routes (longest prefix match first):
  - 192.168.3.0/24 ✓ (matches; /24 prefix)
  - 0.0.0.0/0 ✗ (no default route)
- **Selected route:** 192.168.3.0/24 via 192.168.12.2 (R2's address)
- **Outgoing interface:** G0/0
- **Next hop:** 192.168.12.2

**Why not 192.168.1.0/24?** Because 192.168.3.11 does not match the first two octets (192.168.1.x). The /24 prefix means only the first 24 bits must match.

### 4.3 Router ARP: Learning the Next Hop's MAC

R1 knows the next hop's IP (192.168.12.2) but must learn its MAC address. R1 checks its ARP table:

```
R1# show ip arp

Protocol  Address          Age (min)  Hardware Addr   Type   Interface
Internet  192.168.1.11          0   BBBB.BBBB.BBBB  ARPA   GigabitEthernet0/1
```

R2's MAC is not in the table, so R1 sends an ARP request on G0/0:

| Step | Device | Action |
|------|--------|--------|
| 1 | R1 | Broadcast ARP: "Who has 192.168.12.2?" on G0/0 (subnet 192.168.12.0/24) |
| 1 | R2 | Receives on G0/0; recognizes its own IP; learns R1's MAC |
| 2 | R2 | Sends ARP reply: "I have 192.168.12.2, my MAC is CCCC.CCCC.CCCC" |
| 2 | R1 | Receives; adds entry to ARP table: 192.168.12.2 → CCCC.CCCC.CCCC |

**Timing optimization:** This ARP happens only once per next hop. Subsequent packets to the same destination reuse the cached MAC address (typically 4 hours timeout by default).

### 4.4 Frame Re-encapsulation: R1 to R2

R1 now creates a **new Layer 2 frame** with:

```
Layer 2 Frame (

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 10 | [[CCNA]]*
